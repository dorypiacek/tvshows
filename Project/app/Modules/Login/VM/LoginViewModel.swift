//
//  LoginViewModel.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import PromiseKit
import ETPersistentValue
import ETBinding

protocol LoginVMType {
	var iconName: String { get }
	var radioButtonContent: LiveOptionalData<RadioButton.Content> { get }
	var loginButtonContent: LiveOptionalData<PrimaryButton.Content> { get }
	var emailTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
	var passwordTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
}

extension Login {
	final class VM: LoginVMType {

		// MARK: - Variables
		// MARK: - Public

		var iconName: String = "img-login-logo"
		var radioButtonContent: LiveOptionalData<RadioButton.Content> = LiveOptionalData(data: nil)
		var loginButtonContent: LiveOptionalData<PrimaryButton.Content> = LiveOptionalData(data: nil)
		var emailTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> = LiveOptionalData(data: nil)
		var passwordTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> = LiveOptionalData(data: nil)

		var onDidLogin: (() -> Void)?
		var onShowAlert: ((AlertConfig) -> Void)?

		// MARK: - Private

		private var dataProvider: LoginDataProviderType

		private var rememberCredentials: Bool = false

		private var email: String?
		private var password: String?

		private var isLoading: Bool = false {
			didSet {
				setupContent()
			}
		}

		// MARK: - Initializer

		init(dataProvider: LoginDataProviderType) {
			self.dataProvider = dataProvider
			setupContent()
		}

		func login() {
			guard let email = email, let password = password else {
				return
			}
			let credentials = UserCredentials(email: email, password: password)

			isLoading = true
			dataProvider
				.login(with: credentials)
				.done { data in
					PersistentString(value: data.data.token, account: PersistentKey.accessToken).save()
					if self.rememberCredentials {
						PersistentCodable(value: credentials, account: PersistentKey.userCredentials).save()
					}
					print("🎉")
					self.onDidLogin?()
				}
				.ensure {
					self.isLoading = false
				}
				.catch { error in
					self.onShowAlert?(self.makeErrorAlertConfig(with: error))
				}
		}
	}
}

private extension Login.VM {
	func setupContent() {
		setupButtons()
		setupTextFields()
	}

	func setupButtons() {
		radioButtonContent.data = RadioButton.Content(
			title: LocalizationKit.login.radioButtonTitle,
			isSelected: rememberCredentials,
			action: { [unowned self] in
				self.rememberCredentials = !self.rememberCredentials
				self.setupContent()
			}
		)
		loginButtonContent.data = PrimaryButton.Content(
			title: LocalizationKit.login.loginButtonTitle,
			isEnabled: !(email?.isEmpty ?? true || password?.isEmpty ?? true),
			isLoading: isLoading,
			action: { [unowned self] in
				self.login()
			}
		)
	}

	func setupTextFields() {
		emailTextFieldContent.data = UnderlinedTextField.Content(
				text: email,
				error: false,
				placeholder: LocalizationKit.login.emailPlaceholder,
				textDidChange: { [unowned self] text in
					self.email = text
					self.setupContent()
				},
				keyboardType: .emailAddress,
				returnKeyType: .next,
				validator: self
		)
		passwordTextFieldContent.data = UnderlinedTextField.Content(
				text: password,
				error: false,
				placeholder: LocalizationKit.login.passwordPlaceholder,
				textDidChange: { [unowned self] text in
					self.password = text
					self.setupContent()
				},
				keyboardType: .default,
				returnKeyType: .done,
				validator: self
		)
	}

	func makeErrorAlertConfig(with error: Error) -> AlertConfig {
		let action = AlertAction(title: LocalizationKit.general.ok, style: .default, handler: nil)
		return AlertConfig(
			title: LocalizationKit.general.errorTitle,
			// TODO: Localize.
			message: "\(error.localizedDescription)\n Please try again later.",
			style: .alert,
			actions: [action]
		)
	}
}

extension Login.VM: InputValidatorType {
	func shouldChangeCharacters(of text: String?, in range: NSRange, replacementString string: String) -> Bool {
		text?.isEmpty ?? true
	}
}

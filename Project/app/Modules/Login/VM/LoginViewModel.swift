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

// MARK: - Protocol definition

protocol LoginVMType {
	var iconName: String { get }
	var radioButtonContent: LiveOptionalData<RadioButton.Content> { get }
	var loginButtonContent: LiveOptionalData<PrimaryButton.Content> { get }
	var emailTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
	var passwordTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
}

extension Login {
	final class VM: LoginVMType {

		// MARK: - Public variables

		var iconName: String = "img-login-logo"
		var radioButtonContent: LiveOptionalData<RadioButton.Content> = LiveOptionalData(data: nil)
		var loginButtonContent: LiveOptionalData<PrimaryButton.Content> = LiveOptionalData(data: nil)
		var emailTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> = LiveOptionalData(data: nil)
		var passwordTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> = LiveOptionalData(data: nil)

		var onDidLogin: (() -> Void)?
		var onShowAlert: ((AlertConfig) -> Void)?

		// MARK: - Private variables

		private var dataProvider: LoginDataProviderType

		private var rememberCredentials: Bool = false

		private var email: String?
		private var password: String?

		private var isPasswordHidden: Bool = true
		private var isLoading: Bool = false {
			didSet {
				setupContent()
			}
		}

		// MARK: - Initializer

		init(dataProvider: LoginDataProviderType) {
			self.dataProvider = dataProvider
			readCredentials()
			setupContent()
		}
	}
}

private extension Login.VM {

	// MARK: - Private methods
	// MARK: - Networking

	func login() {
		guard let email = email, let password = password else {
			return
		}
		let credentials = UserCredentials(email: email, password: password)

		isLoading = true
		dataProvider
			.login(with: credentials)
			.done { data in
				PersistentString(key: PersistentKey.accessToken, value: data.data.token).save()
				self.rememberCredentials ? PersistentCodable(key: PersistentKey.userCredentials, value: credentials).save() : PersistentCodable<UserCredentials>(key: PersistentKey.userCredentials).remove()
				self.onDidLogin?()
			}
			.ensure {
				self.isLoading = false
			}
			.catch { error in
				self.onShowAlert?(self.makeErrorAlertConfig(with: error))
			}
	}

	// MARK: - Content setup

	func readCredentials() {
		if let credentials = PersistentCodable<UserCredentials>(key: PersistentKey.userCredentials).value {
			email = credentials.email
			password = credentials.password
			rememberCredentials = true
		}
	}

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
				placeholder: LocalizationKit.login.emailPlaceholder,
				textDidChange: { [unowned self] text in
					self.email = text
					self.setupContent()
				},
				keyboardType: .emailAddress,
				returnKeyType: .next
		)
		passwordTextFieldContent.data = UnderlinedTextField.Content(
				text: password,
				placeholder: LocalizationKit.login.passwordPlaceholder,
				textDidChange: { [unowned self] text in
					self.password = text
					self.setupContent()
				},
				keyboardType: .default,
				returnKeyType: .done,
				isSecured: isPasswordHidden,
				rightView: UnderlinedTextField.RightViewContent(
					normalIcon: "ic-hide-password",
					selectedIcon: "ic-characters-hide",
					isSelected: !isPasswordHidden,
					action: { [unowned self] in
						self.isPasswordHidden = !self.isPasswordHidden
						self.setupContent()
				}
			)
		)
	}

	func makeErrorAlertConfig(with error: Error) -> AlertConfig {
		let action = AlertAction(title: LocalizationKit.general.ok, style: .default, handler: nil)
		return AlertConfig(
			title: LocalizationKit.general.errorTitle,
			message: LocalizationKit.general.errorMessage,
			style: .alert,
			actions: [action]
		)
	}
}

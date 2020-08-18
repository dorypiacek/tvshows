//
//  LoginVM.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import PromiseKit
import ETPersistentValue
import ETBinding

final class LoginVM: LoginVMType {
	// MARK: - Public properties

	let iconName: String = StyleKit.image.logo.login
	let checkboxButtonContent: LiveOptionalData<CheckboxButton.Content> = LiveOptionalData(data: nil)
	let loginButtonContent: LiveOptionalData<PrimaryButton.Content> = LiveOptionalData(data: nil)
	let emailTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> = LiveOptionalData(data: nil)
	let passwordTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> = LiveOptionalData(data: nil)

	/// Action called after succesful login
	var onDidLogin: (() -> Void)?
	/// Shows alert with given config
	var onShowAlert: ((AlertConfig) -> Void)?

	// MARK: - Private properties

	private var dataProvider: LoginDataProviderType

	private var email: String?
	private var password: String?

	private var isPasswordHidden: Bool = true
	private var rememberCredentials: Bool = false
	private var isLoading: Bool = false {
		didSet {
			setupContent()
		}
	}

	// MARK: - Public methods

	func readCredentials() {
		let credentials = PersistentCodable<UserCredentials>(key: PersistentKey.userCredentials).value
		email = credentials?.email ?? nil
		password = credentials?.password ?? nil
		rememberCredentials = credentials != nil
		setupContent()
	}

	// MARK: - Initializer

	init(dataProvider: LoginDataProviderType) {
		self.dataProvider = dataProvider
		readCredentials()
		setupContent()
	}

	// MARK: - Public methods

	func login() {
		guard let email = email, !email.isEmpty, let password = password, !password.isEmpty else {
			updateTextfields()
			return
		}
		let credentials = UserCredentials(email: email, password: password)

		isLoading = true
		dataProvider
			.login(with: credentials)
			.done { data in
				PersistentString(key: PersistentKey.accessToken, value: data.data.token).save()
				self.rememberCredentials ? PersistentCodable(key: PersistentKey.userCredentials, value: credentials).save() : PersistentCodable<UserCredentials>(key: PersistentKey.userCredentials).remove()
				self.isPasswordHidden = true
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

private extension LoginVM {

	// MARK: - Private methods

	func setupContent() {
		setupButtons()
		setupTextFields()
	}

	func setupButtons() {
		checkboxButtonContent.data = CheckboxButton.Content(
			title: LocalizationKit.login.radioButtonTitle,
			isSelected: rememberCredentials,
			action: { [weak self] in
				guard let self = self else {
					return
				}
				self.rememberCredentials = !self.rememberCredentials
				self.setupContent()
			}
		)
		loginButtonContent.data = PrimaryButton.Content(
			title: LocalizationKit.login.loginButtonTitle,
			isEnabled: !(email?.isEmpty ?? true || password?.isEmpty ?? true),
			isLoading: isLoading,
			action: { [weak self] in
				self?.login()
			}
		)
	}

	func setupTextFields() {
		emailTextFieldContent.data = makeEmailTextField()
		passwordTextFieldContent.data = makePasswordTextField()
	}

	func updateTextfields() {
		if email?.isEmpty ?? true {
			emailTextFieldContent.data = makeEmailTextField(error: true)
		}
		if password?.isEmpty ?? true {
			passwordTextFieldContent.data = makePasswordTextField(error: true)
		}
	}

	func makeEmailTextField(error: Bool = false) -> UnderlinedTextField.Content {
		UnderlinedTextField.Content(
			text: email,
			placeholder: LocalizationKit.login.emailPlaceholder,
			textDidChange: { [weak self] text in
				self?.email = text
				self?.setupContent()
			},
			keyboardType: .emailAddress,
			returnKeyType: .next,
			hasError: error
		)
	}

	func makePasswordTextField(error: Bool = false) -> UnderlinedTextField.Content {
		UnderlinedTextField.Content(
			text: password,
			placeholder: LocalizationKit.login.passwordPlaceholder,
			textDidChange: { [weak self] text in
				self?.password = text
				self?.setupContent()
			},
			keyboardType: .default,
			returnKeyType: .done,
			isSecured: isPasswordHidden,
			hasError: error,
			rightView: UnderlinedTextField.RightViewContent(
				normalIcon: StyleKit.image.password.hide,
				selectedIcon: StyleKit.image.password.show,
				isSelected: !isPasswordHidden,
				action: { [weak self] in
					guard let self = self else {
						return
					}
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

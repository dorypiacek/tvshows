//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit
import ETBinding

final class LoginVC: UIViewController {
	// MARK: - Private properties

	private var vm: LoginVMType

	private lazy var imageView = UIImageView(image: StyleKit.image.make(from: vm.iconName))
	private let emailTextField = UnderlinedTextField()
	private let passwordTextField = UnderlinedTextField()
	private let checkboxButton = CheckboxButton()
	private let loginButton = PrimaryButton()

	// MARK: - Initializers

	init(vm: LoginVMType) {
		self.vm = vm
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - ViewController lifecycle

	override func loadView() {
		super.loadView()
		setupUI()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindObservers()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		vm.readCredentials()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		emailTextField.becomeFirstResponder()
	}
}

extension LoginVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == emailTextField {
			passwordTextField.becomeFirstResponder()
		} else if textField == passwordTextField {
			textField.resignFirstResponder()
			vm.login()
		}
		return true
	}
}

private extension LoginVC {

	// MARK: - Private

	func bindObservers() {
		vm.emailTextFieldContent.observe(owner: self) { [weak self] content in
			if let content = content {
				self?.emailTextField.update(with: content)
			}
		}
		vm.emailTextFieldContent.dispatch()
		vm.passwordTextFieldContent.observe(owner: self) { [weak self] content in
			if let content = content {
				self?.passwordTextField.update(with: content)
			}
		}
		vm.passwordTextFieldContent.dispatch()
		vm.checkboxButtonContent.observe(owner: self) { [weak self] content in
			if let content = content {
				self?.checkboxButton.update(with: content)
			}
		}
		vm.checkboxButtonContent.dispatch()
		vm.loginButtonContent.observe(owner: self) { [weak self] content in
			if let content = content {
				self?.loginButton.update(with: content)
			}
		}
		vm.loginButtonContent.dispatch()
	}

	func setupUI() {
		view.backgroundColor = .white
		navigationController?.isNavigationBarHidden = true

		[imageView, emailTextField, passwordTextField, checkboxButton, loginButton].forEach(view.addSubview)

		setupImageView()
		setupEmailTextField()
		setupPasswordTextField()
		setupCheckboxButton()
		setupLoginButton()
	}

	func setupImageView() {
		imageView.contentMode = .scaleAspectFit
		imageView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(2 * StyleKit.metrics.padding.large)
			make.centerX.equalToSuperview()
		}
	}

	func setupEmailTextField() {
		emailTextField.delegate = self
		emailTextField.returnKeyType = .next
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(imageView.snp.bottom).offset(StyleKit.metrics.padding.large)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
			make.height.equalTo(StyleKit.metrics.textFieldHeight)
		}
	}

	func setupPasswordTextField() {
		passwordTextField.delegate = self
		passwordTextField.returnKeyType = .done
		passwordTextField.snp.makeConstraints { make in
			make.top.equalTo(emailTextField.snp.bottom).offset(StyleKit.metrics.padding.medium)
			make.leading.trailing.equalTo(emailTextField)
			make.height.equalTo(StyleKit.metrics.textFieldHeight)
		}
	}

	func setupCheckboxButton() {
		checkboxButton.snp.makeConstraints { make in
			make.top.equalTo(passwordTextField.snp.bottom).offset(StyleKit.metrics.padding.medium)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
			make.height.equalTo(StyleKit.metrics.buttonHeight)
		}
	}

	func setupLoginButton() {
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(checkboxButton.snp.bottom).offset(StyleKit.metrics.padding.large)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
			make.height.equalTo(StyleKit.metrics.buttonHeight)
		}
	}
}

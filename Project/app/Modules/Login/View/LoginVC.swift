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

	private let vm: LoginVMType

	private let stackView = UIStackView()
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
		addGestureRecognizer()
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
		vm.emailTextFieldContent.observe(owner: self) { [weak emailTextField] content in
			if let content = content {
				emailTextField?.update(with: content)
			}
		}
		vm.emailTextFieldContent.dispatch()
		vm.passwordTextFieldContent.observe(owner: self) { [weak passwordTextField] content in
			if let content = content {
				passwordTextField?.update(with: content)
			}
		}
		vm.passwordTextFieldContent.dispatch()
		vm.checkboxButtonContent.observe(owner: self) { [weak checkboxButton] content in
			if let content = content {
				checkboxButton?.update(with: content)
			}
		}
		vm.checkboxButtonContent.dispatch()
		vm.loginButtonContent.observe(owner: self) { [weak loginButton] content in
			if let content = content {
				loginButton?.update(with: content)
			}
		}
		vm.loginButtonContent.dispatch()
	}

	func addGestureRecognizer() {
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
	}

	func setupUI() {
		view.backgroundColor = .white
		navigationController?.isNavigationBarHidden = true

		view.addSubview(stackView)
		[imageView, emailTextField, passwordTextField, checkboxButton, loginButton].forEach(stackView.addArrangedSubview)

		setupStackView()
		setupImageView()
		setupEmailTextField()
		setupPasswordTextField()
		setupCheckboxButton()
		setupLoginButton()
	}

	func setupStackView() {
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = StyleKit.metrics.padding.medium
		stackView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(2 * StyleKit.metrics.padding.large)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
		}
	}

	func setupImageView() {
		imageView.contentMode = .scaleAspectFit
	}

	func setupEmailTextField() {
		emailTextField.delegate = self
		emailTextField.returnKeyType = .next
		emailTextField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		emailTextField.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(StyleKit.metrics.textFieldHeight).priority(.required)
		}
	}

	func setupPasswordTextField() {
		passwordTextField.delegate = self
		passwordTextField.returnKeyType = .done
		passwordTextField.setContentCompressionResistancePriority(.required, for: .vertical)
		passwordTextField.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(StyleKit.metrics.textFieldHeight).priority(.required)
		}
	}

	func setupCheckboxButton() {
		checkboxButton.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(StyleKit.metrics.buttonHeight)
		}
	}

	func setupLoginButton() {
		loginButton.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(StyleKit.metrics.buttonHeight)
		}
	}

	@objc func hideKeyboard() {
		view.endEditing(true)
	}
}

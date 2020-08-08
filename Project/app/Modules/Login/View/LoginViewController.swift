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

extension Login {
	final class VC: UIViewController {
		// MARK: - Variables
		// MARK: - Private

		private var vm: LoginVMType

		private lazy var imageView = UIImageView(image: UIImage(named: vm.iconName))
		private let emailTextField = UnderlinedTextField()
		private let passwordTextField = UnderlinedTextField()
		private let radioButton = RadioButton()
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
			bind()
		}

		override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
			vm.readCredentials()
		}
	}
}

private extension Login.VC {

	// MARK: - Private

	func bind() {
		vm.emailTextFieldContent.observe(owner: self) { [unowned self] content in
			if let content = content {
				self.emailTextField.update(with: content)
			}
		}
		vm.emailTextFieldContent.dispatch()
		vm.passwordTextFieldContent.observe(owner: self) { [unowned self] content in
			if let content = content {
				self.passwordTextField.update(with: content)
			}
		}
		vm.passwordTextFieldContent.dispatch()
		vm.radioButtonContent.observe(owner: self) { [unowned self] content in
			if let content = content {
				self.radioButton.update(with: content)
			}
		}
		vm.radioButtonContent.dispatch()
		vm.loginButtonContent.observe(owner: self) { [unowned self] content in
			if let content = content {
				self.loginButton.update(with: content)
			}
		}
		vm.loginButtonContent.dispatch()
	}

	func setupUI() {
		view.backgroundColor = .white
		navigationController?.isNavigationBarHidden = true

		[imageView, emailTextField, passwordTextField, radioButton, loginButton].forEach(view.addSubview)

		setupImageView()
		setupTextFields()
		setupRadioButton()
		setupLoginButton()
	}

	func setupImageView() {
		imageView.contentMode = .scaleAspectFit
		imageView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(2 * StyleKit.metrics.padding.large)
			make.centerX.equalToSuperview()
		}
	}

	func setupTextFields() {
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(imageView.snp.bottom).offset(StyleKit.metrics.padding.large)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
		}

		passwordTextField.snp.makeConstraints { make in
			make.top.equalTo(emailTextField.snp.bottom).offset(StyleKit.metrics.padding.medium)
			make.leading.trailing.equalTo(emailTextField)
		}
	}

	func setupRadioButton() {
		radioButton.snp.makeConstraints { make in
			make.top.equalTo(passwordTextField.snp.bottom).offset(StyleKit.metrics.padding.medium)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
			make.height.equalTo(StyleKit.metrics.buttonHeight)
		}
	}

	func setupLoginButton() {
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(radioButton.snp.bottom).offset(StyleKit.metrics.padding.large)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
			make.height.equalTo(StyleKit.metrics.buttonHeight)
		}
	}
}

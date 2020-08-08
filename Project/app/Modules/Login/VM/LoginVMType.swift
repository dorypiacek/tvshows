//
//  LoginVMType.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding

// MARK: - Protocol definition

protocol LoginVMType {
	var iconName: String { get }
	var radioButtonContent: LiveOptionalData<RadioButton.Content> { get }
	var loginButtonContent: LiveOptionalData<PrimaryButton.Content> { get }
	var emailTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
	var passwordTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
	func login()
}

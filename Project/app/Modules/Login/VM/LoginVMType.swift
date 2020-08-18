//
//  LoginVMType.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding

protocol LoginVMType {
	/// Name of icon to show
	var iconName: String { get }
	/// Checkbox button content
	var checkboxButtonContent: LiveOptionalData<CheckboxButton.Content> { get }
	/// Login button content
	var loginButtonContent: LiveOptionalData<PrimaryButton.Content> { get }
	/// Email text field content
	var emailTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
	/// Password text field content
	var passwordTextFieldContent: LiveOptionalData<UnderlinedTextField.Content> { get }
	/// Calls login API request, shows TV Show list if successful or an alert if error occurs
	func login()
	func readCredentials()
}

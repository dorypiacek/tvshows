//
//  InputValidator.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation

public protocol InputValidatorType: AnyObject {
    func shouldChangeCharacters(of text: String?, in range: NSRange, replacementString string: String) -> Bool
}

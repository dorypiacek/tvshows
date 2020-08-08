//
//  AlertAction.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

struct AlertAction {
	let title: String
	let style: UIAlertAction.Style
	let handler: ((UIAlertAction) -> Void)?
}

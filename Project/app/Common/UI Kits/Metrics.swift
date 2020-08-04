//
//  Metrics.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

struct Metrics {
	let padding = Padding()
	let cornerRadius: CGFloat = 6
	let separator: CGFloat = 1
	let buttonHeight: CGFloat = 48
	let tableRowHeight: CGFloat = 56
	let textFieldHeight: CGFloat = 64

	struct Padding {
		let small: CGFloat = 10
		let medium: CGFloat = 16
		let large: CGFloat = 24
	}
}

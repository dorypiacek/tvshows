//
//  Metrics.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

/// Definition of paddings, radii and other constants used in app layout.
struct Metrics {
	let padding = Padding()
	let smallCornerRadius: CGFloat = 4
	let cornerRadius: CGFloat = 6
	let separator: CGFloat = 1
	let buttonHeight: CGFloat = 48
	let tableRowHeight: CGFloat = 56
	let textFieldHeight: CGFloat = 64
	static let thumbnailSize: CGSize = CGSize(width: 64, height: 90)

	struct Padding {
		let verySmall: CGFloat = 8
		let small: CGFloat = 10
		let medium: CGFloat = 16
		let large: CGFloat = 24
	}
}

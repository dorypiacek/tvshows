//
//  UIColor+Hex.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	/// Initialize UIColor from hex string
	///
	/// examples:
	/// - With or without hash character: UIColor(hex: "#00FFFFFF"), UIColor(hex: "00FFFFFF")
	/// - With alpha (ARGB): UIColor(hex: "#00FFFFFF")
	/// - Without alpha (alpha is 1): UIColor(hex: "#FFFFFF")
	/// - Parameter hex: hex string
	convenience init(hex: String) {
		let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		let scanner = Scanner(string: hexString)

		let charCount: Int
		if hexString.hasPrefix("#") {
			scanner.scanLocation = 1
			charCount = hex.count - 1
		} else {
			charCount = hex.count
		}

		var color: UInt32 = 0
		scanner.scanHexInt32(&color)

		switch charCount {
		case 6:
			self.init(hex6: color)
		case 8:
			self.init(hex8: color)
		default:
			self.init(red: 1, green: 1, blue: 1, alpha: 1)
		}
	}

	/// Initialize UIColor from hex (without alpha) in int
	/// example: UIColor(hex6: 0xFFFFFF)
	///
	/// - Parameter hex6: UInt32
	convenience init(hex6: UInt32) {
		let mask = 0x000000FF
		let r = Int(hex6 >> 16) & mask
		let g = Int(hex6 >> 8) & mask
		let b = Int(hex6) & mask

		let red = CGFloat(r) / 255.0
		let green = CGFloat(g) / 255.0
		let blue = CGFloat(b) / 255.0

		self.init(red: red, green: green, blue: blue, alpha: 1)
	}

	/// Initialize UIColor from hex (without alpha) in int
	/// example: UIColor(hex8: 0x77FFFFFF)
	/// - For ARGB reference see [ARGB]
	///
	/// [ARGB]: https://en.wikipedia.org/wiki/RGBA_color_space#ARGB_.28word-order.29/
	///
	/// - Parameter hex8: UInt32
	convenience init(hex8: UInt32) {
		let mask = 0x000000FF
		let r = Int(hex8 >> 16) & mask
		let g = Int(hex8 >> 8) & mask
		let b = Int(hex8) & mask
		let a = Int(hex8 >> 24) & mask

		let red = CGFloat(r) / 255.0
		let green = CGFloat(g) / 255.0
		let blue = CGFloat(b) / 255.0
		let alpha = CGFloat(a) / 255.0

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}

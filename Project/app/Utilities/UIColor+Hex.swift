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
		var cleanHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHex = cleanHex.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = cleanHex.count

        Scanner(string: cleanHex).scanHexInt32(&rgb)

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        }

		self.init(red: r, green: g, blue: b, alpha: a)
	}
}

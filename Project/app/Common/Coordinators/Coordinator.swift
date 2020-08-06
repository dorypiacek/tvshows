//
//  Coordinator.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

/// Protocol used for coordinator pattern implementation
protocol Coordinator {
	var presenter: UINavigationController { get set }
	var onDidStop: (() -> Void)? { get set }
	func start()
	func stop()
}

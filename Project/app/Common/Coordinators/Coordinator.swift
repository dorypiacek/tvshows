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
	func start()
}

extension Coordinator {
	func showAlert(with config: AlertConfig) {
		let alert = UIAlertController(title: config.title, message: config.message, preferredStyle: config.style)
		config.actions.forEach { action in
			let action = UIAlertAction(
				title: action.title,
				style: action.style,
				handler: action.handler
			)
			alert.addAction(action)
		}
		presenter.present(alert, animated: true, completion: nil)
	}
}

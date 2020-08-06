//
//  BaseCoordinator.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
	var presenter: UINavigationController
	var onDidStop: (() -> Void)?

	init(presenter: UINavigationController) {
		self.presenter = presenter
	}

	func start() {
		// Used for overrides
	}

	func stop() {
		presenter.presentedViewController?.dismiss(animated: true, completion: { [weak self] in
			self?.onDidStop?()
		})
	}

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
		presenter.presentedViewController?.present(alert, animated: true, completion: nil)
	}
}

//
//  LoginCoordinator.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

extension Login {
	final class Coord: Coordinator {

		// MARK: - Variables
		// MARK: - Public

		var presenter: UINavigationController

		// MARK: - Initializer

		init(presenter: UINavigationController) {
			self.presenter = presenter
		}

		func start() {
			let dataProvider = ApiDataProvider() as LoginDataProviderType
			let vm = VM(dataProvider: dataProvider)
			vm.onDidLogin = { [weak self] in
				self?.showList()
			}
			vm.onShowAlert = { [weak self] config in
				self?.showAlert(with: config)
			}
			let vc = VC(vm: vm)
			vc.modalPresentationStyle = .overFullScreen
			presenter.present(vc, animated: true, completion: nil)
		}
	}
}

private extension Login.Coord {
	func showList() {
		// TODO: Implement.
	}
}

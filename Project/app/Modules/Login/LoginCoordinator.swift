//
//  LoginCoordinator.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

final class LoginCoordinator: BaseCoordinator {

	private var listCoord: ShowsListCoordinator?

	override func start() {
		let dataProvider = ApiDataProvider() as LoginDataProviderType
		let vm = LoginVM(dataProvider: dataProvider)
		vm.onDidLogin = { [weak self] in
			self?.showList()
		}
		vm.onShowAlert = { [weak self] config in
			self?.showAlert(with: config)
		}
		let vc = LoginVC(vm: vm)
		presenter.pushViewController(vc, animated: false)
	}
}

private extension LoginCoordinator {
	func showList() {
		listCoord = ShowsListCoordinator(presenter: presenter)
		listCoord?.onDidStop = { [weak self] in
			self?.listCoord = nil
		}
		listCoord?.start()
	}
}

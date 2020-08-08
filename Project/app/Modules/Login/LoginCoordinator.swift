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
	final class Coord: BaseCoordinator {
		private var listCoord: ShowsList.Coord?

		override func start() {
			let dataProvider = ApiDataProvider() as LoginDataProviderType
			let vm = VM(dataProvider: dataProvider)
			vm.onDidLogin = { [weak self] in
				self?.showList()
			}
			vm.onShowAlert = { [weak self] config in
				self?.showAlert(with: config)
			}
			let vc = VC(vm: vm)
			vc.modalPresentationStyle = .fullScreen
			presenter.present(vc, animated: false, completion: nil)
		}
	}
}

private extension Login.Coord {
	func showList() {
		listCoord = ShowsList.Coord(presenter: presenter)
		listCoord?.onDidStop = { [weak self] in
			self?.listCoord = nil
		}
		listCoord?.start()
	}
}

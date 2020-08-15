//
//  ShowsListCoordinator.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

final class ShowsListCoordinator: BaseCoordinator {

	private var detailCoord: ShowDetailCoordinator?

	override func start() {
		let dataProvider = ApiDataProvider() as ShowsListDataProviderType
		let vm = ShowsListVM(dataProvider: dataProvider)
		vm.onSelect = { [weak self] show in
			self?.showDetail(with: show)
		}
		vm.onLogout = { [weak self] in
			self?.stop()
		}
		let vc = ShowsListVC(vm: vm)
		presenter.pushViewController(vc, animated: true)
	}
}

private extension ShowsListCoordinator {
	func showDetail(with show: TVShow) {
		detailCoord = ShowDetailCoordinator(presenter: presenter, show: show)
		detailCoord?.onDidStop = { [weak self] in
			self?.detailCoord = nil
		}
		detailCoord?.start()
	}
}

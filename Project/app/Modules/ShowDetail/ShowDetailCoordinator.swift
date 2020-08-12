//
//  ShowDetailCoordinator.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

final class ShowDetailCoordinator: BaseCoordinator {
	var showId: TVShowId

	init(presenter: UINavigationController, showId: TVShowId) {
		self.showId = showId
		super.init(presenter: presenter)
	}

	override func start() {
		let dataProvider = ApiDataProvider() as ShowDetailDataProviderType
		let vm = ShowDetailVM(dataProvider: dataProvider, showId: showId)
		vm.onBackTapped = { [weak self] in
			self?.stop()
		}
		let vc = ShowDetailVC(vm: vm)
		presenter.pushViewController(vc, animated: true)
	}
}

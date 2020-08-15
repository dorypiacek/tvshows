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
	var show: TVShow

	init(presenter: UINavigationController, show: TVShow) {
		self.show = show
		super.init(presenter: presenter)
	}

	override func start() {
		let dataProvider = ApiDataProvider() as ShowDetailDataProviderType
		let vm = ShowDetailVM(dataProvider: dataProvider, showPreview: show)
		vm.onBackTapped = { [weak self] in
			self?.stop()
		}
		let vc = ShowDetailVC(vm: vm)
		presenter.pushViewController(vc, animated: true)
	}
}

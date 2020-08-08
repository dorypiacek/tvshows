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
	override func start() {
		let dataProvider = ApiDataProvider() as ShowsListDataProviderType
		let vm = ShowsListVM(dataProvider: dataProvider)
		vm.onSelect = { _ in
			// TODO: Implement show detail.
		}
		vm.onLogout = { [weak self] in
			self?.stop()
		}
		let vc = ShowsListVC(vm: vm)
		vc.modalPresentationStyle = .fullScreen
		presenter.presentedViewController?.present(vc, animated: true, completion: nil)
	}
}

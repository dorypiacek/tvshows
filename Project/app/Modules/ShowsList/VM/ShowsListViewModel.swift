//
//  ShowsListViewModel.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding

// MARK: - Protocol definition

protocol ShowsListVMType {
	var tableContent: LiveOptionalData<[ShowsList.Cell.Content]> { get }
	var headerContent: LiveOptionalData<ShowsList.HeaderView.Content> { get }
	var isLoading: LiveData<Bool> { get }
}

extension ShowsList {
	final class VM: ShowsListVMType {

		// MARK: Public variables

		var tableContent: LiveOptionalData<[Cell.Content]> = LiveOptionalData(data: nil)
		var headerContent: LiveOptionalData<HeaderView.Content> = LiveOptionalData(data: nil)
		var isLoading: LiveData<Bool> = LiveData(data: false)

		var onSelect: ((TVShow) -> Void)?
		var onLogout: (() -> Void)?

		// MARK: Private variables

		private var dataProvider: ShowsListDataProviderType

		// MARK: Initializer

		init(dataProvider: ShowsListDataProviderType) {
			self.dataProvider = dataProvider
			setupContent()
		}
	}
}

private extension ShowsList.VM {
	func setupContent() {
		headerContent.data = ShowsList.HeaderView.Content(
			title: LocalizationKit.showsList.title,
			iconName: "ic-logout",
			action: { [unowned self] in
				self.onLogout?()
			}
		)
	}
}

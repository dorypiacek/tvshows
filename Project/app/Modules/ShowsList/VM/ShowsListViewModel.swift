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
	var tableContent: LiveData<[ShowsList.Cell.Content]> { get }
	var headerContent: LiveOptionalData<ShowsList.HeaderView.Content> { get }
	func load()
}

extension ShowsList {
	final class VM: ShowsListVMType {

		// MARK: Public variables

		var tableContent: LiveData<[Cell.Content]> = LiveData(data: [])
		var headerContent: LiveOptionalData<HeaderView.Content> = LiveOptionalData(data: nil)

		var onSelect: ((TVShow) -> Void)?
		var onLogout: (() -> Void)?

		// MARK: Private variables

		private var dataProvider: ShowsListDataProviderType
		private var shows: [TVShow] = []

		// MARK: Initializer

		init(dataProvider: ShowsListDataProviderType) {
			self.dataProvider = dataProvider
			setupContent()
		}

		// MARK: - Public methods

		func load() {
			dataProvider
				.loadShows()
				.done { data in
					self.shows = data.data
					self.setupContent()
				}
				.catch { error in
					// TODO: Implement error & empty placeholder
				}
		}
	}
}

private extension ShowsList.VM {

	// MARK: - Private methods

	func setupContent() {
		setupHeader()
		setupTableContent()
	}

	func setupHeader() {
		headerContent.data = ShowsList.HeaderView.Content(
			title: LocalizationKit.showsList.title,
			iconName: "ic-logout",
			action: { [unowned self] in
				self.onLogout?()
			}
		)
	}

	func setupTableContent() {
		tableContent.data =	shows.map { show in
			let url = try? Endpoint.image(show.imageUrl).url.asURL()
			return ShowsList.Cell.Content(
				id: show.id,
				imageURL: url,
				title: show.title,
				didSelect: { [unowned self] in
					self.onSelect?(show)
				}
			)
		}
	}
}

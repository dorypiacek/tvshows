//
//  ShowsListVM.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding

final class ShowsListVM: ShowsListVMType {

	// MARK: Public variables

	var tableContent: LiveData<[ShowsListCell.Content]> = LiveData(data: [])
	var headerContent: LiveOptionalData<ShowsListHeaderView.Content> = LiveOptionalData(data: nil)

	var onSelect: ((TVShowId) -> Void)?
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
			print(error.localizedDescription)
		}
	}
}

private extension ShowsListVM {

	// MARK: - Private methods

	func setupContent() {
		setupHeader()
		setupTableContent()
	}

	func setupHeader() {
		headerContent.data = ShowsListHeaderView.Content(
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
			return ShowsListCell.Content(
				id: show.id,
				imageURL: url,
				title: show.title,
				didSelect: { [unowned self] in
					self.onSelect?(show.id)
				}
			)
		}
	}
}

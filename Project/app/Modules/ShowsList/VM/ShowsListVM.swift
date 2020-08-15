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
	enum State {
		case loading
		case loaded
		case error
	}

	// MARK: Public properties

	var tableContent: LiveData<[ShowsListCell.Content]> = LiveData(data: [])
	var headerContent: LiveOptionalData<ShowsListHeaderView.Content> = LiveOptionalData(data: nil)
	var placeholderContent: LiveOptionalData<PlaceholderView.Content> = LiveOptionalData(data: nil)

	var onSelect: ((TVShow) -> Void)?
	var onLogout: (() -> Void)?

	// MARK: Private properties

	private var dataProvider: ShowsListDataProviderType
	private var shows: [TVShow] = []
	private var state: State = .loading {
		didSet {
			updatePlaceholder()
		}
	}

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
				self.state = .loaded
			}
			.catch { error in
				self.state = .error
			}
	}
}

private extension ShowsListVM {

	// MARK: - Private methods

	func setupContent() {
		setupHeader()
		setupTableContent()
		updatePlaceholder()
	}

	func setupHeader() {
		headerContent.data = ShowsListHeaderView.Content(
			title: LocalizationKit.showsList.title,
			iconName: "ic-logout",
			action: { [weak self] in
				self?.onLogout?()
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
				didSelect: { [weak self] in
					self?.onSelect?(show)
				}
			)
		}
	}

	func updatePlaceholder() {
		switch state {
		case .loading:
			placeholderContent.data = PlaceholderView.Content(
				title: LocalizationKit.general.loading,
				isLoading: true
			)
		case .error:
			placeholderContent.data = PlaceholderView.Content(
				title: LocalizationKit.general.errorTitle,
				subtitle: LocalizationKit.general.errorMessage,
				isLoading: false,
				button: ButtonContent(
					title: LocalizationKit.general.tryAgain,
					action: { [weak self] in
						self?.load()
					}
				)
			)
		case .loaded:
			placeholderContent.data = nil
		}
	}
}

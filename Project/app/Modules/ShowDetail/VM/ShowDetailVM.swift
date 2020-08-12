//
//  ShowDetailVM.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding
import PromiseKit

typealias ShowDetailTableSection = (header: EpisodeTableHeaderView.Content, rows: [EpisodeCell.Content])

final class ShowDetailVM: ShowDetailVMType {

	// MARK: - Public variables

	var title: LiveOptionalData<String> = LiveOptionalData(data: nil)
	var description: LiveOptionalData<String> = LiveOptionalData(data: nil)
	var headerContent: LiveOptionalData<ShowDetailHeaderView.Content> = LiveOptionalData(data: nil)
	var tableContent: LiveData<[ShowDetailTableSection]> = LiveData(data: [])
	var isLoading: LiveData<Bool> = LiveData(data: false)

	var onBackTapped: (() -> Void)?

	// MARK: Private variables

	private let dataProvider: ShowDetailDataProviderType
	private let showId: TVShowId

	private var show: TVShowDetail?
	private var episodes: [TVShowEpisode] = []

	// MARK: - Initializer

	init(dataProvider: ShowDetailDataProviderType, showId: TVShowId) {
		self.dataProvider = dataProvider
		self.showId = showId
		load()
	}

	// MARK: Public methods

	func load() {
		isLoading.data = true
		dataProvider
			.showDetail(with: showId)
			.then { show -> Promise<Data<[TVShowEpisode]>> in
				self.show = show.data
				self.setupContent()
				return self.dataProvider.episodes(for: self.showId)
			}
			.done { episodes in
				self.episodes = episodes.data
				self.setupContent()
			}
			.ensure {
				self.isLoading.data = false
			}
			.catch { error in
				print(error.localizedDescription)
			}
	}
}

// MARK: Private methods

private extension ShowDetailVM {
	func setupContent() {
		title.data = show?.title
		description.data = show?.description

		setupHeaderContent()
		setupTableContent()
	}

	func setupHeaderContent() {
		guard let show = show else {
			return
		}
		let url = try? Endpoint.image(show.imageUrl).url.asURL()
		headerContent.data = ShowDetailHeaderView.Content(
			imageUrl: url,
			backAction: { [weak self] in
				self?.onBackTapped?()
			}
		)
	}

	func setupTableContent() {
		let header = EpisodeTableHeaderView.Content(title: LocalizationKit.showDetail.title, count: String(episodes.count))
		let rows = episodes.map { episode in
			EpisodeCell.Content(
				episode: "S\(episode.season) Ep\(episode.episodeNumber)",
				title: episode.title
			)
		}
		tableContent.data = [ShowDetailTableSection(header: header, rows: rows)]
	}
}

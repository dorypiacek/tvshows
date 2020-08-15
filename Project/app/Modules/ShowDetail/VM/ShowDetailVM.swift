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

	// MARK: - Public properties

	/// Episode title
	var title: LiveOptionalData<String> = LiveOptionalData(data: nil)
	/// Episode description
	var description: LiveOptionalData<String> = LiveOptionalData(data: nil)
	/// Header content, contains episode image URL and back navigation action, shows loading if needed
	var headerContent: LiveOptionalData<ShowDetailHeaderView.Content> = LiveOptionalData(data: nil)
	/// Table view content
	var tableContent: LiveData<[ShowDetailTableSection]> = LiveData(data: [])
	/// Defines when to show/hide refresh control
	var isEpisodesLoading: LiveData<Bool> = LiveData(data: false)

	var onBackTapped: (() -> Void)?

	// MARK: - Private properties

	private let dataProvider: ShowDetailDataProviderType
	private let showPreview: TVShow

	private var showDetail: TVShowDetail?
	private var episodes: [TVShowEpisode] = []

	private var isShowLoading: Bool = false {
		didSet {
			setupContent()
		}
	}

	// MARK: - Initializer

	init(dataProvider: ShowDetailDataProviderType, showPreview: TVShow) {
		self.dataProvider = dataProvider
		self.showPreview = showPreview
		setupContent()
		load()
	}

	// MARK: - Public methods

	/// Loads TV Show detail, then episodes and updates content accordingly.
	func load() {
		isShowLoading = true
		dataProvider
			.showDetail(with: showPreview.id)
			.done { show in
				self.showDetail = show.data
				self.isShowLoading = false
			}
			.ensure {
				self.loadEpisodes()
			}
			.catch { error in
				self.isShowLoading = false
				print(error.localizedDescription)
			}
	}
}

// MARK: - Private methods

private extension ShowDetailVM {
	func loadEpisodes() {
		dataProvider
			.episodes(for: showDetail?.id ?? showPreview.id)
			.done { episodes in
				self.episodes = episodes.data
				self.setupTableContent()
			}
			.ensure {
				self.isEpisodesLoading.data = false
			}
			.catch { error in
				self.setupTableContent(error: true)
				print(error.localizedDescription)
			}
	}

	// MARK: - Content

	func setupContent() {
		title.data = showDetail?.title ?? showPreview.title
		description.data = showDetail?.description

		setupHeaderContent()
		setupTableContent()
	}

	func setupHeaderContent() {
		let url = try? Endpoint.image(showDetail?.imageUrl ?? "").url.asURL()
		headerContent.data = ShowDetailHeaderView.Content(
			imageUrl: url,
			isLoading: isShowLoading,
			backAction: { [weak self] in
				self?.onBackTapped?()
			}
		)
	}

	func setupTableContent(error: Bool = false) {
		let header = EpisodeTableHeaderView.Content(
			title: LocalizationKit.showDetail.title,
			count: error ? LocalizationKit.showDetail.episodesLoadingFailed : String(episodes.count),
			hasError: error
		)
		let rows = episodes.map { episode in
			EpisodeCell.Content(
				episode: "S\(episode.season) Ep\(episode.episodeNumber)",
				title: episode.title
			)
		}
		tableContent.data = [ShowDetailTableSection(header: header, rows: rows)]
	}
}

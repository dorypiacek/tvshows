//
//  EpisodeCell.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

final class EpisodeCell: UITableViewCell {

	// MARK: - Private variables

	private let episodeLabel = UILabel()
	private let titleLabel = UILabel()

	override func layoutSubviews() {
		super.layoutSubviews()

		setupUI()
	}

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	func update(with content: Content) {
		titleLabel.text = content.title
		episodeLabel.text = content.episode
	}
}

// MARK: - Content

extension EpisodeCell {
	struct Content {
		let episode: String
		let title: String
	}
}

// MARK: - Private methods

private extension EpisodeCell {
	func setupUI() {
		addSubview(episodeLabel)
		addSubview(titleLabel)

		setupEpisodeLabel()
		setupTitleLabel()
	}

	func setupEpisodeLabel() {
		episodeLabel.numberOfLines = 0
		episodeLabel.font = StyleKit.font.callout
		episodeLabel.textColor = StyleKit.color.brand
		episodeLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(StyleKit.metrics.padding.large)
		}
	}

	func setupTitleLabel() {
		titleLabel.numberOfLines = 0
		titleLabel.font = StyleKit.font.callout
		titleLabel.textColor = StyleKit.color.defaultText
		titleLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalTo(episodeLabel.snp.trailing).offset(StyleKit.metrics.padding.medium)
			make.trailing.equalToSuperview().inset(StyleKit.metrics.padding.large)
		}
	}
}

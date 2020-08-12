//
//  EpisodeTableViewHeader.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 10/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

final class EpisodeTableHeaderView: UITableViewHeaderFooterView {

	// MARK: - Private variables

	private let titleLabel = UILabel()
	private let countLabel = UILabel()

	// MARK: - Initializers

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	func update(with content: Content) {
		titleLabel.text = content.title
		countLabel.text = content.count
	}
}

// MARK: - Content

extension EpisodeTableHeaderView {
	struct Content {
		let title: String
		let count: String
	}
}

// MARK: - Private methods

private extension EpisodeTableHeaderView {
	func setupUI() {
		contentView.backgroundColor = .white

		contentView.addSubview(titleLabel)
		contentView.addSubview(countLabel)

		titleLabel.textColor = StyleKit.color.darkGrayText
		titleLabel.font = StyleKit.font.title3
		titleLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(StyleKit.metrics.padding.large)
			make.centerY.equalToSuperview()
		}

		countLabel.textColor = StyleKit.color.lightGrayText
		countLabel.font = StyleKit.font.title3
		countLabel.snp.makeConstraints { make in
			make.leading.equalTo(titleLabel.snp.trailing).offset(StyleKit.metrics.padding.medium)
			make.trailing.lessThanOrEqualToSuperview().inset(StyleKit.metrics.padding.large)
			make.centerY.equalToSuperview()
		}
	}
}

//
//  ShowsListCell.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension ShowsList {
	final class Cell: UITableViewCell {
		struct Content {
			let id: String
			let imageURL: URL?
			let title: String
			let didSelect: () -> Void
		}

		private let titleLabel = UILabel()
		private let thumbnailImageView = UIImageView()

		override func layoutSubviews() {
			super.layoutSubviews()
			setupUI()
		}

		override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: .default, reuseIdentifier: reuseIdentifier)
			setupUI()
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		func update(with content: Content) {
			titleLabel.text = content.title
			thumbnailImageView.kf.setImage(with: content.imageURL)
		}
	}
}

private extension ShowsList.Cell {
	func setupUI() {
		contentView.addSubview(thumbnailImageView)
		contentView.addSubview(titleLabel)

		setupImage()
		setupTitle()
	}

	func setupTitle() {
		titleLabel.font = StyleKit.font.body
		titleLabel.textColor = StyleKit.color.defaultText
		titleLabel.numberOfLines = 0
		titleLabel.snp.makeConstraints { make in
			make.leading.equalTo(thumbnailImageView.snp.trailing).offset(StyleKit.metrics.padding.medium)
			make.top.equalTo(thumbnailImageView).offset(StyleKit.metrics.padding.verySmall)
		}
	}

	func setupImage() {
		thumbnailImageView.contentMode = .scaleAspectFill
		thumbnailImageView.layer.cornerRadius = StyleKit.metrics.smallCornerRadius
		thumbnailImageView.clipsToBounds = true
		thumbnailImageView.snp.makeConstraints { make in
			make.size.equalTo(Metrics.thumbnailSize)
			make.top.bottom.equalToSuperview().inset(StyleKit.metrics.padding.verySmall / 2)
			make.leading.equalToSuperview().offset(StyleKit.metrics.padding.medium)
		}
	}
}

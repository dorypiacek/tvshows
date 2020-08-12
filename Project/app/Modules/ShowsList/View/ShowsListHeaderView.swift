//
//  ShowsListHeaderView.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

final class ShowsListHeaderView: UIView {

	// MARK: - Private variables

	private let titleLabel = UILabel()
	private let button = UIButton()

	// MARK: - Initializers

	init() {
		super.init(frame: .zero)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	func update(with content: Content) {
		titleLabel.text = content.title
		button.setImage(StyleKit.image.make(from: content.iconName), for: .normal)
		button.replaceAction(for: .touchUpInside, content.action)
	}
}

// MARK: - Content

extension ShowsListHeaderView {
	struct Content {
		let title: String
		let iconName: String
		let action: () -> Void
	}
}

// MARK: - Private methods

private extension ShowsListHeaderView {
	func setupUI() {
		addSubview(titleLabel)
		addSubview(button)

		setupTitle()
		setupButton()
	}

	func setupTitle() {
		titleLabel.font = StyleKit.font.title1
		titleLabel.textColor = StyleKit.color.darkGrayText
		titleLabel.numberOfLines = 0
		titleLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.trailing.lessThanOrEqualTo(button.snp.leading)
			make.top.bottom.equalToSuperview().inset(StyleKit.metrics.padding.medium)
		}
	}

	func setupButton() {
		button.snp.makeConstraints { make in
			make.centerY.equalTo(titleLabel)
			make.trailing.equalToSuperview()
		}
	}
}

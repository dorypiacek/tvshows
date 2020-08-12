//
//  ShowDetailHeaderView.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

final class ShowDetailHeaderView: UIView {

	// MARK: - Private variables

	private let imageView = UIImageView()
	private let backButton = UIButton(type: .system)
	private let gradientView = UIView()
	private let gradientLayer = CAGradientLayer()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - View lifecycle

	override func layoutSubviews() {
		super.layoutSubviews()
		updateGradient()
	}

	// MARK: - Public methods

	func update(with content: Content) {
		DispatchQueue.main.async { [weak self] in
			self?.imageView.kf.indicatorType = .activity
			self?.imageView.kf.setImage(
				with: content.imageUrl,
				options: [.transition(.fade(1))]
			)
		}
		backButton.replaceAction(for: .touchUpInside, content.backAction)
	}
}

// MARK: - Content

extension ShowDetailHeaderView {
	struct Content {
		let imageUrl: URL?
		let backAction: () -> Void
	}
}

// MARK: - Private methods

private extension ShowDetailHeaderView {
	func setupUI() {
		addSubview(imageView)
		imageView.addSubview(backButton)
		imageView.addSubview(gradientView)

		setupImageView()
		setupButton()
		setupGradient()
	}

	func setupImageView() {
		imageView.backgroundColor = StyleKit.color.separator
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.isUserInteractionEnabled = true
		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	func setupButton() {
		let image = UIImage(named: StyleKit.image.navigation.back)?.withRenderingMode(.alwaysOriginal)
		backButton.setImage(image, for: .normal)
		backButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(StyleKit.metrics.padding.medium)
			make.top.equalTo(safeAreaLayoutGuide.snp.top).offset( StyleKit.metrics.padding.medium)
		}
	}

	func setupGradient() {
		gradientLayer.colors = [
			UIColor.white.withAlphaComponent(0).cgColor,
			UIColor.white.withAlphaComponent(0.5).cgColor,
			UIColor.white.withAlphaComponent(1).cgColor
		]
		gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
		gradientLayer.locations = [0.0, 0.5, 1.0]
		imageView.layer.insertSublayer(gradientLayer, at: 0)
		updateGradient()
	}

	func updateGradient() {
		let y = imageView.bounds.height - StyleKit.metrics.gradientHeight
		gradientLayer.frame = CGRect(x: 0, y: y, width: imageView.bounds.width, height: StyleKit.metrics.gradientHeight)
	}
}

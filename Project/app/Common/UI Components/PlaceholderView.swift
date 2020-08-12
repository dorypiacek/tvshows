//
//  PlaceholderView.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 12/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

typealias ButtonContent = (title: String, action: () -> Void)

final class PlaceholderView: UIView {

	// MARK: - Private variables

	private let stackView = UIStackView()
	private let titleLabel = UILabel()
	private var subtitleLabel: UILabel?
	private var activityIndicator: UIActivityIndicatorView?
	private var button: UIButton?

	// MARK: - Initializer

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	func update(with content: Content) {
		titleLabel.text = content.title

		if let subtitle = content.subtitle {
			setupSubtitle(with: subtitle)
		} else {
			subtitleLabel?.removeFromSuperview()
			subtitleLabel = nil
		}

		if content.isLoading {
			setupActivityIndicator()
			activityIndicator?.startAnimating()
		} else {
			activityIndicator?.stopAnimating()
			activityIndicator?.removeFromSuperview()
			activityIndicator = nil
		}

		if let buttonContent = content.button {
			setupButton(with: buttonContent)
		} else {
			button?.removeFromSuperview()
			button = nil
		}
	}
}

extension PlaceholderView {
	struct Content {
		let title: String
		let subtitle: String?
		let isLoading: Bool
		let button: ButtonContent?

		init(title: String, subtitle: String? = nil, isLoading: Bool = false, button: ButtonContent? = nil) {
			self.title = title
			self.subtitle = subtitle
			self.isLoading = isLoading
			self.button = button
		}
	}
}

private extension PlaceholderView {
	func setupUI() {
		addSubview(stackView)
		stackView.addArrangedSubview(titleLabel)

		setupBlur()
		setupStackView()
		setupTitle()
	}

	func setupBlur() {
		if !UIAccessibility.isReduceTransparencyEnabled {
			backgroundColor = .clear

			let blurEffect = UIBlurEffect(style: .light)
			let blurEffectView = UIVisualEffectView(effect: blurEffect)
			insertSubview(blurEffectView, at: 0)
			blurEffectView.snp.makeConstraints { make in
				make.edges.equalToSuperview()
			}
		} else {
			backgroundColor = .white
		}
	}

	func setupStackView() {
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = StyleKit.metrics.padding.medium
		stackView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.large)
		}
	}

	func setupTitle() {
		titleLabel.font = StyleKit.font.title2
		titleLabel.textColor = StyleKit.color.darkGrayText
		titleLabel.textAlignment = .center
		titleLabel.numberOfLines = 0
	}

	func setupSubtitle(with text: String) {
		if subtitleLabel == nil {
			subtitleLabel = UILabel()
		}
		subtitleLabel?.text = text
		subtitleLabel?.font = StyleKit.font.body
		subtitleLabel?.textColor = StyleKit.color.defaultText
		subtitleLabel?.textAlignment = .center
		subtitleLabel?.numberOfLines = 0
		if let subtitleLabel = subtitleLabel {
			stackView.addArrangedSubview(subtitleLabel)
		}
	}

	func setupButton(with content: ButtonContent) {
		if button == nil {
			button = UIButton()
		}
		button?.titleLabel?.font = StyleKit.font.title3
		button?.titleLabel?.textAlignment = .center
		button?.setTitleColor(StyleKit.color.brand, for: .normal)
		button?.setTitle(content.title, for: .normal)
		button?.replaceAction(for: .touchUpInside, content.action)
		if let button = button {
			stackView.addArrangedSubview(button)
		}
	}

	func setupActivityIndicator() {
		if activityIndicator == nil {
			activityIndicator = UIActivityIndicatorView(style: .gray)
		}
		if let activityIndicator = activityIndicator {
			stackView.addArrangedSubview(activityIndicator)
		}
		activityIndicator?.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
		}
	}
}

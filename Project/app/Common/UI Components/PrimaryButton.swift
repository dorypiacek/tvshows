//
//  PrimaryButton.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class PrimaryButton: UIButton {
	struct Content {
		let title: String
		let isEnabled: Bool
		let isLoading: Bool
		let action: () -> Void
	}

	// MARK: - Variables
	// MARK: - Private

	private var activityIndicator: UIActivityIndicatorView?

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func update(with content: Content) {
		setTitle(content.isLoading ? "" : content.title, for: .normal)
		replaceAction(for: .touchUpInside, content.action)
		backgroundColor = content.isEnabled ? StyleKit.color.brand : StyleKit.color.buttonDisabled
		isEnabled = content.isEnabled && !content.isLoading
		content.isLoading ? startLoading() : stopLoading()
	}
}

private extension PrimaryButton {
	func setupUI() {
		backgroundColor = StyleKit.color.brand
		titleLabel?.font = StyleKit.font.callout
		titleLabel?.textColor = StyleKit.color.buttonTitle
		layer.cornerRadius = StyleKit.metrics.cornerRadius
	}

	func startLoading() {
		guard activityIndicator == nil else {
			return
		}
		activityIndicator = UIActivityIndicatorView(style: .white)

		if let activity = activityIndicator {
			addSubview(activity)
			activity.snp.makeConstraints { make in
				make.center.equalToSuperview()
			}
			activity.startAnimating()
		}
	}

	func stopLoading() {
		activityIndicator?.stopAnimating()
		activityIndicator?.removeFromSuperview()
		activityIndicator = nil
	}
}

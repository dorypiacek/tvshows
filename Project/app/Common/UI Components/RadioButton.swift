//
//  RadioButton.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

final class RadioButton: UIButton {
	struct Content {
		let title: String
		let isSelected: Bool
		let action: () -> Void
	}

	// MARK: - Innitializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	func update(with content: Content) {
		setTitle(content.title, for: .normal)
		isSelected = content.isSelected
		replaceAction(for: .touchUpInside, content.action)
	}
}

private extension RadioButton {

	// MARK: - Private

	func setupUI() {
		setImage(UIImage(named: "ic-checkbox-empty"), for: .normal)
		setImage(UIImage(named: "ic-checkbox-filled"), for: .selected)
		setTitleColor(StyleKit.color.defaultText, for: .normal)
		titleLabel?.font = StyleKit.font.callout
		titleLabel?.textAlignment = .left
	}
}

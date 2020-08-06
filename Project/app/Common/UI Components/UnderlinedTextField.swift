//
//  UnderlinedTextField.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import JVFloatLabeledTextField

final class UnderlinedTextField: JVFloatLabeledTextField {

	// MARK: - Private variables

    private let separator = UIView()
	private var rightViewButton: UIButton?

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
	}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - Override methods

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		bounds.insetBy(dx: 0, dy: StyleKit.metrics.padding.small)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		bounds.insetBy(dx: 0, dy: StyleKit.metrics.padding.small)
	}

	// MARK: - Public methods

    func update(with content: Content) {
        text = content.text
        placeholder = content.placeholder
        keyboardType = content.keyboardType
		returnKeyType = content.returnKeyType
		isSecureTextEntry = content.isSecured
        replaceAction(for: .editingChanged) { [unowned self] in
            content.textDidChange?(self.text ?? "")
        }

		updateRightView(with: content.rightView)
    }
}

private extension UnderlinedTextField {

	// MARK: - Private methods

    func setupUI() {
		font = StyleKit.font.title3
		textColor = StyleKit.color.darkGrayText
		floatingLabelFont = StyleKit.font.caption1
		floatingLabelTextColor = StyleKit.color.lightGrayText
		tintColor = StyleKit.color.lightGrayText
		attributedPlaceholder = NSAttributedString(string: "", attributes: [.foregroundColor: StyleKit.color.lightGrayText])
        returnKeyType = .done
        replaceAction(for: .editingDidEndOnExit) { [unowned self] in
            self.resignFirstResponder()
        }

        separator.backgroundColor = StyleKit.color.separator
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(StyleKit.metrics.separator)
        }
    }

	func updateRightView(with content: RightViewContent?) {
		if let content = content {
			if rightViewButton == nil {
				rightViewButton = UIButton(type: .custom)
			}
			rightViewMode = .always
			rightView = rightViewButton
			rightViewButton?.isSelected = content.isSelected
			rightViewButton?.setImage(UIImage(named: content.isSelected ? content.selectedIcon : content.normalIcon), for: .normal)
			rightViewButton?.replaceAction(for: .touchUpInside, content.action)
		} else {
			rightViewButton = nil
			rightView = nil
			rightViewMode = .never
		}
	}
}

// MARK: - Content

extension UnderlinedTextField {
	struct RightViewContent {
		var normalIcon: String
		var selectedIcon: String
		var isSelected: Bool
		var action: (() -> Void)
	}

	struct Content {
		let text: String?
		var placeholder: String?
		let textDidChange: ((String) -> Void)?
		let keyboardType: UIKeyboardType
		let returnKeyType: UIReturnKeyType
		let isSecured: Bool
		let rightView: RightViewContent?

		init(text: String?, placeholder: String?, textDidChange: ((String) -> Void)?, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, isSecured: Bool = false, rightView: RightViewContent? = nil) {
			self.text = text
			self.placeholder = placeholder
			self.textDidChange = textDidChange
			self.keyboardType = keyboardType
			self.returnKeyType = returnKeyType
			self.isSecured = isSecured
			self.rightView = rightView
		}
	}
}

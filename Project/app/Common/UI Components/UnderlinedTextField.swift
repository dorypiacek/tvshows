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

final class UnderlinedTextField: UITextField {
    private let separator = UIView()

    var validator: InputValidatorType?

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
	}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		bounds.insetBy(dx: 0, dy: StyleKit.metrics.padding.small)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		bounds.insetBy(dx: 0, dy: StyleKit.metrics.padding.small)
	}

    private func setupUI() {
		font = StyleKit.font.title3
		textColor = StyleKit.color.darkGrayText
		attributedPlaceholder = NSAttributedString(string: "", attributes: [.foregroundColor: StyleKit.color.lightGrayText])
        smartInsertDeleteType = .no
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

    func update(with content: Content) {
        text = content.text
        placeholder = content.placeholder
        keyboardType = content.keyboardType
		returnKeyType = content.returnKeyType
        replaceAction(for: .editingChanged) { [unowned self] in
            content.textDidChange?(self.text ?? "")
        }

        if content.error {
            tintColor = StyleKit.color.brand
			textColor = StyleKit.color.brand
			attributedPlaceholder = NSAttributedString(string: content.placeholder ?? "", attributes: [.foregroundColor: StyleKit.color.brand])
            separator.backgroundColor = StyleKit.color.brand
        } else {
            textColor = StyleKit.color.darkGrayText
            tintColor = StyleKit.color.darkGrayText
            attributedPlaceholder = NSAttributedString(string: content.placeholder ?? "", attributes: [.foregroundColor: StyleKit.color.lightGrayText])
			separator.backgroundColor = StyleKit.color.separator
        }

        validator = content.validator
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let validator = validator else {
            return true
        }

        return validator.shouldChangeCharacters(of: textField.text, in: range, replacementString: string)
    }
}

extension UnderlinedTextField {
	struct Content {
		let text: String?
		let error: Bool
		var placeholder: String?
		let textDidChange: ((String) -> Void)?
		let keyboardType: UIKeyboardType
		let returnKeyType: UIReturnKeyType
		let validator: InputValidatorType?

		init(text: String?, error: Bool, placeholder: String?, textDidChange: ((String) -> Void)?, keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, validator: InputValidatorType? = nil) {
			self.text = text
			self.error = error
			self.placeholder = placeholder
			self.textDidChange = textDidChange
			self.keyboardType = keyboardType
			self.validator = validator
			self.returnKeyType = returnKeyType
		}
	}
}

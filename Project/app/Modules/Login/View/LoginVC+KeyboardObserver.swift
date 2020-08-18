//
//  LoginVC+KeyboardObserver.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 16/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

extension LoginVC {
	func registerKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	func unregisterKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	@objc func keyboardWillShow(notification: Notification) {
		let keyboardFrame: CGRect? = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		let animationDuration: TimeInterval = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
		let animationOptions = UIView.AnimationOptions(rawValue: (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? UIView.AnimationOptions.curveEaseIn.rawValue)

		view.layoutIfNeeded()
		stackView.snp.remakeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(2 * StyleKit.metrics.padding.large).priority(.low)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
			make.bottom.lessThanOrEqualToSuperview().offset(-(keyboardFrame?.size.height ?? 0))
		}
		UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationOptions, animations: { [weak self] in
			//self?.imageView.alpha = 0
			//self?.imageView.isHidden = true
			self?.view.layoutIfNeeded()
		}, completion: nil)
	}

	@objc func keyboardWillHide(notification: Notification) {
		let animationDuration: TimeInterval = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
		let animationOptions = UIView.AnimationOptions(rawValue: (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? UIView.AnimationOptions.curveEaseIn.rawValue)

		view.layoutIfNeeded()
		stackView.snp.remakeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(2 * StyleKit.metrics.padding.large)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
			make.bottom.lessThanOrEqualToSuperview()
		}
		UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationOptions, animations: { [weak self] in
			//self?.imageView.alpha = 1
			//self?.imageView.isHidden = false
			self?.view.layoutIfNeeded()
		}, completion: nil)
	}
}

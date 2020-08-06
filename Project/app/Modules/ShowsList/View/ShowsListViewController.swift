//
//  ShowsListViewController.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit
import ETBinding

extension ShowsList {
	final class VC: UIViewController {

		// MARK: Private variables

		private var vm: ShowsListVMType

		private let tableView = UITableView()
		private let headerView = HeaderView()

		// MARK: - Initializers

		init(vm: ShowsListVMType) {
			self.vm = vm
			super.init(nibName: nil, bundle: nil)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		// MARK: - ViewController lifecycle

		override func loadView() {
			super.loadView()
			setupUI()
		}

		override func viewDidLoad() {
			super.viewDidLoad()
			bind()
		}
	}
}

private extension ShowsList.VC {
	func setupUI() {
		view.backgroundColor = .white
		view.addSubview(headerView)
		setupHeader()
	}

	func bind() {
		vm.headerContent.observe(owner: self) { [weak self] content in
			if let content = content {
				self?.headerView.update(with: content)
			}
		}
		vm.headerContent.dispatch()
	}

	func setupHeader() {
		headerView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
		}
	}
}

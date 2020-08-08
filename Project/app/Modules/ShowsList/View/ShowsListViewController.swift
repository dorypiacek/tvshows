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

		private let reuseIdentifier = "ShowsListCell"
		private var content: [Cell.Content] = [] {
			didSet {
				tableView.reloadData()
			}
		}

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
			vm.load()
		}
	}
}

private extension ShowsList.VC {

	// MARK: - Private methods

	func setupUI() {
		view.backgroundColor = .white

		view.addSubview(headerView)
		view.addSubview(tableView)

		setupHeader()
		setupTableView()
	}

	func bind() {
		vm.headerContent.observe(owner: self) { [weak self] content in
			if let content = content {
				self?.headerView.update(with: content)
			}
		}
		vm.headerContent.dispatch()
		vm.tableContent.observe(owner: self) { [weak self] content in
			self?.content = content
		}
		vm.tableContent.dispatch()
	}

	func setupHeader() {
		headerView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.medium)
		}
	}

	func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.register(ShowsList.Cell.self, forCellReuseIdentifier: reuseIdentifier)
		tableView.snp.makeConstraints { make in
			make.top.equalTo(headerView.snp.bottom)
			make.leading.trailing.bottom.equalToSuperview()
		}
	}
}

extension ShowsList.VC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		vm.tableContent.data[indexPath.row].didSelect()
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension ShowsList.VC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		vm.tableContent.data.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ShowsList.Cell else {
			let cell = ShowsList.Cell(style: .default, reuseIdentifier: reuseIdentifier)
			cell.update(with: vm.tableContent.data[indexPath.row])
			return cell
		}

		cell.update(with: vm.tableContent.data[indexPath.row])
		return cell
	}
}

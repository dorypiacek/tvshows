//
//  ShowsListVC.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 06/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit
import ETBinding

final class ShowsListVC: UIViewController {

	// MARK: Private variables

	private var vm: ShowsListVMType

	private let tableView = UITableView()
	private let headerView = ShowsListHeaderView()

	private var placeholderView: PlaceholderView?

	private let reuseIdentifier = "ShowsListCell"
	private var content: [ShowsListCell.Content] = [] {
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
		bindObservers()
		vm.load()
	}
}

private extension ShowsListVC {

	// MARK: - Private methods

	func setupUI() {
		view.backgroundColor = .white

		view.addSubview(headerView)
		view.addSubview(tableView)

		setupHeader()
		setupTableView()
	}

	func bindObservers() {
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
		vm.placeholderContent.observe(owner: self) { [weak self] content in
			if let content = content {
				if let placeholderView = self?.placeholderView {
					placeholderView.update(with: content)
				} else {
					self?.showPlaceholder(with: content)
				}
			} else {
				self?.hidePlaceholder()
				self?.placeholderView = nil
			}
		}
		vm.placeholderContent.dispatch()
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
		tableView.register(ShowsListCell.self, forCellReuseIdentifier: reuseIdentifier)
		tableView.snp.makeConstraints { make in
			make.top.equalTo(headerView.snp.bottom)
			make.leading.trailing.bottom.equalToSuperview()
		}
	}

	func showPlaceholder(with content: PlaceholderView.Content) {
		placeholderView = PlaceholderView()
		placeholderView?.update(with: content)

		guard let placeholderView = placeholderView else {
			return
		}

		UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
			self.view.insertSubview(placeholderView, aboveSubview: self.tableView)
			placeholderView.snp.makeConstraints { make in
				make.top.equalTo(self.headerView.snp.bottom)
				make.leading.trailing.bottom.equalToSuperview()
			}
		}, completion: nil)
	}

	func hidePlaceholder() {
		UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
			self.placeholderView?.removeFromSuperview()
		}, completion: nil)
	}
}

extension ShowsListVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		vm.tableContent.data[indexPath.row].didSelect()
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension ShowsListVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		vm.tableContent.data.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ShowsListCell else {
			let cell = ShowsListCell(style: .default, reuseIdentifier: reuseIdentifier)
			cell.update(with: vm.tableContent.data[indexPath.row])
			return cell
		}

		cell.update(with: vm.tableContent.data[indexPath.row])
		return cell
	}
}

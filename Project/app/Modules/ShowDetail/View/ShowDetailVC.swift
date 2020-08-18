//
//  ShowDetailVC.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding
import UIKit

final class ShowDetailVC: UIViewController {

	// MARK: - Private properties

	private let vm: ShowDetailVMType

	private let scrollView = UIScrollView()
	private let headerView = ShowDetailHeaderView()
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let tableView = UITableView()

	private var tableContent: [ShowDetailTableSection] = [] {
		didSet {
			tableView.reloadData()
		}
	}

	private let cellReuseIdentifier = "EpisodeCell"
	private let headerReuseIdentifier = "EpisodeHeader"

	// MARK: - Initializers

	init(vm: ShowDetailVMType) {
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
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		.lightContent
	}
}

// MARK: - Private methods

private extension ShowDetailVC {
	func bindObservers() {
		vm.title.observe(owner: self) { [weak titleLabel] title in
			titleLabel?.text = title
		}
		vm.title.dispatch()
		vm.description.observe(owner: self) { [weak descriptionLabel] description in
			descriptionLabel?.text = description
		}
		vm.description.dispatch()
		vm.headerContent.observe(owner: self) { [weak headerView] content in
			if let content = content {
				headerView?.update(with: content)
			}
		}
		vm.headerContent.dispatch()
		vm.tableContent.observe(owner: self) { [weak self] content in
			self?.tableContent = content
		}
		vm.tableContent.dispatch()
		vm.isEpisodesLoading.observe(owner: self) { [weak tableView] loading in
			loading ? tableView?.refreshControl?.beginRefreshing() : tableView?.refreshControl?.endRefreshing()
		}
		vm.isEpisodesLoading.dispatch()
	}

	func setupUI() {
		view.backgroundColor = .white
		navigationController?.isNavigationBarHidden = true

		[headerView, titleLabel, descriptionLabel, tableView].forEach { view.addSubview($0) }

		setupHeader()
		setupTitle()
		setupDescription()
		setupTableView()
	}

	func setupHeader() {
		headerView.snp.makeConstraints { make in
			make.leading.trailing.top.equalToSuperview()
			make.height.equalToSuperview().multipliedBy(0.25)
		}
	}

	func setupTitle() {
		titleLabel.font = StyleKit.font.title1
		titleLabel.textColor = StyleKit.color.darkGrayText
		titleLabel.numberOfLines = 0
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(headerView.snp.bottom).offset(StyleKit.metrics.padding.medium)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.large)
		}
	}

	func setupDescription() {
		descriptionLabel.font = StyleKit.font.callout
		descriptionLabel.textColor = StyleKit.color.defaultText
		descriptionLabel.numberOfLines = 0
		descriptionLabel.adjustsFontSizeToFitWidth = true
		descriptionLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(StyleKit.metrics.padding.medium)
			make.leading.trailing.equalToSuperview().inset(StyleKit.metrics.padding.large)
			make.height.lessThanOrEqualToSuperview().multipliedBy(0.25)
		}
	}

	func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.backgroundColor = .white
		tableView.register(EpisodeCell.self, forCellReuseIdentifier: cellReuseIdentifier)

		let refresh = UIRefreshControl()
		refresh.addAction(for: .valueChanged) { [weak self] in
			self?.vm.load()
		}
		tableView.refreshControl = refresh
		tableView.snp.makeConstraints { make in
			make.top.equalTo(descriptionLabel.snp.bottom).offset(StyleKit.metrics.padding.medium)
			make.leading.trailing.bottom.equalToSuperview()
		}
	}
}

// MARK: - UITableViewDelegate

extension ShowDetailVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		StyleKit.metrics.tableRowHeight
	}
}

// MARK: - UITableViewDataSource

extension ShowDetailVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		tableContent.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tableContent[section].rows.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? EpisodeCell else {
			let cell = EpisodeCell(style: .default, reuseIdentifier: cellReuseIdentifier)
			cell.update(with: tableContent[indexPath.section].rows[indexPath.row])
			return cell
		}

		cell.update(with: tableContent[indexPath.section].rows[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = EpisodeTableHeaderView(reuseIdentifier: headerReuseIdentifier)
		header.update(with: tableContent[section].header)
		return header
	}
}

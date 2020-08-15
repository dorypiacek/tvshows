//
//  ShowDetailVMType.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding

// MARK: - Protocol definition

protocol ShowDetailVMType {
	var title: LiveOptionalData<String> { get }
	var description: LiveOptionalData<String> { get }
	var headerContent: LiveOptionalData<ShowDetailHeaderView.Content> { get }
	var tableContent: LiveData<[ShowDetailTableSection]> { get }
	var isEpisodesLoading: LiveData<Bool> { get }
	func load()
}

//
//  ShowsListVMType.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding

// MARK: - Protocol definition

protocol ShowsListVMType {
	var tableContent: LiveData<[ShowsListCell.Content]> { get }
	var headerContent: LiveOptionalData<ShowsListHeaderView.Content> { get }
	var placeholderContent: LiveOptionalData<PlaceholderView.Content> { get }
	func load()
}

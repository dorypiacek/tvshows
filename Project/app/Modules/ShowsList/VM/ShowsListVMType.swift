//
//  ShowsListVMType.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import ETBinding

protocol ShowsListVMType {
	/// Table view content
	var tableContent: LiveData<[ShowsListCell.Content]> { get }
	/// Header content with a title and logout action
	var headerContent: LiveOptionalData<ShowsListHeaderView.Content> { get }
	/// Placeholder content to be shown while loading and on error
	var placeholderContent: LiveOptionalData<PlaceholderView.Content> { get }
	func load()
}

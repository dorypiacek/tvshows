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
	/// Episode title
	var title: LiveOptionalData<String> { get }
	/// Episode description
	var description: LiveOptionalData<String> { get }
	/// Header content, contains episode image URL and back navigation action, shows loading if needed
	var headerContent: LiveOptionalData<ShowDetailHeaderView.Content> { get }
	/// Table view content
	var tableContent: LiveData<[ShowDetailTableSection]> { get }
	/// Defines when to show/hide refresh control
	var isEpisodesLoading: LiveData<Bool> { get }
	/// Loads TV Show detail, then episodes and updates content accordingly.
	func load()
}

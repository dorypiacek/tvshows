//
//  ImageKit.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 08/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

struct ImageKit {
	let password = Password()
	let checkbox = Checkbox()
	let navigation = Navigation()
	let logo = Logo()
	let placeholder = Placeholder()
}

extension ImageKit {
	struct Password {
		let hide = "ic-characters-hide"
		let show = "ic-hide-password"
	}

	struct Checkbox {
		let filled = "ic-checkbox-filled"
		let empty = "ic-checkbox-empty"
	}

	struct Navigation {
		let logout = "ic-logout"
		let back = "ic-navigate-back"
	}

	struct Logo {
		let login = "img-login-logo"
	}

	struct Placeholder {
		let noImage = "ic-placeholder"
	}
}

extension ImageKit {
	func make(from name: String, with renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIImage? {
		UIImage(named: name)?.withRenderingMode(renderingMode)
	}
}

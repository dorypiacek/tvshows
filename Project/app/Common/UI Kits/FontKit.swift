//
//  FontKit.swift
//  TV Shows
//
//  Created by Dorota Piačeková on 04/08/2020.
//  Copyright © 2020 Dorota Piačeková. All rights reserved.
//

import Foundation
import UIKit

struct FontKit {
	var title1: UIFont { UIFont.preferredFont(forTextStyle: .title1) }
    var title2: UIFont { UIFont.preferredFont(forTextStyle: .title2) }
    var title3: UIFont { UIFont.preferredFont(forTextStyle: .title3) }
    var body: UIFont { UIFont.preferredFont(forTextStyle: .body) }
    var callout: UIFont { UIFont.preferredFont(forTextStyle: .callout) }
    var subhead: UIFont { UIFont.preferredFont(forTextStyle: .subheadline) }
    var caption1: UIFont { UIFont.preferredFont(forTextStyle: .caption1) }
    var caption2: UIFont { UIFont.preferredFont(forTextStyle: .caption2) }
    var footnote: UIFont { UIFont.preferredFont(forTextStyle: .footnote) }
}

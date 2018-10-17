//
//  MultiBadgeProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol MultiBadgeProperties {
    var badges: [BadgeCompatible]? { get set }
    var badgeSpacing: CGFloat { get set }
    var badgeRounding: Bool { get set }
    var groupBadge: Bool { get set }
    var hideOnZero: Bool { get set }
    var badgeCornerRadius: CGFloat? { get set }
    var badgeFont: UIFont { get set }
}

public protocol MultiBadgeBase {
    var badgeElements: [UILabelExtended]? { get set }
}

public protocol MultiBadgeMethods {
    func refreshBadges()
}

public protocol MultiBadgeContainer: MultiBadgeProperties, MultiBadgeMethods {
    var badgeView: UIMultiBadge { get set }
}

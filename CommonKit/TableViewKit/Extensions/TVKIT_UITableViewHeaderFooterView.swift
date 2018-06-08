//
//  TVKIT_UITableViewHeaderFooterView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewHeaderFooterView {

    private struct TV_AssociatedKeys {
        static var _tableView: UITableView? = nil
    }

    open var tableView: UITableView? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys._tableView) as? UITableView }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys._tableView, newValue as UITableView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

}

//
//  ExtendedHeader.swift
//  CommonKit
//
//  Created by Oskari Rauta on 14/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol ExtendedHeaderProperties { }

@objc public protocol ExtendedHeaderMethods {
    
    func headerProperties()
    func setupViews()
    func secondarySetupViews()
    func setupConstraints()
}

public protocol ExtendedHeader: ExtendedHeaderProperties, ExtendedHeaderMethods { }

extension UITableViewHeaderFooterView: ExtendedHeader {
    
    open func headerProperties() { }
    open func setupViews() { }
    open func secondarySetupViews() { }
    open func setupConstraints() { }
    @objc open func secondaryConstraints() { }

}

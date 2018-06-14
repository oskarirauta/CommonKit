//
//  ExtendedHeaderSettingsProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 14/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

@objc protocol ExtendedHeaderSettingsProtocolBase {
    func headerProperties()
    func setupViews()
    func secondarySetupViews()
    func setupConstraints()
}

protocol ExtendedHeaderSettingsProtocol: ExtendedHeaderSettingsProtocolBase { }

extension UITableViewHeaderFooterView: ExtendedHeaderSettingsProtocol {
    
    open func headerProperties() { }
    open func setupViews() { }
    open func secondarySetupViews() { }
    open func setupConstraints() { }
    @objc open func secondaryConstraints() { }

}

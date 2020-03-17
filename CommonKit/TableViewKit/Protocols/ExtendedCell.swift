//
//  ExtendedCell.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ExtendedCellProperties {
    
    var uuid: String? { get set }
    var selectable: Bool { get set }
    var enabled: Bool { get set }
}

@objc public protocol ExtendedCellMethods {
        
    func cellProperties()
    func setupViews()
    func secondarySetupViews()
    func setupConstraints()
}

public protocol ExtendedCell: ExtendedCellProperties, ExtendedCellMethods {
    
    var isEnabled: Bool { get set }
}

extension UITableViewCell: ExtendedCell {
    
    open var isEnabled: Bool {
        get { return self.enabled }
        set { self.enabled = newValue }
    }

    open func cellProperties() {
        self.shouldIndentWhileEditing = true
        self.selectionStyle = .none
        self.accessoryType = .none
        self.editingAccessoryType = .none
        self.focusStyle = .default
        self.selectable = false
        self.enabled = true
        self.backgroundColor = UIColor.cellBackgroundColor
    }
    
    open func setupViews() {
        self.backgroundView = UIView()
    }
    
    open func secondarySetupViews() { }
    open func setupConstraints() { }
    @objc open func secondaryConstraints() { }

}

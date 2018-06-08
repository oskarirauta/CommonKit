//
//  UITableViewCellExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UITableViewCellExtended: UITableViewCell, CellConstraintProtocol, UICellDelegateSelectable {
    
    open var cellConstraints: CellConstraints = [:]
    open var handler: CellHandler = nil
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.cellProperties()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tableView = nil
        self.cellProperties()
        self.setupViews()
        self.secondarySetupViews()
        self.setupConstraints()
        self.secondaryConstraints()
        (self as CellConstraintProtocol).updateCellConstraints?()
        self.activateCellConstraints()
        self.setNeedsUpdateConstraints()
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.tableView = nil
        self.cellProperties()
        self.setupViews()
        self.secondarySetupViews()
        self.setupConstraints()
        self.secondaryConstraints()
        (self as CellConstraintProtocol).updateCellConstraints?()
        self.activateCellConstraints()
        self.setNeedsUpdateConstraints()
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        
        guard self.selectable, self.enabled else { return }
        
        if (( self.tableView != nil ) && ( self.tableView!.isEditing ) && (( self.controller as? EditingSectionProtocol)?.editingSection == self.indexPath?.section )) {
            return
        }
        
        (self as UICellDelegateSelectable?)?.internalSetSelected?(selected, animated: animated)
    }
    
    open func activateCellConstraints(_ key: String? = nil) {
        guard key == nil else {
            guard let constraint: NSLayoutConstraint = self.cellConstraints[key!] else { return }
            constraint.isActive = true
            return
        }
        
        self.cellConstraints.values.forEach {
            $0.isActive = true
        }
    }
    
    open func deactivateCellConstraints(_ key: String? = nil) {
        
        guard key == nil else {
            guard let constraint: NSLayoutConstraint = self.cellConstraints[key!] else { return }
            constraint.isActive = false
            return
        }
        
        self.cellConstraints.values.forEach {
            $0.isActive = false
        }
    }
    
}

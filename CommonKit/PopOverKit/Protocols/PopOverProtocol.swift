//
//  PopOverProtocol.swift
//  PopOverKit
//
//  Created by Oskari Rauta on 03/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol PopOverProtocol: UIPopoverPresentationControllerDelegate {
    
    var popoverLayoutMargins: UIEdgeInsets { get set }
    var backgroundColor: UIColor? { get set }
    var passthroughViews: [UIView]? { get set }
    var popoverBackgroundViewClass: UIPopoverBackgroundViewMethods.Type? { get set }
    var canOverlapSourceViewRect: Bool { get set }
    var barButtonItem: UIBarButtonItem? { get set }
    var sourceView: UIView? { get set }
    var sourceRect: CGRect { get set }
    var permittedArrowDirections: UIPopoverArrowDirection { get set }
    var arrowDirection: UIPopoverArrowDirection { get }
    
    func setupView()
    func setupConstraints()
}

//
//  BackButtonProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol BackButtonProtocolBase {
    @objc func backAction()
}

public protocol BackButtonProtocol: BackButtonProtocolBase {
    var _backBtn: UIBarButtonItem? { get set }
    var backBtn: UIBarButtonItem { get set }
    func defaultBackBtn() -> UIBarButtonItem
}

extension BackButtonProtocol where Self: UIViewController {
    
    public var backBtn: UIBarButtonItem {
        get { return self._backBtn ?? self.defaultBackBtn() }
        set {
            self._backBtn = newValue
            self.navigationItem.leftBarButtonItem = newValue
        }
    }
    
    public func defaultBackBtn() -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "BackBtn")?.stretchableImage(withLeftCapWidth: 38, topCapHeight: 64).withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.backAction)).properties {
            $0.isEnabled = true
        }
    }
}

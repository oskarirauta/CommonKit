//
//  BackButton.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol BackButtonProperties {
    
    var _backButton: UIBackButton? { get set }
    var backButton: UIBackButton { get set }
}

public protocol BackButtonMethods {
    
    func backAction()
}

public protocol BackButton: BackButtonProperties, BackButtonMethods { }

public extension BackButton where Self: UIViewController {
    
    var backButton: UIBackButton {
        get { return self._backButton ?? UIBackButton.default.properties { $0.backAction = self.backAction }
        }
        set {
            self._backButton = newValue
            self.navigationItem.leftBarButtonItem = newValue
        }
    }

}


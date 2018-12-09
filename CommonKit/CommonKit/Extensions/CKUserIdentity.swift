//
//  CKUserIdentity.swift
//  CommonKit
//
//  Created by Oskari Rauta on 09/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CloudKit

extension CKUserIdentity {
    
    public var firstName: String? {
        get { return self.nameComponents?.givenName }
    }
    
    public var lastName: String? {
        get { return self.nameComponents?.familyName }
    }
    
}

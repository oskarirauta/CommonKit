//
//  CKUserResponse+values.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CloudKit

public extension CKUserResponse {
    
    public var record: CKRecord.ID? {
        get {
            switch self {
            case let .success(record: _record): return _record
            default: return nil
            }
        }
    }
    
    public var accountStatus: CKAccountStatus? {
        get {
            switch self {
            case let .notSignedIn(accountStatus: _accountStatus): return _accountStatus
            default: return nil
            }
        }
    }
    
    public var error: Error? {
        get {
            switch self {
            case let .failure(error: _error): return _error
            default: return nil
            }
        }
    }

}

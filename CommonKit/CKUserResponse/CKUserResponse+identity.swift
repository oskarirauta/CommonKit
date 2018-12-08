//
//  CKUserResponse+identity.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CloudKit

public extension CKUserResponse {
    
    public enum IdentityStatus {
        
        case success(identity: CKUserIdentity)
        case failure(error: Error?)
        
        public enum Types {
            case success
            case failure
        }
        
        public var type: Types {
            get {
                switch self {
                case .success: return CKUserResponse.IdentityStatus.Types.success
                case .failure: return CKUserResponse.IdentityStatus.Types.failure
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

        public var identity: CKUserIdentity? {
            get {
                switch self {
                case let .success(identity: _identity): return _identity
                default: return nil
                }
            }
        }
        
    }

    public var userInfo: IdentityStatus? {
        get {
            guard
                self.type == .success,
                let permissionStatus: PermissionStatus = self.userDiscoverabilityPermissionStatus,
                permissionStatus.type == .granted,
                let record: CKRecord.ID = self.record
                else { return nil }
            
            let container = CKContainer.default()
            var result: CKUserResponse.IdentityStatus? = nil
            
            container.discoverUserIdentity(withUserRecordID: record, completionHandler: {
                userInfo, error in
                if error == nil, let identity: CKUserIdentity = userInfo {
                    result = .success(identity: identity)
                } else {
                    result = .failure(error: error)
                }
            })
            
            while result == nil { }
            return result!
        }
    }

    
}

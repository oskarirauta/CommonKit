//
//  CKUserResponse+PermissionStatus.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension CKUserResponse {
    
    enum PermissionStatus {
        
        case notDecided
        case failure(error: Error?)
        case denied
        case granted
        
        public enum Types {
            case notDecided
            case failure
            case denied
            case granted
        }
        
        public var type: Types {
            get {
                switch self {
                case .notDecided: return CKUserResponse.PermissionStatus.Types.notDecided
                case .failure: return CKUserResponse.PermissionStatus.Types.failure
                case .denied: return CKUserResponse.PermissionStatus.Types.denied
                case .granted: return CKUserResponse.PermissionStatus.Types.granted
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

}

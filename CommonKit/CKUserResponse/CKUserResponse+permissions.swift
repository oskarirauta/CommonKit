//
//  CKUserResponse+permissions.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CloudKit

public extension CKUserResponse {
    
    public var userDiscoverabilityPermissionStatus: CKUserResponse.PermissionStatus? {
        get {
            guard self.type == .success else { return nil }
            var result: CKUserResponse.PermissionStatus? = nil
            let container = CKContainer.default()
            container.status(forApplicationPermission: .userDiscoverability, completionHandler: {
                status, error in
                if let error = error {
                    result = .failure(error: error)
                } else if status == .initialState {
                    result = .notDecided
                } else if status == .denied {
                    result = .denied
                } else if status == .granted {
                    result = .granted
                } else {
                    result = .failure(error: nil)
                }
            })
            
            let timer: Timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {
                _timer in
                if !_timer.isValid, result == nil {
                    result = .failure(error: NSError(domain: Bundle.main.bundleIdentifier ?? "", code: 500, userInfo: [
                        NSLocalizedDescriptionKey: "Timed-out. Propably network error or network is not reachable."
                        ]))
                }
            })
            
            while result == nil { }
            timer.invalidate()
            return result!
        }
    }
    
    public var requestUserDiscoverabilityPermission: CKUserResponse.PermissionStatus? {
        get {
            guard self.type == .success else { return nil }
            var result: CKUserResponse.PermissionStatus? = nil
            let container = CKContainer.default()
            container.requestApplicationPermission(.userDiscoverability, completionHandler: {
                status, error in
                if let error = error {
                    result = .failure(error: error)
                } else if status == .initialState {
                    result = .notDecided
                } else if status == .denied {
                    result = .denied
                } else if status == .granted {
                    result = .granted
                } else {
                    result = .failure(error: nil)
                }
            })
            
            let timer: Timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {
                _timer in
                if !_timer.isValid, result == nil {
                    result = .failure(error: NSError(domain: Bundle.main.bundleIdentifier ?? "", code: 500, userInfo: [
                        NSLocalizedDescriptionKey: "Timed-out. Propably network error or network is not reachable."
                        ]))
                }
            })
            
            while result == nil { }
            timer.invalidate()
            return result!
        }
    }

}

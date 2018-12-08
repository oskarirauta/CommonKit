//
//  CKUserResponse.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CloudKit

public enum CKUserResponse {
    
    case success(record: CKRecord.ID)
    case failure(error: Error?)
    case notSignedIn(accountStatus: CKAccountStatus)
    
    public enum Types {
        case success
        case failure
        case notSignedIn
    }
    
    public var type: CKUserResponse.Types {
        get {
            switch self {
            case .success: return CKUserResponse.Types.success
            case .failure: return CKUserResponse.Types.failure
            case .notSignedIn: return CKUserResponse.Types.notSignedIn
            }
        }
    }
    
    public init() {
        
        let container = CKContainer.default()
        var result: CKUserResponse? = nil
        container.accountStatus() { accountStatus, error in
            if error != nil {
                result = .failure(error: error)
            } else if accountStatus == .available {
                container.fetchUserRecordID() { recordID, error in
                    if let recordID = recordID {
                        result = .success(record: recordID)
                    } else {
                        result = .failure(error: error)
                    }
                }
            }
            else { result = .notSignedIn(accountStatus: accountStatus) }
        }
        
        while result == nil { }
        self = result!
    }
            
}

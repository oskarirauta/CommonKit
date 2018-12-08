//
//  ViewController.swift
//  CKUserResponseExample
//
//  Created by Oskari Rauta on 09/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CloudKit
import CommonKit

/*
 
 Requirement: App Capabilities -> iCloud -> [x] CloudKit
 
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ckResponse: CKUserResponse = CKUserResponse()
        
        guard ckResponse.type == .success else {
            
            if ckResponse.type == .failure {
                print("iCloud error has occurred.")
                if let error = ckResponse.error { print("Error: \(error)") } else { print("Unknown error") }
            } else if ckResponse.type == .notSignedIn {
                print("Device has not signed into iCloud. Please, sign in to iCloud to proceed.")
            }
            return
        }
        
        var permissionStatus: CKUserResponse.PermissionStatus? = ckResponse.userDiscoverabilityPermissionStatus
        
        if permissionStatus != nil, permissionStatus!.type == .notDecided {
            
            print("Asking for permission to user information.")
            permissionStatus = ckResponse.requestUserDiscoverabilityPermission
            
            if let permissionStatus = permissionStatus {
                print("Result: \(permissionStatus.type)")
                if permissionStatus.type == .failure, let error = permissionStatus.error {
                    print("Error: \(error)")
                }
            } else { print("Result: nil - iCloudUserIDResponse must have failed.") }
            
        } else {
            if let permissionStatus = permissionStatus {
                print("Result: \(permissionStatus.type)")
                if permissionStatus.type == .failure, let error = permissionStatus.error {
                    print("Error: \(error)")
                    print("\nIf error is request failed with http status code 503, login once to CloudKit dashboard. Usually this resolves this issue (new apps get initialized that way).")
                    print("You can do this from Projects capabilties page, from iCloud section.")
                }
            } else { print("Result: nil - iCloudUserIDResponse must have failed.") }
        }
        
        if permissionStatus?.type == .granted, let userInfo = ckResponse.userInfo {
            
            if userInfo.type == .failure {
                print("Userinfo retrieving has failed.")
                if let error = userInfo.error { print("Error: \(error)") }
            } else if userInfo.type == .success, let identity: CKUserIdentity = userInfo.identity {
                print("First name: " + ( identity.nameComponents?.givenName ?? "nil" ))
                print("Last name: " + ( identity.nameComponents?.familyName ?? "nil" ))
            }
        }
        
    }

}


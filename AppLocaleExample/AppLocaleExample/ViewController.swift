//
//  ViewController.swift
//  AppLocaleExample
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Region: " + ( Locale.appLocale.regionCode ?? "" ) + "\nDescription: " + ( Locale.appLocale.description))

        DispatchQueue.background.async {
            print("Background Region: " + ( Locale.appLocale.regionCode ?? "" ) + "\nDescription: " + ( Locale.appLocale.description))
            
        }

        print("\nAvailable locales:")
        Locale.locales.forEach {
            print($0.countryCode + "\t\t" + $0.countryName + "\t\t\t" + $0.currencyCode)
        }

        DispatchQueue.main.async {
            print("Main thread results: " + AppDelegate.shared.regionCode)
        }
        DispatchQueue.background.async {
            print("Background thread results: " + AppDelegate.shared.regionCode)
        }
 
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  ViewController.swift
//  CurrencyExample
//
//  Created by Oskari Rauta on 07/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

class ViewController: UIViewController {

    var price: Money = Money(0)
    var amount: Decimal = Decimal(1)
    var vat: Decimal = Decimal(0)
    
    lazy var priceLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.text = "Price:"
    }
    
    lazy var priceField: CurrencyField = CurrencyField.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .bezel
        $0.allowSignChange = true
        $0.clearButtonMode = .whileEditing
        $0.maximum = 50000
        $0.placeholder = "Price"
        $0.value = self.price
        $0.clearButtonMode = .never
        $0.addTarget(self, action: #selector(self.changePrice), for: .valueChanged)
    }
    
    lazy var amountField: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.text = "Amount: " + self.amount.description
    }
    
    lazy var amountStepper: UIStepper = UIStepper.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.transform = $0.transform.scaledBy(x: 0.85, y: 0.85)
        $0.minimumValue = 0
        $0.maximumValue = 120.0
        $0.stepValue = 1.0
        $0.value = self.amount.doubleValue
        $0.addTarget(self, action: #selector(self.changeAmount), for: .valueChanged)
    }
    
    lazy var vatField: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.text = "VAT: " + self.vat.description + "%"
    }
    
    lazy var vatStepper: UIStepper = UIStepper.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.transform = $0.transform.scaledBy(x: 0.85, y: 0.85)
        $0.minimumValue = 0
        $0.maximumValue = 100.0
        $0.stepValue = 0.5
        $0.value = self.vat.doubleValue
        $0.addTarget(self, action: #selector(self.changeVAT), for: .valueChanged)
    }
    
    lazy var totalVAT: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.text = "VAT: " + CartItem(name: nil, count: self.amount, unit: nil, price: self.price, VAT: self.vat).VAT.description
    }
    
    lazy var totalVAT0: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.text = "VAT Free: " + CartItem(name: nil, count: self.amount, unit: nil, price: self.price, VAT: self.vat).totalVAT0.description
    }
    
    lazy var total: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.text = "Total: " + CartItem(name: nil, count: self.amount, unit: nil, price: self.price, VAT: self.vat).total.description
    }
    
    func updateValues() {
        
        self.amountField.text = "Amount: " + self.amount.description
        self.vatField.text = "VAT: " + self.vat.description + "%"
        
        self.totalVAT.text = "VAT: " + CartItem(name: nil, count: self.amount, unit: nil, price: self.price, VAT: self.vat).VAT.description
        
        self.totalVAT0.text = "VAT Free: " + CartItem(name: nil, count: self.amount, unit: nil, price: self.price, VAT: self.vat).totalVAT0.description
        
        self.total.text = "Total: " + CartItem(name: nil, count: self.amount, unit: nil, price: self.price, VAT: self.vat).total.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.priceLabel)
        self.view.addSubview(self.priceField)
        self.view.addSubview(self.vatField)
        self.view.addSubview(self.vatStepper)
        self.view.addSubview(self.amountField)
        self.view.addSubview(self.amountStepper)
        self.view.addSubview(self.totalVAT)
        self.view.addSubview(self.totalVAT0)
        self.view.addSubview(self.total)
        
        self.priceLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30.0).isActive = true
        self.priceLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        
        self.priceField.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 4.0).isActive = true
        self.priceField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        self.priceField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        self.vatStepper.trailingAnchor.constraint(equalTo: self.priceField.trailingAnchor, constant: -20.0 ).isActive = true
        self.vatStepper.topAnchor.constraint(equalTo: self.priceField.bottomAnchor, constant: 30.0).isActive = true
        self.vatField.centerXAnchor.constraint(equalTo: self.vatStepper.centerXAnchor).isActive = true
        self.vatField.bottomAnchor.constraint(equalTo: self.vatStepper.topAnchor, constant: -2.0).isActive = true
        
        self.amountStepper.leadingAnchor.constraint(equalTo: self.priceField.leadingAnchor, constant: 20.0).isActive = true
        self.amountStepper.topAnchor.constraint(equalTo: self.priceField.bottomAnchor, constant: 30.0).isActive = true
        self.amountField.centerXAnchor.constraint(equalTo: self.amountStepper.centerXAnchor).isActive = true
        self.amountField.bottomAnchor.constraint(equalTo: self.amountStepper.topAnchor, constant: -2.0).isActive = true
        
        self.totalVAT.leadingAnchor.constraint(equalTo: self.priceLabel.leadingAnchor).isActive = true
        self.totalVAT0.leadingAnchor.constraint(equalTo: self.priceLabel.leadingAnchor).isActive = true
        self.total.leadingAnchor.constraint(equalTo: self.priceLabel.leadingAnchor).isActive = true
        
        self.totalVAT.topAnchor.constraint(equalTo: self.amountStepper.bottomAnchor, constant: 25.0).isActive = true
        self.totalVAT0.topAnchor.constraint(equalTo: self.totalVAT.bottomAnchor, constant: 10.0).isActive = true
        self.total.topAnchor.constraint(equalTo: self.totalVAT0.bottomAnchor, constant: 10.0).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.priceField.becomeFirstResponder()
    }
    
    @objc func changePrice() {
        self.price = self.priceField.value ?? Money(0)
        self.updateValues()
    }
    
    @objc func changeVAT() {
        if ( self.priceField.isFirstResponder ) { self.priceField.resignFirstResponder() }
        self.vat = Decimal(self.vatStepper.value.rounded(to: 2))
        self.updateValues()
    }
    
    @objc func changeAmount() {
        if ( self.priceField.isFirstResponder ) { self.priceField.resignFirstResponder() }
        self.amount = Decimal(self.amountStepper.value)
        self.updateValues()
    }

}


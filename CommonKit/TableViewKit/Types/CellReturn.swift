//
//  CellReturn.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class CellReturn: NSObject {
    
    public enum cellState: Int {
        case none = 0
        case begun = 1
        case ended = 2
        case changed = 3
        
        var description: String {
            switch self {
            case .none: return "None"
            case .begun: return "Begun"
            case .ended: return "Ended"
            case .changed: return "Changed"
            }
        }
        
    }
    
    public var state: cellState {
        get { return self.dict["state"] as? cellState ?? .none }
        set { self.dict["state"] = newValue }
    }
    
    public var cell: UITableViewCell? {
        get { return self.dict["cell"] as? UITableViewCell }
        set { self.dict["cell"] = newValue }
    }
    
    public var index: IndexPath? {
        get { return self.dict["index"] as? IndexPath }
        set { self.dict["index"] = newValue }
    }
    
    public var int: Int? {
        get { return self.dict["int"] as? Int }
        set { self.dict["int"] = newValue }
    }
    
    public var decimal: Decimal? {
        get { return self.dict["decimal"] as? Decimal }
        set { self.dict["decimal"] = newValue }
    }
    
    public var double: Double? {
        get { return self.dict["double"] as? Double }
        set { self.dict["double"] = newValue }
    }
    
    public var string: String? {
        get { return self.dict["string"] as? String }
        set { self.dict["string"] = newValue }
    }
    
    public var date: Date? {
        get { return self.dict["date"] as? Date }
        set { self.dict["date"] = newValue }
    }
    
    public var bool: Bool? {
        get { return self.dict["bool"] as? Bool }
        set { self.dict["bool"] = newValue }
    }
    
    public var stringArray: [String]? {
        get { return self.dict["strarray"] as? [String] }
        set { self.dict["strarray"] = newValue }
    }
    
    public var intArray: [Int]? {
        get { return self.dict["intarray"] as? [Int] }
        set { self.dict["intarray"] = newValue }
    }
    
    public var text: String? {
        get { return self.string }
        set { self.string = newValue }
    }
    
    public var choice: Int? {
        get { return self.index?.row }
        set { self.index = newValue == nil ? nil : IndexPath(row: newValue!, section: 0) }
    }
    
    public var float: Float? {
        get { return self.double == nil ? nil : Float(self.double!) }
        set { self.double = newValue == nil ? nil : Double(newValue!)}
    }
    
    public var menu: [String]? {
        get { return self.stringArray }
        set { self.stringArray = newValue }
    }
    
    public var tag: Int? {
        get { return self.cell?.tag }
    }
    
    public var uuid: String? {
        get {
            guard let cellDelegate: UUIDProtocol = self.cell as UUIDProtocol? else { return nil }
            return cellDelegate.uuid
        }
    }
    
    public var indexPath: IndexPath? {
        get {
            guard let cellDelegate: ParentTableViewProtocol = self.cell as ParentTableViewProtocol? else { return nil }
            return cellDelegate.tableView != nil ? cellDelegate.tableView?.indexPath(for: self.cell!) : nil
        }
    }
    
    private var dict: [String: Any] = [:]
    
    private func setVal(val: Any) {
        
        switch val {
        case is cellState:
            self.dict["state"] = val as! cellState
        case is UITableViewCell:
            self.dict["cell"] = val as! UITableViewCell
        case is IndexPath:
            self.dict["index"] = val as! IndexPath
        case is Int:
            self.dict["int"] = val as! Int
        case is Double:
            self.dict["double"] = val as! Double
        case is Float:
            self.dict["double"] = Double(val as! Float)
        case is String:
            self.dict["string"] = val as! String
        case is Date:
            self.dict["date"] = val as! Date
        case is Bool:
            self.dict["bool"] = val as! Bool
        case is [String]:
            self.dict["strarray"] = val as! [String]
        case is [Int]:
            self.dict["intarray"] = val as! [Int]
        case is [Decimal]:
            self.dict["decimalarray"] = val as! [Decimal]
        default:
            print("Storage of unsupported type " + String(describing: type(of: val)))
            assertionFailure()
        }
    }
    
    public func reset() {
        self.index = nil
        self.int = nil
        self.double = nil
        self.string = nil
        self.date = nil
        self.bool = nil
        self.stringArray = nil
        self.intArray = nil
    }
    
    public init(_ values: Any...) {
        super.init()
        values.forEach { self.setVal(val: $0) }
    }
    
    public init(cell: UITableViewCell, state: cellState, values: Any...) {
        super.init()
        self.cell = cell
        self.state = state
        values.forEach { self.setVal(val: $0) }
    }
    
    public init(cell: UITableViewCell, values: Any...) {
        super.init()
        self.cell = cell
        values.forEach { self.setVal(val: $0) }
    }
    
    public init(state: cellState, values: Any...) {
        super.init()
        self.state = state
        values.forEach { self.setVal(val: $0) }
    }
    
    public override init() {
        super.init()
    }
    
    open static var `nil`: CellReturn {
        get { return CellReturn() }
    }
    
    open override var description: String {
        get {
            var desc: String = "State: " + self.state.description + ""
            desc += "\nUITableViewCell is" + ( self.cell == nil ? " not" : "" ) + " attached."
            desc += "\nIndexPath: " + ( self.indexPath == nil ? "nil" : ( String(self.indexPath!.section) + ":" + String(self.indexPath!.row)))
            desc += "\nChoice/Index row: " + ( self.choice == nil ? "nil" : String(self.choice!))
            desc += "\nInt: " + ( self.int == nil ? "nil" : String(self.int!))
            desc += "\nDouble: " + ( self.double == nil ? "nil" : String(self.double!))
            desc += "\nString: " + ( self.string ?? "nil" )
            desc += "\nDate: " + ( self.date?.description ?? "nil" )
            desc += "\nBool: " + ( self.bool == nil ? "nil" : ( self.bool == true ? "True" : "False" ))
            desc += "\nString array:" + ( self.stringArray == nil ? " nil" : "" )
            self.stringArray?.forEach {
                desc += ( $0 == self.stringArray!.first! ? " " : ", " ) + $0
            }
            desc += "\nInt array:" + ( self.intArray == nil ? " nil" : "" )
            self.intArray?.forEach {
                desc += ( $0 == self.intArray!.first! ? " " : ", " ) + String($0)
            }
            return desc
        }
    }
    
}

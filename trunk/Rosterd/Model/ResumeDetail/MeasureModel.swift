//
//  MeasureModel.swift
//  Rosterd
//
//  Created by iMac on 21/04/23.
//

import UIKit

class MeasureModel : NSObject {
    
    var key : String
    var Value : String
    var measurementId : String

    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.key = dictionary["key"] as? String ?? ""
        self.Value = dictionary["value"] as? String ?? ""
        self.measurementId = dictionary["measurementId"] as? String ?? ""
        
    }
    
    init(key : String,Value : String,measurementId : String) {
        self.key = key
        self.Value = Value
        self.measurementId = measurementId
    }
    
    override init() {
        self.key = ""
        self.Value = ""
        self.measurementId = ""
       
    }
}

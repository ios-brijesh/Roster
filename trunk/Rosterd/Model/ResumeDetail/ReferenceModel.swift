//
//  ReferenceModel.swift
//  Rosterd
//
//  Created by iMac on 21/04/23.
//

import UIKit

class ReferenceModel : NSObject {
    
    var Name : String
    var academic : String
    var Phone : String
    var Email : String
    var referenceId : String
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.Name = dictionary["name"] as? String ?? ""
        self.academic = dictionary["academic"] as? String ?? ""
        self.Phone = dictionary["phone"] as? String ?? ""
        self.Email = dictionary["email"] as? String ?? ""
        self.referenceId = dictionary["referenceId"] as? String ?? ""
    }
    
    init(Name : String,academic : String,Phone : String,Email : String,referenceId : String) {
        self.Name = Name
        self.academic = academic
        self.Phone = Phone
        self.Email = Email
        self.referenceId = referenceId
    }
    
    override init() {
        self.Name = ""
        self.academic = ""
        self.Phone = ""
        self.Email = ""
        self.referenceId = ""
    }
}

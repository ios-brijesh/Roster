//
//  productSpecificationModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 17/05/22.
//


import Foundation
import UIKit


class productSpecificationModel : NSObject {
    
    var id : String
    var productId : String
    var label : String
    var value : String
    var updatedDate : String
    var createdDate : String
    var status : String
    
    
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.productId = dictionary[kproductId] as? String ?? ""
        self.label = dictionary[klabel] as? String ?? ""
        self.value = dictionary[kvalue] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
       
    }
    
}

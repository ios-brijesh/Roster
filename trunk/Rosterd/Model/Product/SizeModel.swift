//
//  SizeModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 05/04/22.
//

import Foundation
import UIKit


class SizeModel : NSObject {
    
    var id : String
    var name : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var variationId : String
    var price : String
    
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.name = dictionary[kname] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.variationId = dictionary[kvariationId] as? String ?? ""
        self.price = dictionary[kprice] as? String ?? ""
    }
    
}

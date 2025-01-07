//
//  ColorModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 28/09/22.
//

import UIKit

class ColorModel : NSObject {
    
    var id : String
    var name : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var color : String
 
    
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.name = dictionary[kname] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.color = dictionary["color"] as? String ?? ""
      
    }
    
}


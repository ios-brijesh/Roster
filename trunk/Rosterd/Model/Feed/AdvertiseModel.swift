//
//  AdvertiseModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 11/07/22.
//

import UIKit


class AdvertiseModel : NSObject {
    
    var id : String
    var name : String
    var Description : String
    var image : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var advImage : String
    var thumbAdvImage : String
    var redirectLink : String
    
    
    // MARK: - init
        init?(dictionary: [String:Any]) {
           self.id = dictionary[kid] as? String ?? ""
           self.name = dictionary[kname] as? String ?? ""
           self.Description = dictionary[kdescription] as? String ?? ""
           self.image = dictionary[kimage] as? String ?? ""
            self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
            self.createdDate = dictionary[kcreatedDate] as? String ?? ""
            self.status = dictionary[kstatus] as? String ?? ""
            self.advImage = dictionary[kadvImage] as? String ?? ""
            self.thumbAdvImage =  dictionary[kthumbAdvImage] as? String ?? ""
            self.redirectLink = dictionary["redirectLink"] as? String ?? ""
        
       
    }
    
}

//
//  GiftCoupenModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 18/08/22.
//

import UIKit



class GiftCoupenModel : NSObject {
    
    var id : String
    var userId : String
    var coupendescription : String
    var offerPercentage : String
    var couponCode : String
    var expiryDate : String
    var websiteLink : String
    var image : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var offerImage : String
    var thumbOfferImage : String
    var isFlipped:Bool
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
        self.coupendescription = dictionary[kdescription] as? String ?? ""
        self.offerPercentage = dictionary["offerPercentage"] as? String ?? ""
        self.couponCode = dictionary["couponCode"] as? String ?? ""
        self.expiryDate = dictionary["expiryDate"] as? String ?? ""
        self.websiteLink = dictionary["websiteLink"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.updatedDate = dictionary["updatedDate"] as? String ?? ""
        self.createdDate = dictionary["createdDate"] as? String ?? ""
        self.status = dictionary["status"] as? String ?? ""
        self.offerImage = dictionary["offerImage"] as? String ?? ""
        self.thumbOfferImage = dictionary["thumbOfferImage"] as? String ?? ""
        self.isFlipped = false
    }
    
    
    
    
    
}

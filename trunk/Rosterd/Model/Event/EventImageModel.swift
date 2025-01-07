//
//  EventImageModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/06/22.
//

import UIKit


class EventImageModel:  NSObject {
    
    var id : String
    var eventId : String
    var galleryImage : String
    var videoThumbImage : String
    var type : String
    var createdDate : String
    var updatedDate : String
    var status : String
    
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.galleryImage = dict[kgalleryImage] as? String ?? ""
        self.videoThumbImage = dict[kvideoThumbImage] as? String ?? ""
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
        self.type = dict[ktype] as? String ?? ""
        self.eventId = dict[keventId] as? String ?? ""
        
    }
    
    
}

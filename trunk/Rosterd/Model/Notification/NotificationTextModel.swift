//
//  NotificationTextModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 17/10/22.
//

import UIKit

class NotificationTextModel: NSObject {
    
    
    var text : String
    var color : String
    var weight : String
    
    
    init?(dict : [String:Any]){
        
        self.text = dict["text"] as? String ?? ""
        self.color = dict["color"] as? String ?? ""
        self.weight = dict["weight"] as? String ?? ""
    }
    
}

//
//  AchievementsModel.swift
//  Rosterd
//
//  Created by iMac on 01/05/23.
//

import UIKit

class AchievementsModel : NSObject {
    
    var achievementId : String
    var text : String
   

    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.achievementId = dictionary["achievementId"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        
    }
    
    init(achievementId : String,text : String) {
        self.achievementId = achievementId
        self.text = text
        
    }
    
    override init() {
        self.achievementId = ""
        self.text = ""
       
    }
}


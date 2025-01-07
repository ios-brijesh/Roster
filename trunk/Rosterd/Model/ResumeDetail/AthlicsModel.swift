//
//  AthlicsModel.swift
//  Rosterd
//
//  Created by iMac on 21/04/23.
//

import UIKit

class AthlicsModel : NSObject {
    
    var Name : String
    var Position : String
    var season : String
    var teamId : String

    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.Name = dictionary["name"] as? String ?? ""
        self.Position = dictionary["position"] as? String ?? ""
        self.season = dictionary["season"] as? String ?? ""
        self.teamId = dictionary["teamId"] as? String ?? ""
    }
    
    init(Name : String,Position : String,season : String,teamId : String) {
        self.Name = Name
        self.Position = Position
        self.season = season
        self.teamId = teamId
    }
    
    override init() {
        self.Name = ""
        self.Position = ""
        self.season = ""
        self.teamId = ""
    }
}

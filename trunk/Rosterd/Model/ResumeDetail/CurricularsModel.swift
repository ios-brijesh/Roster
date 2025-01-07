//
//  CurricularsModel.swift
//  Rosterd
//
//  Created by iMac on 01/05/23.
//

import UIKit

class CurricularsModel : NSObject {
    
    var curricularId : String
    var text : String
   

    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.curricularId = dictionary["curricularId"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        
    }
    
    init(curricularId : String,text : String) {
        self.curricularId = curricularId
        self.text = text
        
    }
    
    override init() {
        self.curricularId = ""
        self.text = ""
       
    }
}


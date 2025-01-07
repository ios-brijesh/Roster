//
//  SupportTicketModel.swift
//  Rosterd
//
//  Created by WM-KP on 19/05/22.
//

import UIKit

class SupportTicketModel : NSObject{
    
    var data : [SupportChatModel]
    var message : String
    var status : String
    var totalPages : String
    
    init?(dict: [String:Any]){
        self.data = (dict[kData] as? [[String:Any]] ?? []).compactMap(SupportChatModel.init)
        message = dict["message"] as? String ?? ""
        status = dict["status"] as? String ?? ""
        totalPages = dict["totalPages"] as? String ?? ""
    }
}


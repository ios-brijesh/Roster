//
//  SetStoryModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 09/03/22.
//

import UIKit

class StoryListModel: NSObject {
    var createdDate : String
    var id : String
    var user_id : String
    var mediaName : String
    var isVideo : String
    var status : String
    var mediaUrl : String
    var userName : String
    var userProfileImage : String
    var userProfileThumbImage : String
    var thumbStoryVideoThumbImage : String
    
    init(fromDictionary dictionary: [String:Any]){
        createdDate = dictionary["id"] as? String ?? ""
        id = dictionary["id"] as? String ?? ""
        user_id = dictionary["user_id"] as? String ?? ""
        mediaName = dictionary["mediaName"] as? String ?? ""
        isVideo = dictionary["isVideo"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        mediaUrl = dictionary["mediaUrl"] as? String ?? ""
        userName = dictionary["userName"] as? String ?? ""
        userProfileImage = dictionary["userProfileImage"] as? String ?? ""
        userProfileThumbImage = dictionary["userProfileThumbImage"] as? String ?? ""
        thumbStoryVideoThumbImage = dictionary["thumbStoryVideoThumbImage"] as? String ?? ""
    }
}

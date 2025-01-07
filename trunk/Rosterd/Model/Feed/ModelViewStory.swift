//
//  ModelViewStory.swift
//  Intro
//
//  Created by WM-KP on 14/12/21.
//  Copyright © 2021 Developer. All rights reserved.
//

import UIKit

class ModelViewStory: NSObject {
    var id : String
    var user_story_id : String
    var user_id : String
    var createdDate : String
    var userName : String
    var userProfileImage : String
    var userProfileThumbImage : String
    var mediaName : String
    var isVideo : String
    var status : String
    var mediaUrl : String
    
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String ?? ""
        user_story_id = dictionary["user_story_id"] as? String ?? ""
        user_id = dictionary["user_id"] as? String ?? ""
        createdDate = dictionary["createdDate"] as? String ?? ""
        userName = dictionary["userName"] as? String ?? ""
        userProfileImage = dictionary["userProfileImage"] as? String ?? ""
        userProfileThumbImage = dictionary["userProfileThumbImage"] as? String ?? ""
        mediaName = dictionary["mediaName"] as? String ?? ""
        isVideo = dictionary["isVideo"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        mediaUrl = dictionary["mediaUrl"] as? String ?? ""
    }
}

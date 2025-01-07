//
//  StoryModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 09/03/22.
//

import Foundation
import UIKit

import UIKit

class StoryModel: NSObject {
    var id : String
    var user_id : String
    var mediaName : String
    var isVideo : Bool
    var status : String
    var mediaUrl : String
    var userName : String
    var userProfileImage : String
    var userProfileThumbImage : String
    var isUnread : String
    var chatGroupId : String
    var thumbStoryVideoThumbImage : String
    var videoThumbImage : String
    var storyList : [StoryListModel]
    
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String ?? ""
        user_id = dictionary["user_id"] as? String ?? ""
        mediaName = dictionary["mediaName"] as? String ?? ""
        isVideo = (dictionary["isVideo"] as? String ?? "") == "1" ? true : false
        status = dictionary["status"] as? String ?? ""
        mediaUrl = dictionary["mediaUrl"] as? String ?? ""
        thumbStoryVideoThumbImage = dictionary["thumbStoryVideoThumbImage"] as? String ?? ""
        userName = dictionary["userName"] as? String ?? ""
        userProfileImage = dictionary["userProfileImage"] as? String ?? ""
        userProfileThumbImage = dictionary["userProfileThumbImage"] as? String ?? ""
        isUnread = dictionary["isUnread"] as? String ?? ""
        chatGroupId = dictionary["chatGroupId"] as? String ?? ""
        videoThumbImage = dictionary["videoThumbImage"] as? String ?? ""
        storyList = [StoryListModel]()
        if let storiesList = dictionary["storyList"] as? [[String:Any]]{
            for dic in storiesList{
                let value = StoryListModel(fromDictionary: dic)
                storyList.append(value)
            }
        }
    }
    
    init(id : String,user_id : String,mediaName : String,isVideo : Bool,status : String,mediaUrl : String,userName : String,userProfileImage : String,userProfileThumbImage : String,isUnread : String,chatGroupId : String,storyList:[StoryListModel],thumbStoryVideoThumbImage : String,videoThumbImage : String){
        self.id = id
        self.user_id = user_id
        self.mediaName = mediaName
        self.isVideo = isVideo
        self.status = status
        self.mediaUrl = mediaUrl
        self.userName = userName
        self.userProfileImage = userProfileImage
        self.userProfileThumbImage = userProfileThumbImage
        self.isUnread = isUnread
        self.storyList = storyList
        self.chatGroupId = chatGroupId
        self.thumbStoryVideoThumbImage = thumbStoryVideoThumbImage
        self.videoThumbImage = videoThumbImage
    }
    
}

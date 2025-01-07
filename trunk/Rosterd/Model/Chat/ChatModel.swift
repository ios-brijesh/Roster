//
//  ChatModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/06/22.
//


import UIKit

class ChatModel: NSObject {
    var id : String
    var friendUserId : String
    var groupType : String
    var image : String
    var isAdmin : String
    var message : String
    var messageId : String
    var name : String
    var sender : String
    var thumbImage : String
    var type : String
    var unreadMessages : String
    var time : String
    var senderImage : String
    var senderName : String
    var groupStatus : String
    var createdDate : String
    var categoryName : String
    var followers : String
    var groupId : String
    var myBlockStatus : String
    var friendBlockStatus : String
    var isRequest : String
    var isOnline : String
    var fileImage : String
    var resumeUserName : String
    var resumeUserImage : String
    var resumeShareProfileId : String
    var resumeUserRoleName : String
    var storyData : StoryListModel!
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.resumeUserRoleName = dictionary["resumeUserRoleName"] as? String ?? ""
        self.resumeShareProfileId = dictionary["resumeShareProfileId"] as? String ?? ""
        self.resumeUserName = dictionary["resumeUserName"] as? String ?? ""
        self.resumeUserImage = dictionary["resumeUserImage"] as? String ?? ""
        self.fileImage = dictionary["fileImage"] as? String ?? ""
        self.isOnline = dictionary["isOnline"] as? String ?? ""
        self.isRequest = dictionary["isRequest"] as? String ?? ""
        self.friendBlockStatus = dictionary["friendBlockStatus"] as? String ?? ""
        self.myBlockStatus = dictionary["myBlockStatus"] as? String ?? ""
        self.id = dictionary[kid] as? String ?? ""
        self.friendUserId = dictionary[kfriendUserId] as? String ?? ""
        self.groupType = dictionary[kgroupType] as? String ?? ""
        self.image = dictionary[kimage] as? String ?? ""
        self.isAdmin = dictionary[kisAdmin] as? String ?? ""
        self.message = dictionary[kmessage] as? String ?? ""
        self.messageId = dictionary[kmessageId] as? String ?? ""
        self.name = dictionary[kname] as? String ?? ""
        self.sender = dictionary[ksender] as? String ?? ""
        self.thumbImage = dictionary[kthumbImage] as? String ?? ""
        self.type = dictionary[ktype] as? String ?? ""
        self.unreadMessages = dictionary[kunreadMessages] as? String ?? ""
        self.time = dictionary[ktime] as? String ?? ""
        self.senderImage = dictionary[ksenderImage] as? String ?? ""
        self.senderName = dictionary[ksenderName] as? String ?? ""
        self.groupStatus = dictionary[kgroupStatus] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.categoryName = dictionary[kcategoryName] as? String ?? ""
        self.followers = dictionary[kfollowers] as? String ?? ""
        self.groupId = dictionary[kgroupId] as? String ?? ""
        if let storyDataData = dictionary["storyData"] as? [String:Any]{
                    storyData = StoryListModel(fromDictionary: storyDataData)
                }
        
    }
    
    class func AcceptChatRequest(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kacceptChatRequest, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func RemoveChatRequest(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kremoveChatRequest, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func RejectChatRequest(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kdeclineChatRequest, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    
    class func ArchiveChatAddRemove(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.karchiveChatAddRemove, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func BlockUnblockChatUser(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kblockUnblockChatUser, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    class func setUserReport(with param: [String:Any]?,isFromChat : Bool = false, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {

        SVProgressHUD.show()
        APIManager.makeRequest(with: isFromChat ? AppConstant.API.ksetReportChatUser : AppConstant.API.ksetReportChatUser, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]

            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            } else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    
    
}

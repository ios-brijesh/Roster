//
//  NotificationModel.swift
//  Chiry
//
//  Created by Harshad on 04/06/21.
//

import UIKit

class NotificationModel: NSObject {

    
    var id : String
    var senderId : String
    var senderName : String
    var image : String
    var title : String
    var senderRole : String
    var desc : String
    var send_from : String
    var send_to : String
    var model : String
    var model_id : String
    var type : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var time : String
    var eventImage : String
    var rightSideImage : String
    var modelId : String
    var descList : [NotificationTextModel]
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.senderId = dict[ksenderId] as? String ?? ""
        self.senderName = dict[ksenderName] as? String ?? ""
        self.senderRole = dict[ksenderRole] as? String  ?? ""
        self.image = dict[kimage] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.desc = dict[kdesc] as? String ?? ""
        self.send_from = dict[ksend_from] as? String ?? ""
        self.send_to = dict[ksend_to] as? String ?? ""
        self.model = dict[kmodel] as? String ?? ""
        self.model_id = dict[kmodel_id] as? String ?? ""
        self.type = dict[ktype] as? String ?? ""
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.time = dict[ktime] as? String ?? ""
        self.eventImage = dict["eventImage"] as? String ?? ""
        self.modelId = dict["modelId"] as? String ?? ""
        self.rightSideImage = dict["rightSideImage"] as? String ?? ""
        self.descList = (dict["descList"] as? [[String:Any]] ?? []).compactMap(NotificationTextModel.init)
        
    }
    
    class func getNotificationsListAPICall(with param: [String:Any]?,isShowLoader : Bool, success withResponse: @escaping (_ arr: [NotificationModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
           if isShowLoader {
           SVProgressHUD.show()
           }
        APIManager.makeRequest(with: AppConstant.API.kgetNotificationsList, method: .post, parameter: param, success: {(response) in
               if isShowLoader {
               SVProgressHUD.dismiss()
               }
               let dict = response as? [String:Any] ?? [:]
               
               let message = dict[kMessage] as? String ?? ""
               let statuscode = dict[kstatus] as? String ?? "0"
               let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
               let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
               if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                   
                   let arr = dataDict.compactMap(NotificationModel.init)
                   
                   withResponse(arr,totalPages,message)
               }
               else {
                   failure(statuscode,message, .response)
               }
           }, failure: { (error) in
               if isShowLoader {
               SVProgressHUD.dismiss()
               }
               failure("0",error, .server)
           }, connectionFailed: { (connectionError) in
               if isShowLoader {
               SVProgressHUD.dismiss()
               }
               failure("0",connectionError, .connection)
           })
       }
    
    class func getUnreadNotificationsCountAPICall(with param: [String:Any]?,isShowLoader : Bool, success withResponse: @escaping (_ unreadPushNoti : Int,_ unreadChatMsg : Int) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
        SVProgressHUD.show()
        }
     APIManager.makeRequest(with: AppConstant.API.kgetUnreadNotificationsCount, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
            SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            
            if  isSuccess {
                let pushcount : Int = Int(dict[kunreadPushNoti] as? String ?? "0") ?? 0
                let chatcount : Int = Int(dict[kunreadChatMsg] as? String ?? "0") ?? 0
                withResponse(pushcount,chatcount)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            if isShowLoader {
            SVProgressHUD.dismiss()
            }
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            if isShowLoader {
            SVProgressHUD.dismiss()
            }
            failure("0",connectionError, .connection)
        })
    }
    
}

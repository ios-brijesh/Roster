//
//  SupportChatModel.swift
//  Rosterd
//
//  Created by WM-KP on 19/05/22.
//

import UIKit

class SupportChatModel : NSObject{
    
    var ticketCategoryImage : String
    var thumbTicketCategoryImage : String
    var category : String
    var closedDate : String
    var createdDate : String
    var createdDateInword : String
    var createdDateSimple : String
    var SupportDescription : String
    var email : String
    var id : String
    var name : String
    var priority : String
    var reopenDate : String
    var status : String
    var title : String
    var updatedDate : String
    var updatedDateInword : String
    var userId : String
    var replyType : String
    var forReply : supportForReplyType
    var thumbSenderImage : String
    var time : String
    var senderName : String
    var sender : String
    var ticketCategoryId : String
    var ticketCategoryName : String
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init?(dict: [String:Any]){
        ticketCategoryImage = dict["ticketCategoryImage"] as? String ?? ""
        thumbTicketCategoryImage = dict["thumbTicketCategoryImage"] as? String ?? ""
        ticketCategoryName = dict["ticketCategoryName"] as? String ?? ""
        ticketCategoryId = dict["ticketCategoryId"] as? String ?? ""
        category = dict["category"] as? String ?? ""
        closedDate = dict["closedDate"] as? String ?? ""
        createdDate = dict["createdDate"] as? String ?? ""
        createdDateInword = dict["createdDateInword"] as? String ?? ""
        createdDateSimple = dict["createdDateSimple"] as? String ?? ""
        SupportDescription = dict[kdescription] as? String ?? ""
        email = dict["email"] as? String ?? ""
        id = dict["id"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        priority = dict["priority"] as? String ?? ""
        reopenDate = dict["reopenDate"] as? String ?? ""
        status = dict["status"] as? String ?? ""
        title = dict["title"] as? String ?? ""
        updatedDate = dict["updatedDate"] as? String ?? ""
        updatedDateInword = dict["updatedDateInword"] as? String ?? ""
        userId = dict["userId"] as? String ?? ""
        replyType = dict["replyType"] as? String ?? ""
        thumbSenderImage = dict["thumbSenderImage"] as? String ?? ""
        time = dict["time"] as? String ?? ""
        senderName = dict["senderName"] as? String ?? ""
        sender = dict["sender"] as? String ?? ""
        self.forReply = supportForReplyType.init(rawValue: dict[kforReply] as? String ?? "1") ?? supportForReplyType.admin
    }
    
    class func setTicket(withParam param: [String:Any], success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetTicket, method: .post, parameter: param, success: {(response) in
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
    
    class func getTicketList(with param: [String:Any]?,isShowLoader : Bool, success withResponse: @escaping (_ arr: [SupportChatModel],_ totalpage : Int) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
        SVProgressHUD.show()
        
        }
        APIManager.makeRequest(with: AppConstant.API.kGetTicket, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
            SVProgressHUD.dismiss()

            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                
                let arr = dataDict.compactMap(SupportChatModel.init)
                
                withResponse(arr,totalPages)
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
    
    class func getTicketDetail(with param: [String:Any]?,isShowLoader : Bool, success withResponse: @escaping (_ ticket : SupportChatModel,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
        SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kGetTicketDetail, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
            SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let ticket = SupportChatModel.init(dict: dataDict){
                
                withResponse(ticket,message)
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
    
    class func reopenTicket(with param: [String:Any]?,isShowLoader : Bool, success withResponse: @escaping (_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
        SVProgressHUD.show()

        }
        APIManager.makeRequest(with: AppConstant.API.kreopenTicket, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
            SVProgressHUD.dismiss()
                
            }
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

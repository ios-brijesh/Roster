//
//  TicketDetailModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 30/12/22.
//

import UIKit

class TicketDetailModel : NSObject {
    
    var place : String
    var transferToBy : String
    var profileImage : String
    var ticketQrId : String
    var status : String
    var time : String
    var updatedDate : String
    var eventTicketType : String
    var qrcodeImage : String
    var redeemBy : String
    var isTransfer : String
    var eventName : String
    var eventId : String
    var eventFormetDate : String
    var id : String
    var date : String
    var userIdTo : String
    var createdDate : String
    var eventBookingDetailId : String
    var qrcodeImageUrl : String
    var totalTickets : String
    var fullName : String
    var userId : String
    var TransferToBy : String
    var isSelect : Bool = false
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        
        self.place = dictionary["place"] as? String ?? ""
        self.transferToBy = dictionary["transferToBy"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.ticketQrId = dictionary["ticketQrId"] as? String ?? ""
        self.status = dictionary["status"] as? String ?? ""
        self.time = dictionary["time"] as? String ?? ""
        self.updatedDate = dictionary["updatedDate"] as? String ?? ""
        self.eventTicketType = dictionary["eventTicketType"] as? String ?? ""
        self.qrcodeImage = dictionary["qrcodeImage"] as? String ?? ""
        self.redeemBy = dictionary["redeemBy"] as? String ?? ""
        self.isTransfer = dictionary["isTransfer"] as? String ?? ""
        self.eventName = dictionary["eventName"] as? String ?? ""
        self.eventId = dictionary["eventId"] as? String ?? ""
        self.eventFormetDate = dictionary["eventFormetDate"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.userIdTo = dictionary["userIdTo"] as? String ?? ""
        self.createdDate = dictionary["createdDate"] as? String ?? ""
        self.eventBookingDetailId = dictionary["eventBookingDetailId"] as? String ?? ""
        self.qrcodeImageUrl = dictionary["qrcodeImageUrl"] as? String ?? ""
        self.totalTickets = dictionary["totalTickets"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
        self.TransferToBy = dictionary["transferToBy"] as? String ?? ""
        self.isSelect = false
    }
    
    class func TicketDetailTeansfer(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [TicketDetailModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kTicketDetail, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(TicketDetailModel.init)
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
    
    class func getEventTransferTicketList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [TicketDetailModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetEventTransferTicketList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(TicketDetailModel.init)
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
    
    
    class func setEventTicketRedeem(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        //SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetEventTicketRedeem, method: .post, parameter: param, success: {(response) in
            //SVProgressHUD.dismiss()
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
            //SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            //SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func setEventTicketTransfer(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        //SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetEventTicketTransfer, method: .post, parameter: param, success: {(response) in
            //SVProgressHUD.dismiss()
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
            //SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            //SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
}

//
//  TransctionModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 02/02/23.
//

import UIKit

class TransctionModel: NSObject {
    
    var id : String
    var userId : String
    var cardId : String
    var orderId : String
    var eventId : String
    var transactionId : String
    var transactionJson : String
    var chargeId : String
    var totalAmount : String
    var type : String
    var payType : String
    var createdDate : String
    var updatedDate : String
    var status : String
    var fullName : String
    var userName : String
    var nickName : String
    var profileimage : String
    var thumbImage : String
    var formatedDate : String
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
        self.cardId = dictionary["cardId"] as? String ?? ""
        self.orderId = dictionary["orderId"] as? String ?? ""
        self.eventId = dictionary["eventId"] as? String ?? ""
        self.transactionId = dictionary["transactionId"] as? String ?? ""
        self.transactionJson = dictionary["transactionJson"] as? String ?? ""
        self.chargeId = dictionary["chargeId"] as? String ?? ""
        self.totalAmount = dictionary["totalAmount"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.payType = dictionary["payType"] as? String ?? ""
        self.createdDate = dictionary["createdDate"] as? String ?? ""
        self.updatedDate = dictionary["updatedDate"] as? String ?? ""
        self.status = dictionary["status"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.nickName = dictionary["nickName"] as? String ?? ""
        self.profileimage = dictionary["profileimage"] as? String ?? ""
        self.thumbImage = dictionary["thumbImage"] as? String ?? ""
        self.formatedDate = dictionary["formatedDate"] as? String ?? ""
    }
    
    class func getProductTransaction(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [TransctionModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetProductTransaction, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(TransctionModel.init)
                withResponse(arr,message)
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

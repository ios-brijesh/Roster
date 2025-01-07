//
//  CardModel.swift
//  Chiry
//
//  Created by Harshad on 29/04/21.
//

import UIKit

class CardModel: NSObject {
    
    var id : String
    var type : String
    var userId : String
    var cardHolder : String
    var cardNumber : String
    var cvv : String
    var exp_month : String
    var exp_year : String
    var stripe_card_id : String
    var stripe_card_token : String
    var stripe_customer_id : String
    var createdDate : String
    var upadatedDate : String
    var status : String
    var expires : String
    var isCardSelected : Bool
    var isDefault : String
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.type = dictionary[ktype] as? String ?? ""
        self.id = dictionary[kid] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.cardHolder = dictionary[kcardHolder] as? String ?? ""
        self.cardNumber = dictionary[kcardNumber] as? String ?? ""
        self.cvv = dictionary[kcvv] as? String ?? ""
        self.exp_month = dictionary[kexp_month] as? String ?? ""
        self.exp_year = dictionary[kexp_year] as? String ?? ""
        self.stripe_card_id = dictionary[kstripe_card_id] as? String ?? ""
        self.stripe_card_token = dictionary[kstripe_card_token] as? String ?? ""
        self.stripe_customer_id = dictionary[kstripe_customer_id] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.upadatedDate = dictionary[kupadatedDate] as? String ?? ""
        self.expires = dictionary[kexpires] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.isDefault = dictionary[kisDefault] as? String ?? ""
        self.isCardSelected = false
    }

    class func addNewCard(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksaveCard, method: .post, parameter: param, success: {(response) in
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
    
    class func deleteCard(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kdeleteUserCard, method: .post, parameter: param, success: {(response) in
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
    
    class func CheckoutOrder(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String,_ eventId : String,_ ticketId : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kcheckout, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let eventId = dict["eventId"] as? String ?? ""
            let ticketId = dict["ticketId"] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(ticketId,eventId,message)
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
    
    class func applyOfferCoupon(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String,_ offerId : String,_ discountAmount : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kapplyOfferCoupon, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let offerId = dataDict["offerId"] as? String ?? ""
                let discountAmount = dataDict["discountAmount"] as? String ?? ""
                let total_amount = dataDict["total_amount"] as? String ?? ""
                withResponse(offerId,discountAmount,total_amount)
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
    
    
    class func getCardList(with param: [String:Any]?, success withResponse: @escaping (_ arr: [CardModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kgetUserCards, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                
                let arr = dataDict.compactMap(CardModel.init)
                
                withResponse(arr,message)
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
}

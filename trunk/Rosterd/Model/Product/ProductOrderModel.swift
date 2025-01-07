//
//  ProductOrderModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 26/09/22.
//

import UIKit

class ProductOrderModel : NSObject {
    
    var id : String
    var userId : String
    var cardId : String
    var addressId : String
    var order_amount : String
    var order_item : String
    var totalPrice : String
    var createdDate : String
    var updatedDate : String
    var order_status : String
    var status : String
    var email : String
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        
        self.id = dictionary[kid] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.cardId = dictionary[kcardId] as? String ?? ""
        self.addressId = dictionary[kaddressId] as? String ?? ""
        self.order_amount = dictionary["order_amount"] as? String ?? ""
        self.order_item = dictionary["order_item"] as? String ?? ""
        self.totalPrice = dictionary["totalPrice"] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.order_status = dictionary["order_status"] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.email = dictionary[kemail] as? String ?? ""
    }
    
    class func getOrderList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ totalAmount : String,_ totalRecords : String,_ arr: [ProductOrderModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetOrderList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            let totalRecords = dict["totalRecords"] as? String ?? "0"
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let totalAmount = dict["totalAmount"] as? String ?? ""
                let arr = dataDict.compactMap(ProductOrderModel.init)
            
                withResponse(totalAmount,totalRecords,arr,totalPages,message)
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
    
    
    class func cancelOrder(with param: [String:Any]?,success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {

        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kcancelOrder, method: .post, parameter: param, success: {(response) in
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

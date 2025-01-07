//
//  OrderDetailModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 27/09/22.
//

import UIKit
class OrderDetailModel : NSObject {
    
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
    var cancleReason : String
    var shippingHouseNumber : String
    var shippingAddress : String
    var shippingLandMark : String
    var shippingCity : String
    var shippingZipcode : String
    var shippingPhone : String
    var offerDiscountAmount : String
    var order_detail : [CartModel]
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        
        self.offerDiscountAmount = dictionary["offerDiscountAmount"] as? String ?? ""
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
        self.cancleReason = dictionary["cancleReason"] as? String ?? ""
        self.shippingHouseNumber = dictionary["shippingHouseNumber"] as? String ?? ""
        self.shippingAddress = dictionary["shippingAddress"] as? String ?? ""
        self.shippingLandMark = dictionary["shippingLandMark"] as? String ?? ""
        self.shippingCity = dictionary["shippingCity"] as? String ?? ""
        self.shippingZipcode = dictionary["shippingZipcode"] as? String ?? ""
        self.shippingPhone = dictionary["shippingPhone"] as? String ?? ""
        self.order_detail = (dictionary["order_detail"] as? [[String:Any]] ?? []).compactMap(CartModel.init)
        
    }
    
    class func getOrderDetail(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ orderdetail: [CartModel],_ subTotal : String,_ searviceCharge : String,_ total : String,_ totalRecords : String,_ arr: OrderDetailModel,_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetOrderDetail, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            let totalRecords = dict["totalRecords"] as? String ?? "0"
            let subTotal = dict["subTotal"] as? String ?? ""
            let total = dict["total"] as? String ?? ""
            let searviceCharge = dict["searviceCharge"] as? String ?? ""
            if  isSuccess,let dataDict = dict[kData] as? [String:Any],
                let arr = OrderDetailModel.init(dictionary: dataDict) {
                    let orderdetail = (dataDict["order_detail"] as? [[String:Any]] ?? []).compactMap(CartModel.init)
                withResponse(orderdetail,subTotal,searviceCharge,total,totalRecords,arr,totalPages,message)
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

//
//  CartModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 10/06/22.
//
import UIKit

class CartModel : NSObject {
    
    var id : String
    var userId : String
    var productId : String
    var variationId : String
    var qty : String
    var createdDate : String
    var updatedDate : String
    var status : String
    var price : String
    var amount : String
    var product_name : String
    var shadeId : String
    var shade_name : String
    var shade_color_code : String
    var size_name : String
    var sizeId : String
    var primaryImage : String
    var category : String
    var primaryThubImage : String
    var cartProductAmount : String
    var orderId : String
    var totalAmount : String
    
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        
        self.totalAmount = dictionary["totalAmount"] as? String ?? ""
        self.orderId = dictionary["orderId"] as? String ?? ""
        self.id = dictionary[kid] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.productId = dictionary[kproductId] as? String ?? ""
        self.variationId = dictionary[kvariationId] as? String ?? ""
        self.qty = dictionary[kqty] as? String ?? "1"
        self.variationId = dictionary[kvariationId] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.price = dictionary[kprice] as? String ?? "0.00"
        self.amount = dictionary[kamount] as? String ?? ""
        self.product_name = dictionary[kproduct_name] as? String ?? ""
        self.shadeId = dictionary[kshadeId] as? String ?? ""
        self.shade_name = dictionary[kshade_name] as? String ?? ""
        self.shade_color_code = dictionary[kshade_color_code] as? String ?? ""
        self.size_name = dictionary[ksize_name] as? String ?? ""
        self.sizeId = dictionary[ksizeId] as? String ?? ""
        self.primaryImage = dictionary[kprimaryImage] as? String ?? ""
        self.category = dictionary[kcategory] as? String ?? ""
        self.primaryThubImage = dictionary[kprimaryThubImage] as? String ?? ""
        self.cartProductAmount = dictionary[kcartProductAmount] as? String ?? ""
        
    }
    
    class func GetcartView(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ subTotal : String,_ shipingCost : String,_ total_amount : String,_ shippingAddress : String,_ arr: [CartModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kcartView, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let subTotal = dict["subTotal"] as? String ?? "0"
                let shipingCost = dict[kshipingCost] as? String ?? "0"
                let total_amount = dict[ktotal_amount] as? String ?? "0"
                let shippingAddress = dict[kshippingAddress] as? String ?? "0"
                let arr = dataDict.compactMap(CartModel.init)
            
                withResponse(subTotal,shipingCost,total_amount,shippingAddress,arr,totalPages,message)
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
    
    
    class func getEventCheckoutDetails(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ subTotal : String,_ fee : String,_ totalAmount : String,_ arraddress: AdresssModel?,_ arruserCard : CardModel?,_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetEventCheckoutDetails, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            
            if  isSuccess {
                let subTotal = dict["subTotal"] as? String ?? "0"
                let fee = dict["fee"] as? String ?? "0"
                let totalAmount = dict["totalAmount"] as? String ?? "0"
                let dataDict = dict[kData] as? [String:Any]
                let dictAddress = dataDict?["address"] as? [String:Any]  ?? [:]
                let dictCard = dataDict?["userCard"] as? [String:Any]  ?? [:]
                
                let arraddress = AdresssModel.init(dictionary: dictAddress)
                let cardModel = CardModel.init(dictionary: dictCard)
                
                withResponse(subTotal,fee,totalAmount,arraddress,cardModel,totalPages,message)
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
    
    class func getProductCheckoutDetails(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ subTotal : String,_ shipingCost : String,_ total_amount : String,_ arraddress: AdresssModel?,_ arruserCard : CardModel?,_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetProductCheckoutDetails, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let subTotal = dict["subTotal"] as? String ?? "0"
                let shipingCost = dict["shipingCost"] as? String ?? "0"
                let total_amount = dict["total_amount"] as? String ?? "0"
                
                let dictAddress = dataDict["address"] as? [String:Any]  ?? [:]
                let dictCard = dataDict["userCard"] as? [String:Any]  ?? [:]
                
                let arraddress = AdresssModel.init(dictionary: dictAddress)
                let cardModel = CardModel.init(dictionary: dictCard)
                
                withResponse(subTotal,shipingCost,total_amount,arraddress,cardModel,totalPages,message)
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
    
    
    
    class func RemoveProductCart(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kremoveProductCart, method: .post, parameter: param, success: {(response) in
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
}

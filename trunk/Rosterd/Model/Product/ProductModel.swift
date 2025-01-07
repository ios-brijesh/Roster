//
//  ProductModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/03/22.
//

import Foundation
import UIKit

class productModel : NSObject {
    var id : String
    var product_brand_id : String
    var product_category_id : String
    var name : String
    var price : String
    var product_for : String
    var desc : String
    var shareLink : String
    var product_type : String
    var other_product_link : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var productfullimage : String
    var product_brand_name : String
    var product_brand_image : String
    var product_brand_thub_image : String
    var product_category_image : String
    var product_category_name : String
    var productImage : String
    var productThubImage : String
    var product_gallery_thub_image : String
    var product_gallery_image : String
    var isLike : String
    var primaryImage : String
    var primaryThubImage : String
    var totalCartProduct : String
    var productId : String
    var allImages : [CategoryModel]
    var productVariation : [VariationModel]
    var productSpecification : [productSpecificationModel]
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.productId = dictionary["productId"] as? String ?? ""
        self.productfullimage = dictionary["productfullimage"] as? String ?? ""
        self.totalCartProduct = dictionary[ktotalCartProduct] as? String ?? ""
        self.product_brand_id = dictionary[kproduct_brand_id] as? String ?? ""
        self.product_category_id = dictionary[kproduct_category_id] as? String ?? ""
        self.name = dictionary[kname] as? String ?? ""
        self.price = dictionary[kprice] as? String ?? ""
        self.product_for = dictionary[kproduct_for] as? String ?? ""
        self.desc = dictionary[kdesc] as? String ?? ""
        self.shareLink = dictionary[kshareLink] as? String ?? ""
        self.product_type = dictionary[kproduct_type] as? String ?? ""
        self.other_product_link = dictionary[kother_product_link] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.product_brand_name = dictionary[kproduct_brand_name] as? String ?? ""
        self.product_brand_image = dictionary[kproduct_brand_image] as? String ?? ""
        self.product_brand_thub_image = dictionary[kproduct_brand_thub_image] as? String ?? ""
        self.product_category_image = dictionary[kproduct_category_image] as? String ?? ""
        self.product_category_name = dictionary[kproduct_category_name] as? String ?? ""
        self.productImage = dictionary[kproductImage] as? String ?? ""
        self.productThubImage = dictionary[kproductThubImage] as? String ?? ""
        self.product_gallery_thub_image = dictionary[kproduct_gallery_thub_image] as? String ?? ""
        self.product_gallery_image = dictionary[kproduct_gallery_image] as? String ?? ""
        self.isLike = dictionary[kisLike] as? String ?? ""
        self.primaryImage = dictionary[kprimaryImage] as? String ?? ""
        self.primaryThubImage = dictionary[kprimaryThubImage] as? String ?? ""
        self.allImages = (dictionary[kallImages] as? [[String:Any]] ?? []).compactMap(CategoryModel.init)
        self.productVariation = (dictionary[kproductVariation] as? [[String:Any]] ?? []).compactMap(VariationModel.init)
        self.productSpecification = (dictionary[kproductSpecification] as? [[String:Any]] ?? []).compactMap(productSpecificationModel.init)
        
    }
    
    class func productDashboardList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrAd: [AdvertiseModel],_ totalCartProduct : String,_ arrlatest: [productModel],_ arrBrand: [CategoryModel],_ arrbyOther: [productModel],_ arrgiftCoupon: [GiftCoupenModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kproductDashboard, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let totalCartProduct = dict[ktotalCartProduct] as? String ?? "0"
                let arrlatest = (dataDict["latest"] as? [[String:Any]] ?? []).compactMap(productModel.init)
                let arrBrand = (dataDict["brand"] as? [[String:Any]] ?? []).compactMap(CategoryModel.init)
                let arrbyOther = (dataDict["byOther"] as? [[String:Any]] ?? []).compactMap(productModel.init)
                let arrgiftCoupon = (dataDict["giftCoupon"] as? [[String:Any]] ?? []).compactMap(GiftCoupenModel.init)
                let arrAd = (dataDict["advList"] as? [[String:Any]] ?? []).compactMap(AdvertiseModel.init)
                withResponse(arrAd,totalCartProduct,arrlatest,arrBrand,arrbyOther,arrgiftCoupon,totalPages,message)
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
    
    class func getProductList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ product_brand_image : String,_ totalCartProduct : String,_ arr: [productModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetProductList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            let totalCartProduct = dict[ktotalCartProduct] as? String ?? "0"
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let product_brand_image = dict[kproduct_brand_image] as? String ?? ""
                let arr = dataDict.compactMap(productModel.init)
            
                withResponse(product_brand_image,totalCartProduct,arr,totalPages,message)
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
    
    class func getMyProductFavoriteList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [productModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetMyProductFavoriteList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(productModel.init)
            
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
    
    class func productDeatil(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ totalCartProduct : String,_ arr: productModel,_ arriamges: [CategoryModel],_ arrvariation: [VariationModel],_ arrvariation: [productSpecificationModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kproductDetail, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
              
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            let totalCartProduct = dict[ktotalCartProduct] as? String ?? "0"
            if  isSuccess,let dataDict = dict[kData] as? [String:Any],
                let arr = productModel.init(dictionary: dataDict) {
                let arriamges = (dataDict["allImages"] as? [[String:Any]] ?? []).compactMap(CategoryModel.init)
                let arrvariation = (dataDict["productVariation"] as? [[String:Any]] ?? []).compactMap(VariationModel.init)
                let arrProductvariation = (dataDict["productSpecification"] as? [[String:Any]] ?? []).compactMap(productSpecificationModel.init)
                
                //compactMap(productModel.init)
                withResponse(totalCartProduct,arr,arriamges,arrvariation,arrProductvariation,totalPages,message)
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
    
    class func getShadeSizeData(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: productModel,_ shade: [ColorModel],_ Sizearr: [SizeModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetShadeSizeData, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
              
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
           
            if  isSuccess,let dataDict = dict[kData] as? [String:Any],
                let arr = productModel.init(dictionary: dataDict) {
                let shade = (dataDict["shade"] as? [[String:Any]] ?? []).compactMap(ColorModel.init)
                let Sizearr = (dataDict["size"] as? [[String:Any]] ?? []).compactMap(SizeModel.init)
               
                
                //compactMap(productModel.init)
                withResponse(arr,shade,Sizearr,totalPages,message)
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
    
    
    class func setProductLikeDislike(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        //SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetLike, method: .post, parameter: param, success: {(response) in
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
    
    
    class func addProductCart(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String,_ shipingCost : String,_ subTotal : String,_ total_amount : String) -> Void, failure: @escaping FailureBlock) {
        
        //SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kaddProductCart, method: .post, parameter: param, success: {(response) in
            //SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let shipingCost = dict[kshipingCost] as? String ?? "0"
            let subTotal = dict["subTotal"] as? String ?? "0"
            let total_amount = dict[ktotal_amount] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(total_amount,subTotal,shipingCost,message)
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

//
//  CategoryModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/03/22.
//

import Foundation
import UIKit

class CategoryModel : NSObject {
    
    var id : String
    var productId : String
    var name : String
    var image : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var brandfullimage : String
    var brandthumbimage : String
    var categorythumbImage : String
    var productfullimage : String
    var productthumbImage: String
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.productId = dictionary[kproductId] as? String ?? ""
        self.name = dictionary[kname] as? String ?? ""
        self.image = dictionary[kimage] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.brandfullimage = dictionary[kbrandfullimage] as? String ?? ""
        self.brandthumbimage = dictionary[kbrandthumbimage] as? String ?? ""
        self.categorythumbImage = dictionary[kcategorythumbImage] as? String ?? ""
        self.productfullimage = dictionary[kproductfullimage] as? String ?? ""
        self.productthumbImage = dictionary[kproductthumbImage] as? String ?? ""
        
    }
    
    
//    class func getProductCategoryList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrstory: [StoryModel],_ arrfeed: [FeedModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
//        if isShowLoader {
//            SVProgressHUD.show()
//        }
//        APIManager.makeRequest(with: AppConstant.API.kgetProductCategory, method: .post, parameter: param, success: {(response) in
//            if isShowLoader {
//                SVProgressHUD.dismiss()
//            }
//            let dict = response as? [String:Any] ?? [:]
//            
//            let message = dict[kMessage] as? String ?? ""
//            let statuscode = dict[kstatus] as? String ?? "0"
//            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
//            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
//            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
//                let arrstory = (dataDict["storyData"] as? [[String:Any]] ?? []).compactMap(StoryModel.init)
//                let arrfeed = (dataDict["postList"] as? [[String:Any]] ?? []).compactMap(FeedModel.init)
//                withResponse(arrstory,arrfeed,totalPages,message)
//            }
//            else {
//                failure(statuscode,message, .response)
//            }
//        }, failure: { (error) in
//            if isShowLoader {
//                SVProgressHUD.dismiss()
//            }
//            failure("0",error, .server)
//        }, connectionFailed: { (connectionError) in
//            if isShowLoader {
//                SVProgressHUD.dismiss()
//            }
//            failure("0",connectionError, .connection)
//        })
//    }
    

}


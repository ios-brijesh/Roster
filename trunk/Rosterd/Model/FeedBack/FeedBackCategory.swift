//
//  FeedBackCategory.swift
//  Rosterd
//
//  Created by WMiosdev01 on 28/06/22.
//
import UIKit

class FeedBackCategoryModel: NSObject {
    
    var createdDate : String
    var id : String
    var name : String
    var status : String
    var isSelect : Bool = false
    var updatedDate : String
    
    
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.name = dict[kname] as? String ?? ""
        self.isSelect = false
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
       
    }
    
    init(id : String,createdDate : String,name : String,status : String,updatedDate : String){
        self.id = id
        self.createdDate = createdDate
        self.name = name
        self.status = status
        self.updatedDate = updatedDate
    }
    
    override init() {
        self.id = ""
        self.createdDate = ""
        self.name = ""
        self.status = ""
        self.updatedDate = ""
    }
    
    
    class func getFeedbackCatergory(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrHearAbout: [FeedBackCategoryModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kGetFeddbackCategory, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(FeedBackCategoryModel.init)
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

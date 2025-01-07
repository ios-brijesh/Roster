//
//  EventCategoryModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 15/06/22.
//

import UIKit

class EventCategoryModel: NSObject {
    
    var createdDate : String
    var id : String
    var name : String
    var status : String
    var isSelectCategory : Bool
    var updatedDate : String
    
    
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.name = dict[kname] as? String ?? ""
        self.isSelectCategory = dict["isSelectCategory"] as? Bool ?? false
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
    }
    
    class func getcatergoryData(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrHearAbout: [EventCategoryModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetEventCategoryList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(EventCategoryModel.init)
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

//
//  FollowModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 14/03/22.
//

import Foundation
import UIKit

class followModel : NSObject {
    
    var id : String
    var userId : String
    var followId : String
    var createdDate : String
    var updatedDate : String
    var status : String
    var userName : String
    var postimage : String
    var thumbpostimage : String
    var TotalFollower : String
    var totalFollower : String
    var profileImage : String
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.followId = dictionary[kfollowId] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.userName = dictionary[kuserName] as? String ?? ""
        self.postimage = dictionary[kpostimage] as? String ?? ""
        self.thumbpostimage = dictionary[kthumbpostimage] as? String ?? ""
        self.TotalFollower = dictionary[kTotalFollower] as? String ?? ""
        self.totalFollower = dictionary["totalFollower"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
    }



    
class func getRequestList(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
    
    SVProgressHUD.show()
    APIManager.makeRequest(with: AppConstant.API.kgetRequestList, method: .post, parameter: param, success: {(response) in
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


    class func GetUserFriendList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [followModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetUserFriendList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(followModel.init)
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
    

class func setFollowList(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
    
    SVProgressHUD.show()
    APIManager.makeRequest(with: AppConstant.API.ksetFollow, method: .post, parameter: param, success: {(response) in
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

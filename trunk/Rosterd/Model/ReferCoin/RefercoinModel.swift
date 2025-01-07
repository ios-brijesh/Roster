//
//  RefercoinModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 24/11/22.
//

import UIKit


class RefercoinModel: NSObject {
    
    var userId : String
    var id : String
    var userIdFrom : String
    var reward : String
    var type : String
    var createdDate : String
    var updatedDate : String
    var status : String
    
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.userId = dict["userId"] as? String ?? ""
        self.userIdFrom = dict["userIdFrom"] as? String ?? ""
        self.reward = dict["reward"] as? String ?? ""
        self.type = dict["type"] as? String ?? ""
        self.createdDate = dict["createdDate"] as? String ?? ""
        self.updatedDate = dict["updatedDate"] as? String ?? ""
        self.status = dict["status"] as? String ?? ""
    }
    
    class func getUserRewardList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ totalStar : String,_ totalReward : String,_ arrHearAbout: [RefercoinModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetUserRewardList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let totalReward = dict["totalReward"] as? String ?? ""
            let totalStar = dict["totalStar"] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(RefercoinModel.init)
                withResponse(totalStar,totalReward,arr,message)
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

//
//  FeedModel.swift
//  Momentor
//
//  Created by Harshad on 31/01/22.
//

import UIKit

class FeedModel: NSObject {
    
    var fullName : String
    var shareLink : String
    var loginUserPostcreate : String
    var id : String
    var tbl_Post_Id : String
    var tbl_post_id : String
    var userId : String
    var postId : String
    var userName : String
    var thumbuserimage : String
    var text : String
    var hashtag : String
    var profileimage : String
    var status : String
    var createdDate : String
    var updatedDate : String
    var postCreateDate : String
    var totalLikeCount : String
    var totalCommentsCount : String
    var isLike : String
    var mediaNameUrl : String
    var post : [AddPhotoVideoModel]
    var userimage : String
    var isSubscriptionActive : String
    var subscriptionId : String
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.subscriptionId = dictionary["subscriptionId"] as? String ?? ""
        self.isSubscriptionActive = dictionary["isSubscriptionActive"] as? String ?? ""
        self.mediaNameUrl = dictionary["mediaNameUrl"] as? String ?? ""
        self.userimage = dictionary["userimage"] as? String ?? ""
        self.shareLink = dictionary["shareLink"] as? String ?? ""
        self.loginUserPostcreate = dictionary["loginUserPostcreate"] as? String ?? ""
        self.id = dictionary[kid] as? String ?? ""
        self.tbl_Post_Id = dictionary[ktbl_Post_Id] as? String ?? ""
        self.tbl_post_id = dictionary[ktbl_post_id] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.postId = dictionary[kpostId] as? String ?? ""
        self.userName = dictionary[kuserName] as? String ?? ""
        self.text = dictionary[ktext] as? String ?? ""
        self.profileimage = dictionary[kprofileimage] as? String ?? ""
        self.thumbuserimage = dictionary[kthumbuserimage] as? String ?? ""
        self.hashtag = dictionary[khashtag] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.totalLikeCount = dictionary[ktotalLikeCount] as? String ?? ""
        self.totalCommentsCount = dictionary[ktotalCommentsCount] as? String ?? ""
        self.postCreateDate = dictionary[kpostCreateDate] as? String ?? ""
        self.isLike = dictionary[kisLike] as? String ?? ""
        self.fullName = dictionary[kfullName] as? String ?? ""
        self.post = (dictionary[kpost] as? [[String:Any]] ?? []).compactMap(AddPhotoVideoModel.init)
    }
    
    

    class func setuserPost(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kuserPost, method: .post, parameter: param, success: {(response) in
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
    
    class func getDashboardList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ subscriptionId : String,_ isSubscriptionActive : String,_ arrstory: [StoryModel],_ arrfeed: [FeedModel],_ arrAd: [AdvertiseModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlockHome) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetDashboardList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSubscriptionActive = dict["isSubscriptionActive"] as? String ?? ""
            let subscriptionId = dict["subscriptionId"] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            let data = dict[kData] as? [String:Any]
            if  isSuccess,let dataDict = data{
                let arrstory = (dataDict["storyData"] as? [[String:Any]] ?? []).compactMap(StoryModel.init)
                let arrfeed = (dataDict["postList"] as? [[String:Any]] ?? []).compactMap(FeedModel.init)
                let arrAd = (dataDict["advList"] as? [[String:Any]] ?? []).compactMap(AdvertiseModel.init)
                withResponse(subscriptionId,isSubscriptionActive,arrstory,arrfeed,arrAd,totalPages,message)
            }
            else {
                let arrAdv = (data?["advList"] as? [[String:Any]] ?? []).compactMap(AdvertiseModel.init)
                failure(statuscode,message, .response,arrAdv)
            }
        }, failure: { (error) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            failure("0",error, .server,[])
        }, connectionFailed: { (connectionError) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            failure("0",connectionError, .connection,[])
        })
    }
    
    class func setPostLikeDislike(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        //SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetPostLikeDislike, method: .post, parameter: param, success: {(response) in
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
    
    class func setFeedReport(with param: [String:Any]?,isFromComment : Bool = false, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {

        SVProgressHUD.show()
        APIManager.makeRequest(with: isFromComment ? AppConstant.API.ksetFeedCommentReport : AppConstant.API.kPostreport, method: .post, parameter: param, success: {(response) in
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
    
    class func deleteFeed(with param: [String:Any]?,isFromComment : Bool = false, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {

        SVProgressHUD.show()
        APIManager.makeRequest(with: isFromComment ? AppConstant.API.kdeleteFeedComment : AppConstant.API.kpostDelete, method: .post, parameter: param, success: {(response) in
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
    
    class func setPostComment(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetPostComment, method: .post, parameter: param, success: {(response) in
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
//    class func setPostComment(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [FeedUserLikeModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
//        if isShowLoader {
//            SVProgressHUD.show()
//        }
//        APIManager.makeRequest(with: AppConstant.API.ksetPostComment, method: .post, parameter: param, success: {(response) in
//            if isShowLoader {
//                SVProgressHUD.dismiss()
//            }
//            let dict = response as? [String:Any] ?? [:]
//            
//            let message = dict[kMessage] as? String ?? ""
//            let statuscode = dict[kstatus] as? String ?? "0"
//            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
//            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
//            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
//                let arr = dataDict.compactMap(FeedUserLikeModel.init)
//                withResponse(arr,totalPages,message)
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

//
//  FeedUserLikeModel.swift
//  Momentor
//
//  Created by Harshad on 01/02/22.
//

import UIKit

class FeedUserLikeModel: NSObject {

    var id : String
    var userName : String
    var commentId : String
    var userId : String
    var postId : String
    var type : String
    var comment : String
    var videoThumpImg : UIImage
    var profileimage : String
    var thumbprofileimage : String
    var createdDate : String
    var commentType : String
    var isFollow : String
    var totalLikes : String
    var totalComments : String
    var childComments : [FeedUserLikeModel]
    
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.userName = dictionary[kuserName] as? String ?? ""
        self.commentId = dictionary[kcommentId] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.postId = dictionary[kpostId] as? String ?? ""
        self.type = dictionary[ktype] as? String ?? ""
        self.videoThumpImg = UIImage(named: DefaultPlaceholderImage.AppPlaceholder) ?? UIImage()
        self.profileimage = dictionary[kprofileimage] as? String ?? ""
        self.thumbprofileimage = dictionary[kthumbprofileimage] as? String ?? ""
        self.comment = dictionary[kcomment] as? String ?? ""
        self.commentType = dictionary[kcommentType] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.isFollow = dictionary[kisFollow]as? String ?? ""
        self.totalLikes = dictionary[ktotalLikes]as? String ?? ""
        self.totalComments = dictionary[ktotalComments] as? String ?? ""
        self.childComments = (dictionary[kchildComments] as? [[String:Any]] ?? []).compactMap(FeedUserLikeModel.init)
        
    }
    
    class func getPostLikeCommentUser(with param: [String:Any]?,isShowLoader : Bool = true,isFromComment : Bool = false ,success withResponse: @escaping (_ totalComments : String,_ totalLikes : String,_ arr: [FeedUserLikeModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: isFromComment ? AppConstant.API.kgetPostcomments : AppConstant.API.kgetPostsLikeList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            let totalLikes = dict[ktotalLikes] as? String ?? "0"
            let totalComments = dict[ktotalComments] as? String ?? "0"
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap({FeedUserLikeModel.init(dictionary: $0)})
                withResponse(totalComments,totalLikes,arr,totalPages,message)
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
}

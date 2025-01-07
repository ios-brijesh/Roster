//
//  ProfileImageModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/09/22.
//

import UIKit


class ProfileImageModel: NSObject {
    
   
    var id : String
    var albumId : String
    var image : String
    var videoThumbImage : String
    var createdDate : String
    var updatedDate : String
    var status : String
    var media : String
    var thumbMedia : String
    var userId : String
    var isVideo : String
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.albumId = dict["albumId"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.videoThumbImage = dict["videoThumbImage"] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
        self.thumbMedia = dict["thumbMedia"] as? String ?? ""
        self.media = dict["media"] as? String ?? ""
        self.userId = dict["userId"] as? String ?? ""
        self.isVideo = dict["isVideo"] as? String ?? ""
        
    }
    class func DeleteUserAlbumMedia(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kdeleteUserAlbumMedia, method: .post, parameter: param, success: {(response) in
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


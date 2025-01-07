//
//  AddPhotoVideoModel.swift
//  Momentor
//
//  Created by Harshad on 31/01/22.
//

import UIKit

class AddPhotoVideoModel: NSObject {

    var isPost : String
    var id : String
    var postId : String
    var postimage : String
    var thumbpostimage : String
    var mediaNameUrl : String
    var mediaName : String
    var isVideo : Bool
    var type : Bool
    var videoImage : String
    var videoThumpImg : UIImage
    var mediaNameThumbUrl : String
    var videoImageUrl : String
    var videoImageThumbUrl : String
    var postvideoThumbImage : String
    var thumbpostvideoThumbImage : String
    var videoThumbImage : String
    var thumbMedia : String
    var media : String
    var image : String
    var name : String
    var videoThumbImgName : String
    var galleryImage : String
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.isPost = dictionary["isPost"] as? String ?? ""
        self.id = dictionary[kid] as? String ?? ""
        self.postId = dictionary[kpostId] as? String ?? ""
        self.postimage = dictionary[kpostimage] as? String ?? ""
        self.thumbpostimage = dictionary[kthumbpostimage] as? String ?? ""
        self.mediaNameUrl = dictionary[kimage] as? String ?? ""
        self.mediaName = dictionary[kmediaName] as? String ?? ""
        self.isVideo = (dictionary["isPost"] as? String ?? "") == "2" ? true : false
        self.type = (dictionary["type"] as? String ?? "") == "2" ? true : false
        self.videoThumpImg = UIImage(named: DefaultPlaceholderImage.AppPlaceholder) ?? UIImage()
        self.videoImage = dictionary[kvideoImage] as? String ?? ""
        self.mediaNameThumbUrl = dictionary[kthumbImage] as? String ?? ""
        self.videoImageUrl = dictionary[kvideoImageUrl] as? String ?? ""
        self.videoImageThumbUrl = dictionary[kvideoThumbImage] as? String ?? ""
        self.postvideoThumbImage = dictionary[kpostvideoThumbImage] as? String ?? ""
        self.thumbpostvideoThumbImage = dictionary[kthumbpostvideoThumbImage] as? String ?? ""
        self.videoThumbImage = dictionary["videoThumbImage"] as? String ?? ""
        self.thumbMedia = dictionary["thumbMedia"] as? String ?? ""
        self.media = dictionary["media"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.videoThumbImgName = dictionary["videoThumbImgName"] as? String ?? ""
        self.galleryImage = dictionary["galleryImage"] as? String ?? ""
    }
    
    init(Id : String,postId : String,postimage : String,FeedId : String,MediaNameUrl : String,MediaName : String,isvideo : Bool,VideoImage : String,videothumpimg : UIImage,MediaNameThumbUrl : String,VideoImageUrl : String,VideoImageThumbUrl : String,thumbpostimage : String,postvideoThumbImage : String,thumbpostvideoThumbImage : String,isPost : String,type : Bool,videoThumbImage : String,thumbMedia : String,media : String,image : String,name : String,videoThumbImgName : String,galleryImage : String){
        self.id = Id
        self.postId = postId
        self.postimage = postimage
        self.mediaNameUrl = MediaNameUrl
        self.mediaName = MediaName
        self.isVideo = isvideo
        self.videoThumpImg = videothumpimg
        self.videoImage = VideoImage
        self.mediaNameThumbUrl = MediaNameThumbUrl
        self.videoImageUrl = VideoImageUrl
        self.thumbpostimage = thumbpostimage
        self.videoImageThumbUrl = VideoImageThumbUrl
        self.postvideoThumbImage = postvideoThumbImage
        self.thumbpostvideoThumbImage = thumbpostvideoThumbImage
        self.isPost = isPost
        self.type = type
        self.videoThumbImage = videoThumbImage
        self.thumbMedia = thumbMedia
        self.media = media
        self.image = image
        self.name = name
        self.videoThumbImgName = videoThumbImgName
        self.galleryImage = galleryImage
    }
    
    override init() {
        self.id = ""
        self.postId = ""
        self.postimage = ""
        self.mediaNameUrl = ""
        self.mediaName = ""
        self.isVideo = false
        self.videoThumpImg = UIImage()
        self.videoImage = ""
        self.mediaNameThumbUrl = ""
        self.videoImageUrl = ""
        self.thumbpostimage = ""
        self.videoImageThumbUrl = ""
        self.postvideoThumbImage = ""
        self.thumbpostvideoThumbImage = ""
        self.isPost = ""
        self.type = false
        self.videoThumbImage = ""
        self.thumbMedia = ""
        self.media = ""
        self.image = ""
        self.name = ""
        self.videoThumbImgName = ""
        self.galleryImage = ""
    }
    
    class func addVideoAPI(with videoData: NSData?,image : UIImage?,param: [String:Any]?, success withResponse: @escaping (_ videoname : String,_ videourl : String,_ videoThumImgUrl : String,_ thumbpostImage : String,_ videoThumImgName : String,_ postvideoThumbimage : String,_ thumbpostvideoThumbimage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeMultipartFormDataVideoRequest(AppConstant.API.kmediaUpload, videodata: videoData, videoName: kfiles, image: image, imageName: kVideoThumbnail, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                
                if let first = dataDict.first {
                    let msg = first[kmediaName] as? String ?? ""
                    let videourl = first[kmediaBaseUrl] as? String ?? ""
                    let videoThumnailurl = first[kvideoThumbImgUrl] as? String ?? ""
                    let thumbpostImage = first[kthumbpostimage] as? String ?? ""
                    let thumpImgName = first[kvideoThumbImgName] as? String ?? ""
                    let postvideoThumbimage = first[kpostvideoThumbImage] as? String ?? ""
                    let thumbpostvideoThumbimage = first[kthumbpostvideoThumbImage] as? String ?? ""
                    withResponse(msg,videourl,videoThumnailurl,thumbpostImage,thumpImgName,postvideoThumbimage,thumbpostvideoThumbimage)
                } else {
                    failure(statuscode,message, .response)
                }
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

class func addFeedVideoAPI(with videoData: NSData?,image : UIImage?,param: [String:Any]?, success withResponse: @escaping (_ videoname : String,_ videourl : String,_ videoThumImgUrl : String,_ videoThumImgName : String) -> Void, failure: @escaping FailureBlock) {
    
    SVProgressHUD.show()
    APIManager.makeMultipartFormDataVideoRequest(AppConstant.API.kmediaUpload, videodata: videoData, videoName: kfiles, image: image, imageName: kVideoThumbnail, withParameter: param, withSuccess: { (response) in
        SVProgressHUD.dismiss()
        let dict = response as? [String:Any] ?? [:]
        let message = dict[kMessage] as? String ?? ""
        let statuscode = dict[kstatus] as? String ?? "0"
        let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
        if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
            
            if let first = dataDict.first {
                let msg = first[kmediaName] as? String ?? ""
                let videourl = first[kmediaBaseUrl] as? String ?? ""
                let videoThumnailurl = first[kvideoThumbImgUrl] as? String ?? ""
                let thumpImgName = first[kvideoThumbImgName] as? String ?? ""
                withResponse(msg,videourl,videoThumnailurl,thumpImgName)
            } else {
                failure(statuscode,message, .response)
            }
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

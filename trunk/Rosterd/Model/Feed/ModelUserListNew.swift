//
//	ModelUserListNew.swift
//
//	Create by wm-devr on 29/6/2020
//	Copyright © 2020. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ModelUserListNew : NSObject{
//    , NSCoding
	var createdDate : String
	var friendId : String
	var id : String
	var myFriendId : String
	var status : String
	var userImage : String
	var userName : String
	var userThumbImage : String
	var userId : String
    var chatGroupId : String
    

    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdDate = dictionary["createdDate"] as? String ?? ""
		friendId = dictionary["friend_id"] as? String ?? ""
		id = dictionary["id"] as? String ?? ""
		myFriendId = dictionary["myFriendId"] as? String ?? ""
		status = dictionary["status"] as? String ?? ""
		userImage = dictionary["postimage"] as? String ?? ""
		userName = dictionary["userName"] as? String ?? ""
		userThumbImage = dictionary["thumbpostimage"] as? String ?? ""
		userId = dictionary["userId"] as? String ?? ""
        chatGroupId = dictionary["chatGroupId"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
//	func toDictionary() -> [String:Any]
//	{
//		var dictionary = [String:Any]()
//		if createdDate != nil{
//			dictionary["createdDate"] = createdDate
//		}
//		if friendId != nil{
//			dictionary["friend_id"] = friendId
//		}
//		if id != nil{
//			dictionary["id"] = id
//		}
//		if myFriendId != nil{
//			dictionary["myFriendId"] = myFriendId
//		}
//		if status != nil{
//			dictionary["status"] = status
//		}
//		if userImage != nil{
//			dictionary["postimage"] = userImage
//		}
//		if userName != nil{
//			dictionary["userName"] = userName
//		}
//		if userThumbImage != nil{
//			dictionary["thumbpostimage"] = userThumbImage
//		}
//		if userId != nil{
//			dictionary["user_id"] = userId
//		}
//        if chatGroupId != nil{
//            dictionary["chatGroupId"] = chatGroupId
//        }
//		return dictionary
//	}
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//	{
//         createdDate = aDecoder.decodeObject(forKey: "createdDate") as? String ?? ""
//         friendId = aDecoder.decodeObject(forKey: "friend_id") as? String ?? ""
//         id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
//         myFriendId = aDecoder.decodeObject(forKey: "myFriendId") as? String ?? ""
//         status = aDecoder.decodeObject(forKey: "status") as? String ?? ""
//         userImage = aDecoder.decodeObject(forKey: "postimage") as? String ?? ""
//         userName = aDecoder.decodeObject(forKey: "userName") as? String ?? ""
//         userThumbImage = aDecoder.decodeObject(forKey: "thumbpostimage") as? String ?? ""
//         userId = aDecoder.decodeObject(forKey: "user_id") as? String ?? ""
//         chatGroupId = aDecoder.decodeObject(forKey: "chatGroupId") as? String ?? ""
//	}
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//	{
//		if createdDate != nil{
//			aCoder.encode(createdDate, forKey: "createdDate")
//		}
//		if friendId != nil{
//			aCoder.encode(friendId, forKey: "friend_id")
//		}
//		if id != nil{
//			aCoder.encode(id, forKey: "id")
//		}
//		if myFriendId != nil{
//			aCoder.encode(myFriendId, forKey: "myFriendId")
//		}
//		if status != nil{
//			aCoder.encode(status, forKey: "status")
//		}
//		if userImage != nil{
//			aCoder.encode(userImage, forKey: "postimage")
//		}
//		if userName != nil{
//			aCoder.encode(userName, forKey: "userName")
//		}
//		if userThumbImage != nil{
//			aCoder.encode(userThumbImage, forKey: "thumbpostimage")
//		}
//		if userId != nil{
//			aCoder.encode(userId, forKey: "user_id")
//		}
//
//	}
    
    
    class func getUsersFollowListAPICall(with param: [String:Any]?,isShowLoader : Bool, success withResponse: @escaping (_ arr: [ModelUserListNew],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
           if isShowLoader {
           SVProgressHUD.show()
           }
        APIManager.makeRequest(with: AppConstant.API.kgetUsersFollowList, method: .post, parameter: param, success: {(response) in
               if isShowLoader {
               SVProgressHUD.dismiss()
               }
               let dict = response as? [String:Any] ?? [:]
               
               let message = dict[kMessage] as? String ?? ""
               let statuscode = dict[kstatus] as? String ?? "0"
               let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
               let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
               if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                   
                   let arr = dataDict.compactMap(ModelUserListNew.init)
                   
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

}

//
//  EventCategoryListModel.swift
//  Rosterd
//
//  Created by WM-KP on 20/05/22.
//

import Foundation

class EventCategoryListModel : NSObject{
    
    var data : [EventCategoryListDataModel]!
    var message : String!
    var status : String!

    init(fromDictionary dictionary: [String:Any]){
        data = [EventCategoryListDataModel]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = EventCategoryListDataModel(fromDictionary: dic)
                data.append(value)
            }
        }
        message = dictionary["message"] as? String
        status = dictionary["status"] as? String
    }
}


class EventCategoryListDataModel : NSObject{
    
    var createdDate : String!
    var id : String!
    var name : String!
    var status : String!
    var updatedDate : String!
    var isSelectCategory : Bool!
    
    init(fromDictionary dictionary: [String:Any]){
        createdDate = dictionary["createdDate"] as? String
        id = dictionary["id"] as? String
        name = dictionary["name"] as? String
        status = dictionary["status"] as? String
        updatedDate = dictionary["updatedDate"] as? String
        isSelectCategory = false
    }
    
    
    init(id : String,Name : String){
        self.id = id
        self.name = Name
    }
    
    override init() {
        self.id = ""
        self.name = ""
    }
    
    
    class func getEventCategoryList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrHearAbout: [EventCategoryListDataModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
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
                let arr = dataDict.compactMap(EventCategoryListDataModel.init)
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




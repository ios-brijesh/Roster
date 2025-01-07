//
//  AdresssModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 08/07/22.
//

import UIKit

class AdresssModel: NSObject {
    
    var id : String
    var userId : String
    var houseNumber : String
    var address : String
    var landMark : String
    var city : String
    var zipcode : String
    var latitude : String
    var longitude : String
    var isDefault : String
    var createdDate : String
    var updatedDate : String
    var status : String
    var phonenumber : String
    
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.houseNumber = dictionary["houseNumber"] as? String ?? ""
        self.address = dictionary[kaddress] as? String ?? ""
        self.landMark = dictionary["landMark"] as? String ?? ""
        self.city = dictionary[kcity] as? String ?? ""
        self.zipcode = dictionary[kzipcode] as? String ?? ""
        self.latitude = dictionary[klatitude] as? String ?? ""
        self.longitude = dictionary[klongitude] as? String ?? ""
        self.isDefault = dictionary[kisDefault] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.phonenumber = dictionary[kphone] as? String ?? ""
        
    }
    
    class func getUserShippingAddress(with param: [String:Any]?, success withResponse: @escaping (_ arr: [AdresssModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kgetUserShippingAddress, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                
                let arr = dataDict.compactMap(AdresssModel.init)
                
                withResponse(arr,message)
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
    
    class func SetUserShippingAddress(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetUserShippingAddress, method: .post, parameter: param, success: {(response) in
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
    
    class func DeleteShippingAddress(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kdeleteShippingAddress, method: .post, parameter: param, success: {(response) in
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

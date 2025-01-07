//
//  SportsModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 12/05/22.
//


import UIKit

class SportsModel: NSObject, NSCoding {
    
    
    var createdDate : String
    var id : String
    var name : String
    var status : String
    var isSelect : Bool 
    var updatedDate : String
    var sportNameId : String
    var userId : String
 
    
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.name = dict[kname] as? String ?? ""
        self.isSelect = dict[kisSelect] as? Bool ?? false
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
        self.sportNameId = dict[ksportNameId] as? String ?? ""
        self.userId = dict[kuserId] as? String ?? ""
    
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.id = aDecoder.decodeObject(forKey: kid) as? String ?? ""
        self.createdDate = aDecoder.decodeObject(forKey: kcreatedDate) as? String ?? ""
        self.status = aDecoder.decodeObject(forKey: kstatus) as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: kname) as? String ?? ""
        self.updatedDate = aDecoder.decodeObject(forKey: kupdatedDate) as? String ?? ""
        self.sportNameId = aDecoder.decodeObject(forKey: ksportNameId) as? String ?? ""
        self.userId = aDecoder.decodeObject(forKey: kuserId) as? String ?? ""
        self.isSelect = Bool(aDecoder.decodeObject(forKey: kisSelect) as? String ?? "") ?? false
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: kid)
        aCoder.encode(createdDate, forKey: kcreatedDate)
        aCoder.encode(status, forKey: kstatus)
        aCoder.encode(name, forKey: kname)
        aCoder.encode(updatedDate, forKey: kupdatedDate)
        aCoder.encode(sportNameId, forKey: ksportNameId)
        aCoder.encode(userId, forKey: kuserId)
        aCoder.encode(isSelect,forKey: kisSelect)
        
        
    }
    

    
    class func getSportsList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrHearAbout: [SportsModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetcommonData, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(SportsModel.init)
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

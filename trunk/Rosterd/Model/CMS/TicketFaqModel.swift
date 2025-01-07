//
//  TicketFaqModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 08/07/22.
//

import UIKit

class TicketFaqModel: NSObject {

    var id : String
    var name : String
    var image : String
    var updatedDate : String
    var createdDate : String
    var status : String
    var faqCategoryImage : String
    var thumbFaqCategoryImage : String
    var faqCount : String
    

    // MARK: - init
    init?(dictionary: [String:Any]) {
        self.id = dictionary[kid] as? String ?? ""
        self.name = dictionary[kname] as? String ?? ""
        self.image = dictionary[kimage] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.faqCategoryImage = dictionary[kfaqCategoryImage] as? String ?? ""
        self.thumbFaqCategoryImage = dictionary[kthumbFaqCategoryImage] as? String ?? ""
        self.faqCount = dictionary[kfaqCount] as? String ?? ""
    }
    
    
    class func GetFaqCategory(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrTicket: [SupportChatModel],_ arrFaq: [TicketFaqModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetFaqCategory, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
               
                let arrTicket = (dataDict["ticketData"] as? [[String:Any]] ?? []).compactMap(SupportChatModel.init)
                let arrFaq = (dataDict["faqData"] as? [[String:Any]] ?? []).compactMap(TicketFaqModel.init)
               
                withResponse(arrTicket,arrFaq,totalPages,message)
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

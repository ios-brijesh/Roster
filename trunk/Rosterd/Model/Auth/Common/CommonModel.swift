//
//  CommonModel.swift
//  XtraHelpCaregiver
//
//  Created by wm-devIOShp on 18/11/21.
//

import UIKit

class CommonModel: NSObject {

    class func getCommonData(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arrsport: [SportsModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
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
            
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                
                let arrsport = (dataDict[ksport] as? [[String:Any]] ?? []).compactMap(SportsModel.init)
//                let arrlicenceType = (dataDict[klicenceType] as? [[String:Any]] ?? []).compactMap(licenceTypeModel.init)
//                let arrInsuranceType = (dataDict[kinsuranceType] as? [[String:Any]] ?? []).compactMap(InsuranceTypeModel.init)
//                let arrWorkSpeciality = (dataDict[kworkSpeciality] as? [[String:Any]] ?? []).compactMap(WorkSpecialityModel.init)
//                let arrWorkMethodOfTransportation = (dataDict[kworkMethodOfTransportation] as? [[String:Any]] ?? []).compactMap(WorkMethodOfTransportationModel.init)
//                let arrWorkDisabilitiesWillingType = (dataDict[kworkDisabilitiesWillingType] as? [[String:Any]] ?? []).compactMap(WorkDisabilitiesWillingTypeModel.init)
                withResponse(arrsport,message)
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

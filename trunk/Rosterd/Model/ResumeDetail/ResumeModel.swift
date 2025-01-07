//
//  ResumeModel.swift
//  Rosterd
//
//  Created by iMac on 01/05/23.
//

import UIKit

class ResumeModel : NSObject {
    var token : String
    var langType : String
    var userResumeId : String
    var twitter : String
    var instagram : String
    var facebook : String
    var linkedIn : String
    var email : String
    var phone : String
    var address : String
    var schoolName : String
    var schoolAddress : String
    var gpa : String
    var actScore : String
    var satScore : String
    var fullName : String
    var resumeShareProfileId : String
    var userThumbProfileImage : String
    var teams : [AthlicsModel]
    var achievements : [AchievementsModel]
    var curriculars : [CurricularsModel]
    var references : [ReferenceModel]
    var measurements : [MeasureModel]
    var highlights : [AddPhotoVideoModel]
    var sportsData : [SportsModel]
    
    init?(dict: [String:Any]){
        self.userThumbProfileImage = dict["userThumbProfileImage"] as? String ?? ""
        self.fullName = dict["fullName"] as? String ?? ""
        self.resumeShareProfileId = dict["resumeShareProfileId"] as? String ?? ""
        self.token = dict["token"] as? String ?? ""
        self.langType = dict["langType"] as? String ?? ""
        self.userResumeId = dict["userResumeId"] as? String ?? ""
        self.twitter = dict["twitter"] as? String ?? ""
        self.instagram = dict["instagram"] as? String ?? ""
        self.facebook = dict["facebook"] as? String ?? ""
        self.linkedIn = dict["linkedIn"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.phone = dict["phone"] as? String ?? ""
        self.address = dict["address"] as? String ?? ""
        self.schoolName = dict["schoolName"] as? String ?? ""
        self.schoolAddress = dict["schoolAddress"] as? String ?? ""
        self.gpa = dict["gpa"] as? String ?? ""
        self.actScore = dict["actScore"] as? String ?? ""
        self.satScore = dict["satScore"] as? String ?? ""
        self.measurements = (dict["measurements"] as? [[String:Any]] ?? []).compactMap(MeasureModel.init)
        self.references = (dict["references"] as? [[String:Any]] ?? []).compactMap(ReferenceModel.init)
        self.curriculars = (dict["curriculars"] as? [[String:Any]] ?? []).compactMap(CurricularsModel.init)
        self.achievements = (dict["achievements"] as? [[String:Any]] ?? []).compactMap(AchievementsModel.init)
        self.teams = (dict["teams"] as? [[String:Any]] ?? []).compactMap(AthlicsModel.init)
        self.highlights = (dict["highlights"] as? [[String:Any]] ?? []).compactMap(AddPhotoVideoModel.init)
        self.sportsData = (dict["sportsData"] as? [[String:Any]] ?? []).compactMap(SportsModel.init)
    }
    
    class func setUserResume(with param: [String:Any]?, success withResponse: @escaping (_ resumeShareProfileId : String,_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetUserResume, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let resumeShareProfileId = dict["resumeShareProfileId"] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(resumeShareProfileId,message)
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
    
    class func getUserResume(with param: [String:Any]?, success withResponse: @escaping (_ Resume: ResumeModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {

        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kgetUserResume, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]

            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let Resume = ResumeModel(dict: dataDict) {
                withResponse(Resume, message)
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

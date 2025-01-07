//
//  bookingUserDataModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/04/22.
//

import UIKit


class bookingUserDataModel : NSObject {
    
    var id : String
    var fullName : String
    var userName : String
    var nickName : String
    var email : String
    var phone : String
    var password : String
    var address : String
    var role : String
    var image : String
    var dob : String
    var ageGroup : String
    var gender : String
    var verificationCode : String
    var forgotCode : String
    var timeZone : String
    var isOnline : String
    var favoriteSportsTeam : String
    var hometown : String
    var coachRecord : String
    var previousExperience   : String
    var recreationalTeams : String
    var clubTeams : String
    var adultLeagues : String
    var mascot : String
    var additionalInfo : String
    var graduationYear : String
    var schoolName : String
    var schoolAddress : String
    var clubName : String
    var clubAddress : String
    var height : String
    var weight : String
    var gpa : String
    var activeStatus : String
    var profileStatus : String
    var customerId : String
    var createdDate : String
    var updatedDate : String
    var status : String
    var profileimage : String
    var thumbprofileimage : String
    
    
    
    init?(dict : [String:Any]){
        
        self.id = dict[kid] as? String ?? ""
        self.fullName = dict[kfullName] as? String ?? ""
        self.userName = dict[kuserName] as? String ?? ""
        self.nickName = dict[knickName] as? String ?? ""
        self.email = dict[kemail] as? String ?? ""
        self.phone = dict[kphone] as? String ?? ""
        self.password = dict[kpassword] as? String ?? ""
        self.address = dict[kaddress] as? String ?? ""
        self.role = dict[krole] as? String ?? ""
        self.image = dict[kimage] as? String ?? ""
        self.dob = dict[kdob] as? String ?? ""
        self.ageGroup = dict[kageGroup] as? String ?? ""
        self.gender = dict[kgender] as? String ?? ""
        self.verificationCode = dict[kverificationCode] as? String ?? ""
        self.forgotCode = dict[kforgotCode]	 as? String ?? ""
        self.timeZone = dict[ktimeZone] as? String ?? ""
        self.isOnline = dict[kisOnline] as? String ?? ""
        self.favoriteSportsTeam = dict[kfavoriteSportsTeam] as? String ?? ""
        self.hometown = dict[khometown] as? String ?? ""
        self.coachRecord = dict[kcoachRecord] as? String ?? ""
        self.previousExperience = dict[kpreviousExperience] as? String ?? ""
        self.recreationalTeams = dict[krecreationalTeams] as? String ?? ""
        self.clubTeams = dict[kclubTeams] as? String ?? ""
        self.adultLeagues = dict[kadultLeagues] as? String ?? ""
        self.mascot = dict[kmascot] as? String ?? ""
        self.additionalInfo = dict[kadditionalInfo] as? String ?? ""
        self.graduationYear = dict[kgraduationYear] as? String ?? ""
        self.schoolName = dict[kschoolName] as? String ?? ""
        self.schoolAddress = dict[kschoolAddress] as? String ?? ""
        self.clubName = dict[kclubName] as? String ?? ""
        self.clubAddress = dict[kclubAddress] as? String ?? ""
        self.height = dict[kheight] as? String ?? ""
        self.weight = dict[kweight] as? String ?? ""
        self.gpa = dict[kgpa] as? String ?? ""
        self.activeStatus = dict[kactiveStatus] as? String ?? ""
        self.profileStatus = dict[kprofileStatus] as? String ?? ""
        self.customerId = dict[kcustomerId] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.profileimage = dict[kprofileimage] as? String ?? ""
        self.thumbprofileimage = dict[kthumbprofileimage] as? String ?? ""
        
        
        
    }
    
    
    
}

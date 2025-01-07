//
//  UserModel.swift
//  OmApp
//
//  Created by KETAN SODVADIYA on 24/01/19.
//  Copyright © 2019 OM App. All rights reserved.
//

import UIKit

final class UserModel: NSObject,NSCoding {
    
    var nickName : String
    var profileStatus : String
    var fillpassword : String
    var emergencyContact : String
    var contactPersonName : String
    var birthdate : String
    var id : String
    var lname : String
    var deviceToken : String
    var country : String
    var stateName : String
    var stateId : String
    var zipcode : String
    var TotalFollower : String
    var mascot : String
    var referralCode : String
    var location : String
    var timeZone : String
    var dob : String
    var fname : String
    var role : userRole
    var verificationCode : String
    var address : String
    var pushNotification : String
    var email : String
    var image : String
    var deviceId : String
    var unitNo : String
    var name : String
    var forgotCode : String
    var longitude : String
    var cityName : String
    var cityId : String
    var deviceType : String
    var status : String
    var favoriteSportsTeam : String
    var hometown : String
    var coachRecord : String
    var clubTeams : String
    var height : String
    var activeStatus : String
    var adultLeagues : String
    var profileimage : String
    var thumbprofileimage : String
    var recreationalTeams : String
    var gender : GenderEnum
    var token : String
    var age : String
    var mname : String
    var userName : String
    var fullName : String
    var password : String
    var phone : String
    var latitude : String
    var qr_code : String
    var about : String
    var ref_url : String
    var additionalInfo : String
    var graduationYear : String
    var schoolName : String
    var schoolAddress : String
    var clubName : String
    var clubAddress : String
    var weight : String
    var previousExperience : String
    var tiesRecord : String
    var lossesRecord : String
    var winRecord : String
    var isCoach : CoachEnum
    var coachYear : YearCoachingEnum
    var athleticDirectorEmail : String
    var athleticDirector : String
    var fax : String
    var grades : GradeEnum
    var School : String
    var clubTeamsAge : String
    var ageGroup : String
    var isAgeGroup : String
    var sport : [SportsModel]
    var albumData : [ProfileAlbumModel]
    var headline : String
    var teamName : String
    var playerPosition : String
    var gpa : String
    var isClubTeams : SchoolClubEnum
    var Club : String
    var clubsTeams : String
    var isFollow : String
    var recreationalTeamsAgeGroup : String
    var ageGroups : String
    var postData : [FeedModel]
    var followers : String
    var following : String
    var postCount : String
    var totalReward : String
    var shareReferralLink : String
    var highlights : [AddPhotoVideoModel]
    var subscriptionId : String
    var subscriptionExpiryDate : String
    var isSubscriptionActive : String
    // MARK: - init
    
    init?(dictionary: [String:Any]) {
        self.isSubscriptionActive = dictionary["isSubscriptionActive"] as? String ?? ""
        self.subscriptionId = dictionary["subscriptionId"] as? String ?? ""
        self.postCount = dictionary["postCount"] as? String ?? ""
        self.following = dictionary["following"] as? String ?? ""
        self.followers = dictionary["followers"] as? String ?? ""
        self.highlights = (dictionary["highlights"] as? [[String:Any]] ?? []).compactMap(AddPhotoVideoModel.init)
        self.sport = (dictionary[ksport] as? [[String:Any]] ?? []).compactMap(SportsModel.init)
        self.albumData = (dictionary["albumData"] as? [[String:Any]] ?? []).compactMap(ProfileAlbumModel.init)
        self.postData = (dictionary["postData"] as? [[String:Any]] ?? []).compactMap(FeedModel.init)
        self.isFollow = dictionary[kisFollow] as? String ?? ""
        self.previousExperience = dictionary[kpreviousExperience] as? String ?? ""
        self.tiesRecord = dictionary[ktiesRecord] as? String ?? ""
        self.lossesRecord = dictionary[klossesRecord] as? String ?? ""
        self.winRecord = dictionary[kwinRecord] as? String ?? ""
        self.athleticDirectorEmail = dictionary[kathleticDirectorEmail] as? String ?? ""
        self.athleticDirector = dictionary[kathleticDirector] as? String ?? ""
        self.fax = dictionary[kfax] as? String ?? ""
        self.ageGroup = dictionary[kageGroup] as? String ?? ""
        self.School = dictionary[kSchool] as? String ?? ""
        self.headline = dictionary[kheadline] as? String ?? ""
        self.grades = GradeEnum(rawValue: (Int(dictionary[kgrades] as? String ?? "0")) ?? 0) ?? .GradeA
        self.isClubTeams = SchoolClubEnum(rawValue: (Int(dictionary[kisClubTeams] as? String ?? "0")) ?? 0) ?? .Club
        self.hometown = dictionary[khometown] as? String ?? ""
        self.coachYear = YearCoachingEnum(rawValue: (Int(dictionary[kcoachYear] as? String ?? "0")) ?? 0) ?? .oneyear
        self.Club = dictionary[kClub] as? String ?? ""
        self.gpa = dictionary[kgpa] as? String ?? ""
        self.clubTeamsAge = dictionary[kclubTeamsAge] as? String ?? ""
        self.isAgeGroup = dictionary[kisAgeGroup] as? String ?? ""
        self.profileStatus = dictionary[kprofileStatus] as? String ?? ""
        self.mascot = dictionary[kmascot] as? String ?? ""
        self.fillpassword = dictionary[kfillpassword] as? String ?? ""
        self.emergencyContact = dictionary[kemergencyContact] as? String ?? ""
        self.clubAddress = dictionary[kclubAddress] as? String ?? ""
        self.contactPersonName = dictionary[kcontactPersonName] as? String ?? ""
        self.birthdate = dictionary[kbirthdate] as? String ?? ""
        self.id = dictionary[kid] as? String ?? ""
        self.weight = dictionary[kweight] as? String ?? ""
        self.lname = dictionary[klname] as? String ?? ""
        self.height = dictionary[kheight] as? String ?? ""
        self.deviceToken = dictionary[kdeviceToken] as? String ?? ""
        self.country = dictionary[kcountry] as? String ?? ""
        self.stateName = dictionary[kstateName] as? String ?? ""
        self.zipcode = dictionary[kzipcode] as? String ?? ""
        self.referralCode = dictionary[kreferralCode] as? String ?? ""
        self.location = dictionary[klocation] as? String ?? ""
        self.timeZone = dictionary[ktimeZone] as? String ?? ""
        self.dob = dictionary[kdob] as? String ?? ""
        self.fname = dictionary[kfname] as? String ?? ""
        self.TotalFollower = dictionary[kTotalFollower] as? String ?? ""
        self.coachRecord = dictionary[kcoachRecord] as? String ?? ""
        self.recreationalTeams = dictionary[krecreationalTeams] as? String ?? ""
        self.clubTeams = dictionary[kclubTeams] as? String ?? ""
        self.adultLeagues = dictionary[kadultLeagues] as? String ?? ""
        self.nickName = dictionary[knickName] as? String ?? ""
        //self.role = dictionary[krole] as? String ?? ""
        self.role = userRole(rawValue: (Int(dictionary[krole] as? String ?? "2")) ?? 0) ?? .athlete
        self.favoriteSportsTeam = dictionary[kfavoriteSportsTeam] as? String ?? ""
        self.verificationCode = dictionary[kverificationCode] as? String ?? ""
        self.address = dictionary[kaddress] as? String ?? ""
        self.pushNotification = dictionary[kpushNotification] as? String ?? ""
        self.email = dictionary[kEmail] as? String ?? ""
        self.image = dictionary[kimage] as? String ?? ""
        self.deviceId = dictionary[kdeviceId] as? String ?? ""
        self.unitNo = dictionary[kunitNo] as? String ?? ""
        self.name = dictionary[kname] as? String ?? ""
        self.forgotCode = dictionary[kforgotCode] as? String ?? ""
        self.longitude = dictionary[klongitude] as? String ?? ""
        self.cityName = dictionary[kcityName] as? String ?? ""
        self.deviceType = dictionary[kdeviceType] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.additionalInfo = dictionary[kadditionalInfo] as? String ?? ""
        self.activeStatus = dictionary[kactiveStatus] as? String ?? ""
        self.profileimage = dictionary[kprofileimage] as? String ?? ""
        self.graduationYear = dictionary[kgraduationYear] as? String ?? ""
        self.thumbprofileimage = dictionary[kthumbprofileimage] as? String ?? ""
        self.schoolName = dictionary[kschoolName] as? String ?? ""
        self.qr_code = dictionary[kqr_code] as? String ?? ""
        self.schoolAddress = dictionary[kschoolAddress] as? String ?? ""
        self.gender = GenderEnum(rawValue: (Int(dictionary[kgender] as? String ?? "0")) ?? 0) ?? .None
        self.isCoach = CoachEnum(rawValue: (Int(dictionary[kisCoach] as? String ?? "0")) ?? 0) ?? .Coach
        self.clubName = dictionary[kclubName] as? String ?? ""
        self.token = dictionary[ktoken] as? String ?? ""
        self.age = dictionary[kage] as? String ?? ""
        self.mname = dictionary[kmname] as? String ?? ""
        self.userName = dictionary[kuserName] as? String ?? ""
        self.fullName = dictionary[kfullName] as? String ?? ""
        self.password = dictionary[kpassword] as? String ?? ""
        self.phone = dictionary[kphone] as? String ?? ""
        self.latitude = dictionary[klatitude] as? String ?? ""
        self.teamName = dictionary[kteamName] as? String ?? ""
        self.playerPosition = dictionary[kplayerPosition] as? String ?? ""
        self.clubsTeams = dictionary[kclubsTeams] as? String ?? ""
        self.recreationalTeamsAgeGroup = dictionary[krecreationalTeamsAgeGroup] as? String ?? ""
        self.stateId = dictionary[kstateId] as? String ?? ""
        self.cityId = dictionary[kcityId] as? String ?? ""
        self.totalReward = dictionary[ktotalReward] as? String ?? ""
        self.about = dictionary[kabout] as? String ?? ""
        self.ref_url = dictionary[kref_url] as? String ?? ""
        self.ageGroups = dictionary[kageGroups] as? String ?? ""
        self.shareReferralLink = dictionary["shareReferralLink"] as? String ?? ""
        self.subscriptionExpiryDate = dictionary["subscriptionExpiryDate"] as? String ?? ""
    

//        self.isCoach = dictionary[kisCoach] as? String ?? ""
//        self.coachYear = dictionary[kcoachYear] as? String ?? ""
        
        
    }
    
    // MARK: - NSCoding
    required init(coder aDecoder: NSCoder) {
        self.isSubscriptionActive = aDecoder.decodeObject(forKey: "isSubscriptionActive") as? String ?? ""
        self.subscriptionId = aDecoder.decodeObject(forKey: "subscriptionId") as? String ?? ""
        self.postCount = aDecoder.decodeObject(forKey: "postCount") as? String ?? ""
        self.following = aDecoder.decodeObject(forKey: "following") as? String ?? ""
        self.followers = aDecoder.decodeObject(forKey: "followers") as? String ?? ""
        self.isFollow = aDecoder.decodeObject(forKey: kisFollow) as? String ?? ""
        self.profileStatus = aDecoder.decodeObject(forKey: kprofileStatus) as? String ?? ""
        self.fillpassword = aDecoder.decodeObject(forKey: kfillpassword) as? String ?? ""
        self.emergencyContact = aDecoder.decodeObject(forKey: kemergencyContact) as? String ?? ""
        self.contactPersonName = aDecoder.decodeObject(forKey: kcontactPersonName) as? String ?? ""
        self.birthdate = aDecoder.decodeObject(forKey: kbirthdate) as? String ?? ""
        self.id = aDecoder.decodeObject(forKey: kid) as? String ?? ""
        self.mascot = aDecoder.decodeObject(forKey: kmascot) as? String ?? ""
        self.lname = aDecoder.decodeObject(forKey: klname) as? String ?? ""
        self.coachRecord = aDecoder.decodeObject(forKey: kcoachRecord) as? String ?? ""
        self.clubTeams = aDecoder.decodeObject(forKey: kclubTeams) as? String ?? ""
        self.height = aDecoder.decodeObject(forKey: kheight) as? String ?? ""
        self.adultLeagues = aDecoder.decodeObject(forKey: kadultLeagues) as? String ?? ""
        self.recreationalTeams = aDecoder.decodeObject(forKey: krecreationalTeams) as? String ?? ""
        self.additionalInfo = aDecoder.decodeObject(forKey: kadditionalInfo) as? String ?? ""
        self.graduationYear = aDecoder.decodeObject(forKey: kgraduationYear) as? String ?? ""
        self.schoolName = aDecoder.decodeObject(forKey: kschoolName) as? String ?? ""
        self.schoolAddress = aDecoder.decodeObject(forKey: kschoolAddress) as? String ?? ""
        self.clubName = aDecoder.decodeObject(forKey: kclubName) as? String ?? ""
        self.clubAddress = aDecoder.decodeObject(forKey: kclubAddress) as? String ?? ""
        self.deviceToken = aDecoder.decodeObject(forKey: kdeviceToken) as? String ?? ""
        self.country = aDecoder.decodeObject(forKey: kcountry)  as? String ?? ""
        self.weight = aDecoder.decodeObject(forKey: kweight)  as? String ?? ""
        self.stateName = aDecoder.decodeObject(forKey: kstateName)  as? String ?? ""
        self.zipcode = aDecoder.decodeObject(forKey: kzipcode)  as? String ?? ""
        self.referralCode = aDecoder.decodeObject(forKey: kreferralCode)  as? String ?? ""
        self.headline = aDecoder.decodeObject(forKey: kheadline) as? String ?? ""
        self.teamName = aDecoder.decodeObject(forKey: kteamName) as? String ?? ""
        self.gpa = aDecoder.decodeObject(forKey: kgpa) as? String ?? ""
        self.Club = aDecoder.decodeObject(forKey: kClub) as? String ?? ""
        self.playerPosition = aDecoder.decodeObject(forKey: kplayerPosition) as? String ?? ""
        self.location = aDecoder.decodeObject(forKey: klocation)  as? String ?? ""
        self.timeZone = aDecoder.decodeObject(forKey: ktimeZone)  as? String ?? ""
        self.dob = aDecoder.decodeObject(forKey: kdob)  as? String ?? ""
        self.favoriteSportsTeam = aDecoder.decodeObject(forKey: kfavoriteSportsTeam) as? String ?? ""
        self.fname = aDecoder.decodeObject(forKey: kfname)  as? String ?? ""
        self.nickName = aDecoder.decodeObject(forKey: knickName) as? String ?? ""
        self.TotalFollower = aDecoder.decodeObject(forKey: kTotalFollower)  as? String ?? ""
        self.clubsTeams = aDecoder.decodeObject(forKey: kclubsTeams)  as? String ?? ""
        self.role = userRole(rawValue: (Int(aDecoder.decodeObject(forKey: krole) as? String ?? "0")) ?? 3) ?? .athlete
        self.verificationCode = aDecoder.decodeObject(forKey: kverificationCode)  as? String ?? ""
        self.address = aDecoder.decodeObject(forKey: kaddress)  as? String ?? ""
        self.pushNotification = aDecoder.decodeObject(forKey: kpushNotification)  as? String ?? ""
        self.email = aDecoder.decodeObject(forKey: kEmail)  as? String ?? ""
        self.image = aDecoder.decodeObject(forKey: kimage)  as? String ?? ""
        self.deviceId = aDecoder.decodeObject(forKey: kdeviceId)  as? String ?? ""
        self.unitNo = aDecoder.decodeObject(forKey: kunitNo)  as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: kname)  as? String ?? ""
        self.forgotCode = aDecoder.decodeObject(forKey: kforgotCode)  as? String ?? ""
        self.longitude = aDecoder.decodeObject(forKey: klongitude)  as? String ?? ""
        self.cityName = aDecoder.decodeObject(forKey: kcityName)  as? String ?? ""
        self.deviceType = aDecoder.decodeObject(forKey: kdeviceType)  as? String ?? ""
        self.status = aDecoder.decodeObject(forKey: kstatus)  as? String ?? ""
        self.recreationalTeamsAgeGroup = aDecoder.decodeObject(forKey: krecreationalTeamsAgeGroup) as? String ?? ""
        self.activeStatus = aDecoder.decodeObject(forKey: kactiveStatus)  as? String ?? ""
        self.profileimage = aDecoder.decodeObject(forKey: kprofileimage)  as? String ?? ""
        self.clubTeamsAge = aDecoder.decodeObject(forKey: kclubTeamsAge) as? String ?? ""
        self.thumbprofileimage = aDecoder.decodeObject(forKey: kthumbprofileimage)  as? String ?? ""
        self.qr_code = aDecoder.decodeObject(forKey: kqr_code)  as? String ?? ""
        self.grades = GradeEnum(rawValue: (Int(aDecoder.decodeObject(forKey: kgrades) as? String ?? "0")) ?? 0) ?? .GradeA
        self.isCoach = CoachEnum(rawValue: (Int(aDecoder.decodeObject(forKey: kisCoach) as? String ?? "0")) ?? 0) ?? .Coach
        self.gender = GenderEnum(rawValue: (Int(aDecoder.decodeObject(forKey: kgender) as? String ?? "0")) ?? 0) ?? .None
        self.isClubTeams = SchoolClubEnum(rawValue: (Int(aDecoder.decodeObject(forKey: kisClubTeams) as? String ?? "0")) ?? 0) ?? .Club
        self.hometown = aDecoder.decodeObject(forKey: khometown)  as? String ?? ""
        self.token = aDecoder.decodeObject(forKey: ktoken)  as? String ?? ""
        self.age = aDecoder.decodeObject(forKey: kage)  as? String ?? ""
        self.mname = aDecoder.decodeObject(forKey: kmname)  as? String ?? ""
        self.userName = aDecoder.decodeObject(forKey: kuserName)  as? String ?? ""
        self.fullName = aDecoder.decodeObject(forKey: kfullName)  as? String ?? ""
        self.password = aDecoder.decodeObject(forKey: kpassword)  as? String ?? ""
        self.phone = aDecoder.decodeObject(forKey: kphone)  as? String ?? ""
        self.latitude = aDecoder.decodeObject(forKey: klatitude)  as? String ?? ""
        self.stateId = aDecoder.decodeObject(forKey: kstateId)  as? String ?? ""
        self.cityId = aDecoder.decodeObject(forKey: kcityId)  as? String ?? ""
        self.ref_url = aDecoder.decodeObject(forKey: kref_url)  as? String ?? ""
        self.about = aDecoder.decodeObject(forKey: kabout)  as? String ?? ""
        self.previousExperience = aDecoder.decodeObject(forKey: kpreviousExperience)  as? String ?? ""
        self.tiesRecord = aDecoder.decodeObject(forKey: ktiesRecord)  as? String ?? ""
        self.lossesRecord = aDecoder.decodeObject(forKey: klossesRecord)  as? String ?? ""
        self.winRecord = aDecoder.decodeObject(forKey: kwinRecord)  as? String ?? ""
        self.coachYear = YearCoachingEnum(rawValue: (Int(aDecoder.decodeObject(forKey: kcoachYear) as? String ?? "0")) ?? 0) ?? .oneyear
        self.athleticDirectorEmail = aDecoder.decodeObject(forKey: kathleticDirectorEmail)  as? String ?? ""
        self.athleticDirector = aDecoder.decodeObject(forKey: kathleticDirector)  as? String ?? ""
        self.fax = aDecoder.decodeObject(forKey: kfax)  as? String ?? ""
        self.School = aDecoder.decodeObject(forKey: kSchool)  as? String ?? ""
        self.ageGroup = aDecoder.decodeObject(forKey: kageGroup)  as? String ?? ""
        self.ageGroups = aDecoder.decodeObject(forKey: kageGroups) as? String ?? ""
        self.isAgeGroup = aDecoder.decodeObject(forKey: kisAgeGroup)  as? String ?? ""
        self.totalReward = aDecoder.decodeObject(forKey: ktotalReward) as? String ?? ""
        self.shareReferralLink = aDecoder.decodeObject(forKey: "shareReferralLink") as? String ?? ""
        self.sport = aDecoder.decodeObject(forKey: ksport )  as? [SportsModel] ?? []
        self.highlights = aDecoder.decodeObject(forKey: "highlights" )  as? [AddPhotoVideoModel] ?? []
        self.albumData = aDecoder.decodeObject(forKey: "albumData" )  as? [ProfileAlbumModel] ?? []
        self.postData = aDecoder.decodeObject(forKey: "postData") as? [FeedModel] ?? []
        self.subscriptionExpiryDate = aDecoder.decodeObject(forKey: "subscriptionExpiryDate") as? String ?? ""
//        self.coachYear = aDecoder.decodeObject(forKey: kcoachYear )  as? String ?? ""
//        self.isCoach = aDecoder.decodeObject(forKey: kisCoach )  as? String ?? ""

        
    }
    
    func encode(with aCoder: NSCoder) {
        //aCoder.encode(isFollow, forKey: kisFollow)
        aCoder.encode(isSubscriptionActive, forKey: "isSubscriptionActive")
        aCoder.encode(subscriptionExpiryDate, forKey: "subscriptionExpiryDate")
        aCoder.encode(subscriptionId, forKey: "subscriptionId")
        aCoder.encode(postCount, forKey: "postCount")
        aCoder.encode(following, forKey: "following")
        aCoder.encode(followers, forKey: "followers")
        aCoder.encode(recreationalTeamsAgeGroup, forKey: krecreationalTeamsAgeGroup)
        aCoder.encode(self.isCoach.apiValue, forKey: kisCoach)
        aCoder.encode(self.grades.apiValue, forKey: kgrades)
        aCoder.encode(self.isClubTeams.apiValue, forKey: kisClubTeams)
        aCoder.encode(self.coachYear.apiValue, forKey: kcoachYear)
        aCoder.encode(hometown, forKey: khometown)
        aCoder.encode(isFollow, forKey: kisFollow)
        aCoder.encode(headline, forKey: kheadline)
        aCoder.encode(clubsTeams, forKey: kclubsTeams)
        aCoder.encode(gpa, forKey: kgpa)
        aCoder.encode(playerPosition, forKey: kplayerPosition)
        aCoder.encode(teamName, forKey: kteamName)
        aCoder.encode(schoolName, forKey: kschoolName)
        aCoder.encode(graduationYear, forKey: kgraduationYear)
        aCoder.encode(additionalInfo, forKey: kadditionalInfo)
        aCoder.encode(recreationalTeams, forKey: krecreationalTeams)
        aCoder.encode(adultLeagues, forKey: kadultLeagues)
        aCoder.encode(height, forKey: kheight)
        aCoder.encode(coachRecord, forKey: kcoachRecord)
        aCoder.encode(mascot, forKey: kmascot)
        aCoder.encode(nickName, forKey: knickName)
        aCoder.encode(profileStatus, forKey: kprofileStatus)
        aCoder.encode(fillpassword, forKey: kfillpassword)
        aCoder.encode(emergencyContact, forKey: kemergencyContact)
        aCoder.encode(contactPersonName, forKey: kcontactPersonName)
        aCoder.encode(birthdate, forKey: kbirthdate)
        aCoder.encode(id, forKey: kid)
        aCoder.encode(lname, forKey: klname)
        aCoder.encode(deviceToken, forKey: kdeviceToken)
        aCoder.encode(country, forKey: kcountry)
        aCoder.encode(stateName, forKey: kstateName)
        aCoder.encode(zipcode, forKey: kzipcode)
        aCoder.encode(referralCode, forKey: kreferralCode)
        aCoder.encode(location, forKey: klocation)
        aCoder.encode(timeZone, forKey: ktimeZone)
        aCoder.encode(dob, forKey: kdob)
        aCoder.encode(fname, forKey: kfname)
        aCoder.encode(role.apiValue, forKey: krole)
        aCoder.encode(verificationCode, forKey: kverificationCode)
        aCoder.encode(address, forKey: kaddress)
        aCoder.encode(pushNotification, forKey: kpushNotification)
        aCoder.encode(email, forKey: kEmail)
        aCoder.encode(image, forKey: kimage)
        aCoder.encode(deviceId, forKey: kdeviceId)
        aCoder.encode(unitNo, forKey: kunitNo)
        aCoder.encode(name, forKey: kname)
        aCoder.encode(forgotCode, forKey: kforgotCode)
        aCoder.encode(longitude, forKey: klongitude)
        aCoder.encode(cityName, forKey: kcity)
        aCoder.encode(deviceType, forKey: kdeviceType)
        aCoder.encode(status, forKey: kstatus)
        aCoder.encode(TotalFollower, forKey: kTotalFollower)
        aCoder.encode(weight, forKey: kweight)
        aCoder.encode(favoriteSportsTeam, forKey: kfavoriteSportsTeam)
        aCoder.encode(clubAddress,forKey: kclubAddress)
        aCoder.encode(activeStatus, forKey: kactiveStatus)
        aCoder.encode(profileimage, forKey: kprofileimage)
        aCoder.encode(clubName, forKey: kclubName)
        aCoder.encode(thumbprofileimage, forKey: kthumbprofileimage)
        aCoder.encode(qr_code, forKey: kqr_code)
        aCoder.encode(gender.apiValue, forKey: kgender)
        aCoder.encode(token, forKey: ktoken)
        aCoder.encode(schoolAddress, forKey: kschoolAddress)
        aCoder.encode(age, forKey: kage)
        aCoder.encode(mname, forKey: kmname)
        aCoder.encode(userName, forKey: kuserName)
        aCoder.encode(fullName, forKey: kfullName)
        aCoder.encode(password, forKey: kpassword)
        aCoder.encode(phone, forKey: kphone)
        aCoder.encode(latitude, forKey: klatitude)
        aCoder.encode(previousExperience, forKey: kpreviousExperience)
        aCoder.encode(tiesRecord, forKey: ktiesRecord)
        aCoder.encode(lossesRecord, forKey: klossesRecord)
        aCoder.encode(winRecord, forKey: kwinRecord)
        aCoder.encode(ageGroups, forKey: kageGroups)
        //aCoder.encode(coachYear, forKey: kcoachYear)
        aCoder.encode(athleticDirectorEmail, forKey: kathleticDirectorEmail)
        aCoder.encode(athleticDirector, forKey: kathleticDirector)
        aCoder.encode(fax, forKey: kfax)
        aCoder.encode(School, forKey: kSchool)
        aCoder.encode(clubTeamsAge, forKey: kclubTeamsAge)
        aCoder.encode(ageGroup, forKey: kageGroup)
        aCoder.encode(isAgeGroup, forKey: kisAgeGroup)
        aCoder.encode(sport, forKey: ksport)
        aCoder.encode(albumData, forKey: "albumData")
        aCoder.encode(postData, forKey: "postData")
        aCoder.encode(stateId, forKey: kstateId)
        aCoder.encode(cityId, forKey: kcityId)
        aCoder.encode(clubTeams, forKey: kclubTeams)
        aCoder.encode(ref_url, forKey: kref_url)
        aCoder.encode(about, forKey: kabout)
        aCoder.encode(totalReward, forKey: ktotalReward)
        aCoder.encode(highlights, forKey: "highlights")
        aCoder.encode(shareReferralLink, forKey: "shareReferralLink")
    }
    
    //Save user object in UserDefault
    func saveCurrentUserInDefault() {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: UserDefaultsKey.kLoginUser)
        } catch {
            print("Not found")
        }
    }
    
    //Get user object from UserDefault
    class func getCurrentUserFromDefault() -> UserModel? {
        do {
            
            if let decoded  = UserDefaults.standard.data(forKey: UserDefaultsKey.kLoginUser), let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? UserModel {
                return user
            }
        } catch {
            print("Couldn't read file.")
            return nil
        }
        return nil
    }
    
    //Remove user object from UserDefault
    class func removeUserFromDefault() {
        UserDefaults.standard.set(Data(), forKey: UserDefaultsKey.kLoginUser)
        UserDefaults.standard.set(nil, forKey: UserDefaultsKey.kLoginUser)
    }
    
    //Save user VOIP token in UserDefault
    class func saveVoipTokenInDefault(token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultsKey.kVoipToken)
        UserDefaults.standard.synchronize()
    }
    
    class func getVoipToken() -> String?{
        return getValueFromNSUserDefaults(key: UserDefaultsKey.kVoipToken) as? String
    }
    
    // MARK: - API call
    class func userLogin(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kLogin, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                user.saveCurrentUserInDefault()
                
                WebSocketChat.shared.isSocketConnected = false
                WebSocketChat.shared.connectSocket()
                
                withResponse(user, message)
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
    
    class func userSocialLogin(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksocialLogin, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                user.saveCurrentUserInDefault()
                
                WebSocketChat.shared.isSocketConnected = false
                WebSocketChat.shared.connectSocket()
                
                withResponse(user, message)
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
    
    class func checkforgotVerificationCode(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kcheckForgotCode, method: .post, parameter: param, success: {(response) in
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
    
    class func registerUser(withParam param: [String:Any], success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kRegisterUser, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                UserDefaults.isUserLogin = true
                user.saveCurrentUserInDefault()
                
                withResponse(user, message)
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
    
    
    class func setFollow(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
       
        APIManager.makeRequest(with: AppConstant.API.ksetFollow, method: .post, parameter: param, success: {(response) in
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
          
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
        
            failure("0",connectionError, .connection)
        })
    }
    
    class func verifyCode(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kverify, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                UserDefaults.isUserLogin = true
                user.saveCurrentUserInDefault()
                
                WebSocketChat.shared.isSocketConnected = false
                WebSocketChat.shared.connectSocket()
                
                withResponse(user, message)
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
    
    class func GetProfileUser(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kGetProfile, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                var token = ""
                if let u = UserModel.getCurrentUserFromDefault() {
                    token = u.token
                }
                
                user.saveCurrentUserInDefault()
                
                if let userdata = UserModel.getCurrentUserFromDefault(){
                    if userdata.token == "" {
                        userdata.token = token
                        userdata.saveCurrentUserInDefault()
                    }
                }
                
                withResponse(user, message)
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
    
    class func completeProfile(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kcompleteProfile, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                var token = ""
                if let u = UserModel.getCurrentUserFromDefault() {
                    token = u.token
                }
                
                user.saveCurrentUserInDefault()
                
                if let userdata = UserModel.getCurrentUserFromDefault(){
                    if userdata.token == "" {
                        userdata.token = token
                        userdata.saveCurrentUserInDefault()
                    }
                }
                
                withResponse(user, message)
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
    
    
    
    class func getUsersList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [UserModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetUsersList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(UserModel.init)
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
    
    class func getFollowList(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [UserModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetFollowList, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(UserModel.init)
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
    
    class func getmyPosts(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [FeedModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetmyPosts, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(FeedModel.init)
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
    
    class func getUserInfo(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kgetUserInfo, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                withResponse(user, message)
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
    
    class func setHighlight(withParam param: [String:Any], success withResponse: @escaping (_ strMessage : String,_ arr : [AddPhotoVideoModel]) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetHighlight, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(AddPhotoVideoModel.init)
                withResponse(message, arr)
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
    
    class func RemoveHighlight(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kRemoveHighlight, method: .post, parameter: param, success: {(response) in
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
    
    
    class func getUserProfile(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {

        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kgetUserProfile, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]

            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                withResponse(user, message)
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
    
    class func getUserProfile(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ user: UserModel,_ arrsports: [SportsModel],_ arrfeed: [FeedModel],_ arrAlbum: [ProfileAlbumModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetUserProfile, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                let arrsports = (dataDict["sportsData"] as? [[String:Any]] ?? []).compactMap(SportsModel.init)
                let arrfeed = (dataDict["postData"] as? [[String:Any]] ?? []).compactMap(FeedModel.init)
                let arrAlbum = (dataDict["albumData"] as? [[String:Any]] ?? []).compactMap(ProfileAlbumModel.init)
                withResponse(user,arrsports,arrfeed,arrAlbum,totalPages,message)
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
    
    class func SaveProfileUser(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {


        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kUpdateUserProfile, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]

            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                var token = ""
                if let u = UserModel.getCurrentUserFromDefault() {
                    token = u.token
                }

                user.saveCurrentUserInDefault()

                if let userdata = UserModel.getCurrentUserFromDefault(){
                    if userdata.token == "" {
                        userdata.token = token
                        userdata.saveCurrentUserInDefault()
                    }
                }

                withResponse(user, message)
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
    
    
    
    class func setCategoryProfileUser(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetCategory, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                var token = ""
                if let u = UserModel.getCurrentUserFromDefault() {
                    token = u.token
                }
                
                user.saveCurrentUserInDefault()
                
                if let userdata = UserModel.getCurrentUserFromDefault(){
                    if userdata.token == "" {
                        userdata.token = token
                        userdata.saveCurrentUserInDefault()
                    }
                }
                
                withResponse(user, message)
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
    
    class func uploadMedia(with param : [String:Any]?,image: UIImage?, success withResponse: @escaping (_ msg : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        APIManager.makeMultipartFormDataRequest(AppConstant.API.kmediaUpload,image: image, imageName: kfiles, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                
                if let first = dataDict.first {
                    let msg = first[kmediaName] as? String ?? ""
                    withResponse(msg)
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
    
    class func uploadMultipleImagesMedia(with param : [String:Any]?,image: [UIImage], success withResponse: @escaping (_ arr:[AddPhotoVideoModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        APIManager.makeMultipartFormDataMultipleImageRequest(AppConstant.API.kmediaUpload,images: image, imageName: kfiles, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                let arrImage = dataDict.compactMap({AddPhotoVideoModel.init(dictionary:$0)})
                withResponse(arrImage,message)
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
    
    class func uploadMultipleImagesAndVideo(with param : [String:Any]?,arrMedia: [typeAliasDictionary], success withResponse: @escaping (_ arr:[AddPhotoVideoModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        APIManager.makeMultipartFormDataMultipleImageAndVideoRequest(AppConstant.API.kmediaUpload,arrMedia: arrMedia, imageName: kfiles, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                let arrImage = dataDict.compactMap({AddPhotoVideoModel.init(dictionary:$0)})
                withResponse(arrImage,message)
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
    
    class func uploadStoryMultipleImagesAndVideo(with param : [String:Any]?,arrMedia: [typeAliasDictionary], success withResponse: @escaping (_ arr:[AddPhotoVideoModel],_ msg : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        APIManager.makeStoryMultipartFormDataMultipleImageAndVideoRequest(AppConstant.API.kmediaUpload,arrMedia: arrMedia, imageName: kfiles, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                let arrImage = dataDict.compactMap({AddPhotoVideoModel.init(dictionary:$0)})
                withResponse(arrImage,message)
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
    
    class func uploadHighlightImagesAndVideo(with param : [String:Any]?,arrMedia: [typeAliasDictionary], success withResponse: @escaping (_ mediaName : String, _ mediaBaseUrl : String,_ videoThumbImgUrl : String,_ videoThumbImgName : String,_ medialThumUrl : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        APIManager.makeMultipartFormDataMultipleImageAndVideoRequest(AppConstant.API.kmediaUpload,arrMedia: arrMedia, imageName: kfiles, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                
                if let first = dataDict.first {
                    let mediaName = first[kmediaName] as? String ?? ""
                    let mediaBaseUrl = first[kmediaBaseUrl] as? String ?? ""
                    let videoThumbImgUrl = first[kvideoThumbImgUrl] as? String ?? ""
                    let videoThumbImgName = first[kvideoThumbImgName] as? String ?? ""
                    let medialThumUrl = first[kmedialThumUrl] as? String ?? ""
                    
                    
                    withResponse(mediaName,mediaBaseUrl,videoThumbImgUrl,videoThumbImgName,medialThumUrl)
                } else {
                    failure(statuscode,message, .response)
                }
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func uploadPDFMedia(with param : [String:Any]?,fileUrl:URL?,pdfdata: Data?, success withResponse: @escaping (_ medianame : String,_ mediaURL : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        APIManager.makePDFMultipartFormDataRequest(AppConstant.API.kmediaUpload, urlFile: fileUrl,pdfdata: pdfdata, pdfkeyName: kfiles, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                
                if let first = dataDict.first {
                    if let first = dataDict.first {
                        let medianame = first[kmediaName] as? String ?? ""
                        let mediaurl = first[kmediaBaseUrl] as? String ?? ""
                        withResponse(medianame,mediaurl)
                    } else {
                        failure(statuscode,message, .response)
                    }
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
    
    class func logoutUser(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.klogout, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue || statuscode == APIStatusCode.AuthTokenInvalied.rawValue) ? true : false
            if  isSuccess {
                self.removeUserFromDefault()
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
    
    class func DeleteAccount(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kDeleteAccount, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue || statuscode == APIStatusCode.AuthTokenInvalied.rawValue) ? true : false
            if  isSuccess {
                self.removeUserFromDefault()
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
    
    class func changePassword(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kChangePassword, method: .post, parameter: param, success: {(response) in
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
    
    
    class func OnOffNotification(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.konoffnotification, method: .post, parameter: param, success: {(response) in
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
    
    
    
    class func GetResume(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String,_ strData : String) -> Void, failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kgetResume, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let strData = dict["data"] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(strData,message)
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
    
    class func forgotPassword(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kforgotPassword, method: .post, parameter: param, success: {(response) in
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
    
    class func resendVerificationCode(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kresendVerification, method: .post, parameter: param, success: {(response) in
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
    
    class func setAppFeedback(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetAppFeedback, method: .post, parameter: param, success: {(response) in
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
    
    class func SetUserAlbum(with param: [String:Any]?,isFromChat : Bool = false, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {

        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetUserAlbum , method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]

            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
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
    
    
    class func resetPassword(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kresetPassword, method: .post, parameter: param, success: {(response) in
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
    
    class func generatePlaidToken(with param: [String:Any]?, success withResponse: @escaping (_ linkToken : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.PlaidAPI.kcreareToken, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
        
            if  let token = dict["link_token"] as? String,token != "" {
                withResponse(token)
            }
            else {
                failure("0","0", .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }


 class func uploadFeedMedia(with param : [String:Any]?,image: UIImage?, success withResponse: @escaping (_ certificateName : String,_ certificateURL : String) -> Void, failure: @escaping FailureBlock) {
    
    SVProgressHUD.show()
    
    APIManager.makeMultipartFormDataRequest(AppConstant.API.kmediaUpload,image: image, imageName: kfiles, withParameter: param, withSuccess: { (response) in
        SVProgressHUD.dismiss()
        let dict = response as? [String:Any] ?? [:]
        let message = dict[kMessage] as? String ?? ""
        let statuscode = dict[kstatus] as? String ?? "0"
        let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
        if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
            
            if let first = dataDict.first {
                let msg = first[kmediaName] as? String ?? ""
                let cerurl = first[kmediaBaseUrl] as? String ?? ""
                withResponse(msg,cerurl)
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
    
    class func setAdvertiseWithUs(withParam param: [String:Any], success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetAdvertiseWithUs, method: .post, parameter: param, success: {(response) in
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

    
    class func setShareResume(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        //SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetShareResume, method: .post, parameter: param, success: {(response) in
            //SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            } else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            //SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            //SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func setSubscriptionPlan(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
    
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetSubscription, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = UserModel(dictionary: dataDict) {
                var token = ""
                if let u = UserModel.getCurrentUserFromDefault() {
                    token = u.token
                }
                user.saveCurrentUserInDefault()

                if let userdata = UserModel.getCurrentUserFromDefault(){
                    if userdata.token == "" {
                        userdata.token = token
                        userdata.saveCurrentUserInDefault()
                    }
                }
                withResponse(user, message)
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
    
    class func getNotificationCount(with param: [String:Any]?, success withResponse: @escaping (_ stCount : String) -> Void, failure: @escaping FailureBlock) {
            SVProgressHUD.dismiss()
            APIManager.makeRequest(with: AppConstant.API.kgetNotificationCount, method: .post, parameter: param, success: {(response) in
                SVProgressHUD.dismiss()
                let dict = response as? [String:Any] ?? [:]

                
                let message = dict[kMessage] as? String ?? ""
                let statuscode = dict[kstatus] as? String ?? "0"
                let data = dict[kData] as? String ?? "0"
                let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
                if  isSuccess {
                    withResponse(data)
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

//
//  GetUserModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 02/08/22.
//

 class GetUserModel: NSObject {
    
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
    var hometown : HomwTownEnum
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
    var sportsData : [SportsModel]
    
    var headline : String
    var teamName : String
    var playerPosition : String
    var gpa : String
    var isClubTeams : SchoolClubEnum
    var Club : String
    var clubsTeams : String
    var isFollow : Bool
    var recreationalTeamsAgeGroup : String
    var ageGroups : String
    var postData : [FeedModel]
    var followers : String
    var following : String
    var postCount : String
    
    //var user_category : [CategoryModel]
    
    // MARK: - init
    
    init?(dictionary: [String:Any]) {
        self.postCount = dictionary["postCount"] as? String ?? ""
        self.following = dictionary["following"] as? String ?? ""
        self.followers = dictionary["followers"] as? String ?? ""
        self.sportsData = (dictionary[ksportsData] as? [[String:Any]] ?? []).compactMap(SportsModel.init)
      
        self.postData = (dictionary["postData"] as? [[String:Any]] ?? []).compactMap(FeedModel.init)
        self.isFollow = dictionary[kisFollow] as? Bool ?? false
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
        self.hometown = HomwTownEnum(rawValue: (Int(dictionary[khometown] as? String ?? "0")) ?? 0) ?? .homeTown1
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
//        self.sport = (dictionary[ksport] as? [[String:Any]] ?? []).compactMap(SportsModel.init)
        
        self.stateId = dictionary[kstateId] as? String ?? ""
        self.cityId = dictionary[kcityId] as? String ?? ""
        
        self.about = dictionary[kabout] as? String ?? ""
        self.ref_url = dictionary[kref_url] as? String ?? ""
        self.ageGroups = dictionary[kageGroups] as? String ?? ""
   }
     
     class func getUserInfo(with param: [String:Any]?, success withResponse: @escaping (_ user: GetUserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
         
         SVProgressHUD.show()
         APIManager.makeRequest(with: AppConstant.API.kgetUserInfo, method: .post, parameter: param, success: {(response) in
             SVProgressHUD.dismiss()
             let dict = response as? [String:Any] ?? [:]
             
             let message = dict[kMessage] as? String ?? ""
             let statuscode = dict[kstatus] as? String ?? "0"
             let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
             if  isSuccess,let dataDict = dict[kData] as? [String:Any], let user = GetUserModel(dictionary: dataDict) {
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
     
}

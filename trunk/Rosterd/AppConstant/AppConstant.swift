//
//  AppConstant.swift
//  Momentor
//
//  Created by Wdev3 on 30/10/20.
//  Copyright © 2020 Wdev3. All rights reserved.
//

import UIKit

//typealias FailureBlock = (_ error: String, _ customError: ErrorType) -> Void
//typealias FailureBlock = (_ statuscode: Int,_ error: String, _ customError: ErrorType) -> Void
typealias FailureBlock = (_ statuscode: String,_ error: String, _ customError: ErrorType) -> Void
typealias FailureBlockHome = (_ statuscode: String,_ error: String, _ customError: ErrorType,_ arrSlider:[AdvertiseModel]) -> Void



 let kMainStoryBoard             =   UIStoryboard(name: "Main", bundle: nil)
//Error enum

enum ErrorType: String {
    case server = "Error"
    case connection = "No connection"
    case response = ""
}
let appDelegate = UIApplication.shared.delegate as! AppDelegate

// MARK: - Media Enum
enum MediaType : String {
    case kImage  = "public.image"
    case kVideo  = "public.movie"
}

//iPhone Screensize
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//iPhone devicetype
struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = ScreenSize.SCREEN_HEIGHT == 812.0
    static let IS_IPHONE_6_OR_LESS  = ScreenSize.SCREEN_MAX_LENGTH <= 736.0
    static let IS_IPHONE_XMAX          = ScreenSize.SCREEN_HEIGHT == 896.0
    static let IS_PAD               = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

struct FileData
{
    static let FILE_NAME         = "com.DDD.filename"
    static let FILE_MIME_TYPE    = "com.DDD.mimetype"
    static let FILE_URL          = "com.DDD.fileurl"
    static let FILE_DATA         = "com.DDD.filedata"
    static let FILE_ATTACHMENTMESSAGE_KEY    = "TEXT"
    static let FILE_ATTACHMENTMESSGE_IMAGE   = "IMAGE"
    static let FILE_ATTACHMENTMESSGE_VIDEO   = "VIDEO"
    static let MIME_JPG  = "image/jpg"
    static let MIME_JPEG = "image/jpeg"
    static let MIME_PNG  = "image/png"
    static let MIME_MP4  = "video/mp4"
    static let MIME_MOV  = "video/mov"
}

struct LinkedInConstants {
    
    static let CLIENT_ID = "77tj842koqaszl"
    static let CLIENT_SECRET = "9eNFytAEpgqFvOPJ"
    static let REDIRECT_URI = "https://www.Webmigrates.com"
    static let SCOPE = "r_liteprofile%20r_emailaddress" //Get lite profile info and e-mail address
    
    static let AUTHURL = "https://www.linkedin.com/oauth/v2/authorization"
    static let TOKENURL = "https://www.linkedin.com/oauth/v2/accessToken"
}

struct INSTAGRAM_CONSTANT{
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_GET_TOKEN = "https://api.instagram.com/oauth/access_token"
    static let INSTAGRAM_USER_INFO = "https://graph.instagram.com/me?fields=id,username&access_token="
    static let INSTAGRAM_CLIENT_ID = "5578218692289194"
    static let INSTAGRAM_CLIENTSERCRET = "f3b564af7efd43c032790ad9365e0914"
    static let INSTAGRAM_REDIRECT_URI = "https://flynaut.com/"
    static var INSTAGRAM_ACCESS_TOKEN = ""
    static let INSTAGRAM_SCOPE = "user_profile" /* add whatever scope you need https://www.instagram.com/developer/authorization/ */
}


// MARK: - Menu Type Enum
enum LanguageImages : Int {
    case America
    case Mexico
    case France
    case Germany
    
    var CountryLanguage : String {
        switch self {
        case .America:
            return "Hello!"
        case .Mexico:
            return "Hola!"
        case .France :
            return "Bonjour!"
        case .Germany :
            return "Hallo!"
        }
        
    }

    
    var img : UIImage {
        switch self {
        case .America:
            return #imageLiteral(resourceName: "ic_america_flag")
        case .Mexico:
            return #imageLiteral(resourceName: "ic_maxico_flag")
        case .France :
            return #imageLiteral(resourceName: "ic_france_flag")
        case .Germany :
            return #imageLiteral(resourceName: "ic_germany_flag")
        }
    }
}

// MARK: - Menu Type Enum
enum TutorialImages : Int {
    case tutorial1
    case tutorial2
    case tutorial3
    
    var HeaderName : String {
        switch self {
        case .tutorial1:
            return "A Community For Athletes"
        case .tutorial2:
            //return "Let your adrenaline rush keep you going!"
            return "Join our team today! Invite your friends and family."
        case .tutorial3 :
            //return "When you meet the people like you!"
            return "Take advantage of special promo's and offers."
        }
    }
    
    var HeaderDescName : String {
        switch self {
        case .tutorial1:
            //return "Connect, Share, Be Known"
            return ""
        case .tutorial2:
            //return "Get started here. Because the secret of getting ahead is getting started."
            return ""
        case .tutorial3 :
            //return "Roster'd: A place where the people you meet don't enforce their expectations on you but help you achieve yours!"
            return ""
        }
    }
    
    var img : UIImage {
        switch self {
        case .tutorial1:
            return #imageLiteral(resourceName: "Totorial1")
        case .tutorial2:
            return #imageLiteral(resourceName: "Tutorial2")
        case .tutorial3 :
            return #imageLiteral(resourceName: "Totorial1")
        }
    }
}

enum SegementEventTabEnum :  Int{
    case EvenInfo
    case Detail
    case Media
    
    var apiValue : String{
        switch self {
        case .EvenInfo:
              return "0"
        case .Detail:
             return "1"
        case .Media:
             return "2"
        }
    }
}

enum filterEnum :  Int{
    case PriceHightoLow
    case PriceLowtoHigh
   
    var apiValue : String{
        switch self {
        case .PriceHightoLow:
              return "2"
        case .PriceLowtoHigh:
             return "1"
       
        }
    }
}



enum SegmentSignTabEnum : Int{
    case SignIn
    case SignUp

    var apiValue : String{
        switch self {
        case .SignIn:
            return "0"
        case .SignUp:
            return "1"
        }
    }
}

enum PayPeriodType: Int{
    case CurrentPayPeriod
    case SpendingMoney
    case NextPayPeriod
    case UpcomingExpenses

}

enum AddMoneyType: Int{
    case AddExpenses
    case AddIncome
    case AddPayee
}

enum SegmentMoneyTabEnum : Int{
    case Cleared
    case Pending
    case PastDue
    
    var apiValue : String{
        switch self {
        case .Cleared:
            return "0"
        case .Pending:
            return "1"
        case .PastDue:
            return "2"
        }
    }
}

enum SegmentIncomeExpenseTabEnum : Int{
    case Income
    case Expenses

    var apiValue : String{
        switch self {
        case .Income:
            return "0"
        case .Expenses:
            return "1"
        }
    }
}


enum keyboardEnumType : Int {
    case defaultkeyboard
    case password
}

enum supportForReplyType : String {
    case admin = "1"
    case user = "2"
}

enum LikeType : Int {
    case Dummy
    case FeedLike
    case Suggestion
}

enum pageIDEnum : Int {
    case AboutUs
    case TermCondition
    case PrivacyPolicy
    case Compliances
    case CancellationPolicy
    case AppLicenseAgreement
    case ProviderAgreement﻿
    
    var name : String{
        switch self {
        case .AboutUs:
            return "About Us"
        case .TermCondition:
            return "Terms & Conditions"
        case .PrivacyPolicy:
            return "Privacy Policy"
        case .Compliances:
            return "Compliances"
        case .CancellationPolicy:
            return "Cancelation Policy"
        case .AppLicenseAgreement:
            return "App License Agreement"
        case .ProviderAgreement﻿:
            return "Provider Agreement﻿"
        }
    }
    
    var pageid : String{
        switch self {
        case .AboutUs:
            return "aboutus"
        case .TermCondition:
            return "termscondition"
        case .PrivacyPolicy:
            return "privacypolicy"
        case .Compliances:
            return "compliances"
        case .CancellationPolicy:
            return "cancelationpolicy"
        case .AppLicenseAgreement:
            return "appeula"
        case .ProviderAgreement﻿:
            return "provideragreement"
        }
    }
}

enum MonthSelection : Int{
    case January = 1,February,March,April,May,June,July,August,September,October,November,December
    
    var name : String {
        switch self {
        case .January:
            return "January"
        case .February:
            return "February"
        case .March:
            return "March"
        case .April:
            return "April"
        case .May:
            return "May"
        case .June:
            return "June"
        case .July:
            return "July"
        case .August:
            return "August"
        case .September:
            return "September"
        case .October:
            return "October"
        case .November:
            return "November"
        case .December:
            return "December"
        }
    }
}

enum DaySelection : Int{
    case One = 1,Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Eleven,Twelve,Thirteen,Fourteen,Fifteen,Sixteen, Seventeen,Eighteen,Nineteen,Twenty,Twentyone,Twentytwo,Twentythree,Twentyfour, Twentyfive,Twentysix,Twentyseven,Twentyeight,Twentynine,Thirty,Thirtyone
    
    var name : String {
        switch self {
        case .One:
            return "1st"
        case .Two:
            return "2nd"
        case .Three:
            return "3rd"
        case .Four:
            return "4th"
        case .Five:
            return "5th"
        case .Six:
            return "6th"
        case .Seven:
            return "7th"
        case .Eight:
            return "8th"
        case .Nine:
            return "9th"
        case .Ten:
            return "10th"
        case .Eleven:
            return "11th"
        case .Twelve:
            return "12th"
        case .Thirteen:
            return "13th"
        case .Fourteen:
            return "14th"
        case .Fifteen:
            return "15th"
        case .Sixteen:
            return "16th"
        case .Seventeen:
            return "17th"
        case .Eighteen:
            return "18th"
        case .Nineteen:
            return "19th"
        case .Twenty:
            return "20th"
        case .Twentyone:
            return "21st"
        case .Twentytwo:
            return "22nd"
        case .Twentythree:
            return "23rd"
        case .Twentyfour:
            return "24th"
        case .Twentyfive:
            return "25th"
        case .Twentysix:
            return "26th"
        case .Twentyseven:
            return "27th"
        case .Twentyeight:
            return "28th"
        case .Twentynine:
            return "29th"
        case .Thirty:
            return "30th"
        case .Thirtyone:
            return "31st"
        }
    }
}

//MARK: LanguageSelection Type
enum GenderEnum : Int {
    case Male = 1, Female = 2,PreferNotToSay = 3, None = 0
    
    var name : String {
        switch self {
        case .Male:
            return "Male"
        case .Female:
            return "Female"
        case .PreferNotToSay:
            return "Prefer not to say"
        case .None:
            return ""
        }
    }
    
    var apiValue : String {
        switch self {
        case .Male:
            return "1"
        case .Female:
            return "2"
        case .PreferNotToSay:
            return "3"
        case .None:
            return "0"
        }
    }
}

//MARK: HomeTownSelection Type
enum HomwTownEnum : Int {
    case homeTown1 = 1, homeTown2 = 2,homeTown3 = 3, homeTown4 = 4,homeTown5 = 5,None = 0
    
    var name : String {
        switch self {
        case .homeTown1:
            return "homeTown1"
        case .homeTown2:
            return "homeTown2"
        case .homeTown3:
            return "homeTown3"
        case .homeTown4:
            return "homeTown4"
        case .homeTown5:
            return "homeTown5"
        case .None:
            return ""
        }
    }
    
    var apiValue : String {
        switch self {
        case .homeTown1:
            return "1"
        case .homeTown2:
            return "2"
        case .homeTown3:
            return "3"
        case .homeTown4:
            return "4"
        case .homeTown5:
            return "5"
        case .None:
            return "0"
        }
    }
}



//MARK: GradeSelection Type
enum GradeEnum : Int {
    case GradeA = 1, GradeB = 2,GradeC = 3, GradeD = 4,GradeE = 5
    
    var name : String {
        switch self {
        case .GradeA:
            return "A"
        case .GradeB:
            return "B"
        case .GradeC:
            return "C"
        case .GradeD:
            return "D"
        case .GradeE:
            return "E"
      
        }
    }
    
    var apiValue : String {
        switch self {
        case .GradeA:
            return "1"
        case .GradeB:
            return "2"
        case .GradeC:
            return "3"
        case .GradeD:
            return "4"
        case .GradeE:
            return "5"
       
        }
    }
}


//MARK: yearcoachingSelection Type
enum YearCoachingEnum : Int {
    case oneyear = 1, twoyear = 2,threeyear = 3, fouryear = 4,fiveyear = 5,fiveyearPlus = 6,None = 0
    
    var name : String {
        switch self {
        case .oneyear:
            return "1"
        case .twoyear:
            return "2"
        case .threeyear:
            return "3"
        case .fouryear:
            return "4"
        case .fiveyear:
            return "5"
        case .fiveyearPlus:
            return "5+"
        case .None:
            return ""
        }
    }
    
    var apiValue : String {
        switch self {
        case .oneyear:
            return "1"
        case .twoyear:
            return "2"
        case .threeyear:
            return "3"
        case .fouryear:
            return "4"
        case .fiveyear:
            return "5"
        case .fiveyearPlus:
            return "6"
        case .None:
            return "0"
        }
    }
}



enum SchoolClubEnum : Int {
    
    case School = 1, Club = 0
    
    var name : String {
        switch self {
        case .School:
            return "School"
        case .Club:
            return "Club"
        }
    }
    
    var apiValue : String {
        switch self {
        case .School:
            return "1"
        case .Club:
            return "0"
        }
    }
}
enum CoachEnum : Int {
    
    case Recruiter = 1, Coach = 0
    
    var name : String {
        switch self {
        case .Recruiter:
            return "Recruiter"
        case .Coach:
            return "Coach"
        }
    }
    
    var apiValue : String {
        switch self {
        case .Recruiter:
            return "1"
        case .Coach:
            return "0"
        }
    }
}
enum userRole : Int{
    case fan = 2
    case athlete = 3
    case schoolclub = 4
    case coachrecruiter = 5
    
    var name : String {
        switch self {
        case .athlete:
            return "Athlete"
        case .fan:
            return "Fan"
        case .schoolclub:
            return "School/Club"
        case .coachrecruiter:
            return "Coach/Recruiter "
            
        }
    }
    
    var apiValue : String {
        switch self {
        case .fan:
            return "2"
        case .athlete:
            return "3"
        case .schoolclub:
            return "4"
        case .coachrecruiter:
            return "5"
        }
    }
    
    var img : UIImage {
        switch self{
        case .fan:
            return #imageLiteral(resourceName: "ic_selectFan")
        case .athlete:
            return #imageLiteral(resourceName: "ic_selectAthlete")
        case .schoolclub:
            return #imageLiteral(resourceName: "ic_selectClub")
        case .coachrecruiter:
            return #imageLiteral(resourceName: "ic_selectCoach")
        }
    }
    
    
}

enum CardAPIType : String {
    case Visa = "visa"
    case Mastercard = "mastercard"//,"Mastercard"
    case AmericanExpress = "American Express"
    case Discover = "discover"
    case DinersClub = "Diners Club"
    case JCB = "JCB"
    case UnionPay = "UnionPay"
    case None = ""
    
    var image : UIImage {
        switch self {
        case .Visa:
            return #imageLiteral(resourceName: "ic_CardVisa")
        case .Mastercard:
            return #imageLiteral(resourceName: "ic_CardMastercard")
        case .AmericanExpress:
            return #imageLiteral(resourceName: "ic_CardAmericanExpress")
        case .Discover:
            return #imageLiteral(resourceName: "ic_CardDiscover")
        case .DinersClub:
            return #imageLiteral(resourceName: "ic_CardDinerClub")
        case .JCB:
            return #imageLiteral(resourceName: "ic_CardJCB")
        case .UnionPay:
            return #imageLiteral(resourceName: "ic_CardUnionPay")
        case .None:
            return #imageLiteral(resourceName: "ic_CardNone")
        }
    }
}

//MARK: LanguageSelection Type
enum LanguageSelection : Int {
    case English = 1, Spanish, Chinese, Russian
    
    var languageCode : String {
        switch self {
        case .English:
            return "en"
        case .Spanish:
            return "es"
        case .Chinese:
            return "zh-Hans"
        case .Russian:
            return "ru"
        }
    }
    
    var apiLanguageCode : String {
        switch self {
        case .English:
            return "english"
        case .Spanish:
            return "spain"
        case .Chinese:
            return "chinese"
        case .Russian:
            return "russian"
        }
    }
}

enum supportReplyType : String {
    case message = "1"
    case media = "2"
}

enum complaintType : String {
    case Better = "1"
    case Worse = "2"
    case SameAs  = "3"
    
    var name : String{
        switch self {
        case .Better:
            return "Better"
        case .Worse:
            return "Worse"
        case .SameAs:
            return "Staying the same"
        }
    }
}

enum appointmentType : String {
    case Virtual = "1"
    case MyPlace = "2"
    case GymOfc  = "3"
    
    var name : String{
        switch self {
        case .Virtual:
            return "Virtual"
        case .MyPlace:
            return "My Place"
        case .GymOfc:
            return "Gym / Office"
        }
    }
}

// MARK: - TabBar ItempType Enum
enum TabbarItemType : Int {
    case Home
    case Events
    case Shop
    case Message
  
    var name : String {
        switch self {
        case .Home:
            return "Home"
        case .Events:
            return "Events"
        case .Shop :
            return "Shop"
        case .Message :
            return "Message"
        }
    }
    
    var imgSelected : UIImage {
        switch self {
        case .Home:
            return #imageLiteral(resourceName: "ic_TabHome_Selected")
        case .Events:
            return #imageLiteral(resourceName: "ic_TabEvents_Selected")
        case .Shop :
            return #imageLiteral(resourceName: "ic_TabShop_Selected")
        case .Message :
            return #imageLiteral(resourceName: "ic_TabMessage_Selected")
        }
    }
    
    var imgDeSelect : UIImage {
        switch self {
        case .Home:
            return #imageLiteral(resourceName: "ic_TabHome")
        case .Events:
            return #imageLiteral(resourceName: "ic_TabEvents")
        case .Shop :
            return #imageLiteral(resourceName: "ic_TabShop")
        case .Message :
            return #imageLiteral(resourceName: "ic_TabMessage")
        }
    }
}


enum segementSupportEnum : Int{
    case All
    case Open
    case Solved
    
    var apivalue : String{
        switch self {
        case .All:
             return "2"
        case .Open:
            return "1"
        case .Solved:
             return "0"
        }
    }
}
enum segementNotificationEnum : Int{
    case All
    case Social
    case Events
    case Shop
    
    var apivalue : String{
        switch self {
        case .All:
             return "0"
        case .Social:
            return "1"
        case .Events:
             return "2"
        case .Shop:
             return "3"
        }
    }
}

enum SegemnetMyBookingEnum : Int{
    case All
    case Booked
    case RSVPd
    
    var apivalue : String{
        switch self {
        case .All:
             return ""
        case .Booked:
            return "1"
        case .RSVPd:
             return "0"
        }
    }
}
enum SegemnentMyeventEnum : Int{
    case CreatedEvents
    case Favorites
   
    
    var apivalue : String{
        switch self {
        case .CreatedEvents:
             return "1"
        case .Favorites:
            return "2"
        
        }
    }
}

enum SegemnentTicketEnum : Int{
    case Available
    case Redeemed
   
    
    var apivalue : String{
        switch self {
        case .Available:
             return "1"
        case .Redeemed:
            return "2"
        
        }
    }
}


// MARK: - Menu Type Enum
enum SideMenu : Int {
    case Profile
    case Messages
    case InviteBlackProfessionals
    case Badges
    case SendFeedback
    case Settings
    
    var name : String {
        switch self {
        case .Profile:
            return "Profile"
        case .Messages:
            return "Messages"
        case .InviteBlackProfessionals :
            return "Invite Black Professionals"
        case .Badges :
            return "Badges"
        case .SendFeedback :
            return "Send Feedback"
        case .Settings :
            return "Settings"
        }
    }
    
    var img : UIImage {
        switch self {
        case .Profile:
            return #imageLiteral(resourceName: "IC_user")
        case .Messages:
            return #imageLiteral(resourceName: "messages")
        case .InviteBlackProfessionals :
            return #imageLiteral(resourceName: "add-user")
        case .Badges :
            return #imageLiteral(resourceName: "trophy")
        case .SendFeedback :
            return #imageLiteral(resourceName: "feedback")
        case .Settings :
            return #imageLiteral(resourceName: "settings")
        }
    }
}

enum SocialLoginType : Int {
    case LinkedIn = 1
    case Apple = 2
}

enum MessageReplyType : String {
    case Text = "1"
    case Image = "2"
    case Video = "3"
    case Doc = "4"
    case Story = "5"
    case Rsume = "6"
  
}

enum MessageType : String {
    case Messages = "1"
    case Request = "2"
    case Archive = "3"
    
}

enum AuthVerificationType : Int {
    case Voice = 1
    case Question = 2
    case DOB = 3
}

struct DefaultPlaceholderImage {
    static let AppPlaceholder = "AppPlaceholder"
    static let UserAppPlaceholder = "AppPlaceholder"
    static let CardBGBlue = "ic_CardBackground"
    static let CardBGOrange = "ic_CardBackgroundOrange-1"
}


struct Masking {
    static let kPhoneNumberMasking = "XXX-XXX-XXXX"
    static let kCardNumberMasking = "XXXX-XXXX-XXXX-XXXX"
    static let kUSPhoneNumberMasking = "(XXX)-XXX-XXXX"
    static let kCardExire = "XX/XXXX"
    static let kCardCVV = "XXXX"
    static let kZipCode = "XXXXXX"
}

struct shareContentApp {
    static let kContent = "Share Roster'D app with friends : \n"
    static let kLink = "https://apps.apple.com/us/app/rosterd/id1642025428"
}
// MARK: - Constant
class AppConstant {
    // MARK: - Validation Messages constants
    static let deviceType : String = "2"
    static let pageSize = 10
    
    struct WebSocketAPI {
        static let kregistration = "registration"
        static let kuserSupportTicketMessageList = "userSupportTicketMessageList"
        static let kuserSupportTicketReply = "userSupportTicketReply"
        
        static let kchatinbox = "chatinbox"
        static let kchatmessagelist = "chatmessagelist"
        static let kusermessagelist = "usermessagelist"
        static let kmessage = "message"
        static let kremovechatmessagelist = "removechatmessagelist"
        static let krequestinbox = "requestinbox"
        static let ksetacceptdeclinerequest = "setacceptdeclinerequest"
        static let kgetUserStory = "getUserStory"
        static let ksaveuserstory = "saveUserStory"
        static let kDeleteUserStory = "deleteUserStory"
        static let kviewUserStory = "viewUserStory"
        static let kgetUserStoryViewList = "getUserStoryViewList"
        static let ksaveStoryReply  = "saveStoryReply"
        
        //Development
//        static let socketURL = "ws://project.greatwisher.com:9030"
        //Live
        static let socketURL = "wss://myrosterd.com:9030"
    
    }
    struct API {
        //Development
//        static let MAIN_URL = "https://project.greatwisher.com/rosterd/"
        //Live
        static let MAIN_URL = "https://myrosterd.com/"
    
        //static let MAIN_URL = ""
        static let BASE_URL = MAIN_URL + "api/"
        
        //Login Module
        static let kLogin               = BASE_URL + "auth/login"
        static let ksocialLogin         = BASE_URL + "auth/socialLogin"
        static let kRegisterUser        = BASE_URL + "auth/signup"
        static let kForgotPassword      = BASE_URL + "auth/forgotPassword"
        static let kChangePassword      = BASE_URL + "auth/changePassword"
        static let kResetPassword       = BASE_URL + "auth/resetPassword"
        static let kgetResume          =  BASE_URL + "users/getResume"
        static let konoffnotification =   BASE_URL + "users/setUserNotification"
        
        static let kverify              = BASE_URL + "auth/verify"
        static let kresendVerification = BASE_URL + "auth/resendVerification"
        static let kforgotPassword          = BASE_URL + "auth/forgotPassword"
        static let kresetPassword          = BASE_URL + "auth/resetPassword"
        static let kchangePassword          = BASE_URL + "auth/changePassword"
        static let kcheckForgotCode          = BASE_URL + "auth/checkForgotCode"
        static let kcompleteProfile         = BASE_URL + "auth/completeProfile"
        static let klogout                  = BASE_URL + "auth/logout"
        static let ksetSubscription         = BASE_URL + "users/setSubscription"
        static let ksetShareResume         = BASE_URL + "users/setShareResume"
        static let kDeleteAccount         = BASE_URL + "users/deleteAccount"
        static let kgetmyPosts          = BASE_URL + "users/getmyPosts"
        static let kgetFollowList                  = BASE_URL + "users/getFollowList"
        static let kGetProfile          = BASE_URL + "users/getUserInfo"
        static let kUpdateUserProfile   = BASE_URL + "users/saveUserProfile"
        static let kgetUsersList       = BASE_URL + "users/getUsersList"
        static let kgetUserInfo       = BASE_URL + "users/getUserInfo"
        static let kgetUserProfile    = BASE_URL + "users/getUserProfile"
        static let kgetUserRewardList  = BASE_URL + "users/getUserRewardList"
        static let kgetCategory          = BASE_URL + "users/getCategory"
        static let ksetCategory          = BASE_URL + "users/setCategory"
        static let ksetUserAlbum       = BASE_URL + "users/setUserAlbum"
        static let kgetAlbums         = BASE_URL + "users/getAlbums"
        static let ksetExperience   = BASE_URL + "users/setExperience"
        static let kgetExperience   = BASE_URL + "users/getExperience"
        static let ksetAdvertiseWithUs   = BASE_URL + "users/setAdvertiseWithUs"
        static let kgetUserShippingAddress  = BASE_URL + "users/getUserShippingAddress"
        static let ksetUserShippingAddress  = BASE_URL + "users/setUserShippingAddress"
        static let kdeleteShippingAddress  = BASE_URL + "users/deleteShippingAddress"
        static let ksetUserAlbumMedia   = BASE_URL + "users/setUserAlbumMedia"
        static let ksetHighlight                   = BASE_URL + "users/setHighlight"
        static let kRemoveHighlight                   = BASE_URL + "users/removeHighlight"
        static let kdeleteAlbum  =      BASE_URL + "users/deleteAlbum"
        static let kgetUsersFollowList   = BASE_URL + "users/getUsersFollowList"
        static let kdeleteUserAlbumMedia = BASE_URL + "users/deleteUserAlbumMedia"
        static let kmediaUpload          = BASE_URL + "common/mediaUpload"
        static let ksetAppFeedback          = BASE_URL + "common/setAppFeedback"
        static let kGetAppFeedback          = BASE_URL + "common/getAppFeedback"
        static let kgetResource          = BASE_URL + "resources/getResource"
        static let kgetResourceDetail          = BASE_URL + "resources/getResourceDetail"
        static let kgetCMS               = BASE_URL + "common/getCMS"
        static let kfaq                  = BASE_URL + "common/faq"
        static let kfaqDetails           = BASE_URL + "common/faqDetails"
        static let kgetcommonData        = BASE_URL + "common/getcommonData"
        static let kGetFeddbackCategory  = BASE_URL + "common/getAppFeedbackCategory"
        static let kGetTicket            = BASE_URL + "common/getTicket"
        static let kGetTicketDetail      = BASE_URL + "common/getTicketDetail"
        static let ksetTicket            = BASE_URL + "common/setTicket"
        static let kreopenTicket         = BASE_URL + "common/reopenTicket"
        static let kgetTicketCategory   = BASE_URL + "common/getTicketCategory"
        static let kgetCategoryList   = BASE_URL + "users/getCategoryList"
        static let kgetFaqCategory    = BASE_URL + "common/getFaqCategory"
        static let ksetReportChatUser  = BASE_URL + "common/setReportChatUser"
        static let kgetNotificationCount  = BASE_URL + "common/getUnreadNotificationsCount"
        
        static let ksetUserResume    = BASE_URL + "users/setUserResume"
        static let kgetUserResume    = BASE_URL + "users/getUserResume"
       
        //Event
      
        
        //Feed
         static let kuserPost            = BASE_URL + "post/userPost"
        static let ksetPostLikeDislike    = BASE_URL + "post/setPostLikeDislike"
        static let kgetPostsLikeList      = BASE_URL + "/post/getPostsLikeList"
        static let kgetPostcomments      = BASE_URL + "post/getPostcomments"
        static let kgetDashboardList     = BASE_URL + "post/getDashboardList"
        static let kgetStory      = BASE_URL + "post/getStory"
        static let ksetStory      = BASE_URL + "post/setStory"
        static let kpostDelete      = BASE_URL + "post/postDelete"
        static let kdeleteFeedComment      = BASE_URL + "feed/deleteFeedComment"
        static let ksetPostComment      = BASE_URL + "post/setPostcomments"
        static let kPostreport              = BASE_URL + "post/report"
        static let ksetFeedCommentReport  = BASE_URL + "feed/setFeedCommentReport"

        
        //Follow
        static let kgetRequestList          = BASE_URL + "follow/getRequestList"
        static let ksetFollow                = BASE_URL + "follow/setFollow"
        static let ksetRequest          = BASE_URL + "follow/setRequest"
        
        
        //Language
        static let kgetLanguagesList          = BASE_URL + "common/getLanguagesList"
        
        //City
        static let kgetStateList          = BASE_URL + "common/getStateList"
        static let kgetCityList          = BASE_URL + "common/getCityList"
        static let kgetProfessionList          = BASE_URL + "common/getProfessionList"
        
        //Product
        static let kgetMyProductFavoriteList = BASE_URL + "product/getMyProductFavoriteList"
        static let kgetProductCategory = BASE_URL + "product/getProductCategory"
        static let kproductDashboard = BASE_URL + "product/productDashboard"
        static let kgetProductList = BASE_URL + "product/getProductList"
        static let kproductDetail = BASE_URL + "product/productDeail"
        static let ksetLike             = BASE_URL + "product/setLike"
        static let kaddProductCart      = BASE_URL + "product/addProductCart"
        static let kcartView            = BASE_URL + "product/cartView"
        static let kremoveProductCart    = BASE_URL + "product/removeProductCart"
        static let kgetProductCheckoutDetails = BASE_URL + "product/getProductCheckoutDetails"
        static let kgetGiftCouponNew  = BASE_URL + "product/getGiftCouponNew"
        static let kgetOrderList      = BASE_URL + "product/getOrderList"
        static let kgetOrderDetail    = BASE_URL + "product/getOrderDetail"
        static let kcancelOrder =   BASE_URL + "product/cancelOrder"
        static let kgetShadeSizeData  = BASE_URL + "common/getShadeSizeData"
        
//        Event
        static let kcreateEvent   = BASE_URL + "event/createEvent"
        static let ksetEventCategory   = BASE_URL + "event/setEventCategory"
        static let kEventDashbaord    = BASE_URL + "event/eventDashboard"
        static let kmyEvent   = BASE_URL + "event/myEvent"
        static let ksetFavoriteEvent   = BASE_URL + "event/setFavoriteEvent"
        static let keventDetail   = BASE_URL + "event/eventDetail"
        static let kgetEventCategoryList        = BASE_URL + "event/getEventCategory"
        static let kaddEventCart        = BASE_URL + "event/addEventCart"
        static let kEventcartView        = BASE_URL + "event/cartView"
        static let kEventremoveCart           = BASE_URL + "event/removeCart"
        static let kMyBookEvent       = BASE_URL + "event/myBookEventList"
        static let kgetEventCheckoutDetails   = BASE_URL + "event/getEventCheckoutDetails"
        static let kticketDetail         = BASE_URL + "event/ticketDetail"
        static let ksetEventTicketRedeem = BASE_URL + "event/setEventTicketRedeem"
        static let kgetEventBookingUser  = BASE_URL + "users/getEventBookingUser"
        static let kTicketDetail  = BASE_URL + "event/ticketDetail"
        static let ksetEventTicketTransfer = BASE_URL + "event/setEventTicketTransfer"
        static let kgetEventTransferTicketList = BASE_URL + "event/getEventTransferTicketList"
//       Chat
        static let kremoveChatRequest     = BASE_URL + "common/removeChatRequest"
        static let kacceptChatRequest       = BASE_URL + "common/acceptChatRequest"
        static let kdeclineChatRequest       = BASE_URL + "common/declineChatRequest"
        static let karchiveChatAddRemove        = BASE_URL + "common/archiveChatAddRemove"
        static let kblockUnblockChatUser      = BASE_URL + "common/blockUnblockChatUser"
        static let kgetUserFriendList       = BASE_URL + "event/getUserFriendList"
        
     
        //Card
        static let ksaveCard         = BASE_URL + "Payments/setCard"
        static let kgetUserCards         = BASE_URL + "Payments/getCard"
        static let kdeleteUserCard        = BASE_URL + "Payments/removeCard"
        static let kcheckout           = BASE_URL + "payments/checkout"
        static let ksetCardDefault        = BASE_URL + "users/setCardDefault"
        static let kapplyOfferCoupon     = BASE_URL + "product/applyOfferCoupon"
        static let kgetProductTransaction = BASE_URL + "product/getProductTransaction"
        
              
        //VOIP
        static let ksetVoipToken_URL                 =  BASE_URL + "common/setVoipToken"
        static let kgenerateAccessToken_URL          =  BASE_URL + "common/generateAccessToken"
        
        //Notification
        static let kgetNotificationsList          = BASE_URL + "common/getNotificationsList"
        static let kgetUnreadNotificationsCount          = BASE_URL + "common/getUnreadNotificationsCount"
    }
    
    struct PlaidAPI {
        
        //Sendbox Environment
        static let MAIN_URL = "https://sandbox.plaid.com/"
        
        
        static let Client_Id = "61b6c1ebead2fb0014400d8e"
        static let Secret_Key = "890439dfb661a9b60bc89ca9c505a9"
        
        static let kcreareToken = MAIN_URL + "link/token/create"
    }
    
    struct PhoneNumberMasking {
        static let kPhoneNumber = "XXX-XXX-XXXX"
    }
    
    struct ValidationMessages {
        
        static let kComingSoon = "Coming Soon"
        
        static let kEmptyTicketTile          = "Please enter ticket title"
        static let kEmptyTicketDesc          = "Please enter ticket description"
        static let kEmptyadvDesc          = "Please enter details"
        static let kEmptyTicketSubject       = "Please select ticket subject"
        static let kEmptyTicketCategory      = "Please select ticket category"
        static let kEmptyFeedbackcategory    = "Please Select Feedback Category"
        static let kstartdateLessThanendDate = "Start date must be less then from end date."
        static let kendDateGreterthanfromstartdate = "End date must be greater then from start date."
        static let kSelectStartdate = "Select start date."
        static let kSelectEnddate = "Select end date."
        static let kEmptySportsSelect = "Please Select Sports"
        static let kAcceptTermsnCondition = "Please accept terms of service"
        static let kacceptTerms      = "Please accept terms "
        static let kEmptyLanguage = "Please select atleast one Preferred Language"
        static let kEmptyTicketType = "Please Select Ticket Type"
        static let kEmptyAdvCategory = "Please Select Advertise Catergory"
        //Login validation message
        static let kCharPassword   = "password must be 8 to 15 character"
        static let kvalidPassword       =   "Your password must contain at least 1 Alphabet, 1 Number and 1 Special Character"
        static let kMsgStrongPassword       =   " Your password must contain at least 1 Alphabet, 1 Number and 1 Special Character "
        static let kInValidPassword       =   "Invalid username or password "
        static let kConfirmPass         = "Enter your confirm password"
        static let kPasswordNotMatch    = "Please ensure your password matches"
        static let kOldNewPasswordoNotMatch = "Old password and new password must not be same"
        static let kEmptyEmail           = "Please enter email address"
        static let kEmptyValidationCode = "Please enter verification code"
        static let kValidValidationCode = "Please enter valid verification code"
        static let kEmptyPassword        = "Please enter password"
        static let KNewPassword          = "Please enter new password"
        static let KOldPassword          = "Please enter old password"
        static let kOldPAsswordInvalid = "Old password must be 8 to 15 character"
        static let kInValidEmail         = "Please enter valid email address"
        static let kFeedbackdesc      = "Please Enter How are we doing?"
        static let kEmptyCompanyName           = "Please enter Company Name"
        static let kEmptyCompanyType          = "Please enter Company Retail, Brand, or Service"
        //Register validation message
        static let kEmptyName            = "Please enter full name"
        static let kNickName            = " Please Enter Nick Name "
        static let kselectclubschool       = "Please Select Club or School"
        static let kselectcoachRecruiter       = "Please Select Coach or Recruiter"
        static let kEmptyClubName       = "Please Enter Club Name "
        static let kEmptyMedicationName            = "Please enter medication name"
        static let kEmptyAge            = "Please enter age"
        static let kEmptyDOB  = "Please select date of birth"
        static let kInvalideAge            = "Age should be more than 18 years"
        static let kEmptyGender            = "Please select gender"
        static let kEmptyDosage            = "Please select dosage"
        static let kEmptyFrequency            = "Please select frequency"
        static let kEmptyRelation            = "Please select family relation"
        static let kEmptyDocumentType            = "Please enter document name"
        static let kEmptyClubAdress          = "Please enter Club address"
        static let kEmptyFavoriteSportsTeam          = "Please enterFavorite Sports Team"
        
        static let kEmptyheadline                 = "Please Enter Hedaline"
        static let kSportParticipation            = "Please Enter Sport Participation"
        static let kEmpryTeamnamne                = "Please Enter Team Name"
        static let kSelectPlayerPostion           = "Please Enetr Player Position"
        static let kEmptyHeight                   = "Please Select Height"
        static let kWeight                        = "Please Select Weight "
        static let kGPA                           = "Please enter GPA"
        static let kAgeGroups                     = "Please Select Age Groups"
        static let kRecreationalTeams             = "Please Select Recreational Teams Age Group"
        static let kClubTeamsage                  = "Please Select Club Teams Age Group"
        static let kAdultLeagues                  = "Please Enter  Adult Leagues"
        static let kFax                           = "Please Enter Fax"
        static let kAthleticDirector              = "Please Enter Athletic Director"
        static let kAthleticDirectorEmail         = "Please Enter Athletic Director Email"
        static let kGrades                        = "Please Enter Grades"
        static let kMascot                        = "Please Enter Mascot"
        static let kSchoolClubname                = "Please Enter School/ Club name"
        static let kSchoolClubaddress             = "Please Enter School / Club address"
        static let kHometown                      = "Please Select Hometown"
        static let kyearsofcoaching               = "Please Select # of years coaching"
        static let kWins                          = "Please Enter wins Records"
        
        
        
        static let kEmptyAllergiesName            = "Please enter allergie name"
        static let kEmptyIllnessName            = "Please enter illness name"
        static let kEmptyHealthIssueName            = "Please enter health issue name"
        static let kEmptyInjuriesName            = "Please enter injuries name"
        static let kEmptySurgerieName            = "Please enter surgerie name"
        static let kEmptyAllergieKeyword            = "Please enter allergie type"
        
        static let kEmptyPhoneNumber          = "Please enter phone number"
        static let kEmptyEmergencyContact     = "Please enter emergency contact"
        static let kEmptyProfession      = "Please enter your profession."
        static let kEmptyAddress         = "Please enter address"
        static let kEmptyConfirmPassword = "Please enter confirm password"
        static let kDontMatchPassword    = "Password and confirm password do not match"
        static let kInvalidPassword      = "Password must contain at least 6 characters."
        static let kInvalidOldPassword   = "Old password must contain at least 6 characters."
        static let kEmptyOldPassword     = "Please enter old password."
        static let kPostEmpaty           = "Please enter at leate one value."
        static let kEmptyPhoneNo         = "Please enter phone number."
        static let kInValidPhoneNo       = "Please enter valid phone number."
        static let kSelectLocation       = "Please choose the location first"
        
        static let kApartmentNumberUnit = "Please enter Apartment Number/Unit"
        static let kEmptyCity = "Please select city"
        static let kEmptyState = "Please select state"
        static let kEmptyZipcode = "Please enter zipcode"
        
        static let kEmptyAppointmentType = "Please select appointment type"
        static let kEmptyAppointmentTime = "Please select appointment time"
        static let kEmptyAppointmentLocation = "Please select appointment location"
        
        
        static let kEmptyHousenumber   = "Please Enter HouseNumber"
        static let kEmptystressadd     = "Please Enter StreetAdress"
        static let kEmptyLandmark      = "Please Enter Landmark"
        static let kEmptycity          = "Please Enter City"
        static let kemptyPostalCode    = "Please Enter PostalCode"
        static let kInvalidcode        = "Please Enter valid Code"
       
//        Event VAlidation Message
        static let KEventName = "Please Enter Event Name"
        static let KEventDate = "Please Select Event Date"
        static let kEventstartTime  = "Please Enter Start Time"
        static let kEventEndTime = "Please Enter End time"
        static let kEventCategory = "Please Select Event Catergory"
        static let kEventDescription = "Please Enter Event Description"
        static let kEventLocation = "Please Enter Location"
        static let kEmptyQuanty   = "Please Enter Ticket Quntaty"
        static let kEmptyImaage   = "Please Enter Event Image"
        
        static let KSelectGoal       = "Please enter goal"
        static let KSelectPainScale       = "Please select pain scale"
        static let KSelectFunctionScale       = "Please select function scale"
        static let KSelectcomplaint       = "Please select complaint"
    
        static let KSelectCard       = "Please select card"
        static let KSelectCategories     = "Please select categories"
        static let KCardHolderName       = "Please enter card holder name"
        static let KCardNumber           = "Please enter card number"
        static let KExpiryDate           = "Please enter expiry Date"
        static let KCVV                  = "Please enter cvv"
        static let KMM                  = "Please enter expiry month"
        static let KYYYY                  = "Please enter expiry year"
        static let KInvalidCardNumber    = "Please enter valid card number"
        static let KInvalidCVV           = "Please enter valid cvv"
        static let KInvalidMM    = "Please enter valid expiry month"
        static let KInvalidYYYY           = "Please enter valid expiry year"
        static let KValidExpiryDate      = "Please enter valid expiry date"
        
        static let kAge18Year = "You must be 18 years or older to join"
        static let kAge18YearProfile = "You must be older than 18 years"
        
        static let KGiveRating           = "Please give your rating"
        static let KGiveFeedback           = "Please give your feedback"
        //Location access message
        static let kLocationDenied       = "Please allow permission to access your location. Go to Settings > MLAB > Location Services > Allow."
        static let kEmptyOpinion         = "Please write something..."
        
        
        static let kFirstName            = "Please enter first name"
        static let kUserName            = "Please enter User Name"
        static let kMiddleName            = "Enter middle name"
        static let kLastName            = "Please enter last name"
        static let kPhoneNumber            = "Please enter phone number"
        static let kValidPhoneNumber            = "Please enter valid phone number"
        static let kDOB            = "Please enter date of birth"
        
        static let kEmptyAprtmentAddress = "Please apartment number."
        static let kEmptyFeedback       = "Please enter feedback"
     
        
        static let kToTimeLessThenFromTime = "To Time should be greater than From Time."
        static let kSelectedTimeLessThenFromTime = "To Time should be greater than From Time."
        static let kSelectedTimeSameFromTime = "To StartTime and From EndTime should not be same."
        static let kFromTimeGreterThenFromTime = "From StartTime should not be greater than To EndTime."
        static let kFromTimeSameToTime = "From Time and To Time should not be same."
        
        static let kEmptyTimeOffMonth = "Please select timeoff month"
        static let kEmptyTimeOffDay = "Please select timeoff day"
        static let kEmptyTimeOffFromTime = "Please select timeoff From Time"
        static let kEmptyTimeOffToTime = "Please select timeoff To Time"
        static let kEmptyAvailibilityWindow = "Please select availibility window"
        static let kEmprtAvailibilityFromTime = "Please select availibility From Time"
        static let kEmprtAvailibilityToTime = "Please select availibility To Time"
        
        
        static let kEndDategreaterThenStartDate = "EndDate should be greater than StartDate."
        static let kStartDateLessThenEndDate = "EndDate should be less than StartDate."
        static let kEndDateLessThenTodayDate = "EndDate should be less than Today Date."
        static let kStartDateLessThenTodayDate = "StartDate should be less than Today Date."
        
        static let kEmptyWorkPlace            = "Please enter Work Place"
        static let kEmptyWorkReasonleaving            = "Please enter Reason for Leaving"
        static let kEmptyStartDate            = "Please select Start Date"
        static let kEmptyEndDate            = "Please select End Date"
        static let kEmptyWorkDetail            = "Please enter work detail"
        
        static let kTimeAlreadyBooked = "The changes cannot be done as the patient has already booked the appointment for this time slot."
    }
    
    struct SuccessMessage {
        static let kImageUploadingSuccess = "Image uploaded successfully."
        static let kProfileUpdatedSuccess = "Profile updated successfully."
        static let kMailSent = "Email sent successfully."
    }
    
    struct FailureMessage {
        static let kNoInternetConnection    = "Please check your internet connection."
        static let kCommanErrorMessage      = "Something went wrong. Please try again later."
        static let kFailToLogin             = "Fail to login."
        static let kFailToLoadCategories    = "Fail to load categories."
        static let kInvalidCredential       = "Invalid login credential."
        static let kFailToUploadImage       = "Image uploading failed."
        static let kFailToUploadProfile     = "Fail to update profile"
        static let kNoDataAvailable         = "No data available at the moment."
        static let kQuickBloxErrorMessage   = "We're having a hard time connecting you to your chat room, please try again."
        static let kMailNoteSetUp           = "Please send your feedback to info@onix-network.com."
        static let kInvaliedCard            = "Card is invalid. Please enter valid card detail."
        
        static let kFbIdNotFound = "Unable to get facebook id"
    }
    
    struct NoDataFoundText {
        static let kNoSearchResult       = "No Search Result Found."
        static let kNoDataFound          = "No Data Found."
        static let kNoStudioFound        = "No Studios Found."
        static let kNoBussinessData      = "No Bussiness Data Available."
        static let kNoUserRequestData    = "No User Request Available."
        static let kNoScheduleData       = "No Scheduled Booking Data Available."
        static let kNoCompletedBookingData = "No Completed Booking Data Available."
        static let kReviewData             =  "No Review Data Available."
        static let kNoFollowingFound             =  "No Following Data Available."
        
    }
    
    //MARK: - Informative Messages Constants
    struct AlertMessages {
        
        static let kDelete               = "Are you sure you want to delete this?"
        
        static let kWrongUsername   = "Enter valid email and password."
        static let kLogout          = "Are you sure you want to logout?"
        static let kDeleteAccount   = "Are you sure you want to Delete?"
        static let kMailNoteSetUp   = "Email is not setup in your device."
        static let kMailSent        = "Email sent successfully."
        static let kProfileUpdated  = "Profile updated succesfully."
        
        static let kEmptyMsg  = "Please write message"
        
        static let kSelectAns  = "Please select answer"
        
        //Tour Detail Message
        static let kNoAudioFound    = "No media found."
        static let copySuccess      = "copy clipboard successfully."
        static let commingSoon      = "Coming Soon"
        
        static let AuthTokenExpire  = "Authentication Token Expire."
        static let LIkedinAccountDataNotFound  = "Oho! There are some actions needed to update privacy of your linkedin profile. we are not able to access your basic data at the moment. So please review the privacy setting in the linkedin profile and try again."
        
        static let sloteBooked      = "Selecetd slot is already booked"
        
    }
    struct DateFormat {
        static let k_yyyy_MM_dd              = "yyyy-MM-dd"
        static let k_YYYY_MM_dd              = "YYYY-MM-dd"
        //static let k_dd_MM_yyyy              = "dd/MM/yyyy"
        static let k_dd_MM_yyyy              = "dd-MM-yyyy"
        static let k_MM_dd_yyyy              = "MM-dd-yyyy"
        static let k_dd_MM_yyyy_hh_mm        = "dd-MM-yyyy hh:mm"
        static let k_dd_MM_yyyy_hh_mm_ss     = "dd-MM-yyyy hh:mm:ss"
        static let k_dd_MM_yyyy_hh_mm_a      = "dd-MM-yyyy hh:mm a"
        static let k_MM_dd_yyyy_hh_mm_a      = "MM-dd-yyyy hh:mm a"
        static let k_yyyy_MM_dd_HH_mm        = "yyyy-MM-dd HH:mm"
        static let k_MMMM_dd_yyyy_EEE_dd_MMM = "MMMM dd, yyyy-EEE-dd-MMM"
        static let k_MMMM_dd_yyyy            = "MMMM dd, yyyy"
        static let k_MMMM_dd_yyyyy           = "MMMM dd yyyy"
        static let k_MMM_dd_yyyy             = "MMM dd yyyy"
        static let k_HH_mm_ss                = "HH:mm:ss"
        static let k_hh_mm_a                 = "hh:mm a"
        static let k_hh_mm_ss_a              = "hh:mm:ss a"
        static let k_h_mm_a                  = "h:mm a"
        static let k_HH_mm                   = "HH:mm"
        static let k_EEEE                    = "EEEE"
        static let k_a_hh_mm                 = "a hh:mm"
        static let k_MMMM_yyyy               = "MMMM yyyy"
        static let k_MMM_yyyy                = "MMM yyyy"
        static let k_MMM_dd                  = "MMM dd"
        static let k_MMM_d                   = "MMM d"
        static let k_MMM_dd_hh_mm_a          = "MMM dd yyyy hh:mm a"
        static let k_dd_MMMM_yyyy            = "dd MMMM yyyy"
        static let k_HH_mm_a                 = "HH:mm a"
        static let k_dd_MMMM                 = "dd MMMM"
        static let k_dd                      = "dd"
        static let k_dd_MMM_yyyy             = "dd MMM yyyy"
        static let k_HH_MM                   = "HH:MM"
        static let k_yyyy                    = "yyyy"
        static let k_yyyy_MM_dd_HH_mm_ss        = "yyyy-MM-dd HH:mm:ss"
        static let k_MMMM                 = "MMMM"
        static let k_MM_yyyy                = "MM/yyyy"
        static let k_MMMMyyyy               = "MMMM/yyyy"
    }
}

func GetAppFontSize(size : CGFloat) -> CGFloat {
    return DeviceType.IS_PAD ? (size + 6.0) : size
}

//MARK: - WeekDayLabels
struct WeekDayLabels {
    
    static let kSunday                          = "sunday"
    static let kMonday                          = "monday"
    static let kTuesday                         = "tuesday"
    static let kWednesday                       = "wednesday"
    static let kThursday                        = "thursday"
    static let kFriday                          = "friday"
    static let kSaturday                        = "saturday"
}

//MARK: - MonthNames
struct MonthNames {
    static let kJan                             = "jan"
    static let kFeb                             = "feb"
    static let kMar                             = "mar"
    static let kApr                             = "apr"
    static let kMay                             = "may"
    static let kJun                             = "jun"
    static let kJul                             = "jul"
    static let kAug                             = "aug"
    static let kSep                             = "sep"
    static let kOct                             = "oct"
    static let kNov                             = "nov"
    static let kDec                             = "dec"
}

enum DateRoundingType {
    case round
    case ceil
    case floor
}

enum TimingEnum : String {
    case HalfHours = "30"
    case OneHours = "60"
}

/*
struct APIStatusCode {
    static let kSessionInvalid   = 401
    static let kSucessResponse   = 200
    static let kFailResponse     = 402
    static let kEmailNotFound    = 404
    static let kAccountNotApprove    = 105
}*/ 

// MARK: - Social API Key
struct APIKeys {
    //static let GooglePlaceAPIKey = "AIzaSyBDnm5bcs_I4KnnBKSHGjTIp-_cfJUyc5Q"
    static let GooglePlaceAPIKey = "AIzaSyCDVxUssYibnmc6Bjrn343G2-_HkyKiNQk"
    static let stripPublicKey = "pk_test_9wyRe5j6MuA1kwWFsMJ08CEI"
    static let stripSecrateKey = "sk_test_Uwe7QpaZBkyFjaL0tVHbFaIA"
}
struct StorageFolder {
    static let ProfilePicture = "Profile_Picture"
}

// MARK: - Screen Title
struct ScreenTitle {
    static let OM = "MLAB"
}

// MARK: - Button Title
struct ButtonTitle {
   static let EditProfile = "EDIT PROFILE"
    static let Update = "UPDATE"
    static let SUBMIT = "SUBMIT"
    static let TakePhoto = "Take photo"
    static let PickFromGallery = "Pick from gallery"
    static let Cancel = "Cancel"
    static let OK = "OK"
    static let kNewTicket = "New Ticket"
    static let kReopen = "Reopen"

    static let Yes = "Yes"
    static let No = "No"
    static let kLogout = "Logout"
}

//MARK: - Alert Title
struct AlertTitles {
    static let kSelectProfileImage  = "Select Profile Image"
    static let kSelectStudioImagesImage  = "Select Studio Image"
    static let kCamera              = "Camera"
    static let kGallery             = "Gallery"
    static let kSelectCancellationPolicy = " Cancellation Fees"
    static let kSelectFeature = " Feature"
    static let KSelectBusinessType = " Select Studio Type"
    static let kSelectFromTime = "Select FromTime"
    static let kSelectToTime = "Select ToTime"
    static let KSelectDate = "Select Date"
    static let kSuccess     = "Success"
    static let kDone     = "Done"
    static let kSelectIndustry     = "Select Industry"
    static let kSelectUniversity     = "Select University"
    static let kSelectStartDate     = "Select Start Date"
    static let kSelectEndDate     = "Select End Date"
    static let kDeleteBookmark = "Are you sure want to delete this bookmark?"
    static let kDeleteMedications = "Are you sure want to delete this medication?"
    static let kDeleteAllergies = "Are you sure want to delete this allergy?"
    static let kDeleteHealthIssue = "Are you sure want to delete this healthissue?"
    static let kDeleteInjuries = "Are you sure want to delete this injury?"
    static let kDeleteSurgeries = "Are you sure want to delete this surgery?"
    static let kDeleteFamilyIllness = "Are you sure want to delete this family illness?"
    static let kDeleteCard = "Are you sure want to delete this card?"
    static let kRemoveCart = "Are you sure want to delete this Product?"
    static let kDeleteDocument = "Are you sure want to delete this document?"
    static let kDeleteChat = "Are you sure want to delete this chat?"
    
    static let kSelectDOB     = "Select Date of Birth"
    static let kSelectMonth = "Select Month of Birth"
    static let kSelectDay = "Select Day of Birth"
    static let kSelectRelaton = "Select Relation"
    
    static let kCanceleAppointment = "Are you sure want to cancel this appointment?"
}

struct TextFieldPlaceHolderText {
    static let kZero = "0"
}

struct ObserverName {
    static let kcontentSize     = "contentSize"
}

struct cornerRadiousValue {
    static let defaulrCorner : CGFloat = 10.0
    static let buttonCorner : CGFloat = 15.0
}

// MARK: - Color Constant
extension UIColor {
    struct CustomColor {
        //0A5C94
        static let appColor = #colorLiteral(red: 0.03921568627, green: 0.3607843137, blue: 0.5803921569, alpha: 1)
        static let appBackgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        static let TextViewTextColor = #colorLiteral(red: 0.6549019608, green: 0.6549019608, blue: 0.6549019608, alpha: 1)
        
        static let calendarLightColor = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1)
        static let prevCalendarLightColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        //171717
        static let textfieldTextColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        
        //1C1D20
        static let dateTextColor = #colorLiteral(red: 0.1098039216, green: 0.1137254902, blue: 0.1254901961, alpha: 1)
        
//        D6D6D6
        static let yesnoColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1)
        
        
//        DBDBDB 80 %
        static let whiteShadow80 = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 0.8)
//        6C727F
        static let ProductListColor = #colorLiteral(red: 0.4235294118, green: 0.4470588235, blue: 0.4980392157, alpha: 1)
        
//        1E4473
        static let YesBorderColor = #colorLiteral(red: 0.1176470588, green: 0.2666666667, blue: 0.4509803922, alpha: 1)
        
        //707586
        static let dateBorderColor = #colorLiteral(red: 0.4392156863, green: 0.4588235294, blue: 0.5254901961, alpha: 1)
        
        //005C9A
        static let dateGradiantColorOne = #colorLiteral(red: 0, green: 0.3607843137, blue: 0.6039215686, alpha: 1)
        
        //024877
        static let dateGradiantColorTwo = #colorLiteral(red: 0.007843137255, green: 0.2823529412, blue: 0.4666666667, alpha: 1)
        
        //F45D1B
        static let BorderColorOne = #colorLiteral(red: 0.9568627451, green: 0.3647058824, blue: 0.1058823529, alpha: 1)
        
        //024E81
        static let viewAllColor = #colorLiteral(red: 0.007843137255, green: 0.3058823529, blue: 0.5058823529, alpha: 1)
        
        //1A1A1A
        static let feedColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
//        102341 88%
        static let imgcaptioncolor88 = #colorLiteral(red: 0.06274509804, green: 0.137254902, blue: 0.2549019608, alpha: 0.8793767885)
        
        //262626
        static let feedCountColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        
        //171717
        static let labelTextColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        
        //847A74
        static let seperaterLabelTextColor = #colorLiteral(red: 0.5176470588, green: 0.4784313725, blue: 0.4549019608, alpha: 1)
        
//        B2B2B2
        static let addressLabelTextColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
        
        //8F8F8F
        static let followersLabelTextColor = #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1)
        
        //E0E4F5
        static let viewSuggestionBorderColor = #colorLiteral(red: 0.8784313725, green: 0.8941176471, blue: 0.9607843137, alpha: 1)
        
        //F1F1F1
        static let viewBGColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        
        //EEEEEE
        static let viewTabBGColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
        //4B4B4B
        static let registerLabelTextColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        
        //828991
        static let deselectSegmentTextColor = #colorLiteral(red: 0.5098039216, green: 0.537254902, blue: 0.568627451, alpha: 1)
        
        //171717
        static let headerTextColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        
        //F87E2C
        static let verifyCodeSeperatorColor = #colorLiteral(red: 0.9725490196, green: 0.4941176471, blue: 0.1725490196, alpha: 1)
        
        //999BB1
        static let subHeaderTextColor = #colorLiteral(red: 0.6, green: 0.6078431373, blue: 0.6941176471, alpha: 1)
        
        //EBFFFC
        static let viewTotalBillsBGColor = #colorLiteral(red: 0.9215686275, green: 1, blue: 0.9882352941, alpha: 1)
        
        //E1FAFF
        static let viewSpendingMoneyBGColor = #colorLiteral(red: 0.8823529412, green: 0.9803921569, blue: 1, alpha: 1)
        
        //F6EFFF
        static let viewNextPeriodBGColor = #colorLiteral(red: 0.9647058824, green: 0.937254902, blue: 1, alpha: 1)
        
//        4A4A4A
        static let UsersubColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        
//        A2D6FF
        static let chatbgcolor = #colorLiteral(red: 0.6352941176, green: 0.8392156863, blue: 1, alpha: 1)
        
        //707070
        
        //F5F5F8
        static let viewOTPBGColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        
        //607698
        static let reusableTextColor = #colorLiteral(red: 0.3764705882, green: 0.462745098, blue: 0.5960784314, alpha: 1)
        
        //607698 40%
        static let reusableTextColor40 = #colorLiteral(red: 0.3764705882, green: 0.462745098, blue: 0.5960784314, alpha: 0.4021099002)
        
        //A8A8A8
        static let reusablePlaceholderColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
        
        //EAE8E7
        static let reusableSeperatorColor = #colorLiteral(red: 0.9176470588, green: 0.9098039216, blue: 0.9058823529, alpha: 1)
        
        
//        404243
        static let ShoesName = #colorLiteral(red: 0.2509803922, green: 0.2588235294, blue: 0.262745098, alpha: 1)
        
//        121826
        static let ProductPrizeColor = #colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1490196078, alpha: 1)
        
        //        121826 40%
                static let prizecolor = #colorLiteral(red: 0.07058823529, green: 0.09411764706, blue: 0.1490196078, alpha: 0.4015370746)
        
        //848A94
        static let weekdayTextColor = #colorLiteral(red: 0.5176470588, green: 0.5411764706, blue: 0.5803921569, alpha: 0.38)
        
        //0967D3
        static let logoutTextColor = #colorLiteral(red: 0.03529411765, green: 0.4039215686, blue: 0.8274509804, alpha: 1)
        
        //001760
        static let segmentTextColor = #colorLiteral(red: 0, green: 0.09019607843, blue: 0.3764705882, alpha: 1)
        
        //0DF54C
        static let AvailablePersonStatusColor = #colorLiteral(red: 0.05098039216, green: 0.9607843137, blue: 0.2980392157, alpha: 1)
        
        //F4BC08
        static let AvailableVideoCallStatusColor = #colorLiteral(red: 0.9568627451, green: 0.737254902, blue: 0.03137254902, alpha: 1)
        
        //326CDE
        static let AvailableGroupSessionStatusColor = #colorLiteral(red: 0.1960784314, green: 0.4235294118, blue: 0.8705882353, alpha: 1)
        
        //D6D8DB
        static let progressBarBackColor = #colorLiteral(red: 0.8392156863, green: 0.8470588235, blue: 0.8588235294, alpha: 1)
        
        //F2F5F8
        static let CMSArrowBGColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        
        //141E30
        static let TextColor = #colorLiteral(red: 0.07843137255, green: 0.1176470588, blue: 0.1882352941, alpha: 1)
        
        //141E30 50%
        static let TimeTextColor = #colorLiteral(red: 0.07843137255, green: 0.1176470588, blue: 0.1882352941, alpha: 0.5)
        
        //037EF3
        static let ResendButtonColor = #colorLiteral(red: 0.01176470588, green: 0.4941176471, blue: 0.9529411765, alpha: 1)
        
        //326CDE
        static let categoriesBorderColor = #colorLiteral(red: 0.1960784314, green: 0.4235294118, blue: 0.8705882353, alpha: 1)
        
        //ECECEC
        static let menuDeselectBGColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        
        //5E7FB1
        static let SubLine15Alpha = #colorLiteral(red: 0.368627451, green: 0.4980392157, blue: 0.6941176471, alpha: 0.15)
        
        //F5F7FB
        static let loginBoxBGColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9843137255, alpha: 1)
        
        //1A2332
        static let textColroLogin = #colorLiteral(red: 0.1019607843, green: 0.137254902, blue: 0.1960784314, alpha: 1)
        
        //1A2332 60%
        static let placeholderApp60 = #colorLiteral(red: 0.1019607843, green: 0.137254902, blue: 0.1960784314, alpha: 0.6)
        
        //1C1C1C 60%
        static let placeholderapp760 = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1098039216, alpha: 0.5950128777)
        
//        1C1C1C
        static let placeholderapp = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1098039216, alpha: 1)
        
        static let reusableViewBackColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 1, alpha: 0.33)
        
        //000000 10%
        static let shadowColorTenPerBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        //000000 12%
        static let shadowColorTwelvePerBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
        
        //000000 5%
        static let shadowColorFivePerBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05)
        
        //01274C 17%
        static let shadowResourcesColor = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2980392157, alpha: 0.1688440588)
        
        //01274C
        static let BlogHeadreGradiantTopColor = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2980392157, alpha: 1)
        
        //01274C 73%
        static let BlogHeadreGradiantTop73Color = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2980392157, alpha: 0.73)
        
        //01274C 0%
        static let BlogHeadreGradiantTop0PerColor = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2980392157, alpha: 0)
        
        //FC2A8C
        static let cancelAppointColor = #colorLiteral(red: 0.9882352941, green: 0.1647058824, blue: 0.5490196078, alpha: 1)
        
        //E8E8E8
        static let borderColorMsg = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        
        //#FFFFFF 50%
        static let whitecolor50 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        //#FFFFFF 25%
        static let videoBackcolor25 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        
        //8E8E8E
        static let bookedSlotColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        
        //8E8E8E
        static let SetAppontmentColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        
        //646464
        static let EmailSidemenuColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        
        //A9A9AB
        static let TicketTimeColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.6705882353, alpha: 1)
        
        //646464 80%
        static let FAQBottomDescColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 0.8)
        
        //646464 60%
        static let NotificationUnSelectColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 0.6)
        
        //F3F7FF
        static let ExperienceBGColor = #colorLiteral(red: 0.9529411765, green: 0.968627451, blue: 1, alpha: 1)
        
        //242529
        static let OnlineSidemenuColor = #colorLiteral(red: 0.1411764706, green: 0.1450980392, blue: 0.1607843137, alpha: 1)
        
        //4D2C5E
        static let TransactionColor = #colorLiteral(red: 0.3019607843, green: 0.1725490196, blue: 0.368627451, alpha: 1)
        
        //293644
        static let forgotColor = #colorLiteral(red: 0.1607843137, green: 0.2117647059, blue: 0.2666666667, alpha: 1)
        
        //FF7700
        static let muteCallColor = #colorLiteral(red: 1, green: 0.4666666667, blue: 0, alpha: 1)
        
        //D20000
        static let EndVideoColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0, alpha: 1)
        
//        CC0000
        static let Logoutcolor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
        
//        1C3254
        static let messageColor = #colorLiteral(red: 0.1098039216, green: 0.1960784314, blue: 0.3294117647, alpha: 1)
        
//        D8D8D8
        static let ResumebgColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        
        //348FFC
        static let MuteVideoColor = #colorLiteral(red: 0.2039215686, green: 0.5607843137, blue: 0.9882352941, alpha: 1)
        
        //AAAAAA
        static let NotificationDescColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        
        //293644 alpha
        static let successprofilesubColor = #colorLiteral(red: 0.1607843137, green: 0.2117647059, blue: 0.2666666667, alpha: 0.3)
        
        //White 0%
        static let whiteGradiantOne = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        //White 100%
        static let whiteGradiantTwo = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //ADADAD
        static let alreadyColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        
        //848A94
        static let searchPlaceholderColor = #colorLiteral(red: 0.5176470588, green: 0.5411764706, blue: 0.5803921569, alpha: 1)
        
        //2D2D2D
        static let NotesTitleColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)
        
        //0C0C0E
        static let BlogSelectedColor = #colorLiteral(red: 0.04705882353, green: 0.04705882353, blue: 0.05490196078, alpha: 1)
        
        //0C0C0E 38%
        static let BlogUnSelectedColor = #colorLiteral(red: 0.04705882353, green: 0.04705882353, blue: 0.05490196078, alpha: 0.38)
        
        //2D2D2D 70%
        static let NotesTitleColor70 = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 0.7)
        
        //C5C5C5
        static let feedTimeCell = #colorLiteral(red: 0.7725490196, green: 0.7725490196, blue: 0.7725490196, alpha: 1)
        
        //83718B
        static let commentTimeCell = #colorLiteral(red: 0.5137254902, green: 0.4431372549, blue: 0.5450980392, alpha: 1)
        
        //6F27FF
        static let registerColor = #colorLiteral(red: 0.4352941176, green: 0.1529411765, blue: 1, alpha: 1)
        
        //EBEFF4
        static let SpecilityColor = #colorLiteral(red: 0.9215686275, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        
        //E0E0E0
        static let slidermaxColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        
        //272755
        static let SliderTextColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.3333333333, alpha: 1)
        
        //5B5A61
        static let segementOtherDotColor = #colorLiteral(red: 0.3568627451, green: 0.3529411765, blue: 0.3803921569, alpha: 1)
        
        //6F27FF 50%
        static let pageAlphaColor = #colorLiteral(red: 0.4352941176, green: 0.1529411765, blue: 1, alpha: 0.5)
        
        //C4C4C4
        static let pageColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        
        //383F45
        static let aboutDetailColor = #colorLiteral(red: 0.2196078431, green: 0.2470588235, blue: 0.2705882353, alpha: 1)
        
//        1D1C1A
        static let ConnectWithColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1019607843, alpha: 1)
        
        //918FB7
        static let RegLanuageColor = #colorLiteral(red: 0.568627451, green: 0.5607843137, blue: 0.7176470588, alpha: 1)
        
        //363636
        static let careDateColor = #colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2117647059, alpha: 1)
        
        //1E243A
        static let AppointmentTExtColor = #colorLiteral(red: 0.1176470588, green: 0.1411764706, blue: 0.2274509804, alpha: 1)
        
        //0098FF
        static let ReopenTicketColor = #colorLiteral(red: 0, green: 0.5960784314, blue: 1, alpha: 1)
        //1D1D1D
        static let TicketTitleColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
        
        //00BC06
        static let SuccessStaus = #colorLiteral(red: 0, green: 0.737254902, blue: 0.02352941176, alpha: 1)
        
        
        //FFBD06
        static let OpenTicketStatus = #colorLiteral(red: 1, green: 0.7411764706, blue: 0.02352941176, alpha: 1)
        
        //113260
        static let otpTextColor = #colorLiteral(red: 0.06666666667, green: 0.1960784314, blue: 0.3764705882, alpha: 1)
        
        //333333
        static let sessionDateTextColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        //EEEEFF
        static let locationNameBackColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 1, alpha: 0.3)
        
        //D61B0A
        static let IntroCurrentTextColor = #colorLiteral(red: 0.8392156863, green: 0.1058823529, blue: 0.03921568627, alpha: 1)
        static let IntroDefaultTextColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        //F04037
        static let resourceBtnColor = #colorLiteral(red: 0.9411764706, green: 0.2509803922, blue: 0.2156862745, alpha: 1)
        
        //D42731
        static let btnBackColor = #colorLiteral(red: 0.831372549, green: 0.1529411765, blue: 0.1921568627, alpha: 1)
        
        //7F8FA4
        static let labelColorLogin = #colorLiteral(red: 0.4980392157, green: 0.5607843137, blue: 0.6431372549, alpha: 1)
        
        //#0078B5
        static let LinkedinColor = #colorLiteral(red: 0, green: 0.4705882353, blue: 0.7098039216, alpha: 1)
        
        //3393F3
        static let profilebackcolor = #colorLiteral(red: 0.2, green: 0.5764705882, blue: 0.9529411765, alpha: 1)
            
        //242424 50%
        static let labelTextColorAlpha = #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 0.5)
        
        //101010
        static let headerBackColor = #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
        
        //101010 50%
        static let headerBackAlphaColor = #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 0.5)
        
        //F8F8F8
        static let otpColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        
        static let postcolor =  #colorLiteral(red: 0.007843137255, green: 0.2823529412, blue: 0.4666666667, alpha: 0.08243063993)
        
        //000000
        static let languageBackColor = #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 0.06)
        
        //0368AC 
        static let gradiantColorTop = #colorLiteral(red: 0.01176470588, green: 0.4078431373, blue: 0.6745098039, alpha: 1)
        
        //0368AC 60%
        static let gradiantColorTop60 = #colorLiteral(red: 0.01176470588, green: 0.4078431373, blue: 0.6745098039, alpha: 0.6)
        
        //024877
        static let gradiantColorBottom = #colorLiteral(red: 0.007843137255, green: 0.2823529412, blue: 0.4666666667, alpha: 1)
        
        //024877 60%
        static let gradiantColorBottom60 = #colorLiteral(red: 0.007843137255, green: 0.2823529412, blue: 0.4666666667, alpha: 0.6)
        
        
//        F4F4F6
        static let MinusBtnColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        
        
        //92703E
        static let gradiantGoldTop = #colorLiteral(red: 0.5725490196, green: 0.4392156863, blue: 0.2431372549, alpha: 1)
        //A68650
        static let gradiantGoldCener = #colorLiteral(red: 0.6509803922, green: 0.5254901961, blue: 0.3137254902, alpha: 1)
        //DBC17E
        static let gradiantGoldBottomCenter = #colorLiteral(red: 0.8588235294, green: 0.7568627451, blue: 0.4941176471, alpha: 1)
        //DEC481
        static let gradiantGoldBottom = #colorLiteral(red: 0.8705882353, green: 0.768627451, blue: 0.5058823529, alpha: 1)
        
        //1C79BC 9%
        static let backBGcolor9Per = #colorLiteral(red: 0.1098039216, green: 0.4745098039, blue: 0.737254902, alpha: 0.5)
        
        //1C2E46 8%
        static let ChatSendMsgBgColor = #colorLiteral(red: 0.1098039216, green: 0.1803921569, blue: 0.2745098039, alpha: 0.08)
        
        //31CBEE 6%
        static let gradiantColorTopAlpha = #colorLiteral(red: 0.1921568627, green: 0.7960784314, blue: 0.9333333333, alpha: 0.06)
        //3358DB 6%
        static let gradiantColorBottomAlpha = #colorLiteral(red: 0.2, green: 0.3450980392, blue: 0.8588235294, alpha: 0.06)
        
        //92929D
        static let labelORColor = #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.6156862745, alpha: 1)
        
        //EAEDF7
        static let loginBGBorderColor = #colorLiteral(red: 0.9176470588, green: 0.9294117647, blue: 0.968627451, alpha: 1)
        
        //54 54 54 242134
        static let appTextColor = #colorLiteral(red: 0.1411764706, green: 0.1294117647, blue: 0.2039215686, alpha: 1)
        
        //121212
        static let calenderSessionTypeTextColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        
        //45464D
        static let calenderSessionTimeTextColor = #colorLiteral(red: 0.2705882353, green: 0.2745098039, blue: 0.3019607843, alpha: 1)
        
        //344356
        static let QuestonAnswerColor = #colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)
        
        //037EF4 35%
        static let ButtonShadowColor = #colorLiteral(red: 0.01176470588, green: 0.4941176471, blue: 0.9568627451, alpha: 0.35)
        
        //1C295A
        static let shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16)
        
        //000000 7%
        static let shadowColorBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.07)
        
        //00000043%
        static let shadowColor43Black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.43)
        
        //000000 7%
        static let ColorBlack25Per = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        
        //000000 20%
        static let shadowFiveColorBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        //FFA638
        static let ratingColor = #colorLiteral(red: 1, green: 0.6509803922, blue: 0.2196078431, alpha: 1)
        
        static let borderColor2 = #colorLiteral(red: 0.8823529412, green: 0.9098039216, blue: 0.9333333333, alpha: 1)
        
        //767581
        static let resourceDateColor = #colorLiteral(red: 0.462745098, green: 0.4588235294, blue: 0.5058823529, alpha: 1)
        //19191B
        static let resourceHeadreColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.1058823529, alpha: 1)
        
        static let viewBackgrounfLanguage = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        
        //303639
        static let barbuttoncolor = #colorLiteral(red: 0.1882352941, green: 0.2117647059, blue: 0.2235294118, alpha: 1)
        
        
        //BFC7D1
        static let appPlaceholderColor = #colorLiteral(red: 0.7490196078, green: 0.7803921569, blue: 0.8196078431, alpha: 1)
        
        //#606060
        static let buttonTextColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
        
        //000000
        static let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        //FF0000
        static let RecordingColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        
        //000000 39%
        static let black39Per = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.39)
        
        //000000 50%
        static let black50Per = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        //000000 35%
        static let black35Per = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.35)
        
        //E1E1E1
        static let borderCalenderColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        
        //161616
        static let btnBackgroundColor = #colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        
        //#707070x
        static let sepretorColor  = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        //DEDEDE
        static let switchOffColor  = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
        
        //#6E6E6E
        static let dateColor  = #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.431372549, alpha: 1)
        
//        FAA300
        static let CoinColor  = #colorLiteral(red: 0.9803921569, green: 0.6392156863, blue: 0, alpha: 1)
        
        //#F2F2F2
        static let sepratorFeedColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        //#DCDCDC
        static let borderColor  = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        //EAE9F2
        static let borderColor23 = #colorLiteral(red: 0.9176470588, green: 0.9137254902, blue: 0.9490196078, alpha: 1)
        //E2E2E2
        static let borderColor4 = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
        //CFCFCF
        static let bordrColor5 = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
        //E8EEF4
        static let borderColor6 = #colorLiteral(red: 0.9098039216, green: 0.9333333333, blue: 0.9568627451, alpha: 1)
        //E9E9E9
        static let borderColor7 = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        //D2D5E1
        static let borderColor8 = #colorLiteral(red: 0.8235294118, green: 0.8352941176, blue: 0.8823529412, alpha: 1)
    
        //E1E8EE
        static let borderFeedback = #colorLiteral(red: 0.8823529412, green: 0.9098039216, blue: 0.9333333333, alpha: 1)
        
        //E1E8EE 6%
        static let answerBackColor = #colorLiteral(red: 0.8823529412, green: 0.9098039216, blue: 0.9333333333, alpha: 0.06)
        
        //#D1D1D1
        static let feedBorderColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
        
        //C7C7CC
        static let sepratorcolor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
        
        //#595959
        static let LoginLabelColor  = #colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3490196078, alpha: 1)
        //#8497B0
        static let LoginLabelSeondTextColor  = #colorLiteral(red: 0.5176470588, green: 0.5921568627, blue: 0.6901960784, alpha: 1)
        //#7F7F7F
        
        static let LoginSubLabelTextColor = #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
        //#8B8B8B
        static let HeaderLabelTextColor = #colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5450980392, alpha: 1)
        
        //#A5A5A5
        static let AcceptLabelTextColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1)
        
        //F3F4F7
        static let SearchBGColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        
        //F3F4F7 26%
        static let SegemntBGColor26Per = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.968627451, alpha: 0.26)
        
        //#EFF5FB
        static let BacButtonBGColor = #colorLiteral(red: 0.937254902, green: 0.9607843137, blue: 0.9843137255, alpha: 1)
        
        //E5E5E5
        static let sepratorColorLocation = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        
        //EDF4F8
        static let availibilityBackColor = #colorLiteral(red: 0.9294117647, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
        
        //#F7F7F7
        static let tabbarBackgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        
        //#151515
        static let lblProfileColor = #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.08235294118, alpha: 1)
        
        static let welcomeBordercolor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9607843137, alpha: 1)
        
        //EBEBEB
        static let cardBackColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        //#FFFFFF
        static let whitecolor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //#7B7B7B
        static let subscriptionHeaderTextColor = #colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1)
        
        //#5CB5EF
        static let subscriptionPriceTextColor = #colorLiteral(red: 0.3607843137, green: 0.7098039216, blue: 0.937254902, alpha: 1)
    
        //F9F9F9
        static let writeSomethingBGColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        
        //A89BAE
        static let commentPlaceholderColor = #colorLiteral(red: 0.6588235294, green: 0.6078431373, blue: 0.6823529412, alpha: 1)
        
//        E6E6E6
        static let feedbackcolor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        //F6F6F6
        static let SupportTopBGcolor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
//        #858585
        static let labelordercolor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
        
        //979797
        static let licenceBorderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        
        //020B2D
        static let MyMentorsUserNameColor = #colorLiteral(red: 0.007843137255, green: 0.0431372549, blue: 0.1764705882, alpha: 1)
        
        //828DA4
        static let MyMentorsCatNameColor = #colorLiteral(red: 0.5098039216, green: 0.5529411765, blue: 0.6431372549, alpha: 1)
        
        //C4CDD5
        static let segmentDotColor = #colorLiteral(red: 0.768627451, green: 0.8039215686, blue: 0.8352941176, alpha: 1)
        
        //#FFFFFF 30
        static let whitecolor30Per = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3046444738)
        
        //#EEF5FB
        static let BackBGColor = #colorLiteral(red: 0.9333333333, green: 0.9607843137, blue: 0.9843137255, alpha: 1)
        
        //#326CDE 12%
        static let GroupCountBGColor = #colorLiteral(red: 0.1960784314, green: 0.4235294118, blue: 0.8705882353, alpha: 0.12)
        
        //#FFFFFF 0%
        static let whitecolor0Per = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        //333232
        static let savedCardColor = #colorLiteral(red: 0.2, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        
        //#FFFFFF 60*
        static let whitecolorAlpha = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        //#FFFFFF 70*
        static let whitecolorAlpha70 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)
        
        //FAFCFE
        static let microColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 0.9960784314, alpha: 1)
        
        //757575
        static let transactionTimeColor = #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        
        //5093FE
        static let transactionPriceColor = #colorLiteral(red: 0.3137254902, green: 0.5764705882, blue: 0.9960784314, alpha: 1)
        
        //#326CDE 10%
        static let transactionDollarBGColor = #colorLiteral(red: 0.1960784314, green: 0.4235294118, blue: 0.8705882353, alpha: 0.1)
        
        //DEDBDB
        static let cardHeaderColor = #colorLiteral(red: 0.8705882353, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        
        //034BB8
        static let progrescolor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.7215686275, alpha: 1)
        
        //404040
        static let aboutVersionColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
        
        //BFBFBF
        static let cardLabelColor = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        
        //636E95
        static let settingSubDescColor = #colorLiteral(red: 0.3882352941, green: 0.431372549, blue: 0.5843137255, alpha: 1)
        
        //369AFE
        static let settingEditBtnColor = #colorLiteral(red: 0.2117647059, green: 0.6039215686, blue: 0.9960784314, alpha: 1)
        
        //666668
        static let profileTextHeaderColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4078431373, alpha: 1)
        
        //E1E0E3
        static let prpfileSepratorColor = #colorLiteral(red: 0.8823529412, green: 0.8784313725, blue: 0.8901960784, alpha: 1)
        
        //ECEFF8
        static let SwitchOffColor = #colorLiteral(red: 0.9254901961, green: 0.937254902, blue: 0.9725490196, alpha: 1)
        
        //5EC298
        static let switchOnColor = #colorLiteral(red: 0.368627451, green: 0.7607843137, blue: 0.5960784314, alpha: 1)
        
        //24272C
        static let sepratorColor2 = #colorLiteral(red: 0.1411764706, green: 0.1529411765, blue: 0.1725490196, alpha: 1)
        
        //5D5D5D
        static let ticketHeadarColor = #colorLiteral(red: 0.3647058824, green: 0.3647058824, blue: 0.3647058824, alpha: 1)
        
        //7ED321
        static let statusTicketColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
        
        //E41E27
        static let statusCloseTicketColor = #colorLiteral(red: 0.8941176471, green: 0.1176470588, blue: 0.1529411765, alpha: 1)
        
        //0052CC
        static let chatBackColor = #colorLiteral(red: 0, green: 0.3215686275, blue: 0.8, alpha: 1)
        //F5F5F5
        static let chatBackColor2 = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
        //FFFFFF
        static let chatTextboxColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.21)
        
        //FFFFFF 45%
        static let copyBackColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.45)
        
        //FFFFFF 40%
        static let White40Per = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        //00DF81
        static let ticketStausColor = #colorLiteral(red: 0, green: 0.8745098039, blue: 0.5058823529, alpha: 1)
        
        //EFF2F7
        static let chatIncomingBackColor = #colorLiteral(red: 0.937254902, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        //56AAFF
        static let chatSendBackColor = #colorLiteral(red: 0.337254902, green: 0.6666666667, blue: 1, alpha: 1)
        
        //171725
        static let notificationTextColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1450980392, alpha: 1)
        
        //F1F1F5
        static let NotificationSepratorColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9607843137, alpha: 1)
        
        //F4F7FF
        static let readStatusColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 1, alpha: 1)
        
        //334150
        static let referEmailColor = #colorLiteral(red: 0.2, green: 0.2549019608, blue: 0.3137254902, alpha: 1)
        
        //323132
        static let referHistoryColor = #colorLiteral(red: 0.1960784314, green: 0.1921568627, blue: 0.1960784314, alpha: 1)
        
        //FC85A3
        static let homeTimeColor = #colorLiteral(red: 0.9882352941, green: 0.5215686275, blue: 0.6392156863, alpha: 1)
        
        //8476CD
        static let homeQuizColor = #colorLiteral(red: 0.5176470588, green: 0.462745098, blue: 0.8039215686, alpha: 1)
        
        //1FD0A3
        static let BookamarkColorHeader = #colorLiteral(red: 0.1215686275, green: 0.8156862745, blue: 0.6392156863, alpha: 1)
        
        //DBF7F0
        static let boomarkBackColor = #colorLiteral(red: 0.8588235294, green: 0.968627451, blue: 0.9411764706, alpha: 1)
        
        //CBDBF7
        static let courseUpgradeColor = #colorLiteral(red: 0.7960784314, green: 0.8588235294, blue: 0.968627451, alpha: 1)
        
        //296DD5
        static let pageControlTintColor = #colorLiteral(red: 0.1607843137, green: 0.4274509804, blue: 0.8352941176, alpha: 0.5)
        
        //000000 18%
        static let shadowColor18PerBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.18)
        
        //3F88EB
        static let PurchaseHistoryColor = #colorLiteral(red: 0.2470588235, green: 0.5333333333, blue: 0.9215686275, alpha: 1)
        
        //EEF2FE
        static let ProgressTrackColor = #colorLiteral(red: 0.9333333333, green: 0.9490196078, blue: 0.9960784314, alpha: 1)
        
        //ECF0FC
        static let UnitStudentBackColor = #colorLiteral(red: 0.9254901961, green: 0.9411764706, blue: 0.9882352941, alpha: 1)
        
        //FF4A77
        static let wrongAnswerColor = #colorLiteral(red: 1, green: 0.2901960784, blue: 0.4666666667, alpha: 1)
        
        //F3F9FF
        static let selectedColorButtonTab = #colorLiteral(red: 0.9529411765, green: 0.9764705882, blue: 1, alpha: 1)
        
//        055F97 28%
        static let shadow28appcolour = #colorLiteral(red: 0.01960784314, green: 0.3725490196, blue: 0.5921568627, alpha: 0.28)
        //FFFFFF
        static let acceptColorButtonText = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //6F27FF
        static let acceptColorButtonBackGround = #colorLiteral(red: 0.4352941176, green: 0.1529411765, blue: 1, alpha: 1)
        
        //#FF0057
        static let rejectColorButtonBackGround = #colorLiteral(red: 1, green: 0, blue: 0.3411764706, alpha: 1)
        
        //#FF0057
        static let viewBreakupTitleColor = #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 0.8)
        
//        E5E6EB
        static let AddcardColor = #colorLiteral(red: 0.8980392157, green: 0.9019607843, blue: 0.9215686275, alpha: 1)
        
        
//        #F45E1C
        static let profilebgColor = #colorLiteral(red: 0.9568627451, green: 0.368627451, blue: 0.1098039216, alpha: 1)
        
        
    }
}

//Alert Control Key
struct AlertControllerKey {

    static let kOpenInMap          = "Open in Apple Maps"
    static let kOpenInGoogleMap    = "Open in Google Maps"
    static let kCopyAddress        = "Copy Address"
    static let kCancel             = "Cancel"
}

// MARK: - User Defaults Key Constant
struct UserDefaultsKey {
    static let kIsLoggedIn      = "isLoggedIn"
    static let kLoginUser       = "loginUser"
    static let kIncognitoCount  = "incognitomodecount"
    static let kIncognitoDate   = "incognitomodedate"
    static let kUserChatID      = "chat_user_id"
    static let kUserFullName    = "user_fullname"
    static let kUserDeviceToken    = "UserDeviceToken"
    static let kSelectedLanguageCode = "SelectedLanguageCode"
    static let kVoipToken = "VoipToken"
    static let kShopInfo = "ShopInfo"
}

struct NotificationPostname {
    static let KAuthenticationTokenExpire = "AuthenticationTokenExpire"
    static let KUpdateProfile = "UpdateProfile"
    static let KReloadHomeScreenData = "ReloadHomeScreenData"
    static let KLocationStatus = "LocationStatus "
    static let kShowFeedDetail = "ShowFeedDetail"
    static let KUpdateNavigationBar = "UpdateNavigationBar"
    static let kSearchClick      = "SearchClick"
    static let kReloadChatConnected = "ReloadChatConnected"
    static let kPushNotification = "PushNotification"
    static let kSocketConnect       = "SocketConnect"
    static let kSearchChatClick      = "SearchChatClick"
    static let kOpenRosterdDetail = "OpenRosterdDetail"
    static let kReferalCoin = "ReferalCoin"
    static let kChangeTabbar = "ChangeTabbar"
}

struct voiceITApiKey {
    static let kAPIKey = "key_067ccd106703471b9d3d54b13a55c68b"
    static let kAPIToken = "tok_725f56b29209465db4fece353bbd35ae"
    static let kPhase = "Saving lives one driver at a time"//"Remember to wash your hands before eating"
    static let kLanguage = "en-AU"
}
/*
//Response StatusCode
enum StatusCode : Int {
    case success = 200,
    passwordInvalid = 104,
    SomthingWentWrong = 400,
    AuthTokenInvalied = 401,
    RecordNotFound = 404,
    OldPasswordWrong = 103,
    EmailAlreadyExist = 102,
    RecordAlreadyExist = 105,
    accountDisaprrove = 106
}

// MARK: - Common Request/Response API Parameter Constant
let kAuthorization = "Authorization"
let kPageNo = "page_no"
let kResult = "Result"
let kMessage = "message"
let kData = "data"
let kStatusCode = "status"
let kTotalCount = "TotalCount"
let kPageSize   = "page_size"
let kFlag = "Flag"*/

//Response StatusCode
enum APIStatusCode : String {
    case success = "1",
    Failure = "0",
    passwordInvalid = "104",
    NoRecord = "6",
    EmailNotAdded = "4",
    AuthTokenInvalied = "2",
    verifyAcccout = "3"
}

// MARK: - Common Request/Response API Parameter Constant
let kAuthorization = "Authorization"
let kPageNo = "page"
let kResult = "Result"
let kMessage = "message"
let kData = "data"
let ktotalPages = "totalPages"
let kStatusCode = "status"
let kstatus = "status"
//let kStatus = "status"
let kTotalCount = "TotalCount"
let kPageSize   = "page_size"
let kFlag = "IsSuccess"
let kRates = "rates"

struct PlatformUtils {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

//MARK: - Notification Observer Strings
struct NotificationObserverStrings {
    static let kReadNotification              = "ReadNotification"
    static let kCloseVideoCall                = "closeVideoCall"
    static let kEndVideoCall                  = "endVideoCall"
    static let kPopVideoCallScreen            = "popVideoCallScreen"
    static let kCallNotReceived               = "callNotReceived"
    static let kCancelCallFromCallKit         = "cancelCallFromCallKit"
   
    
    //Video
    static let kDismissVideoCall              = "DismissVideoCall"
    static let kRejectVideoCall               = "RejectVideoCall"
    static let kAcceptedVideoCall             = "AcceptedVideoCall"
    static let kMissedVideoCall               = "MissedVideoCall"
    //Audio
    static let kDismissAudioCall               = "DismissAudioCall"
    static let kRejectAudioCall               = "RejectAudioCall"
    static let kAcceptedAudioCall             = "AcceptedAudioCall"
    static let kMissedAudioCall               = "MissedAudioCall"
    //For Both
    static let kFinalEndCall                  = "FinalEndCall"
    //Notification
    static let kUpdateBellIconBadge           = "UpdateBellIconBadge"
}

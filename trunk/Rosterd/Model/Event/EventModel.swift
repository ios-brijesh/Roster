//
//  EventModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/04/22.
//

import UIKit

class EventModel: NSObject {
    
    var id : String
    var userId : String
    var categoryId : String
    var name : String
    var eventDate : String
    var startTime : String
    var endTime : String
    var isPaid : String
    var location : String
    var latitude : String
    var longitude : String
     var Description : String
    var createdDate : String
    var updatedDate : String
    var status : String
    var eventDateFormat : String
    var startTimeFormat : String
    var categoryName : String
    var userName : String
    var profileimage : String
    var bookinguserprofileimage : String
    var isFavourite : String
    var endTimeFormat : String
    var shareLink : String
    var thumbprofileimage : String
    var coverImage : String
    var ownEvent : String
    var totalEvent : String
    var thumbcoverImage : String
    var eventCategoryName : String
    var eventLocation : String
    var eventName : String
    var eventId : String
    var userImage : [String]
    var place : String
    var Time : String
    var eventBookingId : String
    var qty : String
    var price : String
    var isBooked : String
    var ticketBookingDetailId : String
    var eventFormetDate : String
    var totalTickets : String
    var ticketId : String
    var qrcodeImageUrl : String
    var eventTicketBooked : String
    var eventTicketRedeemed : String
    var userFollower : String
    var freeTicketSeat : String
    var ticketData : [TicketdataModel]
    var galleryImage : [AddPhotoVideoModel]
    var bookingUserData : [bookingUserDataModel]
    
    init?(dict : [String:Any]){
        
        self.eventTicketBooked = dict["eventTicketBooked"] as? String ?? ""
        self.eventTicketRedeemed = dict["eventTicketRedeemed"] as? String ?? ""
        self.userFollower = dict["userFollower"] as? String ?? ""
        self.qrcodeImageUrl = dict["qrcodeImageUrl"] as? String ?? ""
        self.Time = dict["time"] as? String ?? ""
        self.totalTickets = dict["totalTickets"] as? String ?? ""
        self.eventFormetDate = dict["eventFormetDate"] as? String ?? ""
        self.isBooked = dict["isBooked"] as? String ?? ""
        self.ticketBookingDetailId = dict["ticketBookingDetailId"] as? String ?? ""
        self.price = dict[kprice] as? String ?? ""
        self.qty = dict[kqty] as? String ?? ""
        self.eventBookingId = dict["eventBookingId"] as? String ?? ""
        self.place = dict["place"] as? String ?? ""
        self.userImage = dict["userImage"] as? [String] ?? []
        self.eventId = dict["eventId"] as? String ?? ""
        self.eventName = dict["eventName"] as? String ?? ""
        self.eventLocation = dict["eventLocation"] as? String ?? ""
        self.eventCategoryName = dict["eventCategoryName"] as? String ?? ""
        self.ownEvent = dict["ownEvent"] as? String ?? ""
        self.totalEvent = dict["totalEvent"] as? String ?? ""
        self.id = dict[kid] as? String ?? ""
        self.userId = dict[kuserId] as? String ?? ""
        self.categoryId = dict[kcategoryId] as? String ?? ""
        self.name = dict[kname] as? String ?? ""
        self.eventDate = dict[keventDate] as? String ?? ""
        self.startTime = dict[kstartTime] as? String ?? ""
        self.endTime = dict[kendTime] as? String ?? ""
        self.isPaid = dict[kisPaid] as? String ?? ""
        self.location = dict[klocation] as? String ?? ""
        self.latitude = dict[klatitude] as? String ?? ""
        self.longitude = dict[klongitude] as? String ?? ""
        self.Description = dict[kdescription] as? String ?? ""
        self.createdDate = dict[kcreatedDate] as? String ?? ""
        self.updatedDate = dict[kupdatedDate] as? String ?? ""
        self.status = dict[kstatus] as? String ?? ""
        self.eventDateFormat = dict["eventDateFormat"] as? String ?? ""
        self.startTimeFormat = dict["startTimeFormat"] as? String ?? ""
        self.categoryName = dict[kcategoryName] as? String ?? ""
        self.userName = dict[kuserName] as? String ?? ""
        self.profileimage = dict[kprofileimage] as? String ?? ""
        self.isFavourite = dict[kisFavourite] as? String ?? ""
        self.bookinguserprofileimage = dict[kbookinguserprofileimage] as? String ?? ""
        self.endTimeFormat = dict["endTimeFormat"] as? String ?? ""
        self.shareLink = dict[kshareLink] as? String ?? ""
        self.thumbprofileimage = dict[kthumbprofileimage] as? String ?? ""
        self.coverImage = dict["coverImage"] as? String ?? ""
        self.freeTicketSeat = dict["freeTicketSeat"] as? String ?? ""
        self.thumbcoverImage = dict["thumbcoverImage"] as? String ?? ""
        self.ticketId = dict["ticketId"] as? String ?? ""
        self.bookingUserData = (dict[kbookingUserData] as? [[String:Any]] ?? []).compactMap(bookingUserDataModel.init)
        self.galleryImage = (dict["galleryImage"] as? [[String:Any]] ?? []).compactMap(AddPhotoVideoModel.init)
        self.ticketData = (dict["ticketData"] as? [[String:Any]] ?? []).compactMap(TicketdataModel.init)
        
    }
    
    
    class func SetEvent(withParam param: [String:Any], success withResponse: @escaping (_ Id : String,_ strMessage : String,_ arr : EventModel) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kcreateEvent, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any], let arr = EventModel.init(dict: dataDict) {
                let Id = dataDict["id"] as? String ?? ""
                withResponse(Id,message, arr)
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
    class func EventDashbaord(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [EventModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kEventDashbaord, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(EventModel.init)
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
    
    class func EventticketDetail(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [EventModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kticketDetail, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(EventModel.init)
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
    
    
    class func MyEvent(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [EventModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kmyEvent, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(EventModel.init)
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
    
    class func MyBookEvent(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [EventModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kMyBookEvent, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(EventModel.init)
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
    
    class func setEventlike(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
    
        APIManager.makeRequest(with: AppConstant.API.ksetFavoriteEvent, method: .post, parameter: param, success: {(response) in
          
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
         
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
          
            failure("0",connectionError, .connection)
        })
    }
    
    class func EventDetail(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: EventModel,_ attTicket: [TicketdataModel],_ galleryImage: [AddPhotoVideoModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.keventDetail, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
              
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [String:Any],
                let arr = EventModel.init(dict: dataDict) {
                let attTicket = (dataDict["ticketData"] as? [[String:Any]] ?? []).compactMap(TicketdataModel.init)
                let arrimage = (dataDict["galleryImage"] as? [[String:Any]] ?? []).compactMap(AddPhotoVideoModel.init)
                
                withResponse(arr,attTicket,arrimage,totalPages,message)
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
    
    
    
    class func addEventCart(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String,_ totalAmount : String) -> Void, failure: @escaping FailureBlock) {
        
        //SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kaddEventCart, method: .post, parameter: param, success: {(response) in
            //SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let totalAmount = dict["totalAmount"] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(totalAmount,message)
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
    
    
    class func getEventBookingUser(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ arr: [EventModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kgetEventBookingUser, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                let arr = dataDict.compactMap(EventModel.init)
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
    
}

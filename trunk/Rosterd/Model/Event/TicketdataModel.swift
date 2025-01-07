//
//  TicketdataModel.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/06/22.
//

import UIKit

class TicketdataModel : NSObject {
    
    var price : String
    var qty : String
    var id : String
    var userId : String
    var ticketId : String
    var eventId : String
    var ticketName : String
    var ticketPrice : String
    var totalSeat : String
    var createdDate : String
    var updatedDate : String
    var availabletickets : String
    var isselectTicket : Bool
    var status : String
    var isPaid : String
    var eventName : String
    var totalticketPriceamount : String
    var totalcartPriceamount : String
    var coverImage : String
    var isSelect : Bool = false
    
    // MARK: - init
    init?(dictionary: [String:Any]) {
       
        self.totalcartPriceamount = dictionary["totalcartPriceamount"] as? String ?? ""
        self.totalticketPriceamount = dictionary["totalticketPriceamount"] as? String ?? ""
        self.eventName = dictionary["eventName"] as? String ?? ""
        self.isPaid = dictionary[kisPaid] as? String ?? ""
        self.status = dictionary[kstatus] as? String ?? ""
        self.price = dictionary[kprice] as? String ?? ""
        self.qty = dictionary[kqty] as? String ?? ""
        self.id = dictionary[kid] as? String ?? ""
        self.userId = dictionary[kuserId] as? String ?? ""
        self.ticketId = dictionary[kticketId] as? String ?? ""
        self.eventId = dictionary[keventId] as? String ?? ""
        self.ticketName = dictionary[kticketName] as? String ?? ""
        self.ticketPrice = dictionary[kticketPrice] as? String ?? ""
        self.totalSeat = dictionary[ktotalSeat] as? String ?? ""
        self.createdDate = dictionary[kcreatedDate] as? String ?? ""
        self.updatedDate = dictionary[kupdatedDate] as? String ?? ""
        self.isselectTicket = dictionary["isselectTicket"] as? Bool ?? false
        self.availabletickets = dictionary["availabletickets"] as? String ?? ""
        self.coverImage = dictionary["coverImage"] as? String ?? ""
        self.isSelect = false
    }
    
    init(totalcartPriceamount : String,totalticketPriceamount : String,eventName : String,isPaid : String,status : String,price : String,qty : String,ticketId : String,id : String,userId : String,ticketName : String,ticketPrice : String,totalSeat : String,eventId : String,createdDate : String,updatedDate : String,availabletickets : String,isselectTicket : Bool,coverImage : String){
        self.id = id
        self.userId = userId
        self.ticketName = ticketName
        self.ticketPrice = ticketPrice
        self.totalSeat = totalSeat
        self.eventId = eventId
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.availabletickets = availabletickets
        self.isselectTicket = isselectTicket
        self.ticketId = ticketId
        self.qty = qty
        self.price = price
        self.status = status
        self.isPaid = isPaid
        self.eventName = eventName
        self.totalticketPriceamount = totalticketPriceamount
        self.totalcartPriceamount = totalcartPriceamount
        self.coverImage = coverImage
    }
    
    override init() {
        self.totalcartPriceamount = ""
        self.totalticketPriceamount = ""
        self.eventName = ""
        self.isPaid = ""
        self.status = ""
        self.price = ""
        self.qty = ""
        self.id = ""
        self.ticketId = ""
        self.userId = ""
        self.ticketName = ""
        self.ticketPrice = ""
        self.totalSeat = ""
        self.eventId = ""
        self.createdDate = ""
        self.updatedDate = ""
        self.availabletickets = ""
        self.isselectTicket = false
        self.coverImage = ""
    }
    
    
    
    class func EventcartView(with param: [String:Any]?,isShowLoader : Bool = true, success withResponse: @escaping (_ fee : String,_ subTotal : String,_ total_amount : String,_ arr: [TicketdataModel],_ totalpage : Int,_ msg : String) -> Void, failure: @escaping FailureBlock) {
        if isShowLoader {
            SVProgressHUD.show()
        }
        APIManager.makeRequest(with: AppConstant.API.kEventcartView, method: .post, parameter: param, success: {(response) in
            if isShowLoader {
                SVProgressHUD.dismiss()
            }
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            let totalPages : Int = Int(dict[ktotalPages] as? String ?? "0") ?? 0
            if  isSuccess,let dataDict = dict[kData] as? [[String:Any]] {
                
                let fee = dict["fee"] as? String ?? "0"
                let subTotal = dict["subTotal"] as? String ?? "0"
                let total_amount = dict["totalAmount"] as? String ?? "0"
                
                let arr = dataDict.compactMap(TicketdataModel.init)
            
                withResponse(fee,subTotal,total_amount,arr,totalPages,message)
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
    
    class func EventremoveCart(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kEventremoveCart, method: .post, parameter: param, success: {(response) in
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


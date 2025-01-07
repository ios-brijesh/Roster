//
//  OrderCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 08/06/22.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet weak var lblordernumber: UILabel?
    @IBOutlet weak var lblCode: UILabel?
    
    @IBOutlet weak var lbltotalitems: UILabel?
    @IBOutlet weak var lbltotalamount: UILabel?
    @IBOutlet weak var lblnumberofitems: UILabel?
    @IBOutlet weak var lblprice: UILabel?
    
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblSatus: UILabel?
    
    @IBOutlet weak var vwsatusview: UIView?
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.initConfig()
    }
    
    private func initConfig() {
        
        self.lblordernumber?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 07.0))
        self.lblordernumber?.textColor = UIColor.CustomColor.labelordercolor
        
        self.lbltotalitems?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 09.0))
        self.lbltotalitems?.textColor = UIColor.CustomColor.labelordercolor
        
        self.lbltotalamount?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 09.0))
        self.lbltotalamount?.textColor = UIColor.CustomColor.labelordercolor
        
        
        self.lblnumberofitems?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 09.0))
        self.lblnumberofitems?.textColor = UIColor.CustomColor.ConnectWithColor
        
        self.lblprice?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 09.0))
        self.lblprice?.textColor = UIColor.CustomColor.ConnectWithColor
        
        
        self.lblDate?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 09.0))
        self.lblDate?.textColor = UIColor.CustomColor.ConnectWithColor
        
        
        self.lblCode?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 16.0))
        self.lblCode?.textColor = UIColor.CustomColor.ConnectWithColor
        
        
        self.lblSatus?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 09.0))
        self.lblSatus?.textColor = UIColor.CustomColor.whitecolor
        
        self.vwsatusview?.backgroundColor = UIColor.CustomColor.statusCloseTicketColor
        self.vwsatusview?.cornerRadius = 5.0
        
        
        self.vwMainView?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        self.vwMainView?.cornerRadius = 15.0
    }
    
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupOrderData(obj : ProductOrderModel){
      
        self.lblCode?.text = "RD\(obj.id)"
        self.lblnumberofitems?.text = obj.order_item
        self.lblprice?.text = "$\(obj.totalPrice)"
        self.lblDate?.text = obj.createdDate

        
        if obj.order_status == "2" {
           
            self.lblSatus?.text = "On the Way"
            self.lblSatus?.textColor = UIColor.CustomColor.blackColor
            self.vwsatusview?.backgroundColor = UIColor.CustomColor.whitecolor
        } else if obj.order_status == "1" {
            self.lblSatus?.text = "On the Way"
            self.lblSatus?.textColor = UIColor.CustomColor.blackColor
            self.vwsatusview?.backgroundColor = UIColor.CustomColor.whitecolor
        } else if obj.order_status == "0" {
            
            self.lblSatus?.text = "Order Pleace"
            self.lblSatus?.textColor = UIColor.CustomColor.whitecolor
            self.vwsatusview?.backgroundColor = UIColor.orange
        }
        else if obj.order_status == "3" {
            self.lblSatus?.text = "Delivered"
            self.lblSatus?.textColor = UIColor.CustomColor.whitecolor
            self.vwsatusview?.backgroundColor = UIColor.CustomColor.ticketStausColor
        }
        else if obj.order_status == "4" {
            self.lblSatus?.text = "Cancelled"
            self.vwsatusview?.backgroundColor = UIColor.CustomColor.statusCloseTicketColor
            self.lblSatus?.textColor = UIColor.CustomColor.whitecolor
        }
    }
    
}

// MARK: - NibReusable
extension OrderCell: NibReusable { }

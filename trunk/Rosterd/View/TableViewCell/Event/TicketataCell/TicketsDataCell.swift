//
//  TicketsDataCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 24/06/22.
//

import UIKit

class TicketsDataCell: UITableViewCell {

    
    // MARK: - IBOutlet
    
  
    @IBOutlet weak var vwMAinView: UIView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblTicketname: UILabel!
    @IBOutlet weak var lblAvailableTickets: UILabel!
    @IBOutlet weak var lblTicketPrize: UILabel!
    
    // MARK: - Variables
    
 
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        
        
        self.vwMAinView?.cornerRadius = 17.0
        self.vwMAinView?.backgroundColor = UIColor.CustomColor.viewBGColor
        
        self.lblTicketname?.textColor = UIColor.CustomColor.blackColor
        self.lblTicketname?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        
        self.lblTicketPrize?.textColor = UIColor.CustomColor.blackColor
        self.lblTicketPrize?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 22.0))
        
        self.lblAvailableTickets?.textColor = UIColor.CustomColor.sepretorColor
        self.lblAvailableTickets?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
    }
    
    func SetTicketData(obj : TicketdataModel){
        self.lblTicketname?.text = obj.ticketName
        self.lblAvailableTickets?.text = "\(obj.totalSeat) Available tickets"
        self.lblTicketPrize?.text = "$\(obj.ticketPrice)"
        self.btnSelect?.isSelected = obj.isselectTicket

    }
    
}

// MARK: - NibReusable
extension TicketsDataCell: NibReusable { }

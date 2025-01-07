//
//  TicketChatHeaderCell.swift
//  DDD
//
//  Created by Wdev3 on 05/11/20.
//  Copyright © 2020 Wdev3. All rights reserved.
//

import UIKit

class TicketChatHeaderCell: UITableViewCell {

    // MARK: - IBOutlet
   
    @IBOutlet weak var lblTicketid: UILabel?
   
    @IBOutlet weak var lblTicketTitle: UILabel?
    
    @IBOutlet weak var lblTicketStatus: UILabel?
    
    
    @IBOutlet weak var vwMainContent: UIView?
    
    // MARK: - Variables
   
    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfigure()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }

   
   
       
    
    private func InitConfigure() {
       
        self.lblTicketTitle?.textColor = UIColor.CustomColor.labelTextColor
        self.lblTicketTitle?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 18.0))
        
        
         self.lblTicketStatus?.textColor = UIColor.CustomColor.labelTextColor
         self.lblTicketStatus?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        
         self.lblTicketid?.textColor = UIColor.CustomColor.labelTextColor
         self.lblTicketid?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
    }
}


//extension TicketChatHeaderCell : NibReusable {}
extension TicketChatHeaderCell : NibReusable{}





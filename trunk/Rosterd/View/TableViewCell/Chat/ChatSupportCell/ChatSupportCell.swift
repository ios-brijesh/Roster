//
//  ChatSupportCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 05/02/22.
//

import UIKit

class ChatSupportCell: UITableViewCell {

    @IBOutlet weak var vwBottomview: UIView!
    
    @IBOutlet weak var vwopenSloved: UIView!
    @IBOutlet weak var imgSolved: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    @IBOutlet weak var lblTicketid: UILabel!
    @IBOutlet weak var lblSloved: UILabel!
    @IBOutlet weak var lblShowtime: UILabel!
    @IBOutlet weak var btnReopen: UIButton!
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.InitConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let imgFAQs = self.vwopenSloved {
            imgFAQs.cornerRadius = imgFAQs.frame.height / 2
        }
    }
    
    // MARK: - Init Configure Methods
    private func InitConfig(){
       
        
        self.lblHeader?.textColor = UIColor.CustomColor.labelTextColor
        self.lblHeader?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 15.0))
     
        
        self.lblSubHeader?.textColor = UIColor.CustomColor.labelTextColor
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblShowtime?.textColor = UIColor.CustomColor.followersLabelTextColor
        self.lblShowtime?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblTicketid?.textColor = UIColor.CustomColor.labelTextColor
        self.lblTicketid?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblSloved?.textColor = UIColor.CustomColor.SuccessStaus
        self.lblSloved?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.btnReopen?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.btnReopen?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
        
       
    }
    
    func setupTicketData(obj : SupportChatModel){
        //self.lblTicketTitle.text = obj.title
        self.lblHeader?.text = obj.title
        self.lblSubHeader?.text = obj.SupportDescription
        self.lblShowtime?.text = obj.createdDate
        self.lblTicketid?.text = "Ticket ID: \(obj.id)"
        self.imgProfile?.setImage(withUrl: obj.ticketCategoryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        if obj.status == "0" {
            self.imgSolved?.isHidden = false
            self.lblSloved?.text = "Solved"
            self.lblSloved?.textColor = UIColor.CustomColor.SuccessStaus
            self.vwopenSloved?.isHidden = true
            self.btnReopen?.isHidden = false
            
        }
        else {
            self.imgSolved?.isHidden = true
            self.lblSloved?.text = "Open"
            self.lblSloved?.textColor = UIColor.CustomColor.OpenTicketStatus
            self.vwopenSloved?.isHidden = false
            self.btnReopen?.isHidden = true
        }
    }
    
    
}

// MARK: - NibReusable
extension ChatSupportCell: NibReusable{}


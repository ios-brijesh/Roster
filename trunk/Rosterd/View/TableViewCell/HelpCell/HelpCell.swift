//
//  HelpCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 07/02/22.
//

import UIKit

class HelpCell: UITableViewCell {

    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSunHeder: UILabel?
    @IBOutlet weak var btnKnowMore: UIButton?
    
    
    
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
       
        self.lblHeader?.textColor = UIColor.CustomColor.labelTextColor
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        
        self.lblSunHeder?.textColor = UIColor.CustomColor.aboutDetailColor
        self.lblSunHeder?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.btnKnowMore?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.btnKnowMore?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        
        
       
         
    }
    
    
    func setFaqData(_ data:FAQModel?) {
        if let faqData = data {
            lblHeader?.text = faqData.name
            lblSunHeder?.text = faqData.FAQdescription
        }
    }
}

//extension TicketChatHeaderCell : NibReusable {}
extension HelpCell : NibReusable{}

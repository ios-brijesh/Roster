//
//  FAQsCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 07/02/22.
//

import UIKit

class FAQsCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblnumber: UILabel?
    @IBOutlet weak var lblFAQs: UILabel?
    @IBOutlet weak var vwMainview: UIView!
    
    @IBOutlet weak var btnNext: UIButton?
    @IBOutlet weak var imgFAQs: UIImageView!
    // MARK: - Variables
   
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let imgFAQs = self.imgFAQs {
            imgFAQs.cornerRadius = imgFAQs.frame.height / 2
        }
    }
    
    private func initConfig() {
        
        self.vwMainview?.cornerRadius = 20
        self.vwMainview?.backgroundColor = UIColor.CustomColor.whitecolor
        
        self.lblName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        self.lblName?.textColor = UIColor.CustomColor.blackColor
        
        self.lblnumber?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 30.0))
        self.lblnumber?.textColor = UIColor.CustomColor.blackColor
        
        self.lblFAQs?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 15.0))
        self.lblFAQs?.textColor = UIColor.CustomColor.blackColor
        
       
        
        if let btnNext = self.btnNext {
            btnNext.clipsToBounds = true
            btnNext.cornerRadius = btnNext.frame.height / 2
            btnNext.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            btnNext.maskToBounds = false
        }
    }
    
    func SetFaqCategoryData(obj : TicketFaqModel) {
        
        self.lblName?.text = obj.name
        self.lblnumber?.text = obj.faqCount
        self.imgFAQs?.setImage(withUrl: obj.thumbFaqCategoryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
    }

}

// MARK: - NibReusable
extension FAQsCell: NibReusable { }

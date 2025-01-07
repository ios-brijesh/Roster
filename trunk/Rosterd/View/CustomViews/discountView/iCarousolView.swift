//
//  iCarousolView.swift
//  BidaShift
//
//  Created by Haresh Flynaut on 18/08/22.
//

import UIKit

class iCarousolView: UIView {

    @IBOutlet weak var vwmainview: UIView?
    @IBOutlet weak var vwcodeview: UIView?
    @IBOutlet weak var vwImageview: UIView!
    @IBOutlet weak var img_Brand: UIImageView!
    
    
    @IBOutlet weak var imgBrand: UIImageView?
    @IBOutlet weak var lblDesc: UILabel?
    @IBOutlet weak var lblpresentage: UILabel?
    @IBOutlet weak var lbloff: UILabel?
    @IBOutlet weak var lblcode: UILabel?
    @IBOutlet weak var lblexpiredate: UILabel?
    
    
    @IBOutlet weak var btnvisitwebsite: UIButton?
//    var trendingData:TrendingPetitionModel?
    
    var coupendata:GiftCoupenModel?
    override  func awakeFromNib() {
        super.awakeFromNib()
        InitConfig()
    }
    
    // MARK: - Init Configure
    private func InitConfig(){
        
        self.lblDesc?.textColor = UIColor.CustomColor.blackColor
        self.lblDesc?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        
        self.lblpresentage?.textColor = UIColor.CustomColor.blackColor
        self.lblpresentage?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 30.0))
        
        self.lbloff?.textColor = UIColor.CustomColor.blackColor
        self.lbloff?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 25.0))
        
        self.lblcode?.textColor = UIColor.CustomColor.blackColor
        self.lblcode?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        
        self.lblexpiredate?.textColor = UIColor.CustomColor.sepretorColor
        self.lblexpiredate?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        self.btnvisitwebsite?.backgroundColor = UIColor.CustomColor.appColor
        self.btnvisitwebsite?.cornerRadius = 15.0
        
//        self.lblpresentage?.setMembershipPriceAttributedTextLable(firstText: "20%\n", SecondText:"off")
        
        self.btnvisitwebsite?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.btnvisitwebsite?.setTitleColor(UIColor.CustomColor.whitecolor, for: .normal)
        
        
        self.vwcodeview?.backgroundColor = UIColor.CustomColor.viewBGColor
        self.vwcodeview?.cornerRadius = 22.0
        
        self.vwmainview?.cornerRadius = 15.0
        self.vwmainview?.shadow(UIColor.CustomColor.shadowColorFivePerBlack, radius: 15.0, offset: CGSize(width: 0, height: 1), opacity: 1)
        self.vwmainview?.maskToBounds = false
        self.vwmainview?.backgroundColor = UIColor.CustomColor.whitecolor
        
        
        self.vwImageview?.cornerRadius = 15.0
        self.vwImageview?.shadow(UIColor.CustomColor.appColor, radius: 15.0, offset: CGSize(width: 0, height: 0), opacity: 1)
        self.vwImageview?.maskToBounds = false
        self.vwImageview?.backgroundColor = UIColor.CustomColor.whitecolor
        
        
        
    
    
    }
    
    func setCoupoenData() {
     
        if let CoupenData = coupendata {
            
            lblDesc?.text = CoupenData.coupendescription
            lblpresentage?.text = "\(CoupenData.offerPercentage)%"
            lblcode?.text = CoupenData.couponCode
            lblexpiredate?.text = "Expires\(CoupenData.expiryDate)"
            self.imgBrand?.setImage(withUrl: CoupenData.offerImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.img_Brand?.setImage(withUrl: CoupenData.offerImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
    }
    
}

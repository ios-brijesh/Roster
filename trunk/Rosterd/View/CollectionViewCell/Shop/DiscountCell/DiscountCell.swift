//
//  DiscountCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/01/22.
//

import UIKit

class DiscountCell: UICollectionViewCell {

    @IBOutlet weak var lblTopRanking: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet weak var img_Product: UIImageView!
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let vw = self.vwMainView {
            vw.cornerRadius = 40.0
            vw.backgroundColor = GradientColor(gradientStyle: .leftToRight, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
    }
    
    private func initConfig() {
        
        self.lblTopRanking?.textColor = UIColor.CustomColor.whitecolor
        self.lblTopRanking?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblDiscount?.textColor = UIColor.CustomColor.whitecolor
        self.lblDiscount?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 22.0))
        
        
        
    }
    
    func setupData(obj : AdvertiseModel) {
      
        self.img_Product?.setImage(withUrl: obj.advImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblDiscount?.text = obj.Description
        
    }
}

// MARK: - NibReusable
extension DiscountCell: NibReusable { }

//
//  HomeSliderImageViewCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 11/07/22.
//

import UIKit

class HomeSliderImageViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var vwMain: UIView?
    
    @IBOutlet weak var imgAdv: UIImageView?
    @IBOutlet weak var btnPost: UIButton!
    
    @IBOutlet weak var lblType: UILabel?
    @IBOutlet weak var lblValue: UILabel?
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
      
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
      
            if let img = self.imgAdv {
                img.cornerRadius = 18.0
            }
            if let vw = self.vwMain {
                vw.cornerRadius = 18.0
            }
        
        self.lblType?.font = UIFont.PoppinsSemiBoldItalic(ofSize: GetAppFontSize(size: 10.0))
        self.lblType?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblValue?.font = UIFont.PoppinsItalic(ofSize: GetAppFontSize(size: 14.0))
        self.lblValue?.textColor = UIColor.CustomColor.whitecolor
       
    }
    
    func setAdvData(obj : AdvertiseModel) {
        self.imgAdv?.setImage(withUrl: obj.advImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblType?.text = obj.name
        self.lblValue?.text = obj.Description
      
    }
    
}
    
    
    
// MARK: - NibReusable
extension HomeSliderImageViewCell: NibReusable { }

    
    



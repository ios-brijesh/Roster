//
//  ProductFilterCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 25/07/22.
//

import UIKit

class ProductFilterCell: UICollectionViewCell {

    @IBOutlet weak var vwimageview: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblbrandName: UILabel!
    @IBOutlet weak var lblBrandCategory: UILabel!
    @IBOutlet weak var lblBrandPrize: UILabel!
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    
      
        
    }
    private func initConfig() {
        
        self.lblbrandName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblbrandName?.textColor = UIColor.CustomColor.placeholderapp760
        
        self.lblBrandCategory?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
        self.lblBrandCategory?.textColor = UIColor.CustomColor.blackColor
        
        self.lblBrandPrize?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblBrandPrize?.textColor = UIColor.CustomColor.viewAllColor
        
        self.vwimageview?.borderColor = UIColor.CustomColor.sepratorFeedColor
        self.vwimageview?.borderWidth = 1.0
        self.vwimageview?.cornerRadius = 17.0
        
    }
    
    
    func SetOtherData(obj : productModel){
     
        self.lblbrandName?.text = obj.product_brand_name
        self.lblBrandCategory?.text = obj.name
        self.lblBrandPrize?.text = "$\(obj.price)"
        self.imgProduct?.setImage(withUrl: obj.productImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
    }
}


// MARK: - NibReusable
extension ProductFilterCell: NibReusable { }

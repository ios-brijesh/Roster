//
//  InformationCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/01/22.
//

import UIKit

class InformationCell: UICollectionViewCell {

    @IBOutlet weak var vwMainView: UIView?
    @IBOutlet weak var lblCategory: UILabel?
    @IBOutlet weak var lblBrandName: UILabel?
    @IBOutlet weak var lblBrandType: UILabel?
    @IBOutlet weak var lblPrice: UILabel?
    
    @IBOutlet weak var imgProduct: UIImageView?
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    
        
    }
    
    private func initConfig() {
        
        self.vwMainView?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        self.vwMainView?.cornerRadius = 35
        
        self.lblCategory?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblCategory?.textColor = UIColor.CustomColor.placeholderapp760
        
        self.lblBrandName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 18.0))
        self.lblBrandName?.textColor = UIColor.CustomColor.placeholderapp
        
        self.lblBrandType?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 18.0))
        self.lblBrandType?.textColor = UIColor.CustomColor.placeholderapp
        
        self.lblPrice?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 24.0))
        self.lblPrice?.textColor = UIColor.CustomColor.placeholderapp
        
       
    }
    
    func setBrandData(obj : productModel){
        self.lblCategory?.text = obj.product_category_name
        self.lblBrandName?.text = obj.product_brand_name
        self.lblBrandType?.text = obj.name
        self.lblPrice?.text = "$\(obj.price)"
        self.imgProduct?.setImage(withUrl: obj.productImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
        
    }

}

// MARK: - NibReusable
extension InformationCell: NibReusable { }

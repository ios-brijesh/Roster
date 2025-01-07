//
//  OtherCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 24/01/22.
//

import UIKit

protocol  ProductCellDelegate {

    func btnLikeSelect(btn : UIButton,cell : OtherCell)
}

class OtherCell: UICollectionViewCell {
    
    @IBOutlet weak var imgShoes: UIImageView!
    
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblType: UILabel?
    @IBOutlet weak var lblPrice: UILabel?
    @IBOutlet weak var vwMainview: UIView?
    @IBOutlet weak var VwLikeView: UIView?
    
    @IBOutlet weak var btnLike: UIButton?
    var Delegate : ProductCellDelegate?
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
      
        
    }
    
    private func initConfig() {
        
        self.vwMainview?.backgroundColor = UIColor.CustomColor.acceptColorButtonText
        if  let vwMainview = self.vwMainview {
            vwMainview.clipsToBounds = true
            vwMainview.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwMainview.maskToBounds = false
            vwMainview.cornerRadius = 10.0

        }
        
        self.lblName?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 12.0))
        self.lblName?.textColor = UIColor.CustomColor.ShoesName
        
        self.lblType?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 10.0))
        self.lblType?.textColor = UIColor.CustomColor.ShoesName
        
        self.lblPrice?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblPrice?.textColor = UIColor.CustomColor.placeholderapp
        
        if let vw = self.imgShoes {
            vw.roundCorners(corners: [.topLeft,.topRight], radius: 10.0)
        }
    }
    
    func SetOtherData(obj : productModel){
     
        self.lblName?.text = obj.product_brand_name
        self.lblType?.text = obj.name
        self.lblPrice?.text = "$\(obj.price)"
        self.imgShoes?.setImage(withUrl: obj.productImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
    }
    
    func SetFavoriteData(obj : productModel){
     
        self.lblName?.text = obj.product_brand_name
        self.lblType?.text = obj.name
        self.lblPrice?.text = "$\(obj.price)"
        self.btnLike?.isSelected = obj.isLike == "1"
        self.imgShoes?.setImage(withUrl: obj.primaryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
    }

    @IBAction func btnlikeClicked(_ sender : UIButton) {
     
        if let btn = self.btnLike {
            self.btnLike?.isSelected = !(self.btnLike?.isSelected ?? false)
            self.Delegate?.btnLikeSelect(btn: btn, cell: self)
           
        }
    }
}

// MARK: - NibReusable
extension OtherCell: NibReusable { }

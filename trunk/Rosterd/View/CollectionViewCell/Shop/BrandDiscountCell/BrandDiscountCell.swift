//
//  BrandDiscountCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 25/08/22.
//

import UIKit

class BrandDiscountCell: UICollectionViewCell {

    @IBOutlet weak var VwImageView: UIView!
    @IBOutlet weak var vwLeftview: UIView!
    @IBOutlet weak var VwBottomView: UIView!
    @IBOutlet weak var vwRightView: UIView!
    
    @IBOutlet weak var img_Brand: UIImageView!
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    
      
        
    }
    private func initConfig() {
        
        self.vwLeftview?.backgroundColor = UIColor.CustomColor.borderColor
        self.VwBottomView?.backgroundColor = UIColor.CustomColor.borderColor
        self.vwRightView?.backgroundColor = UIColor.CustomColor.borderColor
        
        
        
        
    }
}
// MARK: - NibReusable
extension BrandDiscountCell: NibReusable { }

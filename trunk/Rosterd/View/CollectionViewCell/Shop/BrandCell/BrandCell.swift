//
//  BrandCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/01/22.
//

import UIKit

class BrandCell: UICollectionViewCell {

    @IBOutlet weak var img_brand: UIImageView?
    @IBOutlet weak var lblbrandname: UILabel?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
       
        
    }
    
    private func initConfig() {
        
        
       
    }

    
    func setBrandiconData(obj : CategoryModel){
      
        self.lblbrandname?.text = obj.name
    
        self.img_brand?.setImage(withUrl: obj.brandfullimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
        
    }
}

// MARK: - NibReusable
extension BrandCell: NibReusable { }

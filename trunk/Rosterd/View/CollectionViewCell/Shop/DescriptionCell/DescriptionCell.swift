//
//  DescriptionCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 05/04/22.
//

import UIKit

class DescriptionCell: UICollectionViewCell {

    @IBOutlet weak var lblValue: UILabel?
    @IBOutlet weak var lblSubValue: UILabel?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    
      
        
    }
    
    private func initConfig() {
        
       
    
        self.lblValue?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblValue?.textColor = UIColor.CustomColor.blackColor
        
        
        self.lblSubValue?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblSubValue?.textColor = UIColor.CustomColor.blackColor
        
    }
    
    func setProductspecification(obj : productSpecificationModel) {
        
        self.lblValue?.text = obj.label
        self.lblSubValue?.text = obj.value
    }
    
    
    

}

// MARK: - NibReusable
extension DescriptionCell: NibReusable { }

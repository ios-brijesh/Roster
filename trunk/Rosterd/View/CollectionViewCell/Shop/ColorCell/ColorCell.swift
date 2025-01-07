//
//  ColorCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 27/01/22.
//

import UIKit

class ColorCell: UICollectionViewCell {

    
    @IBOutlet weak var vwMainview: UIView?
    @IBOutlet weak var vwColorview: UIView?
    
    
    var isselectColourCell : Bool = false {
        didSet{
            self.vwMainview?.borderColor = isselectColourCell ? UIColor.CustomColor.blackColor : UIColor.clear
            self.vwMainview?.cornerRadius = isselectColourCell ? 18.0 : 25.0
            self.vwMainview?.borderWidth = isselectColourCell ? 1.0 : 1.0
        }
    }
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        if let vwMainview = self.vwMainview {
//            vwMainview.cornerRadius = vwMainview.frame.height / 2
//        }
      
        if let vwColorview = self.vwColorview {
            vwColorview.cornerRadius = vwColorview.frame.height / 2
        }
      
        
    }
    
    private func initConfig() {
        
        if let vwColorview = self.vwColorview {
            vwColorview.clipsToBounds = true
            vwColorview.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwColorview.maskToBounds = false
        }



    }
    
    func setcolordata(obj : VariationModel) {
        
        self.vwColorview?.backgroundColor = Rosterd.sharedInstance.hexStringToUIColor(hex: obj.shade_color_code)
    }
    
    
    func setFiltercolordata(obj : ColorModel) {
        
        self.vwColorview?.backgroundColor = Rosterd.sharedInstance.hexStringToUIColor(hex: obj.color)
    }
    

}


// MARK: - NibReusable
extension ColorCell: NibReusable { }

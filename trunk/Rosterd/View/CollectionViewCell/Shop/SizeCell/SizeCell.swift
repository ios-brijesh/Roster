//
//  SizeCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 27/01/22.
//

import UIKit

class SizeCell: UICollectionViewCell {

    @IBOutlet weak var vwMainView: UIView?
    @IBOutlet weak var lblSize: UILabel?
    
    
    var isselectCell : Bool = false {
        didSet{
            self.vwMainView?.backgroundColor = isselectCell ? UIColor.CustomColor.blackColor : UIColor.clear
        }
    }
   
  
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
        self.isselectCell = false
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let vwMainView = self.vwMainView {
            vwMainView.cornerRadius = vwMainView.frame.height / 2
        }
        
      
        
    }
    
    private func initConfig() {
        
        
       
        if let vwMainview = self.vwMainView {
//            vwMainview.cornerRadius = (vwMainview.frame.height ) / 2
            vwMainview.borderWidth = 1.5
            vwMainview.borderColor = UIColor.CustomColor.blackColor
            
        }
        
        self.lblSize?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        self.lblSize?.textColor = UIColor.CustomColor.blackColor
        
    }
    
    func setSizedata(obj : SizeModel) {
        
        self.lblSize?.text = obj.name
    }
    

}

// MARK: - NibReusable
extension SizeCell: NibReusable { }

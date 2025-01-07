//
//  TabCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/01/22.
//

import UIKit

class TabCell: UICollectionViewCell {

    @IBOutlet weak var lblTab: UILabel!
    
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
        
        self.lblTab?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblTab?.textColor = UIColor.CustomColor.labelTextColor
       
    }

}

// MARK: - NibReusable
extension TabCell: NibReusable { }

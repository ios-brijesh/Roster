//
//  HeaderAdressCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/05/22.
//

import UIKit

class HeaderAdressCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var vwMainview: UIView?
    
    @IBOutlet weak var lblDefaultadd: UILabel?
    @IBOutlet weak var lblDetailadd: UILabel?
    
    @IBOutlet weak var btnEdit: UIButton?
    // MARK: - Variables
    
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
        self.lblDetailadd?.textColor = UIColor.CustomColor.labelTextColor
        self.lblDetailadd?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 11.0))
        
        self.lblDefaultadd?.textColor = UIColor.CustomColor.addressLabelTextColor
        self.lblDefaultadd?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 11.0))
        
        self.btnEdit?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnEdit?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        
        self.vwMainview?.cornerRadius = 14.0
        self.vwMainview?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
    }
}

// MARK: - NibReusable
extension HeaderAdressCell: NibReusable { }

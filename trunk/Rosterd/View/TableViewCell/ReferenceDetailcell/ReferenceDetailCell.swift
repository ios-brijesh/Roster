//
//  ReferenceDetailCell.swift
//  Rosterd
//
//  Created by iMac on 02/05/23.
//

import UIKit

class ReferenceDetailCell: UITableViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var vwSepratoe: UIView?
    @IBOutlet weak var lblCoachname: UILabel?
    @IBOutlet weak var lblAcademic: UILabel?
    @IBOutlet weak var lblEmail: UILabel?
    @IBOutlet weak var lblPhone: UILabel?
    @IBOutlet var lblHeder : [UILabel]?
    // MARK: - Variables
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initConfig() {
        self.lblHeder?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        })
        
        [self.lblAcademic,self.lblEmail,self.lblPhone].forEach({
            $0?.textColor = UIColor.CustomColor.labelTextColor
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        self.lblCoachname?.textColor = UIColor.CustomColor.viewAllColor
        self.lblCoachname?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 16.0))
    }
}

// MARK: - NibReusable
extension ReferenceDetailCell: NibReusable { }

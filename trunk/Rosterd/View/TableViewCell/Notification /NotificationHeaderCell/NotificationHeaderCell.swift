//
//  NotificationHeaderCell.swift
//  LightOnLeadership
//
//  Created by Harshad on 19/02/22.
//

import UIKit

class NotificationHeaderCell: UITableViewHeaderFooterView {

    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    
    
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
        self.lblHeader?.textColor = UIColor.CustomColor.labelTextColor
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 18.0))
    }
}

// MARK: - NibReusable
extension NotificationHeaderCell: NibReusable { }

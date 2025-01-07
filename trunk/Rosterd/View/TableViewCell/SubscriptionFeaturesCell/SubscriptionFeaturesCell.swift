//
//  SubscriptionFeaturesCell.swift
//  Rosterd
//
//  Created by Haresh Flynaut on 22/06/23.
//

import UIKit

class SubscriptionFeaturesCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var lblFeatureText: UILabel?
    
    // MARK: - Variables
    
    // MARK: - Lefe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initConfig() {
        self.lblFeatureText?.textColor = UIColor.CustomColor.headerBackColor
        self.lblFeatureText?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
    }
    
}

// MARK: - NibReusable
extension SubscriptionFeaturesCell: NibReusable { }

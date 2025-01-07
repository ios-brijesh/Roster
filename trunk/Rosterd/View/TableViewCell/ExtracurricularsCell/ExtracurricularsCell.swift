//
//  ExtracurricularsCell.swift
//  Rosterd
//
//  Created by iMac on 28/04/23.
//

import UIKit

class ExtracurricularsCell: UITableViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var lblValue: UILabel?
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
        self.lblValue?.textColor = UIColor.CustomColor.labelTextColor
        self.lblValue?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
    }
    
}
// MARK: - NibReusable
extension ExtracurricularsCell: NibReusable { }

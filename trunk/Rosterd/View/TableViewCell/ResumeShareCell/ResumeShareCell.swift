//
//  ResumeShareCell.swift
//  Rosterd
//
//  Created by iMac on 03/05/23.
//

import UIKit

class ResumeShareCell: UITableViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var imgProfile: UIImageView?
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblFollower: UILabel?
    @IBOutlet weak var btnShare: UIButton?
    // MARK: - Variables
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let imgSuggestion = self.imgProfile {
            imgSuggestion.cornerRadius = imgSuggestion.frame.height / 2
        }
    }
    private func initConfig() {
        
        self.lblFollower?.textColor = UIColor.CustomColor.followersLabelTextColor
        self.lblFollower?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        self.lblName?.textColor = UIColor.CustomColor.messageColor
        self.lblName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        self.btnShare?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.btnShare?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
    }
}

// MARK: - NibReusable
extension ResumeShareCell: NibReusable { }

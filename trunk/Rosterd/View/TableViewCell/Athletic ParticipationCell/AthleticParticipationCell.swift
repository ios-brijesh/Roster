//
//  Athletic ParticipationCell.swift
//  Rosterd
//
//  Created by iMac on 28/04/23.
//

import UIKit

class AthleticParticipationCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet var lblHeader : [UILabel]?
    @IBOutlet weak var lblSport : UILabel?
    @IBOutlet weak var lblTeam : UILabel?
    @IBOutlet weak var lblPosition : UILabel?
   
    @IBOutlet weak var vwSeprate: UIView?
    @IBOutlet weak var vwDownView: UIView?
    @IBOutlet weak var vwUpView: UIView?
    // MARK: - Variables
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initConfig() {
        
        [self.lblTeam,self.lblPosition].forEach({
            $0?.textColor = UIColor.CustomColor.labelTextColor
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.lblSport?.textColor = UIColor.CustomColor.viewAllColor
        self.lblSport?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 16.0))
        
        self.lblHeader?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        })
    }
}

// MARK: - NibReusable
extension AthleticParticipationCell: NibReusable { }

//
//  SportParticipationCell.swift
//  Rosterd
//
//  Created by WM-KP on 07/01/22.
//

import UIKit

class SportParticipationCell: UICollectionViewCell {

    @IBOutlet weak var lblSportsName: UILabel?
    @IBOutlet weak var btnClose: UIButton?
    @IBOutlet weak var vwBGMain: UIView?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.vwBGMain?.setCornerRadius(withBorder: 1, borderColor: UIColor.CustomColor.appColor, cornerRadius: (vwBGMain?.frame.height ?? 0.0) / 2)
    }
    
    private func initConfig() {
        self.lblSportsName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSportsName?.textColor = UIColor.CustomColor.appColor
    }

    func setSelectSport(obj : SportsModel) {
        self.lblSportsName?.text = obj.name
        
    }
    
    
}

// MARK: - NibReusable
extension SportParticipationCell: NibReusable { }

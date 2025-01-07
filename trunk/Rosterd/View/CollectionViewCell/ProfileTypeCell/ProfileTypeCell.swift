//
//  ProfileTypeCell.swift
//  Rosterd
//
//  Created by WM-KP on 07/01/22.
//

import UIKit

class ProfileTypeCell: UICollectionViewCell {

    @IBOutlet weak var lblProfileTitle: UILabel?
    @IBOutlet weak var imgProfileType: UIImageView?
    @IBOutlet weak var vwMainBG: UIView?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    private func initConfig() {
    }

}

// MARK: - NibReusable
extension ProfileTypeCell: NibReusable { }

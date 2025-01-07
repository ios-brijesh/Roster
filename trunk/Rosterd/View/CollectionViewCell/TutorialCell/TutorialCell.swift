//
//  TutorialCell.swift
//  DDD
//
//  Created by Wdev3 on 30/10/20.
//  Copyright © 2020 Wdev3. All rights reserved.
//

import UIKit

class TutorialCell: UICollectionViewCell {

    @IBOutlet weak var imgTutorial: UIImageView!
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeaderDesc: UILabel!
    @IBOutlet weak var btnNext: UIButton!
   
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
        self.lblHeader.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 30.0))
        self.lblHeader.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblHeaderDesc.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblHeaderDesc.textColor = UIColor.CustomColor.subHeaderTextColor
    }
    
    func setupData(obj : TutorialImages) {
        self.lblHeader.text = obj.HeaderName
        self.lblHeaderDesc.text = obj.HeaderDescName
        self.imgTutorial.image = obj.img
    }
}

// MARK: - NibReusable
extension TutorialCell: NibReusable { }

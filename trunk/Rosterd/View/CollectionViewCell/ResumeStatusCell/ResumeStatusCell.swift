//
//  ResumeStatusCell.swift
//  Rosterd
//
//  Created by iMac on 21/04/23.
//

import UIKit

class ResumeStatusCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var vwStatus: UIView!
    
    // MARK: - Variables
    var isSelectedStatus : Bool = false {
        didSet{
            self.vwStatus.backgroundColor = isSelectedStatus ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.White40Per
        }
    }
    
    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    private func InitConfig() {
        delay(seconds: 0.1) {
            self.vwStatus.cornerRadius = self.vwStatus.frame.height/2
        }
       
        //
    }

}

extension ResumeStatusCell : NibReusable{}

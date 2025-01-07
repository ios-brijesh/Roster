//
//  NotificationPhotoCell.swift
//  LightOnLeadership
//
//  Created by Harshad on 19/02/22.
//

import UIKit

class NotificationPhotoCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var vwMain: UIView?
    
    @IBOutlet weak var imgPhoto: UIImageView?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        self.vwMain?.cornerRadius = 10.0
        self.imgPhoto?.cornerRadius = 10.0
    }
}

// MARK: - NibReusable
extension NotificationPhotoCell: NibReusable { }

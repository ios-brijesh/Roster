//
//  ViewallEventCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/12/22.
//

import UIKit

class ViewallEventCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var imgUser: UIImageView?
    
    @IBOutlet weak var lblUserName: UILabel?
    
    // MARK: - Variables

    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let imgUser = self.imgUser {
            imgUser.cornerRadius = imgUser.frame.height / 2
        }
    }
    
    private func initConfig() {
        
        self.lblUserName?.textColor = UIColor.CustomColor.blackColor
        self.lblUserName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
    }
}
// MARK: - NibReusable
extension ViewallEventCell: NibReusable { }

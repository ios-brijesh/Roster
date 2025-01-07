//
//  MenuCell.swift
//  Momentor
//
//  Created by Wdev3 on 17/02/21.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initConfig(){
        self.lblMenuName.textColor = UIColor.CustomColor.blackColor
        self.lblMenuName.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 10.0))
    }
}

// MARK: - NibReusable
extension MenuCell: NibReusable { }

//
//  ProfileCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/01/22.
//

import UIKit

class ProfileCell: UITableViewCell {

    
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
      
    }
    
}

// MARK: - NibReusable
extension ProfileCell: NibReusable { }



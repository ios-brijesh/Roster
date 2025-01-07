//
//  StoryViewCell.swift
//  Intro
//
//  Created by WM-KP on 13/12/21.
//  Copyright © 2021 Developer. All rights reserved.
//

import UIKit

class StoryViewCell: UITableViewCell {

    @IBOutlet weak var vwCheckBox: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnShareCheckBox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setViewStoryData(_ data:ModelViewStory?) {
        if let storyInfo = data {
            vwCheckBox.isHidden = true
            self.imgProfile?.setImage(withUrl: storyInfo.userProfileThumbImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.lblUserName.text = storyInfo.userName
        }
    }
    
    func setShareFriendsData(_ data:ModelUserListNew?) {
        if let storyInfo = data {
            vwCheckBox.isHidden = false
            self.imgProfile?.setImage(withUrl: storyInfo.userThumbImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            
            self.lblUserName.text = storyInfo.userName
        }
    }
    
}


// MARK: - NibReusables
extension StoryViewCell: NibReusable { }


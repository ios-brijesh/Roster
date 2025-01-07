//
//  HomeStoryCell.swift
//  Rosterd
//
//  Created by wm-devIOShp on 22/01/22.
//

import UIKit

class HomeStoryCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imgStory: UIImageView?
    @IBOutlet weak var vwMain: UIView?
    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet weak var vwYourStoryBGMain: UIView?
    @IBOutlet weak var vwYourStoryBGSub: UIView?
    @IBOutlet weak var lblUserName: UILabel?
    @IBOutlet weak var lblStoryUserName: UILabel?
    
    @IBOutlet weak var vwUserProfileMain: UIView?
    @IBOutlet weak var imgUserProfile: UIImageView?
    
    @IBOutlet weak var btnusername: UIButton!
    @IBOutlet weak var btnAddStory: UIButton!
    @IBOutlet weak var stackUserStoryMain: UIStackView?
    // MARK: - Variables
    var isYourStory : Bool = false {
        didSet{
            self.vwYourStoryBGMain?.isHidden = !isYourStory
            //            self.stackUserStoryMain?.isHidden = isYourStory
            self.lblUserName?.text = isYourStory ? "Add Story" : "username"
            self.vwUserProfileMain?.isHidden = isYourStory
            
        }
    }
    
    var isFromViewAllStory : Bool = false {
        didSet{
            self.vwYourStoryBGMain?.isHidden = true
            self.stackUserStoryMain?.isHidden = false
            self.lblStoryUserName?.text = "username"
            self.lblUserName?.isHidden = true
        }
    }
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let img = self.imgUserProfile {
            img.cornerRadius = img.frame.height / 2.0
        }
    }
    
    private func initConfig() {
        self.lblUserName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 10.0))
        self.lblUserName?.textColor = UIColor.CustomColor.viewAllColor
        self.lblStoryUserName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 10.0))
        self.lblStoryUserName?.textColor = UIColor.CustomColor.whitecolor
        self.imgStory?.cornerRadius = 18.0
        self.vwYourStoryBGSub?.cornerRadius = 18.0
        self.vwMain?.cornerRadius = 18.0
        self.vwMain?.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
    }
    
    func setStoryData(obj : StoryModel) {
        self.imgStory?.setImage(withUrl: obj.isVideo ? obj.thumbStoryVideoThumbImage :  obj.mediaUrl, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.imgUserProfile?.setImage(withUrl: obj.userProfileThumbImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblUserName?.text = obj.userName
    }
    
    func setViewAllStoryData(obj : StoryModel) {
        
        self.imgStory?.setImage(withUrl: obj.isVideo ? obj.thumbStoryVideoThumbImage :  obj.mediaUrl, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.imgUserProfile?.setImage(withUrl: obj.userProfileThumbImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblUserName?.text = obj.userName
        self.lblStoryUserName?.text = obj.userName
        
    }
}

// MARK: - NibReusables
extension HomeStoryCell: NibReusable { }


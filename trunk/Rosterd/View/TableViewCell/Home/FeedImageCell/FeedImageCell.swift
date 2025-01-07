//
//  FeedImageCell.swift
//  Momentor
//
//  Created by wmdevios-h on 20/09/21.
//

import UIKit


class FeedImageCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var vwMain: UIView?
    @IBOutlet weak var imgVideoPost : UIImageView?
    @IBOutlet weak var imgFeed: UIImageView?
    @IBOutlet weak var btnPost: UIButton!
    
    
    // MARK: - Variables
  
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.contentView.clipsToBounds = true
        self.contentView.cornerRadius = 34.0
        //self.contentView.shadow(UIColor.CustomColor.shadowColorBlack, radius: 5.0, offset: CGSize(width: 4, height: 2), opacity: 1)
        self.contentView.maskToBounds = false
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        //delay(seconds: 0.2) {
            if let img = self.imgFeed {
                img.cornerRadius = 34.0
            }
            if let vw = self.vwMain {
                vw.cornerRadius = 34.0
            }
        //}
    }
//    func setImagevideoData(obj : AddPhotoVideoModel) {
//        self.imgFeed?.setImage(withUrl: obj.isVideo ? obj.thumbpostvideoThumbImage :  obj.postimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
//
//    }
  
}

// MARK: - NibReusable
extension FeedImageCell: NibReusable { }

//
//  HighlightsCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/12/22.
//

import UIKit

class HighlightsCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var vwPlusView: UIView?
    @IBOutlet weak var VwMainimageView: UIView?
    @IBOutlet weak var VwMainView: UIView!
    
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var imgVideo: UIImageView?
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnVideo: UIButton?
    @IBOutlet weak var btnImage: UIButton?
    @IBOutlet weak var btnPlus: UIButton?
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
        
        self.vwPlusView?.borderColor = UIColor.CustomColor.yesnoColor
        self.vwPlusView?.borderWidth = 1.0
        self.vwPlusView?.cornerRadius = 13.0
//        self.VwMainimageView?.cornerRadius = 13.0
//        self.VwMainView?.cornerRadius = 13.0
        
        self.lblName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblName?.textColor = UIColor.CustomColor.blackColor
    }

    func setHighlightsData(obj : AddPhotoVideoModel) {
        if obj.name == "" {
            self.lblName?.isHidden = true
        } else {
            self.lblName?.text = obj.name
        }
        self.imgVideo?.setImage(withUrl: obj.type ? obj.thumbMedia :  obj.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        if obj.type == true {
            self.btnVideo?.isHidden = false
            self.btnImage?.isHidden = true
        } else {
            self.btnVideo?.isHidden = true
            self.btnImage?.isHidden = false
        }
    }
    
    func setGalleryimage(obj : AddPhotoVideoModel) {
        self.imgVideo?.setImage(withUrl: obj.galleryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.btnVideo?.isHidden = true
        self.btnImage?.isHidden = false
    }
}

// MARK: - NibReusable
extension HighlightsCell: NibReusable { }

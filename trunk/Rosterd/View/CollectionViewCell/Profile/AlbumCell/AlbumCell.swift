//
//  AlbumCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/02/22.
//

import UIKit

class AlbumCell: UICollectionViewCell {

    
    // MARK: - IBOutlet
    @IBOutlet weak var vwMain: UIView?
    
    @IBOutlet weak var imgFeed: UIImageView?
    
    @IBOutlet weak var vwAddview: UIView?
    @IBOutlet weak var btnAdd: UIButton?
    @IBOutlet weak var btncancel: UIButton?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.contentView.clipsToBounds = true
        self.contentView.cornerRadius = 10.0
        //self.contentView.shadow(UIColor.CustomColor.shadowColorBlack, radius: 5.0, offset: CGSize(width: 4, height: 2), opacity: 1)
        self.contentView.maskToBounds = false
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        //delay(seconds: 0.2) {
            if let img = self.imgFeed {
                img.cornerRadius = 10.0
            }
            if let vw = self.vwMain {
                vw.cornerRadius = 10.0
            }
            if let vw = self.vwAddview {
              vw.cornerRadius = 10.0
            }
    }
   
    func setProductImageData(obj : CategoryModel) {
        self.imgFeed?.setImage(withUrl: obj.productfullimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
    }
    
    
    func setAlbumData(obj : ProfileAlbumModel) {
        
    }
    
}

// MARK: - NibReusable
extension AlbumCell: NibReusable { }

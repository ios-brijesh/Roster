//
//  iCarouselHomeView.swift
//  Bluecoller
//
//  Created by Wdev3 on 11/12/20.
//  Copyright © 2020 Bhagvan Mangukiya. All rights reserved.
//

import UIKit

class iCarouselHomeView: UIView {
    
    @IBOutlet weak var vwImageView: UIView?
    @IBOutlet weak var vwmainview: UIView?
    
    @IBOutlet weak var CVBrandimage: UICollectionView!
    
    @IBOutlet weak var vwcodeview: UIView?
    
    
    @IBOutlet weak var imgBrand: UIImageView?
    @IBOutlet weak var lblDesc: UILabel?
    @IBOutlet weak var lblpresentage: UILabel?
    @IBOutlet weak var lbloff: UILabel?
    @IBOutlet weak var lblcode: UILabel?
    @IBOutlet weak var lblexpiredate: UILabel?
    
    
    @IBOutlet weak var btnvisitwebsite: UIButton?
//    var trendingData:TrendingPetitionModel?
    
    var coupendata:ModelGiftCoupon?
    var arrImages = [ModelSubData]()
    var onClickImageData:((_ imgData:ModelSubData)->Void)?
    override  func awakeFromNib() {
        super.awakeFromNib()
        InitConfig()
    }
    
    // MARK: - Init Configure
    private func InitConfig(){
        
       
    
        self.vwmainview?.cornerRadius = 15.0
        self.vwmainview?.shadow(UIColor.CustomColor.appColor, radius: 15.0, offset: CGSize(width: 0, height: 1), opacity: 1)
        self.vwmainview?.maskToBounds = false
        self.vwmainview?.backgroundColor = UIColor.CustomColor.whitecolor
        
        
        if let cv = self.CVBrandimage {
        
            cv.register(BrandDiscountCell.self)
            cv.dataSource = self
            cv.delegate = self
            cv.isPagingEnabled = true
        }
        
        self.lblDesc?.textColor = UIColor.CustomColor.blackColor
        self.lblDesc?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        
        self.lblpresentage?.textColor = UIColor.CustomColor.blackColor
        self.lblpresentage?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 30.0))
        
        self.lbloff?.textColor = UIColor.CustomColor.blackColor
        self.lbloff?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 25.0))
        
        self.lblcode?.textColor = UIColor.CustomColor.blackColor
        self.lblcode?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        
        self.lblexpiredate?.textColor = UIColor.CustomColor.sepretorColor
        self.lblexpiredate?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        self.btnvisitwebsite?.backgroundColor = UIColor.CustomColor.appColor
        self.btnvisitwebsite?.cornerRadius = 15.0
        
        self.btnvisitwebsite?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.btnvisitwebsite?.setTitleColor(UIColor.CustomColor.whitecolor, for: .normal)
        
        
        self.vwcodeview?.backgroundColor = UIColor.CustomColor.viewBGColor
        self.vwcodeview?.cornerRadius = 22.0
        
        self.vwmainview?.cornerRadius = 15.0
        self.vwmainview?.shadow(UIColor.CustomColor.appColor, radius: 15.0, offset: CGSize(width: 0, height: 0), opacity: 0.5)
        self.vwmainview?.maskToBounds = false
        self.vwmainview?.backgroundColor = UIColor.CustomColor.whitecolor
        
        
        self.vwImageView?.cornerRadius = 15.0
        self.vwImageView?.shadow(UIColor.CustomColor.appColor, radius: 15.0, offset: CGSize(width: 0, height: 0), opacity: 0.5)
        self.vwImageView?.maskToBounds = false
        self.vwImageView?.backgroundColor = UIColor.CustomColor.whitecolor
        
        
        
        
    
    }
    
    
    func setImageData() {
     
        if let CoupenData = coupendata {
            
            self.arrImages = CoupenData.subData
            self.CVBrandimage.reloadData()
        }
    }


}


  //MARK: - UICollectionView Delegate and Datasource Method
  extension iCarouselHomeView : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
          return arrImages.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        
              let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: BrandDiscountCell.self)
          let i_Info = arrImages[indexPath.item]
          cell.img_Brand?.setImage(withUrl: i_Info.offerImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
          if indexPath.row == 0 {
              cell.vwLeftview?.isHidden = true
              cell.VwBottomView?.isHidden = false
              cell.vwRightView?.isHidden = false
             
          } else if indexPath.row == 1 {
              cell.vwLeftview?.isHidden = true
              cell.VwBottomView?.isHidden = false
              cell.vwRightView?.isHidden = false
          } else if indexPath.row == 2 {
              cell.vwLeftview?.isHidden = true
              cell.vwRightView?.isHidden = true
          } else if indexPath.row == 3 {
              cell.vwLeftview?.isHidden = true
          } else if indexPath.row == 4 {
              cell.vwLeftview?.isHidden = true
          } else if indexPath.row == 5 {
              cell.vwLeftview?.isHidden = true
              cell.vwRightView?.isHidden = true
          } else if indexPath.row == 6 {
              cell.vwLeftview?.isHidden = true
              cell.VwBottomView?.isHidden = true
          } else if indexPath.row == 7 {
              cell.vwLeftview?.isHidden = true
              cell.VwBottomView?.isHidden = true
          } else if indexPath.row == 8 {
              cell.vwLeftview?.isHidden = true
              cell.VwBottomView?.isHidden = true
              cell.vwRightView?.isHidden = true
          }
          
          

         
              return cell
          
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         
          return 0
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         
         
        
          return 0
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = ((collectionView.frame.width)) / 3
          return CGSize(width: width, height: 120)
//                       ((3 - 1) * 3))
          
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let i_Info = arrImages[indexPath.item]
          guard let onImage = self.onClickImageData else { return }
          onImage(i_Info)
      }
      
     
  }

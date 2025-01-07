//
//  HomeSliderCell.swift
//  Rosterd
//
//  Created by wm-devIOShp on 21/01/22.
//

import UIKit

class HomeSliderCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var vwMain: UIView?
    @IBOutlet weak var vwSubLayer: UIView?
    @IBOutlet weak var vwCountMain: UIView?
    @IBOutlet weak var vwCountSub: UIView?
    
    @IBOutlet weak var lblCount: UILabel?
    @IBOutlet weak var lblType: UILabel?
    @IBOutlet weak var lblValue: UILabel?
    
    @IBOutlet weak var btnClose: UIButton?
    @IBOutlet weak var btnPrev: UIButton?
    @IBOutlet weak var btnNext: UIButton?
    @IBOutlet weak var cvimageSlider: UICollectionView!
    
    @IBOutlet weak var imgSlider: UIImageView?
    
    // MARK: - Variables
    var totalImages : Int  = 0 {
        didSet {
            self.cvimageSlider?.reloadData()
            self.lblCount?.text = "1/\(self.totalImages)"
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
        
        if let btn = self.btnClose {
            btn.cornerRadius = btn.frame.height / 2
        }
        
        if let btn = self.btnNext {
            btn.cornerRadius = btn.frame.height / 2
        }
        
        if let btn = self.btnPrev {
            btn.cornerRadius = btn.frame.height / 2
        }
        
        if let vw = self.vwCountSub {
            vw.cornerRadius = vw.frame.height / 2
        }
    }
    
    private func initConfig() {
        self.lblCount?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        self.lblCount?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblType?.font = UIFont.PoppinsSemiBoldItalic(ofSize: GetAppFontSize(size: 10.0))
        self.lblType?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblValue?.font = UIFont.PoppinsItalic(ofSize: GetAppFontSize(size: 14.0))
        self.lblValue?.textColor = UIColor.CustomColor.whitecolor
        
        self.imgSlider?.cornerRadius = 18.0
        self.vwSubLayer?.cornerRadius = 18.0
        self.vwMain?.cornerRadius = 18.0
        self.vwSubLayer?.backgroundColor = UIColor.CustomColor.black35Per
        
        self.vwCountSub?.backgroundColor = UIColor.CustomColor.black50Per
        self.btnClose?.backgroundColor = UIColor.CustomColor.black50Per
        self.btnNext?.backgroundColor = UIColor.CustomColor.cardBackColor
        self.btnPrev?.backgroundColor = UIColor.CustomColor.cardBackColor
        
        
        self.cvimageSlider?.dataSource = self
        self.cvimageSlider?.delegate = self
        self.cvimageSlider?.register(HomeSliderImageViewCell.self)
        self.cvimageSlider?.reloadData()
        self.lblCount?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        self.lblCount?.textColor = UIColor.CustomColor.whitecolor
        self.lblCount?.text = "1/\(self.totalImages)"
        self.vwCountMain?.backgroundColor = UIColor.CustomColor.black50Per
    }
    
}

//MARK: - UICollectionView Delegate and Datasource Method
extension HomeSliderCell : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeSliderImageViewCell.self)
        if indexPath.row == 0 {
            cell.imgAdv?.image = UIImage(named: "imgDemoFeed")
        } else if indexPath.row == 1 {
            cell.imgAdv?.image = UIImage(named: "ImgDemoFeed2")
        } else {
            cell.imgAdv?.image = UIImage(named: "imgDemoFeed")
        }
        
        self.vwCountMain?.isHidden = self.totalImages == 0
//        cell.setImagevideoData(obj: self.arrFeedImages[indexPath.row])
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        if self.totalImages == 0 {
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if self.totalImages == 1 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        //}
        //return CGSize(width: (ScreenSize.SCREEN_WIDTH * 0.7), height: ScreenSize.SCREEN_WIDTH * 0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
   
}

//MARK: -  Scrollview Method
extension HomeSliderCell {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //self.collectionview.scrollToNearestVisibleCollectionViewCell()
        //self.pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print("scrollViewDidEndDecelerating : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
        let currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        self.lblCount?.text = "\(currentIndex + 1)/\(self.totalImages)"
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //self.pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        let currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print("scrollViewDidEndScrollingAnimation : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
        
        self.lblCount?.text = "\(currentIndex + 1)/\(self.totalImages)"
    }
}


// MARK: - NibReusable
extension HomeSliderCell: NibReusable { }

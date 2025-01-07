//
//  FeedCell.swift
//  Momentor
//
//  Created by wmdevios-h on 18/09/21.
//

import UIKit

protocol  FeedCellDelegate {

    func btnLikeSelect(btn : UIButton,cell : FeedCell)
    func btnMoreSelect(btn : UIButton,cell : FeedCell)
    func btnReportSelect(btn : UIButton,obj : FeedModel)
    func btnPreviewImage(obj : AddPhotoVideoModel)
}

class FeedCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imgProfile: UIImageView?
    
    @IBOutlet weak var lblUsername: UILabel?
    @IBOutlet weak var lblTime: UILabel?
    @IBOutlet weak var lblFeedDesc: UILabel?
    @IBOutlet weak var lblLikeCount: UILabel?
    @IBOutlet weak var lblCommentCount: UILabel?
    @IBOutlet weak var lblhastag: UILabel?
    
    @IBOutlet weak var vwMain: UIView?
    @IBOutlet weak var vwFeedImageMain: UIView?
    @IBOutlet weak var vwTopContentMain: UIView?
    @IBOutlet weak var vwBottomContentMain: UIView?
    @IBOutlet weak var vwLikeMain: UIView?
    @IBOutlet weak var vwCommentMain: UIView?
    @IBOutlet weak var vwMoreMain: UIView?
    
    @IBOutlet weak var btnReport: UIButton?
    @IBOutlet weak var btnCommentSelect: UIButton?
    @IBOutlet weak var brnComment: UIButton?
    @IBOutlet weak var btnLikeSelect: UIButton?
    @IBOutlet weak var btnlike: UIButton?
    @IBOutlet weak var btnMoreSelect: UIButton?
    @IBOutlet weak var btnlikeRed: UIButton!
    @IBOutlet weak var btnUsername: UIButton!

    
    @IBOutlet weak var cvFeedImages: UICollectionView?
    
    @IBOutlet weak var constraintCVImageHeight: NSLayoutConstraint?
    
    @IBOutlet weak var vwCountMain: UIView?
    @IBOutlet weak var lblCount: UILabel?
    // MARK: - Variables
    var totalImages : Int  = 0 {
        didSet {
            self.cvFeedImages?.reloadData()
            self.lblCount?.text = "1/\(self.totalImages)"
        }
    }
    
    var isShowContentTextOnly : Bool = false {
        didSet {
            self.vwFeedImageMain?.isHidden = isShowContentTextOnly
        }
    }
    var arrFeedImages : [AddPhotoVideoModel]  = [] {
        didSet {
            self.cvFeedImages?.reloadData()
        }
    }
    
    
    
    var Delegate : FeedCellDelegate?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let img = self.imgProfile {
            img.cornerRadius = img.frame.height / 2.0
        }
        if let vw = self.vwMain {
            vw.clipsToBounds = true
            vw.cornerRadius = 34.0
            vw.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vw.maskToBounds = false
        }
        
        if let vw = self.vwCountMain {
            vw.cornerRadius = vw.frame.height / 2
        }
    }
    
    // MARK: - Init Configure Methods
    private func InitConfig(){
        self.lblUsername?.textColor = UIColor.CustomColor.viewAllColor
        self.lblUsername?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
        
        self.lblTime?.textColor = UIColor.CustomColor.sepretorColor
        self.lblTime?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        self.lblFeedDesc?.textColor = UIColor.CustomColor.feedColor
        self.lblFeedDesc?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        
        self.lblhastag?.textColor = UIColor.CustomColor.appColor
        self.lblhastag?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        [self.lblLikeCount,self.lblCommentCount].forEach({
            $0?.textColor = UIColor.CustomColor.feedCountColor
            $0?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        })
        
        self.cvFeedImages?.dataSource = self
        self.cvFeedImages?.delegate = self
        self.cvFeedImages?.register(FeedImageCell.self)
        //self.cvFeedImages?.register(UINib.init(nibName: CellIdentifier.kFeedImageCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.kFeedImageCell)
        //self.cvFeedImages?.interitemSpacing = 30.0
        //self.cvFeedImages?.transformer = FSPagerViewTransformer(type: .zoomOut)
        
       // delay(seconds: 0.1) {
            
            self.constraintCVImageHeight?.constant = ScreenSize.SCREEN_WIDTH //* 0.9
            
            
            self.cvFeedImages?.reloadData()
            /*if let cv = self.cvFeedImages {
                cv.itemSize = CGSize(width: ScreenSize.SCREEN_WIDTH - 100.0, height: cv.frame.height)
            }*/
       // }
        
        self.lblCount?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        self.lblCount?.textColor = UIColor.CustomColor.whitecolor
        self.lblCount?.text = "1/\(self.totalImages)"
        self.vwCountMain?.backgroundColor = UIColor.CustomColor.black50Per
    }
    
    func setFeedData(obj : FeedModel){
        self.lblFeedDesc?.text = obj.text.decodingEmoji()
        self.lblUsername?.text = obj.userName
        self.imgProfile?.setImage(withUrl: obj.thumbuserimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
        self.arrFeedImages = obj.post
        self.totalImages = self.arrFeedImages.count
        self.lblTime?.text = obj.postCreateDate
        self.lblLikeCount?.text = obj.totalLikeCount
        self.lblCommentCount?.text = obj.totalCommentsCount
        self.lblhastag?.text = obj.hashtag
        
        if self.arrFeedImages.isEmpty && !obj.text.isEmpty {
            self.isShowContentTextOnly = true
        } else if !self.arrFeedImages.isEmpty && obj.text.isEmpty {
            self.lblFeedDesc?.isHidden = true
            self.isShowContentTextOnly = false
        } else {
            self.vwFeedImageMain?.isHidden = false
            self.lblFeedDesc?.isHidden = false
        }
//        self.cvFeedImages?.reloadData()
        self.btnlike?.isSelected = obj.isLike == "1"
    }
    @IBAction func btnlikeClicked(_ sender : UIButton) {
     
        if let btn = self.btnlike {
            self.btnlike?.isSelected = !(self.btnlike?.isSelected ?? false)
            self.Delegate?.btnLikeSelect(btn: btn, cell: self)
           
        }
    }
    
    
}

//MARK: - UICollectionView Delegate and Datasource Method
extension FeedCell : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FeedImageCell.self)
      
       if self.arrFeedImages.count > 0 {
           let obj = self.arrFeedImages[indexPath.row]
           //let isVideo : Bool = !(obj.postVideoThumbImage.isEmpty)
           cell.imgFeed?.setImage(withUrl: obj.isVideo ? obj.thumbpostvideoThumbImage :  obj.postimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
           cell.imgVideoPost?.isHidden = !obj.isVideo
       }
       

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
    
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if self.arrFeedImages.count > 0 {
            if let del = self.Delegate {
                del.btnPreviewImage(obj: self.arrFeedImages[indexPath.row])
            }
        }
    }
   
}

//MARK: -  Scrollview Method
extension FeedCell {
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
extension FeedCell: NibReusable { }

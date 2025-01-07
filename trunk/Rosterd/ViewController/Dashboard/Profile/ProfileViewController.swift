//
//  ProfileViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 24/01/22.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwAlbumview: UIView?
    @IBOutlet weak var vwAboutview: UIView?
    @IBOutlet weak var vwSportview: UIView?
    @IBOutlet weak var vwsubnameView: UIView?
    
    @IBOutlet weak var imgRightFan: UIImageView?
    @IBOutlet weak var imgRightAthlate: UIImageView?
    @IBOutlet weak var imgRightSchool: UIImageView?
    @IBOutlet weak var imgRightClub: UIImageView?
    @IBOutlet weak var imgRightRe: UIImageView?
    @IBOutlet weak var imgRightCoach: UIImageView?
    
    @IBOutlet weak var imgLeftFan: UIImageView?
    @IBOutlet weak var imgLeftAthlate: UIImageView?
    @IBOutlet weak var imgLeftSchool: UIImageView?
    @IBOutlet weak var imgLeftClub: UIImageView?
    @IBOutlet weak var imgLeftRe: UIImageView?
    @IBOutlet weak var imgLeftCoach: UIImageView?
    
    @IBOutlet weak var lblSubuserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView?
    @IBOutlet weak var imgPro: UIImageView!
    @IBOutlet weak var tblFeed: UITableView?
    @IBOutlet weak var constrainttblFeedHeight: NSLayoutConstraint?
    
    @IBOutlet weak var lblHighlights: UILabel!
    @IBOutlet weak var lblPosts: UILabel?
    @IBOutlet weak var lblShowFollowing: UILabel?
    @IBOutlet weak var lblShowFollowers: UILabel?
    @IBOutlet weak var lblSubUser: UILabel?
    @IBOutlet weak var lblUserName: UILabel?
    @IBOutlet weak var lblContent: UILabel?
    @IBOutlet var lblMainHeader: [UILabel]?
    @IBOutlet  var lblHeader: [UILabel]?
    @IBOutlet var lblSubHeader: [UILabel]?
    @IBOutlet weak var cvAlbum: UICollectionView?
    @IBOutlet weak var cvHighliths: UICollectionView!
    @IBOutlet weak var vwFollowingview: UIView!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var btnFollowers: UIButton?
    @IBOutlet weak var btnFollowing: UIButton?
    @IBOutlet weak var btnPost: UIButton?
    
    @IBOutlet weak var lblSportparticipat: UILabel!
    @IBOutlet weak var lblplayerposition: UILabel!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblshowCoins: UILabel!
    
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblGpa: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblfavsportTeam: UILabel!
    @IBOutlet weak var lblEmailContact: UILabel?
    @IBOutlet weak var lblphonenu: UILabel?
    @IBOutlet weak var lblfax: UILabel?
    @IBOutlet weak var lblAthlatename: UILabel?
    @IBOutlet weak var lblAthlateEmail: UILabel?
    @IBOutlet weak var lblUpdateResume: UILabel?
    
    @IBOutlet weak var lblLestSide: UILabel?
    @IBOutlet weak var lblRightSide: UILabel?
    
    
    @IBOutlet weak var btnResume: UIButton!
    @IBOutlet weak var btnRefer: UIButton!
    @IBOutlet weak var btnCoin: UIButton?
    @IBOutlet weak var btnDownload: UIButton?
    @IBOutlet weak var btnChat: UIButton?
    @IBOutlet weak var btnFollowUnfollow: UIButton?
    @IBOutlet weak var btnSetting: UIButton?
    
    @IBOutlet weak var vwResume: UIView!
    @IBOutlet weak var vwDownloadView: UIView!
    @IBOutlet weak var vwRefer: UIView!
    @IBOutlet weak var vwDownload: UIView!
    @IBOutlet weak var vwChat: UIView!
    @IBOutlet weak var vwMore: UIView!
    @IBOutlet weak var vwSetting: UIView!
    
    @IBOutlet weak var vwUpdateSubResume: UIView?
    @IBOutlet weak var vwUpdateResume: UIView?
    @IBOutlet weak var vwMainCoinview: UIView!
    @IBOutlet weak var vwCoinView: UIView!
    @IBOutlet weak var vwWeightView: UIView!
    @IBOutlet weak var vwFavSportView: UIView!
    @IBOutlet weak var vwGpaView: UIView!
    @IBOutlet weak var vwHeightView: UIView!
    @IBOutlet weak var vwContactView: UIView!
    @IBOutlet weak var vwHighlightsView: UIView!
    
    @IBOutlet weak var vwMainContactView: UIView!
    @IBOutlet weak var VWMainWeightFavsportView: UIView!
    @IBOutlet weak var VWMainHeightGpaView: UIView!
    @IBOutlet weak var VWMainSportsPlayersView: UIView!
    @IBOutlet weak var vwHeadlineView: UIView!
    @IBOutlet weak var vwSportsView: UIView!
    @IBOutlet weak var vwPlayesView: UIView!
    @IBOutlet weak var vwTamView: UIView!
    // MARK: - Variables
    private var selectedCoach : CoachEnum?
    private var selectedSchool : SchoolClubEnum?
    private var selectedRole : userRole?
    private var userProfileData : UserModel?
    private var arrFeed : [FeedModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    var isbtnRefer : Bool = false
    var isbtnchat : Bool = false
    var isbtnsettinf : Bool = false
    var isbtnMore : Bool = false
    var isfromFeed : Bool = false
    var isfromdownload : Bool = false
    var isfromResume : Bool = false
    var isfromUpdateResume : Bool = false
    var selectedpostdata : FeedModel?
    var selectedUserID : String = ""
    var isfromOther : Bool = false
    private var arrImages : [ProfileAlbumModel] = []
    private var selectalbumid : ProfileAlbumModel?
    private var arrhighlights : [AddPhotoVideoModel] = []
    @IBOutlet weak var vwAlbumMain: UIView?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isfromOther {
            self.reloadFeedData()
        }
        else {
            self.reloadFeedData()
        }
        self.addTableviewOberver()
        self.navigationController?.setNavigationBarHidden(true, animated: true)//navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.vwFollowingview?.cornerRadius = 20
        self.vwFollowingview?.borderColor = UIColor.CustomColor.appColor
        self.vwFollowingview?.borderWidth = 1.0
        
        if let img = self.btnDownload {
            img.cornerRadius = img.frame.height / 2.0
            img.borderWidth = 1.5
            img.borderColor = UIColor.white
        }
        
        if let img = self.vwDownload {
            img.cornerRadius = img.frame.height / 2.0
        }
        self.vwDownload?.backgroundColor = UIColor.CustomColor.appColor
        
        if let vw = self.vwUpdateSubResume {
            vw.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
            vw.cornerRadius = 20.0
        }
        
        self.vwMainCoinview?.cornerRadius = 18.0
        self.vwMainCoinview?.backgroundColor = UIColor.white
        self.vwCoinView?.cornerRadius = 18.0
        self.vwCoinView?.backgroundColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
}
// MARK: - Init Configure
extension ProfileViewController {
    private func InitConfig(){
        self.vwDownloadView?.isHidden = true
        self.btnViewAll?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.btnViewAll?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.lblUserName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 53.0))
        self.lblUserName?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblSubuserName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 53.0))
        self.lblSubuserName?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblShowFollowers?.setFollowAttributedTextLable(firstText: "00", SecondText: "\nFollowers")
        self.lblShowFollowing?.setFollowAttributedTextLable(firstText: "00", SecondText: "\nFollowing")
        self.lblPosts?.setFollowAttributedTextLable(firstText: "00", SecondText: "\nPosts")
        
        self.lblLestSide?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 09.0))
        self.lblLestSide?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblRightSide?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 09.0))
        self.lblRightSide?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblshowCoins?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 11.0))
        self.lblshowCoins?.textColor = UIColor.CustomColor.CoinColor
        
        self.lblUpdateResume?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.lblUpdateResume?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblHighlights?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblHighlights?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblLestSide?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        self.lblRightSide?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        self.tblFeed?.register(FeedCell.self)
        self.tblFeed?.estimatedRowHeight = 100.0
        self.tblFeed?.rowHeight = UITableView.automaticDimension
        self.tblFeed?.delegate = self
        self.tblFeed?.dataSource = self
        
        self.tblFeed?.reloadData()
        
        self.imgLeftRe?.isHidden = true
        self.imgRightRe?.isHidden = true
        self.imgLeftCoach?.isHidden = true
        self.imgRightCoach?.isHidden = true
        self.imgLeftFan?.isHidden = true
        self.imgRightFan?.isHidden = true
        self.imgLeftAthlate?.isHidden = true
        self.imgRightAthlate?.isHidden = true
        self.imgLeftSchool?.isHidden = true
        self.imgRightSchool?.isHidden = true
        self.imgLeftClub?.isHidden = true
        self.imgRightClub?.isHidden = true
        
        if let cv = self.cvAlbum {
            cv.register(PofileAlbumCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        if let cvHighliths = self.cvHighliths {
            cvHighliths.register(HighlightsCell.self)
            cvHighliths.dataSource = self
            cvHighliths.delegate = self
        }
        
        delay(seconds: 0.2) {
            if  let imgUser = self.imgUser {
                imgUser.roundCorners(corners: [.bottomRight,.bottomLeft], radius: 35.0)
                
            }
        }
        self.lblHeader?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        })
        self.lblSubHeader?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.lblMainHeader?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        })
        
        
        
        [self.lblSportparticipat,self.lblTeamName,self.lblplayerposition,self.lblHeight,self.lblWeight,self.lblGpa,self.lblfavsportTeam,self.lblfax,self.lblphonenu,self.lblAthlatename,self.lblAthlateEmail,self.lblEmailContact].forEach({
            $0?.textColor = UIColor.CustomColor.labelTextColor
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        
        delay(seconds:0.2) {
            [self.vwAboutview,self.vwAlbumview,self.vwSportview,self.vwContactView].forEach({
                $0?.cornerRadius = 20
                $0?.backgroundColor = UIColor.CustomColor.SupportTopBGcolor
            })
        }
        self.lblContent?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.lblContent?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblSubUser?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblSubUser?.textColor = UIColor.CustomColor.whitecolor
        
        self.vwChat?.isHidden = self.isbtnchat
        self.vwMore?.isHidden = self.isbtnMore
        self.vwSetting?.isHidden = self.isbtnsettinf
        self.vwDownload?.isHidden = self.isfromdownload
        self.vwRefer?.isHidden = self.isbtnRefer
        self.vwResume?.isHidden = self.isfromResume
        self.vwUpdateResume?.isHidden = self.isfromUpdateResume
        self.setupESInfiniteScrollinWithTableView()
    }
}
//
////MARK: Pagination tableview Mthonthd
extension ProfileViewController {
    
    private func reloadFeedData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrFeed.removeAll()
        self.tblFeed?.reloadData()
        self.getUserProfile()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblFeed?.es.addPullToRefresh {
            [unowned self] in
            self.reloadFeedData()
        }
        
        self.tblFeed?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getUserProfile()
                } else if self.pageNo <= self.totalPages {
                    self.getUserProfile()
                } else {
                    self.tblFeed?.es.noticeNoMoreData()
                }
            } else {
                self.tblFeed?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblFeed?.footer?.animator as? ESRefreshFooterAnimator {
            animator.noMoreDataDescription = ""
        }
    }
    
    /**
     This function is used to hide the footer infinte loading.
     - Parameter success: Used to know API reponse is succeed or fail.
     */
    //Harshad
    func hideFooterLoading(success: Bool) {
        if success {
            if self.pageNo == self.totalPages {
                self.tblFeed?.es.noticeNoMoreData()
            }
            else {
                self.tblFeed?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblFeed?.es.stopLoadingMore()
            self.tblFeed?.es.noticeNoMoreData()
            self.isLoading = true
        }
        
    }
}

//MARK: - Tableview Observer
extension ProfileViewController {
    
    private func addTableviewOberver() {
        self.tblFeed?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableviewObserver() {
        if self.tblFeed?.observationInfo != nil {
            self.tblFeed?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblFeed && keyPath == ObserverName.kcontentSize {
                self.constrainttblFeedHeight?.constant = self.tblFeed?.contentSize.height ?? 0.0
            }
        }
    }
}

//MARK:- UITableView Delegate
extension ProfileViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFeed.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: FeedCell.self)
        if self.arrFeed.count > 0 {
            cell.setFeedData(obj: self.arrFeed[indexPath.row])
            
            cell.Delegate = self
        }
        
        cell.btnLikeSelect?.tag = indexPath.row
        cell.btnLikeSelect?.addTarget(self, action: #selector(self.btnLikeClicked(_:)), for: .touchUpInside)
        
        cell.btnCommentSelect?.tag = indexPath.row
        cell.btnCommentSelect?.addTarget(self, action: #selector(self.btnCommentClicked(_:)), for: .touchUpInside)
        
        cell.btnReport?.tag = indexPath.row
        cell.btnReport?.addTarget(self, action: #selector(self.btnReportClicked(_:)), for: .touchUpInside)
        
        cell.btnMoreSelect?.tag = indexPath.row
        cell.btnMoreSelect?.addTarget(self, action: #selector(self.btnMoreSelectClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func btnCommentClicked(_ sender : UIButton){
        self.appNavigationController?.detachRightSideMenu()
        self.appNavigationController?.push(FeedCommentViewController.self,configuration: { vc in
            vc.CommentId = self.arrFeed[sender.tag].id
            
        })
    }
    
    @objc func btnMoreSelectClicked(_ sender : UIButton){
        let postInfo = arrFeed[sender.tag]
        let textToShare = [ postInfo.shareLink ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @objc func btnLikeClicked(_ sender : UIButton){
        
        if self.arrFeed.count > 0 {
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(FeedLikeViewController.self,configuration: { vc in
                vc.LikeId = self.arrFeed[sender.tag].id
                //vc.isFromJobApplicant = false
            })
        }
    }
    
    @objc func btnReportClicked(_ sender : UIButton){
        if self.arrFeed.count > 0 {
            let obj = self.arrFeed[sender.tag]
            let getDirectionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            //Open Apple Map
            let reportAction = UIAlertAction(title: "Report", style: .default, handler:
                                                {
                (alert: UIAlertAction!) -> Void in
                self.appNavigationController?.detachRightSideMenu()
                self.appNavigationController?.present(FeedReportPopupViewController.self,configuration: { (vc) in
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.selectedFeedData = obj
                })
            })
            
            //OPen Gogole Map
            let deleteAction = UIAlertAction(title: "Delete", style: .default, handler:
                                                {
                (alert: UIAlertAction!) -> Void in
                self.showAlert(withTitle: "", with: "Are you sure want to delete this feed?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
                    self.deleteFeed(feedID: obj.id)
                }, secondButton: ButtonTitle.No, secondHandler: nil)
            })
            
            let editAction = UIAlertAction(title: "Edit", style: .default, handler:
                                            {
                (alert: UIAlertAction!) -> Void in
                
                self.appNavigationController?.push(CreatePostViewController.self,configuration: { vc in
                    vc.selectedFeedData = obj
                    vc.postid = obj.id
                    vc.isFromEdit = true
                    vc.delegate = self
                })
            })
            
            //cancel
            let cancelAction = UIAlertAction(title: AlertControllerKey.kCancel, style: .cancel, handler:
                                                {
                (alert: UIAlertAction!) -> Void in
                
            })
            
            getDirectionMenu.popoverPresentationController?.sourceView = sender as? UIView
            //        getDirectionMenu.popoverPresentationController?.permittedArrowDirections = .down
            
            if let user = UserModel.getCurrentUserFromDefault() {
                if (user.id == obj.userId) {
                    getDirectionMenu.addAction(editAction)
                    getDirectionMenu.addAction(deleteAction)
                } else {
                    getDirectionMenu.addAction(reportAction)
                }
            }
            
            getDirectionMenu.addAction(cancelAction)
            self.present(getDirectionMenu, animated: true, completion: nil)
        }
        
        
        
    }
}

///MARK: - UICollectionView Delegate and Datasource Method
extension ProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.cvAlbum {
            
            if self.isfromOther {
                return self.arrImages.count
            } else {
                return self.arrImages.count + 1
            }
        } else {
            return self.arrhighlights.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.cvAlbum {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PofileAlbumCell.self)
            
            if indexPath.row == arrImages.count && !self.isfromOther {
                cell.vwPlusView?.isHidden = false
                cell.btnAddimg.isHidden = false
                cell.imgFirst?.isHidden = true
                cell.imgSecond?.isHidden = true
                cell.imgThird?.isHidden = true
                cell.imgfourth?.isHidden = true
                cell.vwlabelview?.isHidden = true
                cell.btnDeleteAlbum?.isHidden = true
                cell.lblAlbumname.text = "Add Album"
            } else {
                
                cell.setAlbumData(obj: self.arrImages[indexPath.row])
                cell.vwPlusView?.isHidden = true
                cell.btnAddimg.isHidden = true
                if self.isfromOther == true {
                    cell.btnDeleteAlbum?.isHidden = true
                    
                } else {
                    cell.btnDeleteAlbum?.isHidden = false
                }
                
                let arrMedia = self.arrImages[indexPath.row].media
                if arrMedia.count == 0 {
                    cell.imgFirst?.isHidden = true
                    cell.imgSecond?.isHidden = true
                    cell.imgThird?.isHidden = true
                    cell.imgfourth?.isHidden = true
                    cell.vwlabelview?.isHidden = true
                }
                else if arrMedia.count == 1 {
                    cell.imgFirst?.isHidden = false
                    cell.imgSecond?.isHidden = true
                    cell.imgThird?.isHidden = true
                    cell.imgfourth?.isHidden = true
                    cell.vwlabelview?.isHidden = true
                    if let imgfirst = arrMedia.first,imgfirst.media != ""  {
                        cell.imgFirst?.setImage(withUrl: imgfirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    }
                    
                }
                else if arrMedia.count == 2 {
                    cell.imgFirst?.isHidden = false
                    cell.imgSecond?.isHidden = false
                    cell.imgThird?.isHidden = true
                    cell.imgfourth?.isHidden = true
                    cell.vwlabelview?.isHidden = true
                    if let imgfirst = arrMedia.first,imgfirst.media != ""  {
                        cell.imgFirst?.setImage(withUrl: imgfirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    }
                    if let imgSecond = arrMedia.last,imgSecond.media != "" {
                        cell.imgSecond?.setImage(withUrl: imgSecond.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    }
                }
                else if arrMedia.count == 3 {
                    cell.imgFirst?.isHidden = false
                    cell.imgSecond?.isHidden = false
                    cell.imgThird?.isHidden = false
                    cell.imgfourth?.isHidden = true
                    cell.vwlabelview?.isHidden = true
                    if let imgFirst = arrMedia.first,imgFirst.media != "" {
                        cell.imgFirst?.setImage(withUrl: imgFirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        
                        cell.imgSecond?.setImage(withUrl: arrMedia[1].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        
                        cell.imgThird?.setImage(withUrl: arrMedia[2].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    }
                }
                else if arrMedia.count == 4 {
                    cell.imgFirst?.isHidden = false
                    cell.imgSecond?.isHidden = false
                    cell.imgThird?.isHidden = false
                    cell.imgfourth?.isHidden = false
                    cell.vwlabelview?.isHidden = true
                    if let imgFirst = arrMedia.first,imgFirst.media != "" {
                        cell.imgFirst?.setImage(withUrl: imgFirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        
                        cell.imgSecond?.setImage(withUrl: arrMedia[1].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        
                        cell.imgThird?.setImage(withUrl: arrMedia[2].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        cell.imgfourth?.setImage(withUrl: arrMedia[3].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    }
                    
                }
                else {
                    cell.imgFirst?.isHidden = false
                    cell.imgSecond?.isHidden = false
                    cell.imgThird?.isHidden = false
                    cell.imgfourth?.isHidden = false
                    cell.vwlabelview?.isHidden = false
                    if let imgFirst = arrMedia.first,imgFirst.media != "" {
                        cell.imgFirst?.setImage(withUrl: imgFirst.media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        
                        cell.imgSecond?.setImage(withUrl: arrMedia[1].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        
                        cell.imgThird?.setImage(withUrl: arrMedia[2].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        cell.imgfourth?.setImage(withUrl: arrMedia[3].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                        
                    }
                }
            }
            cell.btnDeleteAlbum?.tag = indexPath.row
            cell.btnDeleteAlbum?.addTarget(self, action: #selector(self.btnDeleteAlbumClicked(_:)), for: .touchUpInside)
            
            cell.btnAddimg?.tag = indexPath.row
            cell.btnAddimg?.addTarget(self, action: #selector(self.btnAddimgClicked(_:)), for: .touchUpInside)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HighlightsCell.self)
            cell.setHighlightsData(obj: self.arrhighlights[indexPath.row])
            cell.btnCancel?.isHidden = true
            //            cell.VwMainView?.cornerRadius = 13.0
            cell.imgVideo?.cornerRadius = 13.0
            
            cell.btnImage?.tag = indexPath.row
            cell.btnImage?.addTarget(self, action: #selector(self.btnImageClicked(_:)), for: .touchUpInside)
            
            cell.btnVideo?.tag = indexPath.row
            cell.btnVideo?.addTarget(self, action: #selector(self.btnVideoClicked(_:)), for: .touchUpInside)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.cvAlbum {
            return 10
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.cvAlbum {
            let width = ((collectionView.frame.width) - ((3 - 1) * 3)) / 3
            return CGSize(width: width, height: 130)
        }
        else {
            return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
        }
        
        
        
        //        return CGSize(width: (collectionView.frame.size.height - 10) / 4, height: (collectionView.frame.size.height - 10) / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.row == arrImages.count {
            
        } else {
            self.appNavigationController?.push(InsideAlbumViewController.self.self,configuration: { vc in
                vc.selectedAlbumdata = self.arrImages[indexPath.row].id
                //                self.delegate?.albumid(obj: self.arrImages[indexPath.row].id)
            })
        }
    }
    @objc func btnAddimgClicked(_ sender : UIButton){
        self.appNavigationController?.detachRightSideMenu()
        self.appNavigationController?.present(AlbumNameViewController.self,configuration: { vc in
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            vc.isfromProfile = true
            vc.isfromAlbum = true
            
            //            vc.selectedAlbumdata = self.arrImages[sender.tag].id
            
        })
    }
    
    @objc func btnDeleteAlbumClicked(_ sender : UIButton){
        self.showAlert(withTitle: "", with:"Are you sure want to delete this Album?", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            if self.arrImages.count > 0 {
                self.DeletePfotoAlbumApi(albumId: self.arrImages[sender.tag].id)
            }
        }, secondButton: ButtonTitle.No, secondHandler: nil)
    }
    
    @objc func btnVideoClicked(_ sender : UIButton){
        
        if self.arrhighlights.count > 0 {
            let obj = self.arrhighlights[sender.tag]
            if let videoURL = URL(string: obj.media) {
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    if let myplayer = playerViewController.player {
                        myplayer.play()
                    }
                }
            }
        }
    }
    
    @objc func btnImageClicked(_ sender : UIButton){
        if self.arrhighlights.count > 0 {
            let obj = self.arrhighlights[sender.tag]
            self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
                vc.imageUrl = obj.media
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
            })
        }
    }
}

//MARK:- UITableView Delegate
extension ProfileViewController : addAlbumDelegate {
    func reloadalbum() {
        self.arrImages.removeAll()
        self.cvAlbum?.reloadData()
        self.getUserProfile()
        let obj = self.selectalbumid?.id ?? ""
        self.appNavigationController?.push(InsideAlbumViewController.self, configuration: { vc in
            vc.selectedAlbumdata = obj
        })
    }
}
// MARK: - API Call

extension ProfileViewController {
    
    private func getUserProfile(){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kid : selectedUserID
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.getUserProfile(with: param, success: { (user,arrsports,arrfeed,arrAlbum,totalPages,message) in
                
                self.arrFeed.append(contentsOf: arrfeed)
                self.tblFeed?.reloadData()
                self.arrImages = arrAlbum
                self.cvAlbum?.reloadData()
                
                if self.isfromOther {
                    self.userProfileData = user
                    self.setProfileData()
                    self.lblSportparticipat.text = arrsports.compactMap({$0.name}).joined(separator: ",")
                    self.btnCoin?.isHidden = true
                }
                else {
                    self.userProfileData = user
                    self.setProfileData()
                    self.lblSportparticipat.text = arrsports.compactMap({$0.name}).joined(separator: ",")
                    self.btnCoin?.isHidden = false
                }
                //                self.vwAlbumMain?.isHidden = self.arrImages.count == 0 ? true : false
            }, failure: {[unowned self] (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
                
            })
        }
    }
    
    private func DeletePfotoAlbumApi(albumId : String){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kalbumId : albumId
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ProfileAlbumModel.DeletePfotoAlbum(with: param, success: { (msg) in
                self.arrImages.removeAll()
                self.cvAlbum?.reloadData()
                self.reloadFeedData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
        
    }
    
    
    
    private func GetResumeAPICall() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                ktoken : user.token,
                klangType : Rosterd.sharedInstance.languageType,
                kuserId : userProfileData?.id ?? ""
                
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.GetResume(with: param, success: { (strData,msg) in
                guard let url = URL(string: strData) else { return }
                UIApplication.shared.open(url)
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                //              if !error.isEmpty {
                //                  self.showMessage(error, themeStyle: .error)
                //              }
            })
        }
    }
    
    private func deleteFeed(feedID : String){
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                ktbl_post_id : feedID,
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedModel.deleteFeed(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.reloadFeedData()
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func setPostLikeDislike(isLike : String,PostID : String){
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kpostId : PostID
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedModel.setPostLikeDislike(with: param, success: { (msg) in
                
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
    private func setFollow(isLike : String){
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kfollowId : selectedUserID,
                kisLike : isLike
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.setFollow(with: param, success: { (msg) in
                
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                }
            })
        }
    }
    
    private func setProfileData(){
        if let obj = self.userProfileData {
            
            self.btnFollowUnfollow?.isSelected = obj.isFollow == "1"
            self.imgUser?.setImage(withUrl: obj.profileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            
            self.lblShowFollowing?.setFollowAttributedTextLable(firstText: obj.following, SecondText: "\nFollowing")
            self.lblShowFollowers?.setFollowAttributedTextLable(firstText: obj.followers, SecondText: "\nFollowers")
            self.lblPosts?.setFollowAttributedTextLable(firstText: obj.postCount, SecondText: "\nPosts")
            
            if obj.highlights != [] {
                self.arrhighlights = obj.highlights
                self.cvHighliths?.reloadData()
                self.vwHighlightsView?.isHidden = false
            } else {
                self.vwHighlightsView?.isHidden = true
            }
            let arrname = obj.fullName.components(separatedBy: " ")
            if arrname.count == 2 {
                self.lblUserName?.text = arrname.first ?? ""
                self.lblSubuserName?.text = arrname.last ?? ""
                self.vwsubnameView?.isHidden = false
            }
            else {
                self.lblUserName?.text = obj.fullName
                self.vwsubnameView?.isHidden = true
            }
            
            if obj.weight != "" {
                self.vwWeightView?.isHidden = false
            } else {
                self.vwWeightView?.isHidden = true
            }
            
            if obj.height != "" {
                self.vwHeightView?.isHidden = false
            } else {
                self.vwHeightView?.isHidden = true
            }
            if obj.headline != "" {
                self.vwHeadlineView?.isHidden = false
            } else {
                self.vwHeadlineView?.isHidden = true
            }
            if obj.gpa != "" {
                self.vwGpaView?.isHidden = false
            } else {
                self.vwGpaView?.isHidden = true
            }
            if obj.teamName != "" {
                self.vwTamView?.isHidden = false
            } else {
                self.vwTamView?.isHidden = true
            }
            if obj.playerPosition != "" {
                self.vwPlayesView?.isHidden = false
            } else {
                self.vwPlayesView?.isHidden = true
            }
            if obj.favoriteSportsTeam != "" {
                self.vwFavSportView?.isHidden = false
            } else {
                self.vwFavSportView?.isHidden = true
            }
            
            if obj.height != "" && obj.gpa != "" {
                self.VWMainHeightGpaView?.isHidden = false
            } else {
                self.VWMainHeightGpaView?.isHidden = true
            }
            self.lblContent?.text = obj.headline
            self.lblplayerposition?.text = obj.playerPosition
            self.lblTeamName?.text = obj.teamName
            self.lblHeight?.text = obj.height
            self.lblWeight?.text = obj.weight
            self.lblGpa?.text = obj.gpa
            self.lblfavsportTeam?.text = obj.favoriteSportsTeam
            self.lblRightSide?.text = obj.role.name
            self.lblLestSide?.text = obj.role.name
            self.lblSubUser?.text = "@\(obj.userName)"
            self.selectedRole = obj.role
            self.selectedCoach = obj.isCoach
            self.selectedSchool = obj.isClubTeams
            self.lblshowCoins?.text = obj.totalReward
            self.lblfax?.text = obj.fax
            self.lblphonenu?.text = obj.phone
            self.lblAthlatename?.text = obj.athleticDirector
            self.lblAthlateEmail?.text = obj.athleticDirectorEmail
            self.lblEmailContact?.text = obj.email
            
            switch self.selectedRole {
            case .fan:
                self.imgLeftFan?.isHidden = false
                self.imgRightFan?.isHidden = false
                self.imgLeftAthlate?.isHidden = true
                self.imgRightAthlate?.isHidden = true
                self.imgLeftSchool?.isHidden = true
                self.imgRightSchool?.isHidden = true
                self.imgLeftClub?.isHidden = true
                self.imgRightClub?.isHidden = true
                self.imgLeftRe?.isHidden = true
                self.imgRightRe?.isHidden = true
                self.imgLeftCoach?.isHidden = true
                self.imgRightCoach?.isHidden = true
                self.vwSportview?.isHidden = true
                self.vwMainContactView?.isHidden = true
                
            case .athlete:
                self.imgLeftFan?.isHidden = true
                self.imgRightFan?.isHidden = true
                self.imgLeftAthlate?.isHidden = false
                self.imgRightAthlate?.isHidden = false
                self.imgLeftSchool?.isHidden = true
                self.imgRightSchool?.isHidden = true
                self.imgLeftClub?.isHidden = true
                self.imgRightClub?.isHidden = true
                self.imgLeftRe?.isHidden = true
                self.imgRightRe?.isHidden = true
                self.imgLeftCoach?.isHidden = true
                self.imgRightCoach?.isHidden = true
                self.vwMainContactView?.isHidden = true
            case .schoolclub:
                switch self.selectedSchool {
                    
                case .Club:
                    self.vwMainContactView?.isHidden = false
                    self.imgLeftFan?.isHidden = true
                    self.imgRightFan?.isHidden = true
                    self.imgLeftAthlate?.isHidden = true
                    self.imgRightAthlate?.isHidden = true
                    self.imgLeftSchool?.isHidden = true
                    self.imgRightSchool?.isHidden = true
                    self.imgLeftClub?.isHidden = false
                    self.imgRightClub?.isHidden = false
                    self.imgLeftRe?.isHidden = true
                    self.imgRightRe?.isHidden = true
                    self.imgLeftCoach?.isHidden = true
                    self.imgRightCoach?.isHidden = true
                    
                case .School:
                    self.vwMainContactView?.isHidden = false
                    self.imgLeftFan?.isHidden = true
                    self.imgRightFan?.isHidden = true
                    self.imgLeftAthlate?.isHidden = true
                    self.imgRightAthlate?.isHidden = true
                    self.imgLeftSchool?.isHidden = false
                    self.imgRightSchool?.isHidden = false
                    self.imgLeftClub?.isHidden = true
                    self.imgRightClub?.isHidden = true
                    self.imgLeftRe?.isHidden = true
                    self.imgRightRe?.isHidden = true
                    self.imgLeftCoach?.isHidden = true
                    self.imgRightCoach?.isHidden = true
                    
                    break
                    
                case .none:
                    break
                }
                
            case .coachrecruiter:
                switch self.selectedCoach {
                case .Coach:
                    self.vwMainContactView?.isHidden = false
                    self.imgLeftFan?.isHidden = true
                    self.imgRightFan?.isHidden = true
                    self.imgLeftAthlate?.isHidden = true
                    self.imgRightAthlate?.isHidden = true
                    self.imgLeftSchool?.isHidden = true
                    self.imgRightSchool?.isHidden = true
                    self.imgLeftClub?.isHidden = true
                    self.imgRightClub?.isHidden = true
                    self.imgLeftRe?.isHidden = true
                    self.imgRightRe?.isHidden = true
                    self.imgLeftCoach?.isHidden = false
                    self.imgRightCoach?.isHidden = false
                    
                case .Recruiter:
                    self.vwMainContactView?.isHidden = false
                    self.imgLeftFan?.isHidden = true
                    self.imgRightFan?.isHidden = true
                    self.imgLeftAthlate?.isHidden = true
                    self.imgRightAthlate?.isHidden = true
                    self.imgLeftSchool?.isHidden = true
                    self.imgRightSchool?.isHidden = true
                    self.imgLeftClub?.isHidden = true
                    self.imgRightClub?.isHidden = true
                    self.imgLeftRe?.isHidden = false
                    self.imgRightRe?.isHidden = false
                    self.imgLeftCoach?.isHidden = true
                    self.imgRightCoach?.isHidden = true
                    break
                case .none:
                    break
                }
                
                
            case .none:
                break
            }
        }
        
    }
}
// MARK: - FeedCellDelegate
extension ProfileViewController : FeedCellDelegate {
    func btnPreviewImage(obj: AddPhotoVideoModel) {
        if obj.isVideo {
            if let videoURL = URL(string: obj.mediaNameUrl) {
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    if let myplayer = playerViewController.player {
                        myplayer.play()
                    }
                }
            }
        } else {
            self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
                vc.imageUrl = obj.mediaNameUrl
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
            })
        }
    }
    
    func btnReportSelect(btn: UIButton, obj: FeedModel) {
        self.showAlert(withTitle: "", with: "Are you sure want to delete this feed?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
            self.deleteFeed(feedID: obj.id)
        }, secondButton: ButtonTitle.No, secondHandler: nil)
    }
    
    
    func btnLikeSelect(btn: UIButton, cell: FeedCell) {
        self.view.endEditing(true)
        if let indexpath = self.tblFeed?.indexPath(for: cell) {
            if self.arrFeed.count > 0 {
                let obj = self.arrFeed[indexpath.row]
                var count : Int = Int(obj.totalLikeCount) ?? 0
                if btn.isSelected {
                    count = count + 1
                } else {
                    count = count - 1
                }
                obj.isLike = btn.isSelected ? "1" : "0"
                obj.totalLikeCount = "\(count)"
                self.setPostLikeDislike(isLike: btn.isSelected ? "1" : "0", PostID: self.arrFeed[indexpath.row].id)
                self.tblFeed?.reloadData()
            }
        }
    }
    
    func btnMoreSelect(btn : UIButton, cell: FeedCell) {
        
    }
    
    func btnUnLikeSelect(btn: UIButton,cell : FeedCell) {
        self.view.endEditing(true)
        
    }
}

// MARK: - IBAction

extension ProfileViewController : FeedDelegate{
    func updateFeedData() {
        self.reloadFeedData()
    }
}

//MARK: - IBAction Method
extension ProfileViewController {
    @IBAction func btnViewAllClick() {
        self.appNavigationController?.push(AlbumViewController.self,configuration:  { (vc) in
            
            vc.userId = self.userProfileData!.id
            vc.isfromother = self.isfromOther
        })
    }
    
    @IBAction func btnNavClick() {
        self.appNavigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChatClick() {
        
        self.appNavigationController?.push(MessageChatViewController.self,configuration: { (vc) in
            vc.chatUserID = self.selectedUserID
            vc.chatUserName = self.userProfileData!.userName
            vc.chatUserImage = self.userProfileData!.thumbprofileimage
            
        })
    }
    
    @IBAction func btnSettingClick() {
        self.appNavigationController?.push(AppSideMenuViewController.self)
    }
    
    
    @IBAction func btnDownloadClick() {
        self.GetResumeAPICall()
        
    }
    
    @IBAction func btnFollowUnfollowClick(_ sender : UIButton) {
        
        self.setFollow(isLike: sender.isSelected ? "1" : "0")
        
    }
    
    @IBAction func btnCoinClicked(_sender : UIButton) {
        if let user = UserModel.getCurrentUserFromDefault(),user.id != "" {
            if user.subscriptionId == "0" || user.subscriptionId == "" {
                self.appNavigationController?.present(SubscriptionPopupViewController.self,configuration: { (vc) in
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                })
            } else {
                self.appNavigationController?.push(MyRewardViewController.self)
            }
        }
    }
    @IBAction func btnFollowerClick(_ sender : UIButton) {
        self.appNavigationController?.push(ViewAllUserViewController.self,configuration: { vc in
            vc.isFromFollowers = true
            vc.Follow = "1"
            vc.userId = self.userProfileData?.id ?? ""
        })
    }
    
    @IBAction func btnFollowingClick(_ sender : UIButton) {
        self.appNavigationController?.push(ViewAllUserViewController.self,configuration: { vc in
            vc.isFromFollowing = true
            vc.Follow = "0"
            vc.userId = self.userProfileData?.id ?? ""
        })
    }
    
    @IBAction func btnPostClick(_ sender : UIButton) {
        self.appNavigationController?.push(ViewAllUserViewController.self,configuration: { vc in
            vc.isFromPost = true
            vc.userId = self.userProfileData?.id ?? ""
        })
    }
    
    @IBAction func btnReferClick(_ sender : UIButton) {
        self.appNavigationController?.push(ReferFriendViewController.self)
    }
    
    @IBAction func btnresume(_ sender : UIButton) {
        self.appNavigationController?.push(ResumeViewController.self,configuration: { vc in
            vc.userId = self.selectedUserID
        })
    }
    
    @IBAction func btnUpdateResume(_ sender : UIButton) {
        self.appNavigationController?.push(ResumeDetailViewController.self)
    }
}

// MARK: - ViewControllerDescribable
extension ProfileViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ProfileViewController: AppNavigationControllerInteractable { }

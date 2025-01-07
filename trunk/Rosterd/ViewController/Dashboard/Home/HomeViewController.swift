//
//  HomeViewController.swift
//  Rosterd
//
//  Created by WM-KP on 08/01/22.
//

import UIKit
import YPImagePicker


typealias typeAliasDictionary = [String:Any]

class HomeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwWriteSomethingMain: UIView?
    @IBOutlet weak var vwWriteSomethingSub: UIView?
    @IBOutlet weak var lblWriteSomething: UILabel?
    @IBOutlet weak var btnWriteSomething: UIButton?
    
    @IBOutlet weak var vwAdv: UIView?
    @IBOutlet weak var vwQuatesMain: UIView?
    @IBOutlet weak var vwQuatesSub: UIView?
    @IBOutlet weak var imgQuates: UIImageView?
    @IBOutlet weak var lblQuates: UILabel?
    @IBOutlet weak var btnQuates: UIButton?
    
    @IBOutlet weak var vwStoryMain: UIView?
    @IBOutlet weak var vwViewAllStorySub: UIView?
    @IBOutlet weak var lblViewAllStory: UILabel?
    @IBOutlet weak var lblNoData: NoDataFoundLabel?
    @IBOutlet weak var cvStory: UICollectionView?
    
    @IBOutlet weak var vwnolabel: UIView!
    @IBOutlet weak var vwFeedMain: UIView?
    @IBOutlet weak var tblFeed: UITableView?
    @IBOutlet weak var constraintTblFeedHeight: NSLayoutConstraint?
    
    @IBOutlet weak var vwCountSub: UIView?
    @IBOutlet weak var btnClose: UIButton?
    @IBOutlet weak var btnPrev: UIButton?
    @IBOutlet weak var btnNext: UIButton?
    @IBOutlet weak var lblCount: UILabel?
    @IBOutlet weak var cvadv: UICollectionView?
    // MARK: - Variables
    var selectedFeedData : FeedModel?
    private var arrFeed : [FeedModel] = []
    private var arradv : [AdvertiseModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    var selectedIndex = 0
    var selectedItems = [YPMediaItem]()
    var arrStoryMedia = [typeAliasDictionary]()
    var arrMyStoriesList = [StoryListModel]()
    var arrStoriesList = [StoryModel]()
    var arrayOfImages: [UIImage] = []
    //    private var arrSelectedImages : [AddPhotoVideoModel] = []
    var strMediaName: String = ""
    
    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WebSocketChat.shared.delegate = self
        self.addTableviewOberver()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let vw = self.vwWriteSomethingSub {
            vw.cornerRadius = vw.frame.height / 2.0
        }
        if let btn = self.btnQuates {
            btn.cornerRadius = btn.frame.height / 2.0
        }
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
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
    
    
}

// MARK: - Init Configure
extension HomeViewController {
    private func InitConfig(){
       // delay(seconds: 0.2) {
            self.reloadFeedData()
     //   }
        
        self.lblCount?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        self.lblCount?.textColor = UIColor.CustomColor.whitecolor
        
        self.btnClose?.backgroundColor = UIColor.CustomColor.black50Per
        self.btnNext?.backgroundColor = UIColor.CustomColor.cardBackColor
        self.btnPrev?.backgroundColor = UIColor.CustomColor.cardBackColor
        self.vwCountSub?.backgroundColor = UIColor.CustomColor.black50Per
        
        self.vwWriteSomethingSub?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        self.vwWriteSomethingSub?.borderColor = UIColor.CustomColor.borderColor4
        self.vwWriteSomethingSub?.borderWidth = 1.0
        
        self.lblWriteSomething?.textColor = UIColor.CustomColor.reusablePlaceholderColor
        self.lblWriteSomething?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        self.vwQuatesSub?.cornerRadius = 18.0
        self.imgQuates?.cornerRadius = 18.0
        self.btnQuates?.backgroundColor = UIColor.CustomColor.black50Per
        self.lblCount?.text = "1/\(self.arradv.count)"
        
        self.lblQuates?.setHomeQuotesAttributedText(firstText: "", SecondText: "\n ")
        
        self.vwnolabel?.isHidden = true
        if let cv = self.cvStory {
            cv.register(HomeStoryCell.self)
            cv.dataSource = self
            cv.delegate = self
            cv.reloadData()
        }
        
        if let cv = self.cvadv {
            
            cv.register(HomeSliderImageViewCell.self)
            cv.dataSource = self
            cv.delegate = self
            cv.isPagingEnabled = true
        }
        
        self.vwViewAllStorySub?.backgroundColor = UIColor.CustomColor.cardBackColor
        
        self.lblViewAllStory?.textColor = UIColor.CustomColor.viewAllColor
        self.lblViewAllStory?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblViewAllStory?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        self.vwViewAllStorySub?.roundCorners([.topRight,.bottomRight], radius: 25.0)
        
        self.tblFeed?.register(FeedCell.self)
        self.tblFeed?.estimatedRowHeight = 100.0
        self.tblFeed?.rowHeight = UITableView.automaticDimension
        self.tblFeed?.delegate = self
        self.tblFeed?.dataSource = self
        
        
        //        self.setupESInfiniteScrollinWithTableView()
        //        self.getDashboardList()
        //        self.getUserStory()
        
        self.tblFeed?.reloadData()
        
    }
}

//
////MARK: Pagination tableview Mthonthd
extension HomeViewController {
    
    private func reloadFeedData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrFeed.removeAll()
        self.tblFeed?.reloadData()
        self.getDashboardList()
    }
    private func reloadCommentFeedData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrFeed.removeAll()
        self.tblFeed?.reloadData()
        self.getDashboardList()
    }
    
    private func REloadStory() {
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrStoriesList.removeAll()
        self.cvStory?.reloadData()
        self.getUserStory()
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
                    self.getDashboardList()
                } else if self.pageNo <= self.totalPages {
                    self.getDashboardList(isshowloader: false)
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
extension HomeViewController {
    
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
                self.constraintTblFeedHeight?.constant = self.tblFeed?.contentSize.height ?? 0.0
            }
        }
    }
}
//MARK:- UITableView Delegate
extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFeed.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: FeedCell.self)
        if self.arrFeed.count > 0 {
            cell.setFeedData(obj: self.arrFeed[indexPath.row])
            
            cell.Delegate = self
            
        }
        cell.btnUsername?.tag = indexPath.row
        cell.btnUsername?.addTarget(self, action: #selector(self.btnUsernameClicked(_:)), for: .touchUpInside)
        
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
    
    @objc func btnUsernameClicked(_ sender : UIButton){
        if self.arrFeed.count > 0 {
            let obj = self.arrFeed[sender.tag]
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(ProfileViewController.self,configuration: { vc in
                //                vc.isbtnsettinf = true
                if UserModel.getCurrentUserFromDefault()?.id == obj.userId {
                    vc.isbtnMore = true
                    vc.isbtnchat = true
                    vc.selectedUserID = obj.userId
                    vc.isbtnsettinf = false
                    vc.isbtnRefer = false
                    vc.isfromUpdateResume = false
                }
                else {
                    vc.isbtnRefer = true
                    vc.isbtnsettinf = true
                    vc.selectedUserID = obj.userId
                    vc.isfromOther = true
                    vc.isbtnMore = false
                    vc.isfromUpdateResume = true
                }
                
            })
        }
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
                vc.likeType = .FeedLike
            })
        }
    }
    
    @objc func btnCommentClicked(_ sender : UIButton){
        self.appNavigationController?.detachRightSideMenu()
        self.appNavigationController?.push(FeedCommentViewController.self,configuration: { vc in
            vc.CommentId = self.arrFeed[sender.tag].id
            vc.delegate = self
        })
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

//MARK: - UICollectionView Delegate and Datasource Method
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.cvStory {
            return arrStoriesList.count == 0 ?  1 : arrStoriesList.count + 1
        } else if collectionView == self.cvadv {
            return self.arradv.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.cvadv {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeSliderImageViewCell.self)
            cell.setAdvData(obj: self.arradv[indexPath.row])
            return cell
        }
        else  if  collectionView == self.cvStory {
            
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeStoryCell.self)
            
            if indexPath.row == 0 {
                
                cell.isYourStory = true
                cell.btnAddStory?.tag = indexPath.row
                cell.btnAddStory?.addTarget(self, action: #selector(self.btnAddStoryClicked(_:)), for: .touchUpInside)
                cell.imgStory?.setImage(withUrl: UserModel.getCurrentUserFromDefault()?.thumbprofileimage ?? "", placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                cell.imgUserProfile?.setImage(withUrl: UserModel.getCurrentUserFromDefault()?.profileimage ?? "", placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            }
            else {
                if arrStoriesList.count > 0 {
                    cell.isYourStory = false
                    cell.btnusername?.isHidden = true
                    cell.setStoryData(obj:self.arrStoriesList[indexPath.row - 1])
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.cvStory {
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.cvStory {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.cvadv {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
            
            
        } else if collectionView == self.cvStory {
            return CGSize(width: collectionView.frame.size.height / 1.6, height: collectionView.frame.size.height)
        }
        return CGSize(width: 0, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvStory {
            if indexPath.row == 0 {
                self.appNavigationController?.push(TakeOrderImageViewController.self,configuration: { vc in
                    vc.delegate = self
                    
                })
                
            }
            else  if UserModel.getCurrentUserFromDefault()?.id == self.arrStoriesList[indexPath.row - 1].user_id {
                if arrStoriesList.count > 0 {
                    let storyInfo = arrStoriesList[indexPath.row - 1]
                    let userStory = StoryModel.init(id: UserModel.getCurrentUserFromDefault()?.id ?? "", user_id: UserModel.getCurrentUserFromDefault()?.id ?? "", mediaName: UserModel.getCurrentUserFromDefault()?.profileimage ?? "", isVideo: false, status: "", mediaUrl: UserModel.getCurrentUserFromDefault()?.thumbprofileimage ?? "", userName: UserModel.getCurrentUserFromDefault()?.userName ?? "", userProfileImage: UserModel.getCurrentUserFromDefault()?.thumbprofileimage ?? "", userProfileThumbImage: UserModel.getCurrentUserFromDefault()?.thumbprofileimage ?? "", isUnread: "", chatGroupId: "", storyList: storyInfo.storyList, thumbStoryVideoThumbImage: "", videoThumbImage: "")
                    let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.pages = [userStory]
                    vc.currentIndex = 0
                    vc.storyType = .MyStory
                    vc.onReloadStory = { () in
                        self.arrStoriesList.removeAll()
                        self.pageNo = 1
                        self.getUserStory()
                    }
                    
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }
            }
            else {
                if arrStoriesList.indices ~= indexPath.row - 1 {
                    let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.pages = arrStoriesList
                    vc.currentIndex = indexPath.row - 1
                    vc.storyType = .OtherStory
                    vc.onReloadStory = { () in
                        self.arrStoriesList.removeAll()
                        self.pageNo = 1
                        self.getUserStory()
                    }
                    vc.onShareStoryDismiss = { () in
                        print("Story Dismiss")
                    }
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }
                
            }
        } else if collectionView == self.cvadv {
            
            if self.arradv.count > 0 {
                let obj = self.arradv[indexPath.row]
                guard let urldata = URL(string: "\(obj.redirectLink)") else { return }
                let safariVC = SFSafariViewController(url: urldata)
                safariVC.delegate = self
                safariVC.modalTransitionStyle = .crossDissolve
                safariVC.modalPresentationStyle = .overFullScreen
                self.present(safariVC, animated: true,completion: nil)
            }
        }
        
    }
    @objc func btnCloseSliderClicked(_ sender : UIButton){
    }
    @objc func btnAddStoryClicked(_ sender : UIButton) {
        //        self.showPicker()
        //        setUpRootScene()
        self.appNavigationController?.push(TakeOrderImageViewController.self,configuration: { vc in
            vc.delegate = self
            
        })
        
    }
}


// MARK: - SFSafariViewControllerDelegate
extension HomeViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension HomeViewController: StorySetDelegate {
    
    func CollageStory(_ Image: UIImage) {
        var dict = typeAliasDictionary()
        dict["mediaName"] = "image"
        dict["media"] = Image
        dict["isVideo"] = "0"
        self.arrStoryMedia.append(dict)
        if self.arrStoryMedia.count > 0 {
            self.mediaAPIImagesAndVideoCall(self.arrStoryMedia)
        }
    }
    
    func setBoomRangStory(_ url: URL) {
       // delay(seconds: 0.1) {
            print("BOOM Images")
            //            if image.count > 0 {
            
            //                for i in 0..<image.count {
            //                    let img = image[i]
            var dict = typeAliasDictionary()
            dict["mediaName"] = "video"
            dict["media"] = url
            dict["isVideo"] = "1"
            //                }
            SVProgressHUD.show()
            do {
                let video = try NSData(contentsOf: url, options: .mappedIfSafe)
                print("movie saved")
                dict["data"] = video
                //arrData.append(video)
              //  delay(seconds: 0.2) {
                    SVProgressHUD.dismiss()
                    self.arrStoryMedia.append(dict)
                    if self.arrStoryMedia.count > 0 {
                        self.mediaAPIImagesAndVideoCall(self.arrStoryMedia,isBoomrang: false)
                    }
               // }
            } catch {
                print(error)
            }
       // }
    }
    
    func StorySet(_ image: UIImage) {
        
        var dict = typeAliasDictionary()
        dict["mediaName"] = "image"
        dict["media"] = image
        dict["isVideo"] = "0"
        self.arrStoryMedia.append(dict)
        if self.arrStoryMedia.count > 0 {
            self.mediaAPIImagesAndVideoCall(self.arrStoryMedia)
        }
    }
    
    func SetGallery() {
        self.showPicker()
    }
    
}


// MARK: - IBAction
extension HomeViewController : FeedDelegate{
    func updateFeedData() {
        self.reloadFeedData()
    }
}

extension HomeViewController : FeedCommentDelegate{
    func updateFeedCommentData() {
        self.reloadCommentFeedData()
    }
}

//MARK:- API Call
extension HomeViewController {
    
    private func getDashboardList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                klimit : "1000"
                
                
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            FeedModel.getDashboardList(with: param, isShowLoader: isshowloader,  success: { (subscriptionId,isSubscriptionActive,arrstory,arrFeed,arrAd,totalpage,msg) in
                self.REloadStory()
                self.tblFeed?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                self.arradv = arrAd
                self.lblCount?.text = "1/\(self.arradv.count)"
                self.cvadv?.reloadData()
                self.arrFeed.append(contentsOf: arrFeed)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
                self.lblNoData?.isHidden = self.arrFeed.count == 0 ? false : true
                self.tblFeed?.reloadData()
                self.vwnolabel?.isHidden = true
                if let userdata = UserModel.getCurrentUserFromDefault(),userdata.token != ""{
                        userdata.isSubscriptionActive = isSubscriptionActive
                        userdata.subscriptionId = subscriptionId
                        userdata.saveCurrentUserInDefault()
                }
            }, failure: {[unowned self] (statuscode,error, errorType,arradv) in
                print(error)
                self.tblFeed?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    self.REloadStory()
                    self.arradv = arradv
                    self.cvadv?.reloadData()
                    self.lblCount?.text = "1/\(self.arradv.count)"
                    self.lblNoData?.text = error
                    self.vwnolabel?.isHidden = false
                    if pageNo == 1 {
                        self.arrFeed.removeAll()
                    }
                    self.lblNoData?.isHidden = self.arrFeed.count == 0 ? false : true
                    self.tblFeed?.reloadData()
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                    }
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
                self.reloadFeedData()
                self.showMessage(msg, themeStyle: .success)
                
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    private func getUserStory(){
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kgetUserStory,
                                              kpage : "\(self.pageNo)",
                                             klimit : "1000",
        ]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
    
    private func saveuserstory(isBoomrang:Bool = false){
        var arrGallery : [[String:Any]] = []
        arrGallery = arrPhotoVideo.compactMap({ (model) -> [String:Any] in
            return [kmediaName:model.mediaName,kvideoThumbImage:model.videoThumbImgName]
        })
        
        var dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.ksaveuserstory,
                                        kmediaArray : arrGallery
        ]
        
        if isBoomrang {
            dictionary["type"] = "1"
        }
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
    
    private func mediaAPIImagesAndVideoCall(_ arrMedia : [typeAliasDictionary],isBoomrang:Bool = false) {
                
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
                
        UserModel.uploadMultipleImagesAndVideo(with: dict, arrMedia: arrMedia) { [unowned self] arr, msg in
            self.arrStoryMedia.removeAll()
            self.arrPhotoVideo = arr
            DispatchQueue.main.async {
                self.saveuserstory()
            }
        } failure: { statuscode, error, customError in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        }
    }
    private func mediaStoryAPIImagesAndVideoCall(_ arrMedia : [typeAliasDictionary]) {
                
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        UserModel.uploadStoryMultipleImagesAndVideo(with: dict, arrMedia: arrMedia) { [unowned self] arr, msg in
            self.arrPhotoVideo = arr
            self.arrStoryMedia.removeAll()
            DispatchQueue.main.async {
                self.saveuserstory()
            }
        } failure: { statuscode, error, customError in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        }
    }
    
    func setUpRootScene() {
        let cc = IGCameraController()
        let navController = UINavigationController(rootViewController: cc)
        navController.isNavigationBarHidden = true
        present(navController, animated: true, completion: nil)
    }
    
    func showPicker() {
        
        var config = YPImagePickerConfiguration()
        
        config.library.mediaType = .photoAndVideo
        config.library.itemOverlayType = .grid

        config.shouldSaveNewPicturesToAlbum = false
        
        /* Choose the videoCompression. Defaults to AVAssetExportPresetHighestQuality */
        config.video.compression = AVAssetExportPresetPassthrough
        
        config.startOnScreen = .library
        
        config.screens = [.library, .photo, .video]
        config.video.libraryTimeLimit = 1000.0
        
        /* Adds a Crop step in the photo taking process, after filters. Defaults to .none */
        config.showsCrop = .none
        config.wordings.libraryTitle = "Gallery"
        
        config.hidesStatusBar = false
        
        config.hidesBottomBar = false
        
        config.maxCameraZoomFactor = 2.0
        
        config.library.maxNumberOfItems = 5
        config.gallery.hidesRemoveButton = false
        
        config.library.preselectedItems = selectedItems
        let picker = YPImagePicker(configuration: config)
        
        picker.imagePickerDelegate = self
                
        picker.didFinishPicking { [weak picker] items, cancelled in
            if cancelled {
                picker?.dismiss(animated: true, completion: nil)
                return
            }
            self.selectedItems = items
            for i in 0..<items.count {
                let item = items[i]
                var dict = typeAliasDictionary()
                switch item {
                case .photo(let photo):
                    dict["mediaName"] = "image\(i)"
                    dict["media"] = photo.image
                    dict["isVideo"] = "0"
                case .video(let video):
                    dict["mediaName"] = "video\(i)"
                    dict["media"] = video.url
                    dict["isVideo"] = "1"
                }
                self.arrStoryMedia.append(dict)
            }
            print("Story Media:\(self.arrStoryMedia)")
            if self.arrStoryMedia.count > 0 {
                picker?.dismiss(animated: true, completion: nil)
                self.mediaStoryAPIImagesAndVideoCall(self.arrStoryMedia)
                
            }
        }
        //
        
        
        /* Single Photo implementation. */
        // picker.didFinishPicking { [weak picker] items, _ in
        //     self.selectedItems = items
        //     self.selectedImageV.image = items.singlePhoto?.image
        //     picker.dismiss(animated: true, completion: nil)
        // }
        /* Single Video implementation. */
        // picker.didFinishPicking { [weak picker] items, cancelled in
        //    if cancelled { picker.dismiss(animated: true, completion: nil); return }
        //
        //    self.selectedItems = items
        //    self.selectedImageV.image = items.singleVideo?.thumbnail
        //
        //    let assetURL = items.singleVideo!.url
        //    let playerVC = AVPlayerViewController()
        //    let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
        //    playerVC.player = player
        //
        //    picker.dismiss(animated: true, completion: { [weak self] in
        //        self?.present(playerVC, animated: true, completion: nil)
        //        print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
        //    })
        //}
        present(picker, animated: true, completion: nil)
    }
    
    
}

//MARK:- webSocketChatDelegate
extension HomeViewController : webSocketChatDelegate{
    
    
    func SendReceiveData(dict: [String : AnyObject]) {
        print(dict)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            print("Socket Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
        }
        
        
        if let hookmethod = dict[khookMethod] as? String {
            if hookmethod == AppConstant.WebSocketAPI.kgetUserStory {
                
                
                if let dataarr = dict[kData] as? [[String:Any]] {
                    let arrStories = dataarr.compactMap({StoryModel.init(fromDictionary: $0)})
                    
                    if arrStories.count > 0 {
                        self.arrStoriesList.append(contentsOf: arrStories)
                    }
                }
                
                //                  if let datamyarr = dict["myStory"] as? [[String:Any]] {
                //                      let arrMyStories = datamyarr.compactMap({StoryListModel.init(fromDictionary: $0)})
                //
                //                      if arrMyStories.count > 0 {
                //                          self.arrMyStoriesList = arrMyStories
                //                      }
                //
                //                  }
                self.cvStory?.reloadData()
                
                
                
                let totalpages : Int =  Int (dict["total_page"] as? String ?? "") ?? 0
                print(totalpages)
                self.totalPages = totalpages
            } else if  hookmethod == AppConstant.WebSocketAPI.ksaveuserstory {
                self.arrMyStoriesList.removeAll()
                self.arrStoriesList.removeAll()
                self.pageNo = 1
                self.cvStory?.reloadData()
                self.reloadFeedData()
            } else {
                return
            }
        }
    }
    
    
}



// YPImagePickerDelegate
extension HomeViewController: YPImagePickerDelegate {
    func noPhotos() {
        
    }
    
    func imagePickerHasNoItemsInLibrary(_ picker: YPImagePicker) {
        // PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    
    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
        return true
    }
}

// MARK: - FeedCellDelegate
extension HomeViewController : FeedCellDelegate {
    func btnReportSelect(btn: UIButton, obj: FeedModel) {
        self.showAlert(withTitle: "", with: "Are you sure want to delete this feed?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
            self.deleteFeed(feedID: obj.tbl_post_id)
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
    func btnPreviewImage(obj: AddPhotoVideoModel) {
        if obj.isVideo {
            if let videoURL = URL(string: obj.postimage) {
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
                vc.imageUrl = obj.postimage
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
            })
        }
    }
}



// MARK: - IBAction
extension HomeViewController {
    
    @IBAction func btnClosAdvClicked(_ sender : UIButton) {
        
        self.vwAdv?.isHidden = true
    }
    
    
    @IBAction func btnWriteSomethingClicked(_ sender: UIButton) {
    }
    @IBAction func btnQuatesClicked(_ sender: UIButton) {
    }
    @IBAction func btnViewAllStoryClicked(_ sender: UIButton) {
        self.appNavigationController?.detachRightSideMenu()
        self.appNavigationController?.push(ViewAllStoryViewController.self)
    }
    
    @IBAction func btnWhatsYourMindClicked(_ sender: UIButton) {
        self.appNavigationController?.detachRightSideMenu()
        self.appNavigationController?.push(CreatePostViewController.self,configuration: { vc in
            vc.delegate = self
        })
    }
    
    @IBAction func btnPrevClicked(_ sender : UIButton) {
        
        if selectedIndex == 0 {
            return
            
        } else {
            self.selectedIndex -= 1
            print("scrolle view : \(self.selectedIndex)")
            self.lblCount?.text = "\(selectedIndex + 1)/\(self.arradv.count)"
            self.cvadv?.scrollToItem(at:IndexPath(item: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
        
    }
    
    @IBAction func btnNextClicked(_ sender : UIButton) {
        
        if selectedIndex == self.arradv.count - 1 {
            return
            
        } else {
            self.selectedIndex += 1
            print("scrolle view : \(self.selectedIndex)")
            self.lblCount?.text = "\(selectedIndex + 1)/\(self.arradv.count)"
            self.cvadv?.scrollToItem(at:IndexPath(item: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
        
    }
    
}



//MARK: -  Scrollview Method
extension HomeViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
        self.selectedIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.lblCount?.text = "\(selectedIndex + 1)/\(self.arradv.count)"
    }
}
// MARK: - ViewControllerDescribable
extension HomeViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}

// MARK: - AppNavigationControllerInteractable
extension HomeViewController: AppNavigationControllerInteractable { }

//
//  ViewAllUserViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/12/22.
//

import UIKit

class ViewAllUserViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tblUserList: UITableView?
    
    
    // MARK: - Variables
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    var isFromFollowers : Bool = false
    var isFromFollowing : Bool = false
    var isFromPost : Bool = false
    var isFromEvent : Bool = false
    var Follow : String = ""
    var userId : String = ""
    var EventId : String = ""
    private var arrFollowing : [UserModel] = []
    private var arrFollowers : [UserModel] = []
    private var arrEventUser : [EventModel] = []
    private var arrPost : [FeedModel] = []
    private var arrEvent : [EventModel] = []
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Init Configure
extension ViewAllUserViewController {
    private func InitConfig(){
        
        self.tblUserList?.delegate = self
        self.tblUserList?.dataSource = self
        if self.isFromPost == true {
            self.tblUserList?.register(FeedCell.self)
        } else {
            self.tblUserList?.register(SuggestionsCell.self)
        }
        self.tblUserList?.separatorStyle = .none
        self.tblUserList?.rowHeight = UITableView.automaticDimension
        
        if isFromPost == true {
            self.getmyPosts()
        } else if isFromEvent == true {
            self.getEventBookingUser()
        } else {
            self.getFollowList()
        }
        self.setupESInfiniteScrollinWithTableView()
        
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if isFromFollowers == true {
            appNavigationController?.appsetUpNotificationWithTitle(title: "View Followers", TitleColor: UIColor.CustomColor.blackColor,navigationItem: self.navigationItem)
        } else if isFromFollowing == true {
            appNavigationController?.appsetUpNotificationWithTitle(title: "View Followings", TitleColor: UIColor.CustomColor.blackColor,navigationItem: self.navigationItem)
        }
        else {
            appNavigationController?.appsetUpNotificationWithTitle(title: "View All", TitleColor: UIColor.CustomColor.blackColor,navigationItem: self.navigationItem)
        }
        appNavigationController?.btnNextClickBlock = {
            self.appNavigationController?.push(HelpViewController.self)
        }
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()

    }
}


////MARK: Pagination tableview Mthonthd
extension ViewAllUserViewController {

    private func reloadFollowData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrFollowers.removeAll()
        self.arrFollowing.removeAll()
        self.arrEventUser.removeAll()
        self.arrPost.removeAll()
        self.tblUserList?.reloadData()
        if isFromPost == true {
            self.getmyPosts()
        } else if isFromEvent == true {
            self.getEventBookingUser()
        } else {
            self.getFollowList()
        }
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblUserList?.es.addPullToRefresh {
            [unowned self] in
            self.reloadFollowData()
        }

        self.tblUserList?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    if self.isFromPost == true {
                        self.getmyPosts()
                    } else if self.isFromEvent == true {
                        self.getEventBookingUser()
                    } else {
                        self.getFollowList()
                    }
                   
                } else if self.pageNo <= self.totalPages {
                    if self.isFromPost == true {
                        self.getmyPosts(isshowloader: false)
                    } else if self.isFromEvent == true {
                        self.getEventBookingUser(isshowloader: false)
                    } else {
                        self.getFollowList(isshowloader: false)
                    }
                } else {
                    self.tblUserList?.es.noticeNoMoreData()
                }
            } else {
                self.tblUserList?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblUserList?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblUserList?.es.noticeNoMoreData()
            }
            else {
                self.tblUserList?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblUserList?.es.stopLoadingMore()
            self.tblUserList?.es.noticeNoMoreData()
            self.isLoading = true
        }
    }
}

//MARK:- UITableView Delegate
extension ViewAllUserViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromFollowing == true {
            return self.arrFollowing.count
        } else if isFromFollowers == true {
            return self.arrFollowers.count
        } else if isFromPost == true {
            return self.arrPost.count
        } else if isFromEvent == true {
            return self.arrEventUser.count
        }
//        return self.arrsuggest.count
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFromPost == true {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: FeedCell.self)
            if self.arrPost.count > 0 {
                cell.setFeedData(obj: self.arrPost[indexPath.row])
                
                cell.Delegate = self
            }
            cell.btnLikeSelect?.tag = indexPath.row
            cell.btnLikeSelect?.addTarget(self, action: #selector(self.btnLikeClicked(_:)), for: .touchUpInside)
            
            cell.btnCommentSelect?.tag = indexPath.row
            cell.btnCommentSelect?.addTarget(self, action: #selector(self.btnCommentClicked(_:)), for: .touchUpInside)
            
            cell.btnReport?.tag = indexPath.row
            cell.btnReport?.addTarget(self, action: #selector(self.btnReportClicked(_:)), for: .touchUpInside)
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, with: SuggestionsCell.self)
            cell.vwUnfollow?.isHidden = true
            cell.lblSuggestionFollowers?.isHidden = true
            cell.vwREdemView?.isHidden = true
            cell.imgPro?.isHidden = true
            if isFromFollowing == true {
                cell.setUserData(obj: self.arrFollowing[indexPath.row])
            } else if isFromFollowers == true {
                cell.setUserData(obj: self.arrFollowers[indexPath.row])
            } else if isFromEvent == true {
                cell.vwREdemView?.isHidden = false
                cell.lblSuggestionFollowers?.isHidden = false
                cell.setEventUserData(obj: self.arrEventUser[indexPath.row])
                
            }
            
    //        if self.arrsuggest.count > 0 {
    //            cell.setsuggestion(obj: self.arrsuggest[indexPath.row])
    //            cell.vwaddSuggestion?.isHidden = false
    ////            cell.vwUnfollow?.isHidden = true
    //            cell.delegate = self
    //        }
            return cell
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func btnCommentClicked(_ sender : UIButton){
        self.appNavigationController?.detachRightSideMenu()
        self.appNavigationController?.push(FeedCommentViewController.self,configuration: { vc in
            vc.CommentId = self.arrPost[sender.tag].id
            
        })
    }
    
    @objc func btnLikeClicked(_ sender : UIButton){
       
        if self.arrPost.count > 0 {
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(FeedLikeViewController.self,configuration: { vc in
                vc.LikeId = self.arrPost[sender.tag].id
                //vc.isFromJobApplicant = false
            })
        }
    }
    
    @objc func btnReportClicked(_ sender : UIButton){
        if self.arrPost.count > 0 {
            let obj = self.arrPost[sender.tag]
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

extension ViewAllUserViewController {
    
    private func getFollowList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                kfollow : self.Follow,
                klimit : "10",
                kuserId : self.userId
               
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.getFollowList(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
                //self.arrUser.append(contentsOf: arr)
                self.tblUserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                
                if self.isFromFollowers == true {
                    self.arrFollowers.append(contentsOf: arr)
                } else if self.isFromFollowing == true  {
                    self.arrFollowing.append(contentsOf: arr)
                }
              
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
//                self.lblNoData?.isHidden = self.arrUser.count == 0 ? false : true
                self.tblUserList?.reloadData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblUserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
//                    self.arrUser.count == 0 ?  false : true
//                   0 self.lblNoData?.text = error
                    self.tblUserList?.reloadData()
                } else {
                    if !error.isEmpty {
//                        self.showMessage(error, themeStyle: .error)
                     
                    }
                }
            })
        }
    }
    
    private func getmyPosts(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                klimit : "10",
                kuserId : self.userId
               
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.getmyPosts(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
                //self.arrUser.append(contentsOf: arr)
                self.tblUserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                self.arrPost.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
//                self.lblNoData?.isHidden = self.arrUser.count == 0 ? false : true
                self.tblUserList?.reloadData()
                self.tblUserList?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblUserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    self.tblUserList?.reloadData()
                    self.tblUserList?.EmptyMessage(message: error)
                } else {
                    if !error.isEmpty {
                    }
                }
            })
        }
    }
    
    private func getEventBookingUser(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                klimit : "10",
                keventId : self.EventId
               
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            EventModel.getEventBookingUser(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
                //self.arrUser.append(contentsOf: arr)
                self.tblUserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                self.arrEventUser.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
                self.tblUserList?.reloadData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblUserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
//                    self.arrUser.count == 0 ?  false : true
//                   0 self.lblNoData?.text = error
                    self.tblUserList?.reloadData()
                } else {
                    if !error.isEmpty {
//                        self.showMessage(error, themeStyle: .error)
                     
                    }
                }
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
                self.reloadFollowData()
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
    
}

// MARK: - FeedCellDelegate
extension ViewAllUserViewController : FeedCellDelegate {
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
        if let indexpath = self.tblUserList?.indexPath(for: cell) {
            if self.arrPost.count > 0 {
                let obj = self.arrPost[indexpath.row]
                var count : Int = Int(obj.totalLikeCount) ?? 0
                if btn.isSelected {
                    count = count + 1
                } else {
                    count = count - 1
                }
                obj.isLike = btn.isSelected ? "1" : "0"
                obj.totalLikeCount = "\(count)"
                self.setPostLikeDislike(isLike: btn.isSelected ? "1" : "0", PostID: self.arrPost[indexpath.row].id)
                self.tblUserList?.reloadData()
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

extension ViewAllUserViewController : FeedDelegate{
    func updateFeedData() {
        self.reloadFollowData()
    }
}

// MARK: - ViewControllerDescribable
extension ViewAllUserViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension ViewAllUserViewController: AppNavigationControllerInteractable { }

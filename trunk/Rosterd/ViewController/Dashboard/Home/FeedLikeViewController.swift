 //
//  FeedLikeViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/02/22.
//

import UIKit

class FeedLikeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblLike: UILabel?
    @IBOutlet weak var tblLikeSuggestion: UITableView?
    @IBOutlet weak var lblNoData: NoDataFoundLabel?
    @IBOutlet weak var constrainttblLikeSuggestionHeight: NSLayoutConstraint?
    
    
    // MARK: - Variables
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    var LikeId : String = ""
    private var arrUser : [FeedUserLikeModel] = []
    var selectedpostData : FeedModel?
    private var selectedlikeData : FeedUserLikeModel?
    var likeType:LikeType = .Dummy
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableviewOberver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}
// MARK: - Init Configure
extension FeedLikeViewController {
    private func InitConfig(){
        
        self.lblLike?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        self.lblLike?.textColor = UIColor.CustomColor.appColor
        
        self.tblLikeSuggestion?.delegate = self
        self.tblLikeSuggestion?.dataSource = self
        self.tblLikeSuggestion?.register(SuggestionsCell.self)
        self.tblLikeSuggestion?.separatorStyle = .none
        self.tblLikeSuggestion?.estimatedRowHeight = 80
        self.tblLikeSuggestion?.rowHeight = UITableView.automaticDimension
        
        self.getPostsLikeList()

    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Likes", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

//MARK: Pagination tableview Mthonthd
extension FeedLikeViewController {
    
    private func reloadJobData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrUser.removeAll()
        self.tblLikeSuggestion?.reloadData()
        self.getPostsLikeList()
        
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblLikeSuggestion?.es.addPullToRefresh {
            [unowned self] in
            self.reloadJobData()
            //self.tblFeed.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        }
        tblLikeSuggestion?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getPostsLikeList()
                } else if self.pageNo <= self.totalPages {
                    self.getPostsLikeList(isshowloader: false)
                } else {
                    self.tblLikeSuggestion?.es.noticeNoMoreData()
                }
            } else {
                self.tblLikeSuggestion?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblLikeSuggestion?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblLikeSuggestion?.es.noticeNoMoreData()
            }
            else {
                self.tblLikeSuggestion?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblLikeSuggestion?.es.stopLoadingMore()
            self.tblLikeSuggestion?.es.noticeNoMoreData()
            self.isLoading = true
        }
        
    }
}

//MARK: - Tableview Observer
extension FeedLikeViewController {
    
    private func addTableviewOberver() {
        self.tblLikeSuggestion?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableviewObserver() {
        if self.tblLikeSuggestion?.observationInfo != nil {
            self.tblLikeSuggestion?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

            if let obj = object as? UITableView {
                if obj == self.tblLikeSuggestion && keyPath == ObserverName.kcontentSize {
                    self.constrainttblLikeSuggestionHeight?.constant = self.tblLikeSuggestion?.contentSize.height ?? 0.0
                }

            }
        }
}

//MARK:- UITableView Delegate
extension FeedLikeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUser.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: SuggestionsCell.self)
        cell.vwMainBG?.layer.borderWidth = 0
        if self.arrUser.count > 0 {
            cell.setLikeFeedUserData(obj: self.arrUser[indexPath.row])
            cell.imgPro?.isHidden = self.likeType == .FeedLike
            cell.vwaddSuggestion?.isHidden = true
            cell.delegate = self
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

// MARK: - FeedCellDelegate
extension FeedLikeViewController : SuggestionsCelldelegate {
    func btnplusSelect(btn: UIButton, cell: SuggestionsCell) {
        self.view.endEditing(true)
        
        if let indexpath = self.tblLikeSuggestion?.indexPath(for: cell) {
            if self.arrUser.count > 0 {
                let obj = self.arrUser[indexpath.row]
                obj.isFollow = btn.isSelected ? "1" : "0"
                self.setFollow(isLike: btn.isSelected ? "1" : "0",FollowId: self.arrUser[indexpath.row].id)
                self.tblLikeSuggestion?.reloadData()
            }
        }
              
    }
}
// MARK: - ViewControllerDescribable
extension FeedLikeViewController {
    
    private func getPostsLikeList(isshowloader :Bool = true) {
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kpostId : self.LikeId,
                klimit : "10",
                kpage : "\(self.pageNo)"
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedUserLikeModel.getPostLikeCommentUser(with: param, isShowLoader: isshowloader,  success: { (totalComments,totalLikes,arr,totalpage,msg) in
                //self.arrUser.append(contentsOf: arr)
                self.tblLikeSuggestion?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                self.lblLike?.text = "\(totalLikes) Likes"
//                self.lblLike = totalLikes
                self.arrUser.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
                self.lblNoData?.isHidden = self.arrUser.count == 0 ? false : true
                self.tblLikeSuggestion?.reloadData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
//                print(error)
                self.tblLikeSuggestion?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                self.lblNoData?.isHidden = self.arrUser.count == 0 ? false : true
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                    self.lblNoData?.text = error
                    self.tblLikeSuggestion?.reloadData()
                } else {
                    if !error.isEmpty {
//                        self.showMessage(error, themeStyle: .error)
                        //self.showAlert(withTitle: errorType.rawValue, with: error)
                    }
                }
            })
        }
    }
    
    private func setFollow(isLike : String,FollowId : String){
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kfollowId : FollowId,
                kisLike : isLike
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.setFollow(with: param, success: { (msg) in
                
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
//                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension FeedLikeViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}
// MARK: - AppNavigationControllerInteractable
extension FeedLikeViewController: AppNavigationControllerInteractable { }

//
//  FeedCommentViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/02/22.
//

import UIKit

protocol FeedCommentDelegate {
    func updateFeedCommentData()
}


class FeedCommentViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var txtMsg: UITextView?
    
    @IBOutlet weak var btnSend: UIButton?
    @IBOutlet weak var btnattch: UIButton?
    @IBOutlet weak var btnEmoji: UIButton?
    @IBOutlet weak var lblNoData: NoDataFoundLabel?
    
    @IBOutlet weak var vwChatviewMain: UIView?
    @IBOutlet weak var vwChatview: UIView?
    
    @IBOutlet weak var constrainttxtMsgHeight: NSLayoutConstraint?
    @IBOutlet weak var constraintvwMainBottom: NSLayoutConstraint?
    @IBOutlet weak var tblComment: UITableView?
    
    
    // MARK: - Variables
    // MARK: - Variables
    private var arrComment : [FeedUserLikeModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    var isFromNotification : Bool = false
    var CommentId : String = ""
    var selectedFeedData : FeedModel?
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    
    private let imagePicker = ImagePicker()
    private var mediaName : String = ""
    private var selectedCommentID : String = ""
    var delegate : FeedCommentDelegate?
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        self.addKeyboardObserver()
        self.configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObserver()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Enable IQKeyboardManager
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Disable IQKeyboardManager
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let vw = self.vwChatview {
            vw.cornerRadius = vw.frame.height / 2.0
        }
    }
}


// MARK: - Init Configure
extension FeedCommentViewController {
    private func InitConfig(){
        
       
        self.txtMsg?.placeholder = "Write a comment..."
        self.txtMsg?.placeholderColor = UIColor.CustomColor.whitecolor
        self.txtMsg?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.txtMsg?.textColor = UIColor.CustomColor.whitecolor
//        self.txtMsg?.centerVertically()
       
        self.vwChatview?.backgroundColor = UIColor.CustomColor.appColor
     
        self.tblComment?.register(CommentReplyCell.self)
        self.tblComment?.estimatedRowHeight = 100.0
        self.tblComment?.register(headerFooterViewType: CommentCell.self)
        self.tblComment?.estimatedSectionHeaderHeight = 100.0
        self.tblComment?.rowHeight = UITableView.automaticDimension
        self.tblComment?.sectionHeaderHeight = UITableView.automaticDimension
        self.tblComment?.delegate = self
        self.tblComment?.dataSource = self
        
        
        self.setupESInfiniteScrollinWithTableView()
        self.getPostLikeCommentUserList( isScrollBottom: false)
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Comments", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}
//MARK: - NotificateionValueDelegate methods
extension FeedCommentViewController {
    
    //MARK:- Notification observer for keyboard
    func addKeyboardObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        self.tblComment?.addGestureRecognizer(tapGesture)
    }
    
    func removeKeyboardObserver () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if #available(iOS 11, *) {
                if keyboardHeight > 0 {
                    keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                }
            }
            
            self.constraintvwMainBottom?.constant = keyboardHeight + (DeviceType.IS_PAD ? 18 : 9) + 30.0
            self.setScrollBottom()
            view.layoutIfNeeded()
        }
    }
    
    func setScrollBottom() {
        
        if let tblView = self.tblComment {
            let point = CGPoint(x: 0, y: (tblView.contentSize.height) + tblView.contentInset.bottom - tblView.frame.height)
                  if point.y >= 0{
                      tblView.setContentOffset(point, animated: true)
                  }
        }
       
       
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
}

//MARK: Pagination tableview Mthonthd
extension FeedCommentViewController {
    
    private func updateFeedCommentData(isScrollBottom :Bool = false){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrComment.removeAll()
        self.tblComment?.reloadData()
        self.getPostLikeCommentUserList(isshowloader: true, isScrollBottom: isScrollBottom)
//        self.getPostLikeCommentUserList(isshowloader: false, isScrollBottom: false,isFromPullRefresh : true)
      
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblComment?.es.addPullToRefresh {
            [unowned self] in
            self.selectedCommentID = ""
            self.txtMsg?.text = ""
            self.txtMsg?.placeholder = "Your Comment here..."
            
            self.updateFeedCommentData()
        }
        
        self.tblComment?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getPostLikeCommentUserList()
                } else if self.pageNo <= self.totalPages {
                    self.getPostLikeCommentUserList(isshowloader: false)
                } else {
                    self.tblComment?.es.noticeNoMoreData()
                }
            } else {
                self.tblComment?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblComment?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblComment?.es.noticeNoMoreData()
            }
            else {
                self.tblComment?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblComment?.es.stopLoadingMore()
            self.tblComment?.es.noticeNoMoreData()
            self.isLoading = true
        }
        
    }
}

//MARK:- UITableView Delegate
extension FeedCommentViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrComment.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrComment[section].childComments.count
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexpath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(for: indexpath, with: CommentReplyCell.self)
        
        if self.arrComment.count > 0, self.arrComment[indexpath.section].childComments.count > 0 {
            let obj = self.arrComment[indexpath.section].childComments[indexpath.row]
            cell.setCommentReplyFeedUserData(obj: obj)
            
          }
        return  cell
    }
            
            
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hview = tableView.dequeueReusableHeaderFooterView(CommentCell.self)
        
        if !self.arrComment.isEmpty {
            hview?.setCommentFeedUserData(obj: self.arrComment[section])
            
            hview?.btnReply?.tag = section
            hview?.btnReply?.addTarget(self, action: #selector(self.btnReplyClicked(_:)), for: .touchUpInside)
        }
        return hview
    }
    
   
   
    internal func tableView(_ tableView: UITableView,heightForHeaderInSection section: Int) -> CGFloat {
       return UITableView.automaticDimension
   }
 
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexpath: IndexPath) {
    
  }
    
   @objc func btnReplyClicked(_ sender : UIButton) {
    
       if self.arrComment.count > 0 {
           let obj = self.arrComment[sender.tag]
           self.txtMsg? .text = ""
           self.selectedCommentID = obj.id
           self.txtMsg?.placeholder = "Your Reply Here....."
           self.txtMsg?.becomeFirstResponder()

       }
   }
    
}
// MARK: - IBAction
extension FeedCommentViewController {
    @IBAction func btnSendcommentClicked(_ sender: UIButton) {
        if !(self.txtMsg?.isEmpty ?? false) {
            self.view.endEditing(true)
            self.SetCommentList()
        }    }
    
    @IBAction func btnAttachClicked(_ sender: UIButton) {
        self.imagePicker.pickImage(sender, "Select Media") { (img,url) in
        self.mediaAPICall(img: img)
    }
    }
}

//MARK:- API Call
extension FeedCommentViewController{
    
    private func getPostLikeCommentUserList(isshowloader :Bool = true,isScrollBottom :Bool = false,isFromPullRefresh : Bool = false){
        if let user = UserModel.getCurrentUserFromDefault(){
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kpostId : self.CommentId,
                klimit : "10",
                kpage : "\(self.pageNo)"
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedUserLikeModel.getPostLikeCommentUser(with: param,isShowLoader: isshowloader, isFromComment: true,  success: { (totalComments,totalLikes,arr,totalpage,msg) in
                //self.arrUser.append(contentsOf: arr)
                if self.pageNo == 1 {
                    self.arrComment.removeAll()
                }
                self.tblComment?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                
                self.arrComment.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
                self.lblNoData?.isHidden = self.arrComment.count == 0 ? false : true
                self.tblComment?.reloadData()
                
                //self.setScrollBottom()
                if isScrollBottom {
                    self.setTxtMsgHeight(value: 35.0)
                } else {
                    self.setScrollBottom()
                }
            }, failure: {[unowned self] (statuscode,error, errorType) in
//            print(error)
                self.tblComment?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                    if !error.isEmpty {
                        self.lblNoData?.isHidden = self.arrComment.count == 0 ? false : true
                        self.lblNoData?.text = error
                        self.tblComment?.reloadData()

                    }

                if isScrollBottom {
                    self.setTxtMsgHeight(value: 35.0)
                } else if !isFromPullRefresh {
                    self.setScrollBottom()
                }
            })
        }
    }
    
   
    
    private func mediaAPICall(img : UIImage) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadMedia(with: dict, image: img, success: { (msg) in
            self.mediaName = msg
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    

    
    private func SetCommentList(){
        if let user = UserModel.getCurrentUserFromDefault(){
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                ktype : self.selectedCommentID.isEmpty ? "0" : "1",
                kcommentId : self.selectedCommentID,
                kcommentType : "1",
                kcomment : self.txtMsg?.text ?? "",
                kpostId : self.CommentId
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedUserLikeModel.setPostComment(with: param) { strMessage in
//                LightOnLeadership.sharedInstance.isReloadCommunityData = true
                self.txtMsg?.text = ""
                self.selectedCommentID = ""
                self.txtMsg?.placeholder = "Your comment here..."
                self.delegate?.updateFeedCommentData()
                self.updateFeedCommentData()
            } failure: { statuscode, error, customError in
                print(error)
            }
        }
    }
    
}

//MARK:- Textfeild Delegate
extension FeedCommentViewController : UITextViewDelegate {
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
       // print(textView.contentSize.height)
        if textView.contentSize.height <= 120 && textView.contentSize.height > 35{
            self.setTxtMsgHeight(value: textView.contentSize.height)
        } else if textView.contentSize.height < 35 {
            self.setTxtMsgHeight(value: 35.0)
        }
    }
    
    private func setTxtMsgHeight(value : CGFloat){
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.constrainttxtMsgHeight?.constant = value
            self.setScrollBottom()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - ViewControllerDescribable
extension FeedCommentViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}

// MARK: - AppNavigationControllerInteractable
extension FeedCommentViewController: AppNavigationControllerInteractable{}

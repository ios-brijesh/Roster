//
//  FeedReportPopupViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/04/22.
//

import UIKit

protocol feedPopupDelegate {
    func feedReport(btn : UIButton,obj : FeedModel)
    func feedDelete(btn : UIButton,obj : FeedModel)
    func feedCommentReport(btn : UIButton,obj : FeedUserLikeModel)
    func feedCommentDelete(btn : UIButton,obj : FeedUserLikeModel)
    func UserReport(btn : UIButton,obj : ChatModel)
    func OrderDeleta(btn : UIButton, obj : ProductOrderModel)
}
class FeedReportPopupViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var lblheader: UILabel?
    
    @IBOutlet weak var vwsub: UIView?
    
    @IBOutlet weak var btnsubmit: AppButton?
    @IBOutlet weak var btnclose: UIButton?
    @IBOutlet weak var btncloseTouch: UIButton?
    
    @IBOutlet weak var vwreportText: ReusableTextview?
    @IBOutlet weak var constarintbottoView: NSLayoutConstraint?
    // MARK: - Variables
    var selectedFeedData : FeedModel?
    
    var isFromComment : Bool = false
    var selectedFeedCommentData : FeedUserLikeModel?
    
    var selectedUser : ChatModel?
    var selecdtedOrder : OrderDetailModel?
    var isFromChat : Bool = false
    var isfromAlbum  : Bool = false
    var isFromOrder : Bool = false
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        self.addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObserver()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.vwsub?.clipsToBounds = true
        self.vwsub?.shadow(UIColor.CustomColor.shadowColorBlack, radius: 5.0, offset: CGSize(width: -4, height: -5), opacity: 1)
        self.vwsub?.maskToBounds = false
    }
}

// MARK: - Init Configure
extension FeedReportPopupViewController {
    private func InitConfig(){
        
        self.btnclose?.backgroundColor = UIColor.CustomColor.appColor
        
        self.lblheader?.textColor = UIColor.CustomColor.TextColor
        self.lblheader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        
      
            self.vwsub?.roundCornersTest(corners: [.topLeft,.topRight], radius: 40.0)
        self.lblheader?.text = "\(self.isFromChat ? "User Chat" : "Feed") Report"
        self.lblheader?.text = "\(self.isFromOrder ? "Cancel Order" : " ")  "
        
//        self.isfromAlbum {
//            self.lblheader?.text = "Create Album Name"
//        }
    }
}

// MARK: - IBAction
extension FeedReportPopupViewController {
    @IBAction func btnsubmitClicked(_ sender: AppButton) {
        self.view.endEditing(true)
        if self.vwreportText?.txtInput?.isEmpty ?? false {
            self.showMessage("Please enter report text", themeStyle: .warning, presentationStyle: .top)
            return
        }
        if self.isFromChat {
            self.setUserChatReport()
        } else if self.isFromOrder{
            
            self.CancelOrderApi()
        }
        else {
            self.setFeedReport()
        }
    }
    
    @IBAction func btncloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: - NotificateionValueDelegate methods
extension FeedReportPopupViewController {
    
    //MARK:- Notification observer for keyboard
    func addKeyboardObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGestureHandler() {
        self.view.endEditing(true)
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
            
            self.constarintbottoView?.constant = keyboardHeight + 20.0
            view.layoutIfNeeded()
        }
    }
}
//MARK:- API Call
extension FeedReportPopupViewController{
    
    private func setFeedReport(){
        if let user = UserModel.getCurrentUserFromDefault(),let feeddata = self.selectedFeedData {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                ktbl_post_id : feeddata.id,
                kreport : (self.vwreportText?.txtInput?.text ?? "").encodindEmoji()
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedModel.setFeedReport(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                delay(seconds: 0.2) {
                    self.dismiss(animated: true, completion: nil)
                }
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func setUserChatReport(){
        if let user = UserModel.getCurrentUserFromDefault(),let userdata = self.selectedUser {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kuserId : userdata.id,
                kmessage : (self.vwreportText?.txtInput?.text ?? "").encodindEmoji()
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ChatModel.setUserReport(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                delay(seconds: 0.2) {
                    self.dismiss(animated: true, completion: nil)
                }
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func CancelOrderApi(){
        if let user = UserModel.getCurrentUserFromDefault(),let Order = self.selecdtedOrder {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                korderId : Order.id,
                korderCancleReason : (self.vwreportText?.txtInput?.text ?? "").encodindEmoji()
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ProductOrderModel.cancelOrder(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                delay(seconds: 0.2) {
                    self.dismiss(animated: true, completion: nil)
                }
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func SetUserAlbum(){
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kname : (self.vwreportText?.txtInput?.text ?? "").encodindEmoji()
            ]
            
//            if self.isfromAlbum,let obj = self.selectedAlbumData {
//                dict[kalbumId] = obj.id
//            } else {
//                dict[kalbumId] = ""
//            }
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.SetUserAlbum(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                delay(seconds: 0.2) {
                    self.dismiss(animated: true, completion: nil)
                }
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension FeedReportPopupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}
// MARK: - AppNavigationControllerInteractable
extension FeedReportPopupViewController: AppNavigationControllerInteractable { }

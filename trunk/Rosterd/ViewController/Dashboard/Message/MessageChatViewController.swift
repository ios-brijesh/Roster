//
//  MessageChatViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/02/22.
//

import UIKit
import IQKeyboardManager





class MessageChatViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var btnNav: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnrightnav: UIButton!
    @IBOutlet weak var btnEmoji: UIButton!
    @IBOutlet weak var btnattach: UIButton!
    @IBOutlet weak var btnSpeacker: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    
    @IBOutlet weak var txtmsg: UITextView!
    @IBOutlet weak var tblChat: UITableView!
    
    @IBOutlet weak var vwBottomview: UIView!
    @IBOutlet weak var vwbottomsubview: UIView!
    
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lblshowstatus: UILabel!
    @IBOutlet weak var imguser: UIImageView!
    
    @IBOutlet weak var constraintVWMainBottom: NSLayoutConstraint?
    @IBOutlet weak var constraintTxtMsgHeight: NSLayoutConstraint?
    
    
    @IBOutlet weak var NoLabel: NoDataFoundLabel!
    
    @IBOutlet weak var vwCenterContentMain: UIView?
    @IBOutlet weak var vwReportview: UIView!
    
    @IBOutlet weak var vwArchieve: UIView!
    @IBOutlet weak var vwBlock: UIView!
    @IBOutlet weak var vwReport: UIView!
    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var btnArchieve: UIButton!
    
    
    
    // MARK: - Variables
    
   
   private var arrChatMsg : [ChatModel] = []
    var isChatClose : Bool = false
    var FriendUserid : String = ""
    var ArchieveId : String = ""
    var chatUserID : String = ""
    private var chatGroupID : String = ""
    private var mediaName : String = ""
    private let imagePicker = ImagePicker()
    private var documentpicker = DocumentPicker()
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    var chatUserName : String = ""
    var chatUserImage : String = ""
    var loginUserId : String = ""
    var myBlockStatus : String = ""
    var friendBlockStatus : String = ""
//    var isOnline : String = ""
    var isFromChatInbox : Bool = false
    private var UserData : ChatModel?
    var isFromArchieve : Bool = false
    var isFromBlock : Bool = false
    var isFromReport : Bool = false
    var isVwFromArchieve : Bool = false
    lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.lightGray
            
            return refreshControl
        }()
    
    private var isOnlineUser : Bool = false {
        didSet {
            self.lblshowstatus?.text = isOnlineUser ? "Online" : "Offline"
            
        }
    }
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //WebSocketChat.shared.delegate = self
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        self.addKeyboardObserver()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
        self.removeKeyboardObserver()
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
    
    
        if let vw = self.vwbottomsubview {
            vw.cornerRadius = vw.frame.height / 2.0
        }
        
    }
}

// MARK: - Init Configure
extension MessageChatViewController {
    private func InitConfig(){
        self.vwBottomview?.isHidden = isChatClose
        self.vwBlock?.isHidden = isFromBlock
        self.vwReport?.isHidden = isFromReport
        self.vwArchieve?.isHidden = isVwFromArchieve
        self.btnArchieve?.setTitle(self.isFromArchieve ? "UnArchive" : "Archive", for: .normal)
        self.btnBlock?.setTitle(self.isFromBlock ? "UnBlock" : "Block", for: .normal)
        
        self.vwReportview?.isHidden = true
        
        self.imagePicker.viewController = self
        WebSocketChat.shared.delegate = self
        self.documentpicker.viewController = self
        
        if let user = UserModel.getCurrentUserFromDefault() {
            self.loginUserId = user.id
        }
        if  let vwReportview = self.vwReportview {
            vwReportview.clipsToBounds = true
            vwReportview.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwReportview.maskToBounds = false
            vwReportview.cornerRadius = 10.0

        }
        
        
        
        
        self.txtmsg?.placeholder = "Write a message..."
        self.txtmsg?.placeholderColor = UIColor.CustomColor.whitecolor
        self.txtmsg?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.txtmsg?.textColor = UIColor.CustomColor.whitecolor
//        self.txtMsg?.delegate = self
//        self.txtmsg?.centerVertically()
        
        //self.vwCenterContentMain?.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 30.0)
        
        self.vwbottomsubview?.backgroundColor = UIColor.CustomColor.appColor
        
        self.tblChat?.register(ChatCell.self)
        self.tblChat?.estimatedRowHeight = 100.0
        self.tblChat?.rowHeight = UITableView.automaticDimension
        self.tblChat?.delegate = self
        self.tblChat?.dataSource = self
        self.getChatListData()
        
        
        if let imguser = self.imguser {
            imguser.cornerRadius = imguser.frame.height / 2
        }
       
        self.btnBlock?.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
        self.btnBlock?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.btnReport?.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
        self.btnReport?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.btnArchieve?.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
        self.btnArchieve?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblusername?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.lblusername?.textColor = UIColor.CustomColor.appColor
        
        self.lblshowstatus?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblshowstatus?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblusername?.text = self.chatUserName
        self.imguser?.setImage(withUrl: self.chatUserImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
       
        self.isOnlineUser = false

    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl){
       self.getChatListData()
    }
}

//MARK: - NotificateionValueDelegate methods
extension MessageChatViewController {
    
    //MARK:- Notification observer for keyboard
    func addKeyboardObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        self.tblChat?.addGestureRecognizer(tapGesture)
    }
    
    func removeKeyboardObserver () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if #available(iOS 11, *) {
                if keyboardHeight > 0 {
                    keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom + 30.0
                }
            }
            
            self.constraintVWMainBottom?.constant = (keyboardHeight > 0) ? keyboardHeight : 30.0
            self.setScrollBottom()
         
            self.vwCenterContentMain?.layoutIfNeeded()
            view.layoutIfNeeded()
        }
    }
    
    func setScrollBottom() {
        
        if self.arrChatMsg.count > 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: self.arrChatMsg.count-1, section: 0)
                self.tblChat?.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
       
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
        self.setScrollBottom()
        view.layoutIfNeeded()
    }
}

//MARK:- UITableView Delegate
extension MessageChatViewController : UITableViewDataSource, UITableViewDelegate {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChatMsg.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ChatCell.self)
        cell.vwSendingStoryMainView?.isHidden = true
        cell.VwIncomingStoryMainView?.isHidden = true
        if self.arrChatMsg.count > 0 {
            let obj = self.arrChatMsg[indexPath.row]
            switch MessageReplyType.init(rawValue: obj.type) ?? .Text {
            case .Text:
                cell.SetChatMessageData(obj: obj, loginUserId: self.loginUserId)
                break
            case .Image:
                
                cell.SetChatImageViewData(obj: obj, loginUserId: self.loginUserId)

                cell.btnSendingimg?.tag = indexPath.row
                cell.btnincomingimg?.tag = indexPath.row
//
                cell.btnSendingimg?.addTarget(self, action: #selector(self.btnImgOpenClick(_:)), for: .touchUpInside)
                cell.btnincomingimg?.addTarget(self, action: #selector(self.btnImgOpenClick(_:)), for: .touchUpInside)
                
                break
            case .Video:
                break
                
            case .Doc:
                cell.SetChatFilesData(obj: obj, loginUserId: self.loginUserId)
        
                cell.btnIncomingOpendoc?.tag = indexPath.row
                cell.btnSendingOpendoc?.tag = indexPath.row
                
                cell.btnIncomingOpendoc?.addTarget(self, action: #selector(self.btnFilesOpenClick(_:)), for: .touchUpInside)
                cell.btnSendingOpendoc?.addTarget(self, action: #selector(self.btnFilesOpenClick(_:)), for: .touchUpInside)
                break
                
            case .Story:
                cell.SetChatStorysData(obj: obj, loginUserId: self.loginUserId)
                
                cell.btnSendingStory?.tag = indexPath.row
                cell.btnIncomingStory?.tag = indexPath.row
                
                cell.btnSendingStory?.addTarget(self, action: #selector(self.btnSendingStoryClick(_:)), for: .touchUpInside)
                cell.btnIncomingStory?.addTarget(self, action: #selector(self.btnSendingStoryClick(_:)), for: .touchUpInside)
                break
                
            case .Rsume:
                cell.SetChatResumeData(obj: obj, loginUserId: self.loginUserId)
                cell.btnSendingResume?.tag = indexPath.row
                cell.btnIncomingResume?.tag = indexPath.row
                cell.btnSendingResume?.addTarget(self, action: #selector(self.btnResumeClick(_:)), for: .touchUpInside)
                cell.btnIncomingResume?.addTarget(self, action: #selector(self.btnResumeClick(_:)), for: .touchUpInside)
                break
            }
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func btnResumeClick(_ sender : UIButton){
        if self.arrChatMsg.count > 0 {
            let obj = self.arrChatMsg[sender.tag].resumeShareProfileId
            self.appNavigationController?.push(ResumeViewController.self,configuration: { vc in
                vc.userId = obj
                vc.isFromChat = true
            })
            
        }
    }
    @objc func btnFilesOpenClick(_ sender : UIButton){
        if self.arrChatMsg.count > 0 {
            let obj = self.arrChatMsg[sender.tag]
            guard let urldata = URL(string: obj.message) else { return }
            let safariVC = SFSafariViewController(url: urldata)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @objc func btnImgOpenClick(_ sender : UIButton){
        if self.arrChatMsg.count > 0 {
            let obj = self.arrChatMsg[sender.tag]
            self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
                vc.imageUrl = obj.message
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
            })
        }
    }
    
    @objc func btnSendingStoryClick(_ sender : UIButton){
        if self.arrChatMsg.count > 0 {
            let obj = self.arrChatMsg[sender.tag]
            if obj.sender == UserModel.getCurrentUserFromDefault()?.id,let storyData = obj.storyData {
                let userStory = StoryModel.init(id: storyData.id , user_id: storyData.id , mediaName: storyData.mediaName , isVideo: false, status: "", mediaUrl: storyData.mediaUrl, userName: storyData.userName, userProfileImage: storyData.userProfileImage, userProfileThumbImage: storyData.userProfileThumbImage, isUnread: "", chatGroupId: "", storyList: [storyData], thumbStoryVideoThumbImage: "", videoThumbImage: "")
                let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
                vc.modalPresentationStyle = .overFullScreen
                vc.pages = [userStory]
                vc.currentIndex = 0
                vc.onReloadStory = { () in
                }
                vc.onShareStoryDismiss = { () in
                   print("Story Dismiss")
                }
                self.navigationController?.present(vc, animated: true, completion: nil)
            } else {
                if let storyData = obj.storyData {
                    
                    let userStory = StoryModel.init(id: storyData.id , user_id: storyData.id , mediaName: storyData.mediaName , isVideo: false, status: "", mediaUrl: storyData.mediaUrl , userName: storyData.userName , userProfileImage: storyData.userProfileImage, userProfileThumbImage: storyData.userProfileThumbImage, isUnread: "", chatGroupId: "", storyList: [storyData], thumbStoryVideoThumbImage: "", videoThumbImage: "")
                    let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
                    vc.modalPresentationStyle = .overFullScreen
                    vc.pages = [userStory]
                    vc.currentIndex = 0
                    vc.onReloadStory = { () in
                    }
                    vc.onShareStoryDismiss = { () in
                       print("Story Dismiss")
                    }
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }
            }
            
        }
    }
}

// MARK: - SFSafariViewControllerDelegate
extension MessageChatViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Textfeild Delegate
extension MessageChatViewController : UITextViewDelegate {
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height <= 120 && textView.contentSize.height > 35{
            self.setTxtMsgHeight(value: textView.contentSize.height)
        } else if textView.contentSize.height < 35 {
            self.setTxtMsgHeight(value: 35.0)
        }
    }
    
    private func setTxtMsgHeight(value : CGFloat){
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.constraintTxtMsgHeight?.constant = value
            self.setScrollBottom()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
// MARK: - Chat Messages Methods
extension MessageChatViewController {
    private func getChatListData(){
        

        self.NoLabel?.isHidden = self.arrChatMsg.count == 0 ? false : true
        self.NoLabel?.text = "Waiting for message list..."
        
        let dictionary : [String:Any] = [khookMethod: isFromChatInbox ? AppConstant.WebSocketAPI.kchatmessagelist : AppConstant.WebSocketAPI.kusermessagelist,
                                         kid : self.chatUserID,
                                         kpage : "\(self.pageNo)",
                                         klimit : "20"]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
        
    }
    
    private func sendMessage(msg : String,replytype: String,fileRealName : String = ""){
        
        self.txtmsg?.text = ""
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kmessage,
                                         krecipient_id : self.chatGroupID,
                                         kmessage : msg.encodindEmoji(),
                                         ktype : replytype]
       
        WebSocketChat.shared.writeSocketData(dict: dictionary)
        self.mediaName = ""
        self.setTxtMsgHeight(value: 35)
    }
    
    private func mediaAPICall(img : UIImage) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadMedia(with: dict, image: img, success: { (msg) in
            self.mediaName = msg
            
            self.sendMessage(msg: self.mediaName, replytype: MessageReplyType.Image.rawValue)
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
                
            }
        })
    }
    
    private func mediaPDFAPICall(fileUrl: URL? ,data : Data,filename : String) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadPDFMedia(with: dict, fileUrl: fileUrl, pdfdata: data, success: { (medianame,mediaurl) in
            //self.mediaName = msg
            self.sendMessage(msg: medianame, replytype: MessageReplyType.Doc.rawValue,fileRealName : filename)
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    
    private func ArchiveChatAddRemove(){
      if let user = UserModel.getCurrentUserFromDefault() {
          self.view.endEditing(true)
          
          let dict : [String:Any] = [
              klangType : Rosterd.sharedInstance.languageType,
              ktoken : user.token,
              kgroupId : self.ArchieveId
          ]
          
          let param : [String:Any] = [
              kData : dict
          ]
          
          ChatModel.ArchiveChatAddRemove(with: param, success: { (msg) in
              self.appNavigationController?.popToRootViewController(animated: true)
              self.showMessage(msg, themeStyle: .success)
              
              
          }, failure: {[unowned self] (statuscode,error, errorType) in
              print(error)
              if !error.isEmpty {
                  self.showMessage(error, themeStyle: .error)
              }
          })
      }
     }
    
    private func BlockUnblockChatUser(){
      if let user = UserModel.getCurrentUserFromDefault() {
          self.view.endEditing(true)
          
          let dict : [String:Any] = [
              klangType : Rosterd.sharedInstance.languageType,
              ktoken : user.token,
              kuserId : self.FriendUserid
          ]
          
          let param : [String:Any] = [
              kData : dict
          ]
          
          ChatModel.BlockUnblockChatUser(with: param, success: { (msg) in
              self.appNavigationController?.popToRootViewController(animated: true)
              self.showMessage(msg, themeStyle: .success)
          }, failure: {[unowned self] (statuscode,error, errorType) in
              print(error)
              if !error.isEmpty {
                  self.showMessage(error, themeStyle: .error)
              }
          })
      }
     }
    
    
    
    
    private func setUserData() {
        if let obj = self.UserData {
            
            self.lblusername?.text = obj.name
            self.imguser?.setImage(withUrl: obj.image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            
            
          
       
    
        }
    }
}



// MARK: - WebSocket Delegate
extension MessageChatViewController : webSocketChatDelegate{
    func SendReceiveData(dict: [String : AnyObject]) {
        print(dict)
      
        if let hookmethod = dict[khookMethod] as? String {
            if hookmethod == AppConstant.WebSocketAPI.kchatmessagelist || hookmethod == AppConstant.WebSocketAPI.kusermessagelist {
             
                self.refreshControl.endRefreshing()
                if let group = dict[kgroup] as? [String:Any] {
           
                    self.title = group[kname] as? String ?? ""
                    self.chatGroupID = group[kid] as? String ?? ""
                   
                    self.vwBottomview?.isHidden = self.myBlockStatus  == "1" || self.friendBlockStatus == "1" ? true : false
                    if self.myBlockStatus == "1" {
                        self.vwArchieve?.isHidden = true
                        self.vwReport?.isHidden = true
                        self.btnBlock?.setTitle("UnBlock", for: .normal)
                    }
                    
                    self.isOnlineUser = (group[kisOnline] as? String ?? "0") == "1"
                   
                    
                    self.lblusername?.text = self.chatUserName
                    self.imguser?.setImage(withUrl: self.chatUserImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    
                    
                    
                   
                }
                
                let totalpages = dict["total_page"] as? String ?? "0"
                print(totalpages)
                self.totalPages = Int(totalpages) ?? 0
                
                if let dataarr = dict[kData] as? [[String:Any]] {
                    let arrNewData = dataarr.compactMap(ChatModel.init)
                    var arrMainChatList : [ChatModel] = []
                    //arrMainChatList.append(contentsOf: arrNewData.reversed())
                    arrMainChatList.append(contentsOf: arrNewData)
//                    if self.arrChatMsg.count > 0 {
//                        arrMainChatList.append(contentsOf: self.arrChatMsg)
//                    }
                    self.arrChatMsg = arrMainChatList
                    
                        self.tblChat?.reloadData()
                    if self.pageNo == 1 {
                        self.setScrollBottom()
                    }
                  
                   
                }
                
                if self.pageNo == self.totalPages{
                    self.refreshControl.removeFromSuperview()
                    self.tblChat?.refreshControl = nil
                }
                
                self.pageNo = self.pageNo + 1
                self.NoLabel?.isHidden = self.arrChatMsg.count > 0 ? true : false
                self.NoLabel?.text = "No Messages Available!"
                
                
            }  else {
                if let dataarr = dict[kData] as? [String:Any],let model = ChatModel.init(dictionary: dataarr) {
                    self.arrChatMsg.append(model)
                    self.tblChat?.reloadData()
                    self.setScrollBottom()
                }
                self.NoLabel?.isHidden = self.arrChatMsg.count > 0 ? true : false
                self.NoLabel?.text = "No Messages Available!"
            }
        }
    }
}



//MARK: - IBAction Method
extension MessageChatViewController {
    
    @IBAction func btnBlockUserClick(_ sender : UIButton) {
        
        if btnBlock?.titleLabel?.text == "Block" {
      
        self.showAlert(withTitle: "", with: "Are you sure want to Block this chat User?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
            self.BlockUnblockChatUser()
        }, secondButton: ButtonTitle.No, secondHandler: nil)
     }
        else {
            self.showAlert(withTitle: "", with: "Are you sure want to UnBlock this chat User?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
                self.BlockUnblockChatUser()
            }, secondButton: ButtonTitle.No, secondHandler: nil)
        }
        
        
    }
    
    @IBAction func btnNavClick() {
        self.appNavigationController?.popViewController(animated: true)
       
    }
    
    @IBAction func btnAttchClick(_ sender : UIButton) {
        
        self.documentpicker.openDocumentPicker(){ (url) in
           
            if url != nil {
                do{
                    let imageData: Data = try Data(contentsOf: url)
                    //audio/mpeg
                    //self.fileName = url.lastPathComponent
                    self.mediaPDFAPICall(fileUrl:url,data: imageData,filename: url.lastPathComponent)
                    //m4a
                    print(imageData)
                }catch{
                    print("Unable to load data: \(error)")
                }
            }
        }
    }
    
    @IBAction func btnPlusClick(_ sender : UIButton) {
        self.view.endEditing(true)
        self.imagePicker.pickImage(sender, "Select Media") { (img,url) in
            self.mediaAPICall(img: img)
        }
    }
    
    @IBAction func btnSendeClick() {
        
        if !(self.txtmsg?.text ?? "").isValidString() {
             self.sendMessage(msg: self.txtmsg?.text ?? "", replytype: supportReplyType.message.rawValue)
        }
    }
    
    @IBAction func btnrightNavClick() {
        self.vwReportview?.isHidden = false
        
        
    }
    
    @IBAction func btnarchieveClick(_ sender : UIButton) {
    
        if btnArchieve?.titleLabel?.text == "Archive" {
      
        self.showAlert(withTitle: "", with: "Are you sure want to archive this chat User?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
            self.ArchiveChatAddRemove()
        }, secondButton: ButtonTitle.No, secondHandler: nil)
     }
        else {
            self.showAlert(withTitle: "", with: "Are you sure want to UnArchive this chat User?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
                self.ArchiveChatAddRemove()
            }, secondButton: ButtonTitle.No, secondHandler: nil)
        }
        
    }
    
    @IBAction func btnReportClick(_ sender : UIButton) {
       
        if self.arrChatMsg.count > 0 {
            let obj = self.arrChatMsg[sender.tag]
           
                self.appNavigationController?.detachRightSideMenu()
                self.appNavigationController?.present(FeedReportPopupViewController.self,configuration: { (vc) in
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.selectedUser = obj
                    vc.isFromChat = true
                })
        }
        
    }
}



// MARK: - ViewControllerDescribable
extension MessageChatViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Message
    }
}

// MARK: - AppNavigationControllerInteractable
extension MessageChatViewController: AppNavigationControllerInteractable { }

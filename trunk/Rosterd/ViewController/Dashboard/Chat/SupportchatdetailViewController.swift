//
//  SupportchatdetailViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 05/02/22.
//

import UIKit
import IQKeyboardManager

class SupportchatdetailViewController: UIViewController {
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var vwTopMain: UIView?
    @IBOutlet weak var vwCenterContentMain: UIView?
    @IBOutlet weak var vwBottomMain: UIView?
    @IBOutlet weak var vwChatSub: UIView?
    @IBOutlet weak var vwTopSubView: UIView?
    
    @IBOutlet weak var heightTopViewConstarint: NSLayoutConstraint?
    @IBOutlet weak var constraintVWMainBottom: NSLayoutConstraint?
    @IBOutlet weak var constraintTxtMsgHeight: NSLayoutConstraint?
    
    @IBOutlet weak var txtMsg: UITextView?
    
    @IBOutlet weak var tblChat: UITableView?
    
    @IBOutlet weak var btnEmoji: UIButton?
    @IBOutlet weak var btnSendMsg: UIButton?
    @IBOutlet weak var btnAttachment: UIButton?
    
    // MARK: - Variables
    private var arrChatMsg : [SupportChatModel] = []
    var isChatClose : Bool = false
    private var arrChatList = [SupportChatModel]()
    var ticketData : SupportChatModel?
    private var ticketId : String = ""
    private var mediaName : String = ""
    private let imagePicker = ImagePicker()
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addKeyboardObserver()
        
    }
    
    
        override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.heightTopViewConstarint?.constant = self.view.safeAreaInsets.top + 10.0
        print(self.heightTopViewConstarint?.constant ?? 0)
        
        self.vwCenterContentMain?.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 40.0)
        
        
        
        if let vw = self.vwChatSub {
            vw.cornerRadius = vw.frame.height / 2.0
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.removeKeyboardObserver()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    @IBAction func btnAttachmentClick(_ sender: UIButton){
        self.view.endEditing(true)
        self.imagePicker.pickImage(sender, "Select Media") { (img,url) in
            self.mediaAPICall(img: img)
        }
    }
}

// MARK: - Init Configure
extension SupportchatdetailViewController {
    private func InitConfig(){
        self.imagePicker.viewController = self
        WebSocketChat.shared.delegate = self
         txtMsg?.delegate = self
        if let obj = self.ticketData {
            self.ticketId = obj.id
        }
        self.txtMsg?.placeholder = "Write a message..."
        self.txtMsg?.placeholderColor = UIColor.CustomColor.whitecolor
        self.txtMsg?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.txtMsg?.textColor = UIColor.CustomColor.whitecolor
        //  self.txtMsg?.delegate = self
//        self.txtMsg?.centerVertically()
        
        self.vwChatSub?.backgroundColor = UIColor.CustomColor.appColor
        
        self.tblChat?.register(ChatCell.self)
        self.tblChat?.register(TicketChatHeaderCell.self)
        self.tblChat?.estimatedRowHeight = 100.0
        self.tblChat?.rowHeight = UITableView.automaticDimension
        self.tblChat?.delegate = self
        self.tblChat?.dataSource = self
        
        self.vwBottomMain?.isHidden = self.isChatClose
        self.getTicketDetailAPICall()
        self.getSuppportData()
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Support Chat", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
    
    
}

//MARK: - NotificateionValueDelegate methods
extension SupportchatdetailViewController {
    
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
                    keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                }
            }
            self.constraintVWMainBottom?.constant = keyboardHeight + (DeviceType.IS_PAD ? 18 : 9)
            self.setScrollBottom()
            view.layoutIfNeeded()
        }
    }
    
  
    
    func setScrollBottom() {
        if self.arrChatMsg.count > 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: self.arrChatMsg.count-1, section: 1)
                self.tblChat?.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
}
//MARK:- UITableView Delegate
extension SupportchatdetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.arrChatMsg.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketChatHeaderCell.self)
             if let obj = self.ticketData {
                 cell.lblTicketid?.text = "Ticket ID :\(obj.id)"
                 cell.lblTicketTitle?.text = obj.title
                 cell.lblTicketStatus?.text = obj.SupportDescription
                 
             }
            cell.layoutIfNeeded()
            return cell
        }
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ChatCell.self)
         let obj = self.arrChatMsg[indexPath.row]
        cell.vwMainSendingDocFilesView?.isHidden = true
        cell.vwMainIncomingDocFilesView?.isHidden = true
        cell.vwSendingStoryMainView?.isHidden = true
        cell.VwIncomingStoryMainView?.isHidden = true
        cell.VWExpireStoryView?.isHidden = true
        cell.vwResumeMainview?.isHidden = true
         cell.setSupportChatData(obj: obj)
        
        cell.btnSendingimg?.tag = indexPath.row
        cell.btnincomingimg?.tag = indexPath.row
//
        cell.btnSendingimg?.addTarget(self, action: #selector(self.btnImgOpenClick(_:)), for: .touchUpInside)
        cell.btnincomingimg?.addTarget(self, action: #selector(self.btnImgOpenClick(_:)), for: .touchUpInside)
             
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func btnImgOpenClick(_ sender : UIButton){
        if self.arrChatMsg.count > 0 {
            let obj = self.arrChatMsg[sender.tag]
            self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
                vc.imageUrl = obj.SupportDescription
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
            })
        }
    }
}

//MARK: - Textfeild Delegate
extension SupportchatdetailViewController : UITextViewDelegate {
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
            self.constraintTxtMsgHeight?.constant = -value
            self.setScrollBottom()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - IBAction
extension SupportchatdetailViewController {
    @IBAction func btnReferClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSendMsgClicked(_ sender: UIButton) {
        if !(self.txtMsg?.text ?? "").isValidString() {
             self.sendMessage(msg: self.txtMsg?.text ?? "", replytype: supportReplyType.message.rawValue)
        }
    }
    
    @IBAction func btnEmojiClicked(_ sender: UIButton) {
    }
    
    @IBAction func btnAttachClicked(_ sender: UIButton) {
        self.view.endEditing(true)
      
    }
}


// MARK: - ViewControllerDescribable
extension SupportchatdetailViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Chat
    }
}

// MARK: - AppNavigationControllerInteractable
extension SupportchatdetailViewController: AppNavigationControllerInteractable { }

//MARK:- WebSocket Chat Delegate
extension SupportchatdetailViewController : webSocketChatDelegate {
    private func getSuppportData(){
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kuserSupportTicketMessageList,
                                         kticket_id : self.ticketId]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
        
    }
    
    private func sendMessage(msg : String,replytype: String){
        if replytype == supportReplyType.message.rawValue {
            self.txtMsg?.text = ""
            self.setTxtMsgHeight(value: 60.0)
        }
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kuserSupportTicketReply,
                                         kticket_id : self.ticketId,
                                         kdescription : msg.encodindEmoji(),
                                         kreplyType : replytype]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
        self.mediaName = ""
    }
    
    
    func SendReceiveData(dict: [String : AnyObject]) {
        print(dict)
        if let hookmethod = dict[khookMethod] as? String {
            if hookmethod == AppConstant.WebSocketAPI.kuserSupportTicketMessageList {
                if let dataarr = dict[kData] as? [[String:Any]] {
                    self.arrChatMsg = dataarr.compactMap(SupportChatModel.init)
                    self.tblChat?.reloadData()
                    self.setScrollBottom()
                }
            } else {
                if let dataarr = dict[kData] as? [String:Any],let model = SupportChatModel.init(dict: dataarr) {
                    self.arrChatMsg.append(model)
                    self.tblChat?.reloadData()
                    self.setScrollBottom()
                }
            }
        }
    }
}

extension SupportchatdetailViewController {
    
    private func getTicketDetailAPICall() {
        if let user = UserModel.getCurrentUserFromDefault(),let ticketdata = self.ticketData {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kticketId : ticketdata.id
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            SupportChatModel.getTicketDetail(with: param, isShowLoader: true,  success: { (ticket,msg) in
                //self.arrResources = arr
                self.ticketData = ticket
                if let obj = self.ticketData {
                    self.isChatClose = obj.status == "0"
//                    self.btnMore?.isHidden = !(obj.status == "0")
                }
               
                self.tblChat?.reloadSections(IndexSet(integer: 0), with: .none)
                //self.btnReopen.isHidden = ticket.status == "0" ? false : true
                self.vwBottomMain?.isHidden = ticket.status == "0" ? true : false
                //self.vwBottomSpace.backgroundColor = ticket.status == "0" ? UIColor.clear : UIColor.CustomColor.chatBackColor
                //self.configureNavigationBar(hideReopenBtn: ticket.status == "0" ? false : true)
                self.setScrollBottom()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                } else {
                    if !error.isEmpty {
                      
                        self.showMessage(error, themeStyle: .error)
                    }
                }
            })
        }
    }
    private func reopenTicketAPICall() {
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kticketId : "\(self.ticketId)"
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            SupportChatModel.reopenTicket(with: param, isShowLoader: true,  success: { (msg) in
                
                self.vwBottomMain?.isHidden = false
                if let data = self.ticketData{
                    data.status = "1"
                }
                //self.vwBottomSpace.backgroundColor = UIColor.CustomColor.chatBackColor
                self.tblChat?.reloadSections(IndexSet(integer: 0), with: .none)
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                } else {
                    if !error.isEmpty {
                        //self.showAlert(withTitle: errorType.rawValue, with: error)
                        self.showMessage(error, themeStyle: .error)
                    }
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
               
               self.sendMessage(msg: self.mediaName, replytype: MessageReplyType.Image.rawValue)
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               if !error.isEmpty {
                   self.showMessage(error, themeStyle: .error)
                   
               }
           })
       }
    
}

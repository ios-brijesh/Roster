//
//  MessageChildViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/01/22.
//

import UIKit

class MessageChildViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tblMessage: UITableView?
    
    @IBOutlet weak var LblNoData: NoDataFoundLabel?
    
    
    // MARK: - Variables
    var selecetdTab : SegmentMessageTabEnum = .Message
    private var arrChatList : [ChatModel] = []
    
    var searchText : String = ""
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WebSocketChat.shared.delegate = self
        self.getChatListData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchNotification(notification:)), name: Notification.Name(NotificationPostname.kSearchChatClick), object: nil)
    }
}

// MARK: - Init Configure
extension MessageChildViewController {
    private func InitConfig(){
       
        self.tblMessage?.register(MessageCell.self)
        self.tblMessage?.estimatedRowHeight = 30.0
        self.tblMessage?.rowHeight = UITableView.automaticDimension
        self.tblMessage?.delegate = self
        self.tblMessage?.dataSource = self
        
        self.setupESInfiniteScrollinWithTableView()
        
    }
    
    @objc func searchNotification(notification: Notification) {
        if notification.object != nil {
            if let notificationdata : String = notification.object as? String {
                self.searchText = notificationdata
                self.reloadChatData()
            }
        }
    }
}



//MARK: Pagination tableview Mthonthd
extension MessageChildViewController {
    
    private func reloadChatData(){
        self.view.endEditing(true)
        self.arrChatList.removeAll()
        self.tblMessage?.reloadData()
        self.getChatListData()
    }
    

    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblMessage?.es.addPullToRefresh {
            [unowned self] in
            self.reloadChatData()
        }
    }
}



//MARK:- UITableView Delegate
extension MessageChildViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChatList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.selecetdTab {
        case .Message:
            let cell = tableView.dequeueReusableCell(for: indexPath, with: MessageCell.self)
            cell.setChatMessageMentorData(obj: self.arrChatList[indexPath.row])
            cell.vwLastview?.isHidden = true
            cell.lblfollow?.isHidden = true
            return cell
        case .Request:
            let cell = tableView.dequeueReusableCell(for: indexPath, with: MessageCell.self)
           
            if self.arrChatList.count > 0 {
                cell.setChatRequestMentorData(obj: self.arrChatList[indexPath.row])
                cell.imgpro?.isHidden = true
                cell.lblSubname?.isHidden = true
                cell.vwSeprateview?.isHidden = true
                cell.vwMainview?.borderWidth = 1.2
                cell.vwMainview?.cornerRadius = 20
                
                cell.btnAccept?.tag = indexPath.row
                cell.btnAccept?.addTarget(self, action: #selector(self.btnAcceptRequest(_:)), for: .touchUpInside)
                
//                cell.btnApproveRequest?.tag = indexPath.row
//                cell.btnApproveRequest?.addTarget(self, action: #selector(self.btnApproveRequest(_:)), for: .touchUpInside)
            }
//         
            return cell
        case .Archieve:
            let cell = tableView.dequeueReusableCell(for: indexPath, with: MessageCell.self)
            if self.arrChatList.count > 0 {
                cell.setArchieveData(obj: self.arrChatList[indexPath.row])
                cell.imgpro?.isHidden = true
                cell.lblfollow?.isHidden = true
                cell.vwLastview?.isHidden = true
                
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.selecetdTab {
        case .Message:
            self.view.endEditing(true)
            if self.arrChatList.count > 0 {
                let obj = self.arrChatList[indexPath.row]
                self.appNavigationController?.push(MessageChatViewController.self,configuration: { (vc) in
                    vc.chatUserID = obj.id
                    vc.chatUserName = obj.name
                    vc.chatUserImage = obj.thumbImage
                    vc.isFromChatInbox = true
                    vc.FriendUserid = obj.friendUserId
                    vc.ArchieveId = obj.id
                    vc.myBlockStatus = obj.myBlockStatus
                    vc.friendBlockStatus = obj.friendBlockStatus

                    
                    
                })
            }
        case .Request:
            break
        case .Archieve:
            self.view.endEditing(true)
            if self.arrChatList.count > 0 {
                let obj = self.arrChatList[indexPath.row]
                self.appNavigationController?.push(MessageChatViewController.self,configuration: { (vc) in
                    vc.chatUserID = obj.id
                    vc.chatUserName = obj.name
                    vc.chatUserImage = obj.thumbImage
                    vc.isFromChatInbox = true
                    vc.isFromArchieve = true
                    vc.isFromBlock = true
                    vc.isFromReport = true
                    vc.isChatClose = true
                    vc.ArchieveId = obj.id

                })
            }
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        switch self.selecetdTab {
            
        case .Message:
            return nil
        
        case .Request:
        let item = UIContextualAction(style: .normal, title: "") {  (contextualAction, view, boolValue) in
            //Write your code in here
            self.showAlert(withTitle: "", with: "Are you sure want to Reject this chat request?", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
                if self.arrChatList.count > 0 {
                    self.RejectChatRequest(groupId: self.arrChatList[indexPath.row].id)
                   
                }
            }, secondButton: ButtonTitle.No, secondHandler: nil)
            self.reloadChatData()
        }
        item.image = UIImage(named: "ic_RejectButton")
        item.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        swipeActions.performsFirstActionWithFullSwipe = false
    
        return swipeActions
        case .Archieve:
            return nil
        }
    }
    
    @objc func btnAcceptRequest(_ sender : UIButton){
        if self.arrChatList.count > 0 {
            let obj = self.arrChatList[sender.tag]
            
            if obj.isAdmin == "0" {
               self.showAlert(withTitle: "", with: "Are you sure want to Accept this chat request?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
                 self.AcceptChatRequest(groupId: self.arrChatList[sender.tag].id)
              }, secondButton: ButtonTitle.No, secondHandler: nil)
        }
            else {
                self.showAlert(withTitle: "", with: "Are you sure want to Remove this chat request?", firstButton: ButtonTitle.Yes, firstHandler: { alert in
                  self.RemoveChatRequest(groupId: self.arrChatList[sender.tag].id)
               }, secondButton: ButtonTitle.No, secondHandler: nil)
            }
        }
        
    }

 }

//MARK:- webSocketChatDelegate
extension MessageChildViewController : webSocketChatDelegate{
    func SendReceiveData(dict: [String : AnyObject]) {
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            print("Socket Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
        }
//        self.reloadChatData()
        
        //var noDataText : String = "No messages available!"
        if self.selecetdTab == .Message {
            self.LblNoData?.text = "No messages available!"
        } else if self.selecetdTab == .Request {
            self.LblNoData?.text = "No requests available!"
        } else if self.selecetdTab == .Archieve {
            self.LblNoData?.text = "No archived messages!"
        }
        
        self.tblMessage?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        if let hookmethod = dict[khookMethod] as? String {
            
            //self.lblNoData?.text = ""
            if hookmethod == AppConstant.WebSocketAPI.kchatinbox || hookmethod == AppConstant.WebSocketAPI.krequestinbox {
                //self.refreshControl.endRefreshing()
                self.arrChatList.removeAll()
                self.tblMessage?.reloadData()
                if let dataarr = dict[kData] as? [[String:Any]] {
                    self.arrChatList = dataarr.compactMap(ChatModel.init)
                    
                    self.LblNoData?.isHidden = !self.arrChatList.isEmpty
                    //self.lblNoData?.text = noDataText
                    self.tblMessage?.reloadData()
                } else {
                    self.LblNoData?.isHidden = false
                    //self.lblNoData?.text = noDataText
                }
            } else if hookmethod == AppConstant.WebSocketAPI.kremovechatmessagelist {
                //self.showMessage("Chat Deleted Successfully")
                self.getChatListData()
                print("Chat Deleted Successfully")
            } else if hookmethod == AppConstant.WebSocketAPI.ksetacceptdeclinerequest {
                self.reloadChatData()
            } else {
                self.LblNoData?.isHidden = !self.arrChatList.isEmpty
               // self.lblNoData?.text = noDataText
            }
        }
    }
    
    private func getChatListData(){
       
        self.LblNoData?.isHidden = false
        var noDataText : String = ""
        if self.selecetdTab == .Request {
            noDataText = ""
        } else if self.selecetdTab == .Archieve {
            noDataText = ""
        }
        self.LblNoData?.text = noDataText
        


        var hookName : String = AppConstant.WebSocketAPI.kchatinbox
        print("tab Name : \(self.selecetdTab)")
        if self.selecetdTab == .Message {
            hookName = AppConstant.WebSocketAPI.kchatinbox
        } else if self.selecetdTab == .Request{
            hookName = AppConstant.WebSocketAPI.kchatinbox
        } else if self.selecetdTab == .Archieve {
            hookName = AppConstant.WebSocketAPI.kchatinbox
        }
        if !hookName.isEmpty {
            let dictionary : [String:Any] = [khookMethod: hookName,
                                                ksearch : self.searchText,
                                                  ktype : self.selecetdTab.apiValue]
            WebSocketChat.shared.writeSocketData(dict: dictionary)
        } else {
            self.LblNoData?.isHidden = false
            self.LblNoData?.text = "No archived messages!"
        }
    }
    
    func realodUserData(){
        self.arrChatList.removeAll()
        self.tblMessage?.reloadData()
    }
    
    private func deleteChat(id : String){
        
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kremovechatmessagelist,
                                         kid : id]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
    
    private func approveRejectChat(id : String,iaApprove : Bool){
        
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.ksetacceptdeclinerequest,
                                         kid : id,
                                         ktype : iaApprove ? "1" : "2"]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
}

extension MessageChildViewController {
  private func AcceptChatRequest(groupId : String){
    if let user = UserModel.getCurrentUserFromDefault() {
        self.view.endEditing(true)
        
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType,
            ktoken : user.token,
            kgroupId : groupId
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        ChatModel.AcceptChatRequest(with: param, success: { (msg) in
            self.showMessage(msg, themeStyle: .success)
            self.getChatListData()
            self.reloadChatData()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
   }
    
    private func RemoveChatRequest(groupId : String){
      if let user = UserModel.getCurrentUserFromDefault() {
          self.view.endEditing(true)
          
          let dict : [String:Any] = [
              klangType : Rosterd.sharedInstance.languageType,
              ktoken : user.token,
              kgroupId : groupId
          ]
          
          let param : [String:Any] = [
              kData : dict
          ]
          
          ChatModel.RemoveChatRequest(with: param, success: { (msg) in
              self.showMessage(msg, themeStyle: .success)
              self.getChatListData()
              self.reloadChatData()
          }, failure: {[unowned self] (statuscode,error, errorType) in
              print(error)
              if !error.isEmpty {
                  self.showMessage(error, themeStyle: .error)
              }
          })
      }
     }
    
    private func RejectChatRequest(groupId : String){
      if let user = UserModel.getCurrentUserFromDefault() {
          self.view.endEditing(true)
          
          let dict : [String:Any] = [
              klangType : Rosterd.sharedInstance.languageType,
              ktoken : user.token,
              kgroupId : groupId
          ]
          
          let param : [String:Any] = [
              kData : dict
          ]
          
          ChatModel.RejectChatRequest(with: param, success: { (msg) in
              self.showMessage(msg, themeStyle: .success)
              self.getChatListData()
              self.reloadChatData()
          }, failure: {[unowned self] (statuscode,error, errorType) in
              print(error)
              if !error.isEmpty {
                  self.showMessage(error, themeStyle: .error)
              }
          })
      }
     }
    
    
    
}
// MARK: - ViewControllerDescribable
extension MessageChildViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Message
    }
}

// MARK: - AppNavigationControllerInteractable
extension MessageChildViewController: AppNavigationControllerInteractable { }

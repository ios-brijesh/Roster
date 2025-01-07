//
//  ViewStoryViewController.swift
//  Intro
//
//  Created by WM-KP on 13/12/21.
//  Copyright © 2021 Developer. All rights reserved.
//

import UIKit

class ViewStoryViewController: UIViewController {

    @IBOutlet weak var lblHeaderText: UILabel!
    @IBOutlet weak var vwSearchConnection: UIView!
    @IBOutlet weak var vwShareAction: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var lblNodata: NoDataFoundLabel!
    var onStartStory:(() -> Void)?
    var onShareStory:(() -> Void)?
    var isShareStory = false
    var storyID = ""
    var arrViewList = [ModelViewStory]()
    var arrUserList = [ModelUserListNew]()
    var arrSelectedUserList = [ModelUserListNew]()
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    @IBOutlet weak var tblViewStory: UITableView!{
        didSet {
            self.tblViewStory?.register(StoryViewCell.self)
            self.tblViewStory?.delegate = self
            self.tblViewStory?.dataSource = self
            self.tblViewStory?.separatorStyle = .none
            self.tblViewStory?.tableFooterView = UIView.init(frame: .zero)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if isShareStory {
            lblHeaderText.text = "Share Story"
            vwSearchConnection.isHidden = false
            vwShareAction.isHidden = false
//            callWsForGetAllUserList("")
//            getUserStoryViewList()
        }
        else {
            lblHeaderText.text = "Story Views"
            vwSearchConnection.isHidden = true
            vwShareAction.isHidden = true
            if storyID != "" {
                self.tblViewStory.reloadData()
                if self.arrViewList.count > 0 {
                    self.tblViewStory.EmptyMessage(message: "")
                }
                else{
                    self.tblViewStory.EmptyMessage(message: "")

                }
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WebSocketChat.shared.delegate = self
         if  self.isShareStory {
            self.getUsersFollowListAPICall("")
        } else {
            self.getUserStoryViewList()
        }
       
//        kAppDelegate.connectSocket()
    }
    
    @IBAction func btnCancelClick(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let onStart = self.onStartStory {
                onStart()
            }
        }
    }
    
    @IBAction func btnShareClick(_ sender: UIButton) {
      
        if arrSelectedUserList.count > 0 {
            GetsaveStoryReply(arrSelectedUserList)
//            hideLoaderHUD()
            self.dismiss(animated: true) {
                if let onShare = self.onShareStory {
                    onShare()
                }
            }
         
        }
    }
    @IBAction func btnDismissClick(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let onStart = self.onStartStory {
                onStart()
            }
        }
    }
}

extension ViewStoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShareStory ? arrUserList.count : arrViewList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StoryViewCell = tableView.dequeueReusableCell(withIdentifier: "StoryViewCell") as! StoryViewCell
        
        if isShareStory {
            let data = arrUserList[indexPath.row]
            cell.setShareFriendsData(data)
            if arrSelectedUserList.firstIndex(where: {$0.id == data.id}) != nil {
                cell.btnShareCheckBox.isSelected = true
            }
            else {
                cell.btnShareCheckBox.isSelected = false
            }
            cell.btnShareCheckBox.tag = indexPath.row
            cell.btnShareCheckBox.addTarget(self, action: #selector(self.btnShareStoryAction), for: .touchUpInside)
        }
        else {
            let data = arrViewList[indexPath.row]
            cell.setViewStoryData(data)
           
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func btnShareStoryAction(sender : UIButton) {
        let index = sender.tag
        let shareInfo = arrUserList[index]
        if let shareIndex = arrSelectedUserList.firstIndex(where: {$0.id == shareInfo.id}) {
            arrSelectedUserList.remove(at: shareIndex)
        }
        else {
            arrSelectedUserList.append(shareInfo)
        }
        self.tblViewStory.reloadData()
    }
}

//MARK: API Calling
extension ViewStoryViewController {
    
    
    
    private func getUserStoryViewList(){
        
       
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kgetUserStoryViewList,
                                           kstoryId : self.storyID,
                                       
                        ]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    
      
    }
    
    private func GetsaveStoryReply(_ arrShareData:[ModelUserListNew]) {
        if arrShareData.count > 0 {
            var arrUserId = [String]()
        for i in 0..<arrShareData.count {
            let modelInfo = arrShareData[i]
            arrUserId.append(modelInfo.userId)
           }
        
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.ksaveStoryReply,
                                           kstoryId : self.storyID,
                                           kuserIds : arrUserId,
                                           kmessage : self.txtMessage?.text ?? ""
                        ]
         WebSocketChat.shared.writeSocketData(dict: dictionary)
        
        }
    }

  
}

extension ViewStoryViewController {
    
    
    private func getUsersFollowListAPICall(isshowloader :Bool = true,_ stName:String){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                klimit : "15",
                ksearch : stName
             
                
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ModelUserListNew.getUsersFollowListAPICall(with: param, isShowLoader: isshowloader, success: { (arr, totalpage,msg) in
                self.tblViewStory?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                self.arrUserList.append(contentsOf: arr)
                self.pageNo = self.pageNo + 1
                self.tblViewStory?.reloadData()
                self.tblViewStory?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblViewStory?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
        
                    self.tblViewStory?.reloadData()
                    self.tblViewStory?.EmptyMessage(message: error)
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                       
                    }
                }
            })
        }
    }
    
}



//MARK:- webSocketChatDelegate
extension ViewStoryViewController : webSocketChatDelegate{
    
    
    func SendReceiveData(dict: [String : AnyObject]) {
        print(dict)
        
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                print("Socket Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
            }
        
        if let hookmethod = dict[khookMethod] as? String {
            if hookmethod == AppConstant.WebSocketAPI.kgetUserStoryViewList {
                
                
                if let dataarr = dict[kData] as? [[String:Any]] {
                    let arrStories = dataarr.compactMap({ModelViewStory.init(fromDictionary: $0)})
                    
                    if arrStories.count > 0 {
                        self.arrViewList.append(contentsOf: arrStories)
                        self.lblNodata?.isHidden = true
                    } else {
                        self.tblViewStory?.EmptyMessage(message: "No views on your story till now")
                        self.lblNodata?.isHidden = true
                    }
                }

                self.tblViewStory?.reloadData()
                
            }
           else  if hookmethod == AppConstant.WebSocketAPI.ksaveStoryReply {
                
                
            }
            
        }
        
    }
}
            

extension ViewStoryViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let stSearch = textField.text ?? ""
        arrUserList.removeAll()
        self.tblViewStory.reloadData()
        self.getUsersFollowListAPICall(stSearch)
//        self.callWsForGetAllUserList(stSearch)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}



//MARK: Socket Custom Metod
extension ViewStoryViewController {
    func shareStorySocketData(_ arrShareData:[ModelUserListNew]) {
//        if kAppDelegate.Socket.isConnected {
//            if arrShareData.count > 0 {
//                showLoaderHUD(strMessage: "")
//                for i in 0..<arrShareData.count {
//                    let modelInfo = arrShareData[i]
//                    let dictionary = ["hookMethod": socketChat,
//                                      "message" : self.storyID,"type" : "5","recipient_id" : "\(modelInfo.chatGroupId ?? "")"]
//                    if let theJSONData = try? JSONSerialization.data(
//                        withJSONObject: dictionary,
//                        options: []) {
//                        let theJSONText = String(data: theJSONData,
//                                                 encoding: .utf8)
//                        print("JSON string = \(theJSONText!)")
//                        kAppDelegate.Socket.write(string: "\(theJSONText!)")
//                    }
//                }
//            }
//        }
//        else {
//            kAppDelegate.connectSocket()
//        }
    }
}

//MARK:- Custom Method




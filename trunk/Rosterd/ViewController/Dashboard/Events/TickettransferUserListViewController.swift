//
//  TickettransferUserListViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 30/12/22.
//

import UIKit



class TickettransferUserListViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var vwSerachView: SearchView?
    @IBOutlet weak var tbluserList: UITableView?
    
    
    // MARK: - Variables
    private var arruser : [followModel] = []
    var selectuser : followModel?
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    var dicticket  : [String:Any] = [:]
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        self.REeloadUserList()
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
extension TickettransferUserListViewController {
    private func InitConfig(){
        
        self.tbluserList?.delegate = self
        self.tbluserList?.dataSource = self
        self.tbluserList?.register(TicketUserListCell.self)
        self.tbluserList?.separatorStyle = .none
        self.tbluserList?.rowHeight = UITableView.automaticDimension
        
        self.vwSerachView?.txtSearch?.returnKeyType = .search
        self.vwSerachView?.txtSearch?.delegate = self
        self.vwSerachView?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appnavigationSetUpTicketTransferNAvigationBar(title: "Transfer Ticket", TitleColor: UIColor.CustomColor.textfieldTextColor, isShowRightButton: false,navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()

    }
}

////MARK: Pagination tableview Mthonthd
extension TickettransferUserListViewController {

    private func REeloadUserList(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arruser.removeAll()
        self.tbluserList?.reloadData()
        self.GetUserFriendList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tbluserList?.es.addPullToRefresh {
            [unowned self] in
            self.REeloadUserList()
        }

        self.tbluserList?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.GetUserFriendList()
                } else if self.pageNo <= self.totalPages {
                    self.GetUserFriendList(isshowloader: false)
                } else {
                    self.tbluserList?.es.noticeNoMoreData()
                }
            } else {
                self.tbluserList?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tbluserList?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tbluserList?.es.noticeNoMoreData()
            }
            else {
                self.tbluserList?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tbluserList?.es.stopLoadingMore()
            self.tbluserList?.es.noticeNoMoreData()
            self.isLoading = true
        }

    }
}

//MARK:- UITableView Delegate
extension TickettransferUserListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arruser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketUserListCell.self)
        let obj = arruser[indexPath.row]
        cell.lblname?.text = obj.userName
        cell.lblFollowers?.text = "\(obj.totalFollower) Followers"
        cell.img_user?.setImage(withUrl: obj.profileImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        if let data = self.selectuser {
            cell.btnSelect?.isSelected = (data.id == obj.id)
        } else {
            cell.btnSelect?.isSelected = false
        }
        
        cell.btnSelect?.tag = indexPath.row
        cell.btnSelect?.addTarget(self, action: #selector(self.btnSelectClicked), for: .touchUpInside)
                               
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func btnSelectClicked(sender : UIButton) {
        if self.arruser.count > 0 {
            let obj = self.arruser[sender.tag]
            self.selectuser = obj
            self.tbluserList?.reloadData()
        }
    }
                               
}

// MARK: - UITextFieldDelegate
extension TickettransferUserListViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if !(textField.isEmpty) {
            self.REeloadUserList()
           
        }
        return true
    }
    
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        if textField.isEmpty {
            self.REeloadUserList()
           
        }
    }
}

//MARK: - API Call
extension TickettransferUserListViewController {
    
    private func GetUserFriendList(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault() {
       
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kPageNo : "\(self.pageNo)",
           klimit : "10",
           ksearch : self.vwSerachView?.txtSearch?.text ?? ""
         
        
        
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       followModel.GetUserFriendList(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
               self.tbluserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arruser.append(contentsOf: arr)
               self.pageNo = self.pageNo + 1
               self.tbluserList?.reloadData()
               self.tbluserList?.EmptyMessage(message: "")
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.tbluserList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               if statuscode == APIStatusCode.NoRecord.rawValue {
                   self.tbluserList?.reloadData()
                   self.tbluserList?.EmptyMessage(message: error)
               } else {
                   if !error.isEmpty {
                       self.showMessage(error, themeStyle: .error)
                     
                   }
               }
           })
       }
   }
    
    private func setEventTicketTransfer() {
        
        if let user = UserModel.getCurrentUserFromDefault(){
            
            dicticket[klangType] = Rosterd.sharedInstance.languageType
            dicticket[ktoken] = user.token
            dicticket[kuserIdTo] = self.selectuser?.id ?? ""

                let param : [String:Any] = [
                    kData : dicticket
                ]

            TicketDetailModel.setEventTicketTransfer(with: param, success: { (msg) in
                self.appNavigationController?.push(TicketSuccesfullyViewController.self)
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
}

//MARK: - IBAction Method
extension TickettransferUserListViewController {
    
    @IBAction func btnTransferClicked(_ sender : AppButton) {
        self.setEventTicketTransfer()
        
    }
}
// MARK: - ViewControllerDescribable
extension TickettransferUserListViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension TickettransferUserListViewController: AppNavigationControllerInteractable { }

//
//  ResumeShareViewController.swift
//  Rosterd
//
//  Created by iMac on 03/05/23.
//

import UIKit

class ResumeShareViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwSerachView: SearchView?
    @IBOutlet weak var tblShareUser: UITableView?
    @IBOutlet weak var btnShare: AppButton?
    
    // MARK: - Variables
    private var arrsuggest : [UserModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    var arrselectedUser = [UserModel]()
    var userResumeId : String = ""
    //MARK: -  View Life cycle
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
    @IBAction func btnShareClick(_ sender : AppButton) {
        self.setShareResume()
    }
    
}

// MARK: - Init Configure
extension ResumeShareViewController {
    private func InitConfig(){
        self.tblShareUser?.register(ResumeShareCell.self)
        self.tblShareUser?.rowHeight = UITableView.automaticDimension
        self.tblShareUser?.delegate = self
        self.tblShareUser?.dataSource = self
        
        self.vwSerachView?.txtSearch?.returnKeyType = .search
        self.vwSerachView?.txtSearch?.delegate = self
        self.vwSerachView?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
        
        self.vwSerachView?.btnClearClickBlock = {
                self.reloadFollowData()
        }
        
        self.getUsersList()
        self.setupESInfiniteScrollinWithTableView()
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        appNavigationController?.setNavigationBackTitleRightBackBtnNavigationBarBlack(title: "", TitleColor: UIColor.CustomColor.whitecolor, rightBtntitle: "", rightBtnColor: UIColor.CustomColor.whitecolor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

//MARK:- UITableView Delegate
extension ResumeShareViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrsuggest.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ResumeShareCell.self)
        let obj = self.arrsuggest[indexPath.row]
        if self.arrsuggest.count > 0 {
            cell.lblName?.text = obj.fullName
            cell.lblFollower?.text = "\(obj.TotalFollower) Followers"
           cell.imgProfile?.setImage(withUrl: obj.thumbprofileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
        if (arrselectedUser.firstIndex(where: {$0.id == obj.id}) != nil){
            cell.btnShare?.isSelected = true
        } else {
            cell.btnShare?.isSelected = false
        }
        cell.btnShare?.tag = indexPath.row
        cell.btnShare?.addTarget(self, action: #selector(self.btnShareClicked), for: .touchUpInside)
        return cell
    }
   
    @objc func btnShareClicked(sender : UIButton) {
        let strData = arrsuggest[sender.tag]
        
        if let index = arrselectedUser.firstIndex(where: {$0.id == strData.id}) {
            arrselectedUser.remove(at: index)
        }
        else {
            arrselectedUser.append(strData)
        }
        self.tblShareUser?.reloadData()
    }
}
// MARK: - UITextFieldDelegate
extension ResumeShareViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if !(textField.isEmpty) {
            self.reloadFollowData()
        }
        return true
    }
    
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        if textField.isEmpty {
            self.reloadFollowData()
        }
    }
}
////MARK: Pagination tableview Mthonthd
extension ResumeShareViewController {

    private func reloadFollowData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrsuggest.removeAll()
        self.tblShareUser?.reloadData()
        self.getUsersList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblShareUser?.es.addPullToRefresh {
            [unowned self] in
            self.reloadFollowData()
        }

        self.tblShareUser?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getUsersList()
                } else if self.pageNo <= self.totalPages {
                    self.getUsersList(isshowloader: false)
                } else {
                    self.tblShareUser?.es.noticeNoMoreData()
                }
            } else {
                self.tblShareUser?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblShareUser?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblShareUser?.es.noticeNoMoreData()
            }
            else {
                self.tblShareUser?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblShareUser?.es.stopLoadingMore()
            self.tblShareUser?.es.noticeNoMoreData()
            self.isLoading = true
        }

    }
}


extension ResumeShareViewController {
    
    private func getUsersList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                ksearch : self.vwSerachView?.txtSearch?.text ?? "",
                klimit : "10",
                kisConnectedUser : "1"
                
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.getUsersList(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
                self.tblShareUser?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                
                self.arrsuggest.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
                self.tblShareUser?.reloadData()
                self.tblShareUser?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblShareUser?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    self.tblShareUser?.reloadData()
                    self.tblShareUser?.EmptyMessage(message: error)
                    self.tblShareUser?.reloadData()
                } else {
                    if !error.isEmpty {
                    }
                }
            })
        }
    }
    private func setShareResume() {
        if let user = UserModel.getCurrentUserFromDefault(){
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kuserIds : self.arrselectedUser.map({$0.id}),
                kresumeShareProfileId : self.userResumeId
            ]
            let param : [String:Any] = [
                kData : dict
            ]

            UserModel.setShareResume(with: param, success: { (msg) in
                self.appNavigationController?.showDashBoardViewController()
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension ResumeShareViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ResumeShareViewController: AppNavigationControllerInteractable { }

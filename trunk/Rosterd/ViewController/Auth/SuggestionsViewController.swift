//
//  SuggestionsViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit
import StoreKit

class SuggestionsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var tblViewSuggestions: UITableView?
    @IBOutlet weak var btnSkip: UIButton?
    @IBOutlet weak var btnviewMore: UIButton?
    @IBOutlet weak var vwSerachView: SearchView!
    
    // MARK: - Variables
    var isFromLogin : Bool = false
    
    private var arrsuggest : [UserModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    var isfromdashboard : Bool = false
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
}

// MARK: - Init Configure
extension SuggestionsViewController {
    private func InitConfig(){
        
         if self.isfromdashboard == true {
            self.btnSkip?.isHidden = true
         } else {
             self.btnSkip?.isHidden = false
         }
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.btnSkip?.setTitleColor(UIColor.CustomColor.subHeaderTextColor, for: .normal)
        self.btnSkip?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        
        
        self.btnviewMore?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnviewMore?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        
        self.vwSerachView?.txtSearch?.returnKeyType = .search
        self.vwSerachView?.txtSearch?.delegate = self
        self.vwSerachView?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
        
        self.vwSerachView.btnClearClickBlock = {
                self.reloadFollowData()
        }
        
        
        self.tblViewSuggestions?.delegate = self
        self.tblViewSuggestions?.dataSource = self
        self.tblViewSuggestions?.register(SuggestionsCell.self)
        self.tblViewSuggestions?.separatorStyle = .none
        self.tblViewSuggestions?.estimatedRowHeight = 80
        self.tblViewSuggestions?.rowHeight = UITableView.automaticDimension
        
        self.getUsersList()
        self.setupESInfiniteScrollinWithTableView()
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
     
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}
////MARK: Pagination tableview Mthonthd
extension SuggestionsViewController {

    private func reloadFollowData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrsuggest.removeAll()
        self.tblViewSuggestions?.reloadData()
        self.getUsersList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblViewSuggestions?.es.addPullToRefresh {
            [unowned self] in
            self.reloadFollowData()
        }

        self.tblViewSuggestions?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getUsersList()
                } else if self.pageNo <= self.totalPages {
                    self.getUsersList(isshowloader: false)
                } else {
                    self.tblViewSuggestions?.es.noticeNoMoreData()
                }
            } else {
                self.tblViewSuggestions?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblViewSuggestions?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblViewSuggestions?.es.noticeNoMoreData()
            }
            else {
                self.tblViewSuggestions?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblViewSuggestions?.es.stopLoadingMore()
            self.tblViewSuggestions?.es.noticeNoMoreData()
            self.isLoading = true
        }

    }
}

//MARK:- UITableView Delegate
extension SuggestionsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrsuggest.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: SuggestionsCell.self)
        if self.arrsuggest.count > 0 {
            cell.vwaddSuggestion?.isHidden = false
            cell.setsuggestion(obj: self.arrsuggest[indexPath.row])
//            cell.vwUnfollow?.isHidden = true
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.arrsuggest.count > 0 {
            let obj = self.arrsuggest[indexPath.row]
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(ProfileViewController.self,configuration: { vc in
                if UserModel.getCurrentUserFromDefault()?.id == obj.id {
                    vc.isbtnMore = true
                    vc.isbtnchat = true
                    vc.selectedUserID = obj.id
                    vc.isbtnsettinf = false
                    vc.isbtnRefer = false
                    vc.isfromUpdateResume = false
                }
                else {
                    vc.isbtnRefer = true
                      vc.isbtnsettinf = true
                      vc.selectedUserID = obj.id
                      vc.isfromOther = true
                    vc.isfromUpdateResume = true
                }
                
            })
        }
    }
    
    
}
// MARK: - UITextFieldDelegate
extension SuggestionsViewController : UITextFieldDelegate {
    
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

// MARK: - FeedCellDelegate
extension SuggestionsViewController : SuggestionsCelldelegate {
    func btnplusSelect(btn: UIButton, cell: SuggestionsCell) {
        self.view.endEditing(true)
        
        if let indexpath = self.tblViewSuggestions?.indexPath(for: cell) {
            if self.arrsuggest.count > 0 {
                let obj = self.arrsuggest[indexpath.row]
                obj.isFollow = btn.isSelected ? "1" : "0"
                self.setFollow(isLike: btn.isSelected ? "1" : "0",FollowId: self.arrsuggest[indexpath.row].id)
                self.tblViewSuggestions?.reloadData()
            }
        }
              
    }
    
  

}
//MARK: - IBAction Method
extension SuggestionsViewController {
    
    @IBAction func btnSkipClick() {
        self.appNavigationController?.push(SubscriptionViewController.self, configuration: { vc in
            vc.isFromLogin = true
        })
    }
}

extension SuggestionsViewController {
    
    private func getUsersList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                ksearch : self.vwSerachView?.txtSearch?.text ?? "",
                klimit : "10"
               
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.getUsersList(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
                //self.arrUser.append(contentsOf: arr)
                self.tblViewSuggestions?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                
                self.arrsuggest.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
//                self.lblNoData?.isHidden = self.arrUser.count == 0 ? false : true
                self.tblViewSuggestions?.reloadData()
                self.tblViewSuggestions?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblViewSuggestions?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    self.tblViewSuggestions?.reloadData()
                    self.tblViewSuggestions?.EmptyMessage(message: error)
//                    self.arrUser.count == 0 ?  false : true
//                   0 self.lblNoData?.text = error
                    self.tblViewSuggestions?.reloadData()
                } else {
                    if !error.isEmpty {
//                        self.showMessage(error, themeStyle: .error)
                     
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
extension SuggestionsViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension SuggestionsViewController: AppNavigationControllerInteractable { }

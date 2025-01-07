//
//  SupportViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 05/02/22.
//

import UIKit

class SupportViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var btnNext: UIButton?
    @IBOutlet weak var tblTicketShow: UITableView?
    @IBOutlet weak var vwSearch: SearchView?
    @IBOutlet weak var vwSolved: SegmentTabView?
    @IBOutlet weak var vwOpen: SegmentTabView?
    @IBOutlet weak var vwAll: SegmentTabView?
    @IBOutlet weak var NoDataFound: NoDataFoundLabel!
  
   
  
    
    // MARK: - Variables
    private var selecetdTab : segementSupportEnum = .All
    private var arrTicketData : [SupportChatModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    private var ticketId : String = ""
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}



// MARK: - Init Configure
extension SupportViewController {
    private func InitConfig(){
        
       
     
        delay(seconds: 0.2) {
            if  let btnNext = self.btnNext {
                btnNext.cornerRadius = btnNext.frame.height / 2
                btnNext.backgroundColor = UIColor.CustomColor.appColor
            }
        }
        self.vwSearch?.txtSearch?.returnKeyType = .search
        self.vwSearch?.txtSearch?.delegate = self
        self.vwSearch?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
        
        
        self.vwAll?.btnSelectTab?.tag = segementSupportEnum.All.rawValue
        self.vwOpen?.btnSelectTab?.tag = segementSupportEnum.Open.rawValue
        self.vwSolved?.btnSelectTab?.tag = segementSupportEnum.Solved.rawValue
        
        [self.vwAll,self.vwOpen,self.vwSolved].forEach({
            $0?.segmentDelegate = self
        })
        
        self.setSelectedTab(obj: .All, isUpdateVC: false)
        
        self.tblTicketShow?.register(ChatSupportCell.self)
        self.tblTicketShow?.estimatedRowHeight = 50
        self.tblTicketShow?.rowHeight = UITableView.automaticDimension
        self.tblTicketShow?.cornerRadius = 20
        self.tblTicketShow?.separatorStyle = .none
        self.tblTicketShow?.delegate = self
        self.tblTicketShow?.dataSource = self
        
        setupESInfiniteScrollinWithTableView()
//        self.getTicketListApi()
      
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Support", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
    
    
}

//MARK: Pagination tableview Mthonthd
extension SupportViewController {
    
    private func reloadSupportData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrTicketData.removeAll()
        self.tblTicketShow?.reloadData()
        self.getTicketListApi()
    }

    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblTicketShow?.es.addPullToRefresh {
            [unowned self] in
            self.reloadSupportData()
           
        }
        
        tblTicketShow?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
              
                    self.getTicketListApi()
                   
                } else if self.pageNo <= self.totalPages {
                 
                    self.getTicketListApi(isshowloader: false)
                 
                } else {
                    self.tblTicketShow?.es.noticeNoMoreData()
                }
            } else {
                self.tblTicketShow?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblTicketShow?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblTicketShow?.es.noticeNoMoreData()
            }
            else {
                self.tblTicketShow?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblTicketShow?.es.stopLoadingMore()
            self.tblTicketShow?.es.noticeNoMoreData()
            self.isLoading = true
        }
        
    }
}


//MARK: - Tableview Observer
extension SupportViewController {
    
    private func addTableviewOberver() {
        self.tblTicketShow?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableviewObserver() {
        if self.tblTicketShow?.observationInfo != nil {
            self.tblTicketShow?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    
}


//MARK:- UITableView Delegate
extension SupportViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTicketData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ChatSupportCell.self)
        let objTicketData = arrTicketData[indexPath.row]
        if self.arrTicketData.indices ~= indexPath.row {
            let obj = self.arrTicketData[indexPath.row]
            cell.setupTicketData(obj: obj)
            
            
            cell.btnReopen?.tag = indexPath.row
            cell.btnReopen?.addTarget(self, action: #selector(self.btnReopenRequest(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.appNavigationController?.push(SupportchatdetailViewController.self,configuration: { vc in
            vc.ticketData = self.arrTicketData[indexPath.row]

        })
    }
    @objc func btnReopenRequest(_ sender : UIButton){
        if self.arrTicketData.count > 0 {
            self.reopenTicketAPICall(ticketId : self.arrTicketData[sender.tag].id)
            self.appNavigationController?.push(SupportchatdetailViewController.self,configuration: { vc in
                vc.ticketData = self.arrTicketData[sender.tag]
            })
            
        }
    }
}
//MARK: - SegmentTabDelegate
extension SupportViewController : SegmentTabDelegate {
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: segementSupportEnum(rawValue: sender.tag) ?? .All)
    }
    
    private func setSelectedTab(obj : segementSupportEnum, isUpdateVC : Bool = true){
        switch obj {
        case .All:
            self.selecetdTab = .All
            self.vwAll?.isSelectTab = true
            self.vwOpen?.isSelectTab = false
            self.vwSolved?.isSelectTab = false
            break
        case .Open:
            self.selecetdTab = .Open
            self.vwAll?.isSelectTab = false
            self.vwOpen?.isSelectTab = true
            self.vwSolved?.isSelectTab = false
            break
        case .Solved:
            self.selecetdTab = .Solved
            self.vwAll?.isSelectTab = false
            self.vwOpen?.isSelectTab = false
            self.vwSolved?.isSelectTab = true
            break
        }
        self.reloadSupportData()
       
    }
}

// MARK: - UITextFieldDelegate
extension SupportViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if !(textField.isEmpty) {
            self.reloadSupportData()
           
        }
        return true
    }
    
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        if textField.isEmpty {
            self.reloadSupportData()
           
        }
    }
}

//MARK : - API Call

extension SupportViewController {
    
    
    private func getTicketListApi(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                klimit : "15",
                ksearch : self.vwSearch?.txtSearch?.text ?? "",
                ktype : self.selecetdTab.apivalue
                
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            SupportChatModel.getTicketList(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage) in

                //self.arrFeed.append(contentsOf: arr)
                self.tblTicketShow?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage

                self.arrTicketData.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
//                self.NoDataFound?.isHidden = self.arrTicketData.count == 0 ? false : true
                self.tblTicketShow?.reloadData()
                self.tblTicketShow?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblTicketShow?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
        
                    self.tblTicketShow?.reloadData()
                    self.tblTicketShow?.EmptyMessage(message: error)
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                       
                    }
                }
            })
        }
    }
    private func reopenTicketAPICall(ticketId : String) {
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kticketId : ticketId
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            SupportChatModel.reopenTicket(with: param, isShowLoader: true,  success: { (msg) in
                
               
              
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
}


// MARK: - IBAction
extension SupportViewController {
    @IBAction func btnNextClicked(_ sender: UIButton) {
        self.appNavigationController?.push(CreateTicketViewController.self, configuration:  {vc in
            vc.delegate = self
            
        })
    }
}

// MARK: - Add New Ticket Delegate
extension SupportViewController : addNewTicketDelegate{
    func addnewticket() {
        self.reloadSupportData()
    }
}

// MARK: - ViewControllerDescribable
extension SupportViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Chat
    }
}

// MARK: - AppNavigationControllerInteractable
extension SupportViewController: AppNavigationControllerInteractable{}


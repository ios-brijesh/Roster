//
//  TicketTransferListViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 30/12/22.
//

import UIKit

class TicketTransferListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tblTransferList: UITableView?
    
    // MARK: - Variables
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    private var arrTicketlist : [TicketDetailModel] = []
    var Ticketid : String = ""
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        self.REeloadTicketList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
}

// MARK: - Init Configure
extension TicketTransferListViewController {
    private func InitConfig(){
        
        self.tblTransferList?.delegate = self
        self.tblTransferList?.dataSource = self
        self.tblTransferList?.register(TicketTransferCell.self)
        self.tblTransferList?.separatorStyle = .none
        self.tblTransferList?.rowHeight = UITableView.automaticDimension
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)

            appNavigationController?.appsetUpNotificationWithTitle(title: "Transfer Ticket", TitleColor: UIColor.CustomColor.blackColor,navigationItem: self.navigationItem)
        
        appNavigationController?.btnNextClickBlock = {
            self.appNavigationController?.push(HelpViewController.self)
        }
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()

    }
}

////MARK: Pagination tableview Mthonthd
extension TicketTransferListViewController {

    private func REeloadTicketList(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrTicketlist.removeAll()
        self.tblTransferList?.reloadData()
        self.getEventTransferTicketList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblTransferList?.es.addPullToRefresh {
            [unowned self] in
            self.REeloadTicketList()
        }

        self.tblTransferList?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getEventTransferTicketList()
                } else if self.pageNo <= self.totalPages {
                    self.getEventTransferTicketList(isshowloader: false)
                } else {
                    self.tblTransferList?.es.noticeNoMoreData()
                }
            } else {
                self.tblTransferList?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblTransferList?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblTransferList?.es.noticeNoMoreData()
            }
            else {
                self.tblTransferList?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblTransferList?.es.stopLoadingMore()
            self.tblTransferList?.es.noticeNoMoreData()
            self.isLoading = true
        }

    }
}

//MARK:- UITableView Delegate
extension TicketTransferListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTicketlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketTransferCell.self)
        cell.SetTicketDetail(obj: self.arrTicketlist[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - API Call
extension TicketTransferListViewController {
    
    private func getEventTransferTicketList(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault() {
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kPageNo : "\(self.pageNo)",
           klimit : "10",
           keventId : self.Ticketid
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       TicketDetailModel.getEventTransferTicketList(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
               self.tblTransferList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrTicketlist.append(contentsOf: arr)
               self.pageNo = self.pageNo + 1
               self.tblTransferList?.reloadData()
               self.tblTransferList?.EmptyMessage(message: "")
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.tblTransferList?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
//               self.hideFooterLoading(success: false)
               if statuscode == APIStatusCode.NoRecord.rawValue {
//                   self.vwNodata?.isHidden = false
                   self.tblTransferList?.reloadData()
                   self.tblTransferList?.EmptyMessage(message: error)
               } else {
                   if !error.isEmpty {
                       self.showMessage(error, themeStyle: .error)
                   }
               }
           })
       }
   }
}
// MARK: - ViewControllerDescribable
extension TicketTransferListViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension TicketTransferListViewController: AppNavigationControllerInteractable { }


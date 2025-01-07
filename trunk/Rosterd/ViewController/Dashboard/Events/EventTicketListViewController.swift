//
//  EventTicketListViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 27/12/22.
//

import UIKit
import SwiftUI

class EventTicketListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tblTicket: UITableView?
    
    @IBOutlet weak var VwAvailable: SegmentTabView?
    @IBOutlet weak var VwRedeem: SegmentTabView?
    
    @IBOutlet weak var btnReedem : AppButton?
    // MARK: - Variablesbtner
    private var selecetdTab : SegemnentTicketEnum = .Available
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    private var arrTicketlist : [TicketDetailModel] = []
    var Ticketid : String = ""
    //MARK: - Life Cycle Methods
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
// MARK: - Init Configure
extension EventTicketListViewController {
    private func InitConfig(){
        self.tblTicket?.delegate = self
        self.tblTicket?.dataSource = self
        self.tblTicket?.register(TicketTransferCell.self)
        self.tblTicket?.separatorStyle = .none
        self.tblTicket?.rowHeight = UITableView.automaticDimension
        
        [self.VwAvailable,self.VwRedeem].forEach({
            $0?.segmentDelegate = self
        })
        
        self.VwAvailable?.btnSelectTab?.tag = SegemnentTicketEnum.Available.rawValue
        self.VwRedeem?.btnSelectTab?.tag = SegemnentTicketEnum.Redeemed.rawValue
        
      self.setSelectedTab(obj: .Available, isUpdateVC: false)
        self.setupESInfiniteScrollinWithTableView()

    }
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appnavigationSetUpTicketTransferNAvigationBar(title: "Ticket", TitleColor: UIColor.CustomColor.textfieldTextColor, isShowRightButton: true,navigationItem: self.navigationItem)
        
        appNavigationController?.btnMoreClickBlock = {
            self.appNavigationController?.push(TicketTransferListViewController.self,configuration: { vc in
                vc.Ticketid = self.Ticketid
            })
        }
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()

    }
}

////MARK: Pagination tableview Mthonthd
extension EventTicketListViewController {

    private func REeloadTicketList(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrTicketlist.removeAll()
        self.tblTicket?.reloadData()
        self.TicketDetailTeansfer()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblTicket?.es.addPullToRefresh {
            [unowned self] in
            self.REeloadTicketList()
        }

        self.tblTicket?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.TicketDetailTeansfer()
                } else if self.pageNo <= self.totalPages {
                    self.TicketDetailTeansfer(isshowloader: false)
                } else {
                    self.tblTicket?.es.noticeNoMoreData()
                }
            } else {
                self.tblTicket?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblTicket?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblTicket?.es.noticeNoMoreData()
            }
            else {
                self.tblTicket?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblTicket?.es.stopLoadingMore()
            self.tblTicket?.es.noticeNoMoreData()
            self.isLoading = true
        }

    }
}

//MARK:- UITableView Delegate
extension EventTicketListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTicketlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketTransferCell.self)
        cell.SetTicketDetail(obj: self.arrTicketlist[indexPath.row])
        cell.vwMainView?.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selecetdTab == .Available {
          if self.arrTicketlist.count > 0 {
              
              let obj = self.arrTicketlist[indexPath.row]
                  self.appNavigationController?.present(TicketTransferpopupViewController.self, configuration: { vc in
                      vc.modalPresentationStyle = .fullScreen
                      vc.modalTransitionStyle = .crossDissolve
                      vc.Ticketid = self.Ticketid
                      
                  })
           }
        }
    }
}

//MARK: - SegmentTabDelegate
extension EventTicketListViewController : SegmentTabDelegate {
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: SegemnentTicketEnum(rawValue: sender.tag) ?? .Available)
    }
    
    private func setSelectedTab(obj : SegemnentTicketEnum, isUpdateVC : Bool = true){
        switch obj {
        case .Available:
            self.selecetdTab = .Available
            self.VwAvailable?.isSelectTab = true
            self.VwRedeem?.isSelectTab = false
            self.btnReedem?.isHidden = false
            break
            
        case .Redeemed:
            self.selecetdTab = .Redeemed
             self.VwAvailable?.isSelectTab = false
            self.VwRedeem?.isSelectTab = true
            self.btnReedem?.isHidden = true
            break
        }
        self.REeloadTicketList()
    }
}

//MARK: - API Call
extension EventTicketListViewController {
    
    private func TicketDetailTeansfer(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault() {
       
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kPageNo : "\(self.pageNo)",
           klimit : "10",
           kstatus : self.selecetdTab.apivalue,
           kid : self.Ticketid
        
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       TicketDetailModel.TicketDetailTeansfer(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
               self.tblTicket?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrTicketlist.append(contentsOf: arr)
               self.pageNo = self.pageNo + 1
               self.tblTicket?.reloadData()
               self.tblTicket?.EmptyMessage(message: "")
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.tblTicket?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
//               self.hideFooterLoading(success: false)
               if statuscode == APIStatusCode.NoRecord.rawValue {
//                   self.vwNodata?.isHidden = false
                   self.tblTicket?.reloadData()
                   self.tblTicket?.EmptyMessage(message: error)
               } else {
                   if !error.isEmpty {
                       self.showMessage(error, themeStyle: .error)
                     
                   }
               }
           })
       }
   }
    
    private func setEventTicketRedeem() {
        
        if let user = UserModel.getCurrentUserFromDefault(){
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kbookTicketId : self.arrTicketlist.map({$0.id})

            ]

            let param : [String:Any] = [
                kData : dict
            ]

            TicketDetailModel.setEventTicketRedeem(with: param, success: { (msg) in
                self.REeloadTicketList()
                self.setSelectedTab(obj: .Redeemed, isUpdateVC: false)
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
}
//MARK: - IBAction Method
extension EventTicketListViewController {
    
    @IBAction func btnReedemClick(_ sender : AppButton) {
        self.setEventTicketRedeem()
    }
}
// MARK: - ViewControllerDescribable
extension EventTicketListViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension EventTicketListViewController: AppNavigationControllerInteractable { }

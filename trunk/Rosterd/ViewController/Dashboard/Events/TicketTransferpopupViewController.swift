//
//  TicketTransferpopupViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 30/12/22.
//

import UIKit

protocol arrticketDelegate {
    func arrticket(arrTicket: [TicketDetailModel])
}

class TicketTransferpopupViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var btntransfer: AppButton?
    @IBOutlet weak var btnReedem: AppButton?
    @IBOutlet weak var btnselectAll: UIButton?
    @IBOutlet weak var btnselectNone: UIButton?
    
    @IBOutlet weak var tblTicketlist: UITableView?
    @IBOutlet weak var constrainttblTicketHeight: NSLayoutConstraint?
    // MARK: - Variables
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    private var arrTicketlist : [TicketDetailModel] = []
    var Ticketid : String = ""
    var arrselectedTicket = [TicketDetailModel]()
    var delegate : arrticketDelegate?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        self.REeloadTicketList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

// MARK: - Init Configure
extension TicketTransferpopupViewController {
    private func InitConfig(){
        
        self.tblTicketlist?.delegate = self
        self.tblTicketlist?.dataSource = self
        self.tblTicketlist?.register(TicketTransferCell.self)
        self.tblTicketlist?.separatorStyle = .none
        self.tblTicketlist?.rowHeight = UITableView.automaticDimension
        
        self.btnselectAll?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.btnselectAll?.setTitleColor(UIColor.white, for: .normal)
        
        self.btnselectNone?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.btnselectNone?.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appnavigationSetUpTicketTransferNAvigationBar(title: "", TitleColor: UIColor.CustomColor.textfieldTextColor, isShowRightButton: false,navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()

    }
}
////MARK: Pagination tableview Mthonthd
extension TicketTransferpopupViewController {

    private func REeloadTicketList(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrTicketlist.removeAll()
        self.tblTicketlist?.reloadData()
        self.TicketDetailTeansfer()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblTicketlist?.es.addPullToRefresh {
            [unowned self] in
            self.REeloadTicketList()
        }

        self.tblTicketlist?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.TicketDetailTeansfer()
                } else if self.pageNo <= self.totalPages {
                    self.TicketDetailTeansfer(isshowloader: false)
                } else {
                    self.tblTicketlist?.es.noticeNoMoreData()
                }
            } else {
                self.tblTicketlist?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblTicketlist?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblTicketlist?.es.noticeNoMoreData()
            }
            else {
                self.tblTicketlist?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblTicketlist?.es.stopLoadingMore()
            self.tblTicketlist?.es.noticeNoMoreData()
            self.isLoading = true
        }

    }
}
//MARK: - Tableview Observer
extension TicketTransferpopupViewController {
    
    private func addTableviewOberver() {
        self.tblTicketlist?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableviewObserver() {
        if self.tblTicketlist?.observationInfo != nil {
            self.tblTicketlist?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblTicketlist && keyPath == ObserverName.kcontentSize {
                self.constrainttblTicketHeight?.constant = self.tblTicketlist?.contentSize.height ?? 0.0
            }
        }
    }
}
 

//MARK:- UITableView Delegate
extension TicketTransferpopupViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTicketlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketTransferCell.self)
        let obj = arrTicketlist[indexPath.row]
        cell.vwMainView?.backgroundColor = UIColor.CustomColor.whitecolor50
        cell.SetTicketDetail(obj: obj)
        if (arrselectedTicket.firstIndex(where: {$0.id == obj.id}) != nil) {
            cell.vwMainView?.backgroundColor = UIColor.CustomColor.whitecolor
            cell.vwMainView?.borderWidth = 2.0
            cell.vwMainView?.borderColor = UIColor.CustomColor.appColor
            cell.vwMainView?.shadowColor = UIColor.CustomColor.whiteShadow80
        }
        else {
            cell.vwMainView?.backgroundColor = UIColor.CustomColor.whitecolor50
            cell.vwMainView?.borderWidth = 0.0
            cell.vwMainView?.borderColor = .clear
            cell.vwMainView?.shadowColor = UIColor.CustomColor.shadow28appcolour
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let obj = arrTicketlist[indexPath.row]
//            obj.isSelect = !obj.isSelect
//            self.tblTicketlist?.reloadData()
        
        let strData = arrTicketlist[indexPath.item]
        
        if let index = arrselectedTicket.firstIndex(where: {$0.id == strData.id}) {
            arrselectedTicket.remove(at: index)
        }
        else {
            arrselectedTicket.append(strData)
        }
        self.tblTicketlist?.reloadData()
    }
}
//MARK: - API Call
extension TicketTransferpopupViewController {
    
    private func TicketDetailTeansfer(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault() {
       
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kPageNo : "\(self.pageNo)",
           klimit : "10",
           kstatus : "1",
           kid : self.Ticketid
        
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       TicketDetailModel.TicketDetailTeansfer(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
               self.tblTicketlist?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrTicketlist.append(contentsOf: arr)
               let model = self.arrTicketlist.first
               model?.isSelect = true
               self.pageNo = self.pageNo + 1
               self.tblTicketlist?.reloadData()
               self.tblTicketlist?.EmptyMessage(message: "")
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.tblTicketlist?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               if statuscode == APIStatusCode.NoRecord.rawValue {
                   self.tblTicketlist?.reloadData()
                   self.tblTicketlist?.EmptyMessage(message: error)
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
                kbookTicketId : self.arrselectedTicket.map({$0.id})
            ]
            let param : [String:Any] = [
                kData : dict
            ]

            TicketDetailModel.setEventTicketRedeem(with: param, success: { (msg) in
                self.REeloadTicketList()
                self.dismiss(animated: true, completion: nil)
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
}
//MARK: - IBAction Method
extension TicketTransferpopupViewController {
    
    @IBAction func btnReedemClick(_ sender : AppButton) {
        self.setEventTicketRedeem()
    }
    @IBAction func btnTransferClick(_ sender : AppButton) {
        var dicticket : [String:Any] = [
            kbookTicketId : self.arrselectedTicket.map({$0.id})
            ]
        self.dismiss(animated: true, completion: nil)
        self.appNavigationController?.push(TickettransferUserListViewController.self,configuration: { vc in
            vc.dicticket = dicticket
        })
    }
    
    @IBAction func btnNavClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSelectallClick(_ sender : UIButton) {
        _ = self.arrTicketlist.compactMap({$0.isSelect = true})
    }
    
    @IBAction func btnSelectnoneClick(_ sender : UIButton) {
        _ = self.arrTicketlist.compactMap({$0.isSelect = false})
    }
}
// MARK: - ViewControllerDescribable
extension TicketTransferpopupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension TicketTransferpopupViewController: AppNavigationControllerInteractable { }

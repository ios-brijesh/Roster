//
//  eventTicketViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 17/02/22.
//

import UIKit

class eventTicketViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwShowTicketview: UIView?
    @IBOutlet weak var vwMainView: UIView?
    
    
    @IBOutlet weak var imgEvent: UIImageView?
    @IBOutlet weak var imgcut: UIImageView?
    @IBOutlet weak var imgBarcode: UIImageView?
    
    @IBOutlet weak var tblticketview: UITableView?
    
    @IBOutlet weak var lblEventName: UILabel?
    @IBOutlet weak var lblNumberticket: UILabel?
    @IBOutlet weak var lblTicket: UILabel?
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblShowDate: UILabel?
    @IBOutlet weak var lblTime: UILabel?
    @IBOutlet weak var lblShowTime: UILabel?
    @IBOutlet weak var lblPlace: UILabel?
    @IBOutlet weak var lblShowPlace: UILabel?
    @IBOutlet weak var lblShowBarcodeNumber: UILabel?
    
    
    private var arrTicket : [EventModel] = []
    var selectedEventData : TicketdataModel?
     var Ticketid : String = ""
    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
 

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
       
    }
}

// MARK: - Init Configure
extension eventTicketViewController {
  private func InitConfig(){
      
  
      self.tblticketview?.register(TicketDetailCell.self)
      self.tblticketview?.estimatedRowHeight = 90
      self.tblticketview?.rowHeight = UITableView.automaticDimension
      self.tblticketview?.cornerRadius = 20
      self.tblticketview?.separatorStyle = .none
      self.tblticketview?.delegate = self
      self.tblticketview?.dataSource = self
      
      self.EventticketDetail()
      
  }
    
    
    
    
private func configureNavigationBar() {
    
    appNavigationController?.setNavigationBarHidden(true, animated: true)
    appNavigationController?.navigationBar.backgroundColor = UIColor.clear
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    
    appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Ticket", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
    
    navigationController?.navigationBar
        .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
    navigationController?.navigationBar.removeShadowLine()
}

}


//MARK:- UITableView Delegate
extension eventTicketViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTicket.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketDetailCell.self)
        cell.SetTicketDetail(obj: self.arrTicket[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}



// MARK: - ViewControllerDescribable
extension eventTicketViewController {
    
    private func EventticketDetail(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault(){
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kid : self.Ticketid,
              
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            EventModel.EventticketDetail(with: param, isShowLoader: isshowloader,  success: { (arr,totalPages,message) in
                self.tblticketview?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.arrTicket = arr
                self.tblticketview?.reloadData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
//                print(error)
                self.tblticketview?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    self.tblticketview?.reloadData()
                } else {
                }
            })
        }
    }
    
}
// MARK: - ViewControllerDescribable
extension eventTicketViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension eventTicketViewController: AppNavigationControllerInteractable { }

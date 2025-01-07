//
//  OrderSuccessfullyViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 03/02/22.
//

import UIKit

class OrderSuccessfullyViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var imgOrderMain: UIImageView?
    @IBOutlet weak var imgTicket: UIImageView!
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    
    @IBOutlet weak var btntrackOrder: UIButton?
    @IBOutlet weak var btnBackyoShipping: UIButton?
    
    @IBOutlet weak var vwimgorder: UIView!
    @IBOutlet weak var vwimgTicket: UIView!
    
    
    // MARK: - Variables
    var isFromEvent : Bool = false
    var isFromimgEvent : Bool = false
    var isFromimgOrder : Bool = false
    var Ticketid : String = ""
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}


// MARK: - Init Configure
extension OrderSuccessfullyViewController {
    private func InitConfig(){
        
        self.vwimgTicket?.isHidden = isFromimgEvent
        self.vwimgorder?.isHidden = isFromimgOrder
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.whitecolor
        
       
        
        self.btntrackOrder?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btntrackOrder?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btntrackOrder?.cornerRadius = 22
        self.btntrackOrder?.backgroundColor = UIColor.white
        
        
        self.btnBackyoShipping?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnBackyoShipping?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btnBackyoShipping?.cornerRadius = 22
        self.btnBackyoShipping?.backgroundColor = UIColor.white
        
        
        self.btntrackOrder?.setTitle(self.isFromEvent ? "View Ticket" : "Track order", for: .normal)
        self.btnBackyoShipping?.setTitle(self.isFromEvent ? "Back to Events" : "Back to Shopping", for: .normal)
        self.lblHeader?.text = self.isFromEvent ? "Ticket Successfully Booked  " : "Order Successfully Placed "
        if self.isFromEvent {
            self.vwimgorder?.isHidden = true
            self.vwimgTicket?.isHidden = false
        }
        else {
            self.vwimgorder?.isHidden = false
            self.vwimgTicket?.isHidden = true
        }
        
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
        //appNavigationControllersetUpTabbarTitle(title: "", TitleColor: UIColor.green, navigat ionItem: self.navigationItem, isHideMsgButton: true)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}

//MARK: - IBAction Method
extension OrderSuccessfullyViewController {
    
    @IBAction func btnTrackOrderClick(_ sender: UIButton) {
        
        if self.isFromEvent {
            self.appNavigationController?.push(EventTicketListViewController.self,configuration: { vc in
                vc.Ticketid = self.Ticketid
           })
        } else {
            self.appNavigationController?.push(MyOrdersViewController.self)
        }
       
      
    }
    @IBAction func btnBacktoShoppingClick(_ sender: UIButton) {
        self.appNavigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kChangeTabbar), object: nil, userInfo: nil)
//        self.appNavigationController?.showDashBoardViewController()
    }
}
// MARK: - ViewControllerDescribable
extension OrderSuccessfullyViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
return UIStoryboard.Name.Shop
}
}

// MARK: - AppNavigationControllerInteractable
extension OrderSuccessfullyViewController: AppNavigationControllerInteractable { }

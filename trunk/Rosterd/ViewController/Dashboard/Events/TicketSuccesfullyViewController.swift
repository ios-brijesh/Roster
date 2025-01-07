//
//  TicketSuccesfullyViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/02/22.
//

import UIKit

class TicketSuccesfullyViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var imgTicket: UIImageView?
    
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    
    @IBOutlet weak var btnViewticket: UIButton?
    @IBOutlet weak var btnBackEvent: UIButton?
    
    // MARK: - Variables
    
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
extension TicketSuccesfullyViewController {
    private func InitConfig(){
        
        self.lblSubHeader?.isHidden = true
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.whitecolor
        
       
        
        self.btnViewticket?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnViewticket?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btnViewticket?.cornerRadius = 22
        self.btnViewticket?.backgroundColor = UIColor.white
        
        
        self.btnBackEvent?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnBackEvent?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btnBackEvent?.cornerRadius = 22
        self.btnBackEvent?.backgroundColor = UIColor.white
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
//MARK: - IBAction Method
extension TicketSuccesfullyViewController {
    
    @IBAction func btnViewticketClick(_ sender: UIButton) {

    }
    @IBAction func btnBackEventClick(_ sender: UIButton) {
        self.appNavigationController?.showDashBoardViewController()
    }
}
// MARK: - ViewControllerDescribable
extension TicketSuccesfullyViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
return UIStoryboard.Name.Events
}
}

// MARK: - AppNavigationControllerInteractable
extension TicketSuccesfullyViewController: AppNavigationControllerInteractable { }

//
//  ProfileCreatedViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit

class ProfileCreatedViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var lblShareProfile: UILabel?
    @IBOutlet weak var btnGetStarted: UIButton?
    
    // MARK: - Variables
    var isFromCreateEvent : Bool = false
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
extension ProfileCreatedViewController {
    private func InitConfig(){
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblShareProfile?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 15.0))
        self.lblShareProfile?.textColor = UIColor.CustomColor.whitecolor
        
        self.btnGetStarted?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnGetStarted?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btnGetStarted?.cornerRadius = 22
        self.btnGetStarted?.backgroundColor = UIColor.white
        
        self.btnGetStarted?.setTitle(self.isFromCreateEvent ? "My Events" : "Get Started", for: .normal)
        self.lblHeader?.text = self.isFromCreateEvent ? "Event Successfully Created " : "Profile Successfully Created "
        self.lblShareProfile?.text = self.isFromCreateEvent ? "Share with your friends" : "Welcome To Team "
        self.lblSubHeader?.isHidden = true
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
extension ProfileCreatedViewController {
    
    @IBAction func btnGetStartedClick(_ sender: UIButton) {
        if btnGetStarted?.titleLabel?.text == "My Events" {
            
            self.appNavigationController?.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kChangeTabbar), object: nil, userInfo: nil)
            
        } else {
            self.appNavigationController?.showDashBoardViewController()
        }
       
    }
    @IBAction func btnfacebookShareClick(_ sender: UIButton) {
        
        if let url = URL(string: "https://www.facebook.com/rosteredapp") {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @IBAction func btnGoogleShareClick(_ sender: UIButton) {
    }
    
    @IBAction func btnShareClick(_ sender: UIButton) {
       
        var textToShare : [AnyObject] = [ shareContentApp.kContent as AnyObject ]
        if let url = URL(string: shareContentApp.kLink) {
            textToShare = [shareContentApp.kContent as AnyObject,url as AnyObject]
        }
        
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        

        self.present(activityViewController, animated: true, completion: nil)
    }
}


// MARK: - SFSafariViewControllerDelegate
extension ProfileCreatedViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
// MARK: - ViewControllerDescribable
extension ProfileCreatedViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension ProfileCreatedViewController: AppNavigationControllerInteractable { }

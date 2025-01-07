//
//  StartedViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit

class StartedViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet var lblRegisterCollection: [UILabel]?
    @IBOutlet var vwRegisterButtonCollection: [UIView]?
    @IBOutlet weak var lblHaveAccount: UILabel?
    @IBOutlet weak var vwAppleLogin: UIView!
    @IBOutlet weak var lblRegisterApple: UILabel!
    
    // MARK: - Variables
    private var socilalogin = SocialLoginManager()
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.socilalogin.getLocation()
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Init Configure
extension StartedViewController {
    private func InitConfig() {
        
        self.socilalogin.viewController = self
        self.socilalogin.appnavigationcontroller = self.appNavigationController
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 30.0))
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblHaveAccount?.font = UIFont.PoppinsLightItalic(ofSize: GetAppFontSize(size: 12.0))
        self.lblHaveAccount?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblRegisterApple?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblRegisterApple?.textColor = UIColor.CustomColor.whitecolor
        
        
        
        self.vwRegisterButtonCollection?.forEach({
            $0.backgroundColor = UIColor.CustomColor.whitecolor
            $0.cornerRadius = 22
        })
        
        
        self.vwAppleLogin?.backgroundColor = UIColor.CustomColor.blackColor
        self.vwAppleLogin?.cornerRadius = 22
        
        
        self.lblRegisterCollection?.forEach({
            $0.textColor = UIColor.CustomColor.registerLabelTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        })
        
    }
}

//MARK: - IBAction Method
extension StartedViewController {
    
    @IBAction func btnRegisterEmailClick() {
        self.appNavigationController?.push(SignupViewController.self)
    }
    
    @IBAction func btnRegisterAppleClick() {
        self.socilalogin.loginWithApple()
    }
    @IBAction func btnRegisterGoogleClick() {
        self.socilalogin.loginWithGoogle()
    }
    
    @IBAction func btnRegisterFacebookClick() {
        self.socilalogin.loginWithFacebook()
    }
    
    @IBAction func btnRegisterInstaClick() {
        self.appNavigationController?.present(instaViewController.self,configuration: { vc in
            vc.onCompleteUserInfo = { (id,userName) in
                self.socilalogin.loginWithInstagram(id, userName: userName)
            }
        })
    }
    
    @IBAction func btnLoginClick() {
        self.appNavigationController?.push(LoginViewController.self)
    }
}


// MARK: - ViewControllerDescribable
extension StartedViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension StartedViewController: AppNavigationControllerInteractable { }

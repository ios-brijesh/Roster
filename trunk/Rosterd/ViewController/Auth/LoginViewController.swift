//
//  LoginViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var vwEmail: ReusableView?
    @IBOutlet weak var vwPassword: ReusableView?
    @IBOutlet weak var btnForgotPassword: UIButton?
    @IBOutlet var vwLoginSeperatorCollection: [UIView]?
    @IBOutlet weak var lblLoginWith: UILabel?
    @IBOutlet weak var btnSignup: UIButton?
    @IBOutlet var btnSocialLoginCollection: [UIButton]?
    
    // MARK: - Variables
    private var lat_currnt : Double = 0.0
    private var long_currnt : Double = 0.0
    var isChangePassword : Bool = false
    var isFromLogin : Bool = false
    private var socilalogin = SocialLoginManager()
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
extension LoginViewController {
    private func InitConfig(){
        
        self.socilalogin.viewController = self
        self.socilalogin.appnavigationcontroller = self.appNavigationController
       
        self.btnForgotPassword?.setTitleColor(UIColor.CustomColor.verifyCodeSeperatorColor, for: .normal)
        self.btnForgotPassword?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        
        self.btnSignup?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnSignup?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.subHeaderTextColor
        
        self.lblLoginWith?.font = UIFont.PoppinsLightItalic(ofSize: GetAppFontSize(size: 12.0))
        self.lblLoginWith?.textColor = UIColor.CustomColor.seperaterLabelTextColor
        
        self.vwLoginSeperatorCollection?.forEach({
            $0.backgroundColor = UIColor.CustomColor.reusableSeperatorColor
        })
        
        self.btnSocialLoginCollection?.forEach({
            $0.cornerRadius = 22
            $0.borderWidth = 1
            $0.borderColor = UIColor.CustomColor.reusableSeperatorColor
        })
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
        //appNavigationControllersetUpTabbarTitle(title: "", TitleColor: UIColor.green, navigationItem: self.navigationItem, isHideMsgButton: true)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}

//MARK: - IBAction Method
extension LoginViewController {
    
    @IBAction func btnSignupClick() {
//        self.appNavigationController?.push(SelectProfileTypeViewController.self)
        self.appNavigationController?.push(SignupViewController.self)
        //self.appNavigationController?.push(DashboardViewController.self)
    }
    
    @IBAction func btnLoginClick() {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
            return
        }
        self.signinAPICall()
        
    }
    @IBAction func btnForgotPassClick() {
        self.appNavigationController?.push(ForgotPasswordViewController.self,configuration: { vc in
            //vc.isFromForgotPassword = true
        })
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
    
    
    
}

//MARK: - Validation
extension LoginViewController {
    private func validateFields() -> String? {
        if self.vwEmail?.txtInput.isEmpty ?? false {
            self.vwEmail?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyEmail
        } else if !(self.vwEmail?.txtInput.isValidEmail() ?? false){
            self.vwEmail?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kInValidEmail
        } else if self.vwPassword?.txtInput.isEmpty ?? false {
            self.vwPassword?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyPassword
        } else if (self.vwPassword?.txtInput.text ?? "").count < 8 || (self.vwPassword?.txtInput.text ?? "").count > 15 {
            self.vwPassword?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kvalidPassword
        } else {
            return nil
        }
    }
}
//MARK : - UITextFieldDelegate
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.vwEmail?.txtInput:
            self.vwEmail?.txtInput.resignFirstResponder()
            self.vwPassword?.txtInput.becomeFirstResponder()
        case self.vwPassword?.txtInput:
            self.vwPassword?.txtInput.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
// MARK: - API Call
extension LoginViewController {
    private func signinAPICall() {
        
        let dict : [String:Any] = [
            kEmail : self.vwEmail?.txtInput.text ?? "",
            kpassword : self.vwPassword?.txtInput.text ?? "",
            klangType : Rosterd.sharedInstance.languageType,
            kdeviceToken : UserDefaults.setDeviceToken,
            kdeviceType : Rosterd.sharedInstance.DeviceType,
            ktimeZone : Rosterd.sharedInstance.localTimeZoneIdentifier,
            kdeviceId: Rosterd.sharedInstance.deviceID,
            klatitude : "\(lat_currnt)",
            klongitude : "\(long_currnt)"
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.userLogin(with: param, success: { (user, msg) in
            
            print("User Token : \(user.token)")
            //self.showMessage(msg, themeStyle: .success)
            UserDefaults.isUserLogin = true
//            Rosterd.sharedInstance.selectedUserType = 
            WebSocketChat.shared.connectSocket()
            if user.profileStatus == "1" {
                self.appNavigationController?.push(SelectProfileTypeViewController.self) { vc in
                    vc.isFromLogin = true
                }
            } else{
                WebSocketChat.shared.connectSocket()
                //appDelegate.updateVOIPToken(token: "")
                self.appNavigationController?.showDashBoardViewController()
            }
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            
            if statuscode == APIStatusCode.verifyAcccout.rawValue {
                self.appNavigationController?.detachRightSideMenu()
                self.appNavigationController?.push(VerificationViewController.self,configuration: { (vc) in
                    vc.userEmail = self.vwEmail?.txtInput.text ?? ""
                    vc.isFromSignup = true
                })
            } else {
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            }
        })
    }
}

// MARK: - ViewControllerDescribable
extension LoginViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension LoginViewController: AppNavigationControllerInteractable { }


//
//  VerificationViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit

class VerificationViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var lblNoSpam: UILabel?
    @IBOutlet weak var lblResendCode: UILabel?
    @IBOutlet weak var vwOTP: OTPFieldView?
    @IBOutlet weak var btnChnageEmail: UIButton?
    // MARK: - Variables
    var userEmail : String = ""
    var isFromSignup : Bool = false
    
    private var verificationCode : String = ""
    var isFromForgotPassword : Bool = false
    
    
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
extension VerificationViewController {
    private func InitConfig(){
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.subHeaderTextColor
        
        self.lblResendCode?.setResendTextLabel(firstText: "Didn't receive code?", SecondText: " Resend")
        self.setupOtpView()
        
        self.lblNoSpam?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblNoSpam?.textColor = UIColor.CustomColor.registerLabelTextColor
        
        self.btnChnageEmail?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnChnageEmail?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
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
    
    private func setupOtpView(){
        self.vwOTP?.fieldsCount = 4
        self.vwOTP?.fieldBorderWidth = 3
        self.vwOTP?.defaultBorderColor = UIColor.CustomColor.reusableSeperatorColor
        self.vwOTP?.filledBorderColor = UIColor.CustomColor.verifyCodeSeperatorColor
        self.vwOTP?.filledBackgroundColor = UIColor.CustomColor.whitecolor
        self.vwOTP?.defaultBackgroundColor = UIColor.CustomColor.whitecolor
        self.vwOTP?.cursorColor = UIColor.CustomColor.textfieldTextColor
        self.vwOTP?.displayType = .underlinedBottom
        self.vwOTP?.fieldFont = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 39.0))
        self.vwOTP?.otpInputType = .numeric
        self.vwOTP?.separatorSpace = 20
        self.vwOTP?.shouldAllowIntermediateEditing = false
        self.vwOTP?.delegate = self
        self.vwOTP?.initializeUI()
    }
}

// MARK: - OTPFieldView Delegate
extension VerificationViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.verificationCode = otpString
    }
}

//MARK: - IBAction Method
extension VerificationViewController {
    
    @IBAction func btnResendCode() {
        if self.isFromForgotPassword {
        self.forgotpasswordAPICall()
        }else{
            resendVerificationAPICall()
        }
    }
    
    @IBAction func btnNextClick() {
//        self.appNavigationController?.push(ResetPasswordViewController.self)
        
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage, themeStyle: .warning,presentationStyle: .top)
            return
        }
        if self.isFromSignup {
            self.verificationAPICall()
            
        } else {
           
            self.checkForgotPasswordVerificationAPICall()
        }
    }
    
    @IBAction func btnChnageEmailClick() {
        self.appNavigationController?.present(ForgotPasswordViewController.self)
    }
}



//MARK : - API Call
extension VerificationViewController {
    
    private func validateFields() -> String? {
        if self.verificationCode.isEmpty {
            return AppConstant.ValidationMessages.kEmptyValidationCode
        } else {
            return nil
        }
    }
    
    private func verificationAPICall() {
        
        let dict : [String:Any] = [
            kdeviceId : Rosterd.sharedInstance.deviceID,
            ktimeZone : Rosterd.sharedInstance.localTimeZoneIdentifier,
            klangType : Rosterd.sharedInstance.languageType,
            kdeviceType : Rosterd.sharedInstance.DeviceType,
           
            kEmail : self.userEmail,
            kdeviceToken : UserDefaults.setDeviceToken,
            kverificationCode : self.verificationCode
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.verifyCode(with: param, success: { (user, msg) in
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(SelectProfileTypeViewController.self, configuration: { vc in
                vc.isFromLogin = true
              
            })

        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
                //self.showAlert(withTitle: errorType.rawValue, with: error)
            }
        })
    }
    
    private func checkForgotPasswordVerificationAPICall() {
        
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType,
            KforgotCode : self.verificationCode,
            kEmail : self.userEmail
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.checkforgotVerificationCode(with: param, success: { (msg) in
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(ResetPasswordViewController.self,configuration: { (vc) in
                vc.userEmail = self.userEmail
                //vc.isFromForgotPassword = self.isFromForgotPassword
            })
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
                //self.showAlert(withTitle: errorType.rawValue, with: error)
            }
        })
    }
    
    private func forgotpasswordAPICall() {
       
        let dict : [String:Any] = [
            kEmail : self.userEmail,
            klangType : Rosterd.sharedInstance.languageType,
           
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.forgotPassword(with: param, success: { (msg) in
            //self.showAlert(with: msg)
            self.showMessage(msg, themeStyle: .success)
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
                //self.showAlert(withTitle: errorType.rawValue, with: error)
            }
        })
    }
    
    private func resendVerificationAPICall() {
        
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType,
            kEmail : self.userEmail
           
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.resendVerificationCode(with: param, success: { (msg) in
            //self.showAlert(with: msg)
            self.showMessage(msg, themeStyle: .success)
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
                //self.showAlert(withTitle: errorType.rawValue, with: error)
            }
        })
    }
}
// MARK: - ViewControllerDescribable
extension VerificationViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension VerificationViewController: AppNavigationControllerInteractable { }

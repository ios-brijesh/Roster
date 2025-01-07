//
//  SignupViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//


import UIKit
func validpassword(mypassword : String) -> Bool
    {

        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*!]).{8,15}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }

class SignupViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet var vwSignupSeperatorCollection: [UIView]?
    @IBOutlet weak var lblRegisterWith: UILabel?
    @IBOutlet weak var btnSignin: UIButton?
    @IBOutlet var btnSocialLoginCollection: [UIButton]?
    @IBOutlet weak var btnTermsCondition: UIButton?
    @IBOutlet weak var lblTermsCondition: UILabel?
    
    @IBOutlet weak var vwFullName: ReusableView?
    @IBOutlet weak var vwPhoneNumber: ReusableView?
    @IBOutlet weak var vwEmail: ReusableView?
    @IBOutlet weak var vwPassword: ReusableView?
    // MARK: - Variables
//    let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,15}$"
    private var socilalogin = SocialLoginManager()
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(setReferalObserver(notification:)), name: NSNotification.Name(rawValue: NotificationPostname.kReferalCoin), object: nil)
    }
    
}

// MARK: - Init Configure
extension SignupViewController {
    private func InitConfig(){
        
        self.socilalogin.viewController = self
        self.socilalogin.appnavigationcontroller = self.appNavigationController
       
        
        self.btnSignin?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnSignin?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.subHeaderTextColor
        
        self.lblRegisterWith?.font = UIFont.PoppinsLightItalic(ofSize: GetAppFontSize(size: 12.0))
        self.lblRegisterWith?.textColor = UIColor.CustomColor.seperaterLabelTextColor
        
        lblTermsCondition?.setTermsConditionTextLabel(firstText: "I agree with the", SecondText: " Terms of Service")
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        self.lblTermsCondition?.addGestureRecognizer(tap)

        self.lblTermsCondition?.isUserInteractionEnabled = true
        
        self.vwSignupSeperatorCollection?.forEach({
            $0.backgroundColor = UIColor.CustomColor.reusableSeperatorColor
        })
        
        self.vwFullName?.txtInput.autocapitalizationType = .words
        
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
    
    @objc func setReferalObserver(notification: Notification) {
        if let userinfo = notification.userInfo, let id = userinfo["linkid"] as? String {
            Rosterd.sharedInstance.ReferalCode = id
     }
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let text = self.lblTermsCondition?.text {
          
            let buzzfeed = (text as NSString).range(of: "Terms of Service")
            
            if gesture.didTapAttributedTextInLabel(label: self.lblTermsCondition ?? UILabel(), inRange: buzzfeed) {
                    print("Terms of Service")
                self.appNavigationController?.push(TermConditionViewController.self,configuration: { vc in
                    vc.pageid = .TermCondition
                })
                }
        }
    }
}

//MARK: - IBAction Method
extension SignupViewController {
    
    @IBAction func btnTermsConditionClick() {
        self.btnTermsCondition?.isSelected = !(self.btnTermsCondition?.isSelected ?? false)
    }
    
    @IBAction func btnSigninClick() {
        self.appNavigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSignupNextClick() {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
            return
        }
        self.SignUpAPICall()
//        self.appNavigationController?.push(SelectProfileTypeViewController.self)
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

//extension SignupViewController: ReusableViewDelegate {
//    func buttonClicked(_ sender: UIButton) {
//        <#code#>
//    }
//
//    func rightButtonClicked(_ sender: UIButton) {
//        <#code#>
//    }
//
//    func leftButtonClicked(_ sender: UIButton) {
//        <#code#>
//    }
//
//


//MARK: - Validation
extension SignupViewController {
    private func validateFields() -> String? {
        
        let stFullName = self.vwFullName?.txtInput.text?.trimWhiteSpace ?? ""
        if stFullName == "" {
            return AppConstant.ValidationMessages.kEmptyName
        }
        else if stFullName.words.count < 2 {
            return AppConstant.ValidationMessages.kEmptyName
        }
        else if self.vwPhoneNumber?.txtInput?.isEmpty ?? true {
            self.vwPhoneNumber?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyPhoneNumber
        } else if !(self.vwPhoneNumber?.txtInput.isValidContactPhoneno() ?? false) {
            self.vwPhoneNumber?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kInValidPhoneNo
        } else if self.vwEmail?.txtInput.isEmpty ?? false {
            self.vwEmail?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyEmail
        } else if !(self.vwEmail?.txtInput.isValidEmail() ?? false){
            self.vwEmail?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kInValidEmail
        } else if self.vwPassword?.txtInput.isEmpty ?? false {
            self.vwPassword?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyPassword
        } else if (self.vwPassword?.txtInput.text ?? "").count < 8 || (self.vwPassword?.txtInput.text ?? "").count > 15 {
            return AppConstant.ValidationMessages.kCharPassword
        } else if !validpassword(mypassword: vwPassword?.txtInput?.text ?? "")  {
            return AppConstant.ValidationMessages.kvalidPassword
            
        } else if !(self.btnTermsCondition?.isSelected ?? true) {
            return AppConstant.ValidationMessages.kAcceptTermsnCondition
            
        } else {
            return nil
        }
    }
}




//MARK : - API Call
extension SignupViewController{
    
    func SignUpAPICall() {
        self.view.endEditing(true)
        let phoneData : String = self.vwPhoneNumber?.txtInput.text?.removeSpecialCharsFromString ?? ""
        let dict : [String:Any] = [
            kEmail : self.vwEmail?.txtInput.text ?? "",
            kpassword : self.vwPassword?.txtInput.text ?? "",
            kfullName : self.vwFullName?.txtInput.text ?? "",
            kphone : phoneData,
            klangType : Rosterd.sharedInstance.languageType,
            kreferralCode : Rosterd.sharedInstance.ReferalCode
           
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.registerUser(withParam: param, success: { (user, msg) in
           
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if statuscode == APIStatusCode.verifyAcccout.rawValue {
                self.appNavigationController?.detachRightSideMenu()
                self.appNavigationController?.push(VerificationViewController.self,configuration: { (vc) in
                    vc.userEmail = self.vwEmail?.txtInput.text ?? ""
                    vc.isFromSignup = true
                })
//                Rosterd.sharedInstance.ReferalCode
            } else {
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                    //self.showAlert(withTitle: errorType.rawValue, with: error)
                 }
            }
        })
    }
}
// MARK: - ViewControllerDescribable
extension SignupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension SignupViewController: AppNavigationControllerInteractable { }


func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    // get the current text, or use an empty string if that failed
    let currentText = textField.text ?? ""

    // attempt to read the range they are trying to change, or exit if we can't
    guard let stringRange = Range(range, in: currentText) else { return false }

    // add their new text to the existing text
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

    // make sure the result is under 16 characters
    return updatedText.count <= 16
}

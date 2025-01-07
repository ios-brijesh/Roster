//
//  ResetPasswordViewController.swift
//  Rosterd
//
//  Created by WM-KP on 06/01/22.
//

import UIKit

func Newvalidpassword(mypassword : String) -> Bool
    {

        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*!]).{8,15}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }


class ResetPasswordViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var vwPassword: ReusableView?
    @IBOutlet weak var vwConfirmPassword: ReusableView?
    // MARK: - Variables
     var userEmail : String = ""
    
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
extension ResetPasswordViewController {
    private func InitConfig(){
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.subHeaderTextColor
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
extension ResetPasswordViewController {
    @IBAction func btnNextClick() {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
            return
        }
        self.recoverpasswordAPICall()
        self.appNavigationController?.present(SuccessPopupViewController.self,configuration: { vc in vc.modalPresentationStyle = .overFullScreen
        })
//        ,configuration: { vc in
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .overFullScreen
//        })
    }
}


//MARK: - Validation
extension ResetPasswordViewController {
    private func validateFields() -> String? {
        if self.vwPassword?.txtInput.isEmpty ?? false {
            self.vwPassword?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyPassword
        } else if !Newvalidpassword(mypassword: vwPassword?.txtInput?.text ?? "")  {
            self.vwPassword?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kMsgStrongPassword
        } else if self.vwConfirmPassword?.txtInput.isEmpty ?? false {
            self.vwConfirmPassword?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyConfirmPassword
        } else if self.vwPassword?.txtInput.text != self.vwConfirmPassword?.txtInput.text {
            self.vwConfirmPassword?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kDontMatchPassword
        } else {
            return nil
        }
    }
}

//MARK : - UITextFieldDelegate
extension ResetPasswordViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        /*case self.vwPassword?.txtInput:
            self.vwPassword?.txtInput.resignFirstResponder()
            self.vwPassword?.txtInput.becomeFirstResponder()*/
        case self.vwPassword?.txtInput:
            self.vwPassword?.txtInput.resignFirstResponder()
            self.vwConfirmPassword?.txtInput.becomeFirstResponder()
        case self.vwConfirmPassword?.txtInput:
            self.vwConfirmPassword?.txtInput.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

//MARK : - API Call
extension ResetPasswordViewController {
    private func recoverpasswordAPICall() {
        
        let dict : [String:Any] = [
            kEmail : self.userEmail,
            klangType : Rosterd.sharedInstance.languageType,
            KnewPassword : self.vwPassword?.txtInput.text ?? "",
            
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.resetPassword(with: param, success: { (msg) in
            //self.appNavigationController?.detachLeftSideMenu()
            //self.appNavigationController?.showSignInViewController(animationType: .fromRight, configuration: nil)
            /*self.appNavigationController?.showSignInViewController(animationType: .fromRight, configuration: { vc in
                vc.isChangePassword = true
            })*/
            self.appNavigationController?.popToPerticularViewController(ofClass: LoginViewController.self, animated: true)
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(errorType.rawValue, themeStyle: .error)
            }
        })
    }
}
// MARK: - ViewControllerDescribable
extension ResetPasswordViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension ResetPasswordViewController: AppNavigationControllerInteractable { }

//
//  ChangePasswordViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/03/22.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var vwoldpassword: TextReusableView?
    @IBOutlet weak var vwNewpassword: TextReusableView?
    @IBOutlet weak var vwComfirmpassword: TextReusableView?
    
    @IBOutlet weak var btnNext: UIButton?
    
    // MARK: - Variables
    var isFromForgotPassword : Bool = false
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
}
//MARK: - Validation
extension ChangePasswordViewController {
    private func validateFields() -> String? {
        if self.vwoldpassword?.txtInput.isEmpty ?? false {
            self.vwoldpassword?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.KOldPassword
        } else if self.vwNewpassword?.txtInput.isEmpty ?? false {
            self.vwNewpassword?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyPassword
        } else if (self.vwNewpassword?.txtInput.text ?? "").count < 8 || (self.vwNewpassword?.txtInput.text ?? "").count > 15 {
            return AppConstant.ValidationMessages.kCharPassword
        } else if !validpassword(mypassword: vwNewpassword?.txtInput?.text ?? "")  {
            return AppConstant.ValidationMessages.kvalidPassword
        } else if self.vwComfirmpassword?.txtInput.isEmpty ?? false {
            self.vwComfirmpassword?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyConfirmPassword
        } else if self.vwNewpassword?.txtInput.text != self.vwComfirmpassword?.txtInput.text {
            self.vwComfirmpassword?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kDontMatchPassword
        } else {
            return nil
        }
    }
} 

//MARK : - UITextFieldDelegate
extension ChangePasswordViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.vwoldpassword?.txtInput:
            self.vwoldpassword?.txtInput.resignFirstResponder()
            self.vwoldpassword?.txtInput.becomeFirstResponder()
        case self.vwNewpassword?.txtInput:
            self.vwNewpassword?.txtInput.resignFirstResponder()
            self.vwComfirmpassword?.txtInput.becomeFirstResponder()
        case self.vwComfirmpassword?.txtInput:
            self.vwComfirmpassword?.txtInput.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
// MARK: - Init Configure
extension ChangePasswordViewController {
    private func InitConfig(){
            
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Change Password", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
    
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}
// MARK: - IBAction
extension ChangePasswordViewController {
    @IBAction func btnSubmitClicked(_ sender: UIButton) { self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
            return
        }
        self.changePasswordAPICall()
    }
}
extension ChangePasswordViewController {
    
private func changePasswordAPICall() {
    if let user = UserModel.getCurrentUserFromDefault() {
        let dict : [String:Any] = [
            ktoken : user.token,
            klangType : Rosterd.sharedInstance.languageType,
            KoldPassword : self.vwoldpassword?.txtInput.text ?? "",
            KnewPassword : self.vwNewpassword?.txtInput.text ?? "",
            krole : Rosterd.sharedInstance.selectedUserType.rawValue
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.changePassword(with: param, success: { (msg) in
            self.showMessage(msg, themeStyle: .success)
            self.appNavigationController?.popViewController(animated: true)
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
 }

    
}
// MARK: - ViewControllerDescribable
extension ChangePasswordViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ChangePasswordViewController: AppNavigationControllerInteractable { }

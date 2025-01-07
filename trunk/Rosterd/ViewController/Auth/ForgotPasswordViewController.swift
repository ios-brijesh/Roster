//
//  ForgotPasswordViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var vwEmail: ReusableView?
    
    // MARK: - Variables
    
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
extension ForgotPasswordViewController {
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
extension ForgotPasswordViewController {
    
    @IBAction func btnNextClick() {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
            return
        }
        self.forgotpasswordAPICall()
    }
}


//MARK: - Validation
extension ForgotPasswordViewController {
    private func validateFields() -> String? {
        if self.vwEmail?.txtInput.isEmpty ?? false {
            self.vwEmail?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyEmail
        } else if !(self.vwEmail?.txtInput.isValidEmail() ?? false){
            self.vwEmail?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kInValidEmail
        } else {
            return nil
        }
    }
}


//MARK : - UITextFieldDelegate
extension ForgotPasswordViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.vwEmail?.txtInput:
            self.vwEmail?.txtInput.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

//MARK : - API
extension ForgotPasswordViewController {
    
    private func forgotpasswordAPICall() {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage)
            return
        }
        let dict : [String:Any] = [
            kEmail : self.vwEmail?.txtInput.text ?? "",
            klangType : Rosterd.sharedInstance.languageType,
            
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.forgotPassword(with: param, success: { (msg) in
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(VerificationViewController.self, configuration: { (vc) in
                vc.isFromForgotPassword = true
                vc.userEmail = self.vwEmail?.txtInput.text ?? ""
            }) 
           
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
extension ForgotPasswordViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension ForgotPasswordViewController: AppNavigationControllerInteractable { }

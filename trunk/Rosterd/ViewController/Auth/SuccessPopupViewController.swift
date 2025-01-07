//
//  SuccessPopupViewController.swift
//  Rosterd
//
//  Created by WM-KP on 07/01/22.
//

import UIKit

class SuccessPopupViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var vwBGBottom: UIView?
    
    // MARK: - Variables
    
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let vw = self.vwBGBottom {
            vw.roundCorners(corners: [.topLeft,.topRight], radius: 35.0)
        }
    }

}

// MARK: - Init Configure
extension SuccessPopupViewController {
    private func InitConfig(){
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.subHeaderTextColor
    }
}

//MARK: - IBAction Method
extension SuccessPopupViewController {
    @IBAction func btnLoginClick() {
        self.dismiss(animated: true) {
//            self.appNavigationController?.push(LoginViewController.self)
            
        }
    }
    
    @IBAction func btnDismissClick() {
        self.dismiss(animated: true) {
            
        }
    }
}


// MARK: - ViewControllerDescribable
extension SuccessPopupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension SuccessPopupViewController: AppNavigationControllerInteractable { }

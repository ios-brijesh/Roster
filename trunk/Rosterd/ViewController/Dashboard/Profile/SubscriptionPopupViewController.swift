//
//  SubscriptionPopupViewController.swift
//  Rosterd
//
//  Created by iMac on 07/07/23.
//

import UIKit

class SubscriptionPopupViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var vwMAinView: UIView?
    
    // MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let View = self.vwMAinView {
            View.cornerRadius = 10.0
            
        }
    }
    // MARK: -IBAction
    @IBAction func btnCloseCick(_ sender : UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnYes(_ sender: AppButton) {
        self.dismiss(animated: true) {
            self.appNavigationController?.push(SubscriptionViewController.self)
        }
    }
}
// MARK: - Init Configure
extension SubscriptionPopupViewController {
    private func InitConfig(){
        
        self.lblHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        
    }
}
// MARK: - ViewControllerDescribable
extension SubscriptionPopupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension SubscriptionPopupViewController: AppNavigationControllerInteractable{}

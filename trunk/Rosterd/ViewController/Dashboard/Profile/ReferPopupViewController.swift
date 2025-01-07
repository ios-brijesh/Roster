//
//  ReferPopupViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/11/22.
//

import UIKit

class ReferPopupViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var btnClose: UIButton?
    
    @IBOutlet weak var vwMAinView: UIView?
    @IBOutlet weak var imgcoin: UIImageView?
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubheader: UILabel?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
}
// MARK: - Init Configure
extension ReferPopupViewController {

    private func InitConfig(){
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 22.0))
        self.lblHeader?.textColor = UIColor.CustomColor.blackColor
        
        self.lblSubheader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubheader?.textColor = UIColor.CustomColor.subHeaderTextColor
        
        self.vwMAinView?.cornerRadius = 25.0
        self.vwMAinView?.backgroundColor = UIColor.white
    
    }
}

//MARK:  - Action
extension ReferPopupViewController {
    @IBAction func btnClose(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - ViewControllerDescribable
extension ReferPopupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ReferPopupViewController: AppNavigationControllerInteractable { }


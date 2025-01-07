//
//  ReferFriendViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/11/22.
//

import UIKit

class ReferFriendViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblinvitelink: UILabel?
    @IBOutlet weak var lblinstalllink: UILabel?
    @IBOutlet weak var lblcoinslink: UILabel?
    @IBOutlet weak var lblSharelink: UILabel?
    @IBOutlet weak var lblLink: UILabel?
    
    @IBOutlet weak var btnCopy: UIButton?
    @IBOutlet weak var btnSahre: AppButton?
    
    @IBOutlet weak var VwMiddleView: UIView!
    @IBOutlet weak var VwLinkView: UIView?
    private var userProfileData : UserModel?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.getUserInfo()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}
// MARK: - Init Configure
extension ReferFriendViewController {
        
    private func InitConfig(){
        self.VwLinkView?.cornerRadius = 17.0
        self.VwLinkView?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        self.VwLinkView?.borderWidth = 1.0
        self.VwLinkView?.borderColor = UIColor.CustomColor.borderColor4
        
        self.VwMiddleView?.cornerRadius = 12.0
        self.VwMiddleView?.backgroundColor = UIColor.CustomColor.sepratorFeedColor
        
        self.lblLink?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblLink?.textColor = UIColor.CustomColor.reusablePlaceholderColor
        
        self.lblinstalllink?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.lblinstalllink?.textColor = UIColor.CustomColor.blackColor
        
        self.lblinvitelink?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.lblinvitelink?.textColor = UIColor.CustomColor.blackColor
        
        self.lblcoinslink?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.lblcoinslink?.textColor = UIColor.CustomColor.blackColor
        
        self.lblSharelink?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblSharelink?.textColor = UIColor.CustomColor.blackColor
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Refer your friends", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}
// MARK: - API Call
extension ReferFriendViewController {
    
    private func getUserInfo(){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.getUserInfo(with: param, success: { (user,msg) in
                self.userProfileData = user
                self.setProfileData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }

            })
        }
    }
    private func setProfileData(){
        if let obj = self.userProfileData {
            self.lblLink?.text = obj.shareReferralLink
        }
    }
}
//MARK:  - Action
extension ReferFriendViewController {
    @IBAction func btnShareCLicked(_ sender : AppButton) {
        let obj = self.userProfileData
        let textToShare = [obj?.shareReferralLink]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            self.present(activityViewController, animated: true, completion: nil)
    }
}
//MARK:  - Action
extension ReferFriendViewController {
    @IBAction func btnCopyClick(_ sender : UIButton) {
        UIPasteboard.general.string = self.userProfileData?.shareReferralLink
    }
}
// MARK: - ViewControllerDescribable
extension ReferFriendViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}
// MARK: - AppNavigationControllerInteractable
extension ReferFriendViewController: AppNavigationControllerInteractable { }

//
//  AppSideMenuViewController.swift
//  Momentor
//
//  Created by mac on 16/01/2020.
//  Copyright © 2019 Differenzsystem Pvt. LTD. All rights reserved.
//

import UIKit
import ViewControllerDescribable
import MessageUI

protocol AppSideMenuViewControllerDelegate: class {
    func appSideMenuViewControllerDidChooseHome(_ sideMenuViewController: AppSideMenuViewController)
}

class AppSideMenuViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var vwMenu: UIView?
    @IBOutlet weak var viewProfilePic: UIView?
    @IBOutlet weak var view_MainContent: UIView?
    @IBOutlet weak var vwMain: UIView?
    @IBOutlet weak var vwLineSub: UIView?
    @IBOutlet weak var vwLineSubMain: UIView?
//
    @IBOutlet weak var btnAboutus: UIButton?
    @IBOutlet weak var btnadvertise: UIButton?
   
    
    @IBOutlet weak var btnLogOut: UIButton?
    @IBOutlet weak var btndeleteaccount: UIButton?
    @IBOutlet weak var lblSetting: UILabel?
    @IBOutlet  var lblcontent: [UILabel]?
    @IBOutlet  var lblHeder: [UILabel]?
    
    
    @IBOutlet weak var switchNotification: UISwitch?
    

    
    // MARK: - Variables
    private var selectedRole : userRole = .fan
    fileprivate lazy var sections = [RowType]()
    weak var delegate: AppSideMenuViewControllerDelegate?
    
    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InitConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        if let myswitch = self.switchNotification {
            myswitch.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: myswitch.frame, colors: [UIColor.CustomColor.cardBackColor,UIColor.CustomColor.cardBackColor])
            myswitch.onTintColor = GradientColor(gradientStyle: .topToBottom, frame: myswitch.frame, colors: [UIColor.CustomColor.cardBackColor,UIColor.CustomColor.cardBackColor])
            myswitch.tintColor = GradientColor(gradientStyle: .topToBottom, frame: myswitch.frame, colors: [UIColor.CustomColor.cardBackColor,UIColor.CustomColor.cardBackColor])

        }

        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.configureNavigationBar()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.configureProfileData()
      
        prepareSections()
//        tblMenu?.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfileObserver(notification:)), name: NSNotification.Name(rawValue: NotificationPostname.KUpdateProfile), object: nil)
    }
}

// MARK: - Init Configure Methods
extension AppSideMenuViewController {
    private func InitConfig(){
        
//        self.btnClose?.backgroundColor = UIColor.CustomColor.BacButtonBGColor
        
        self.vwLineSubMain?.backgroundColor = UIColor.CustomColor.categoriesBorderColor
        self.vwLineSub?.backgroundColor = UIColor.CustomColor.SubLine15Alpha
        
        if let myswitch = self.switchNotification {
            myswitch.isOn = true
            //myswitch.onTintColor = UIColor.CustomColor.whitecolor
            //myswitch.tintColor = UIColor.CustomColor.whitecolor
            myswitch.cornerRadius = 16.0
            //myswitch.backgroundColor = UIColor.CustomColor.whitecolor
            myswitch.thumbTintColor = UIColor.CustomColor.gradiantColorBottom
        }
        
        self.lblSetting?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblSetting?.textColor = UIColor.CustomColor.TextColor
        
        self.lblHeder?.forEach({
            $0.textColor = UIColor.CustomColor.appColor
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.lblcontent?.forEach({
            $0.textColor = UIColor.CustomColor.TextColor
            $0.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        })
       
       
        
        [self.btndeleteaccount,self.btnLogOut].forEach({
            $0?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
            $0?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        })
        
        self.btnadvertise?.setTitleColor(UIColor.CustomColor.TextColor, for: .normal)
        self.btnadvertise?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        
        self.btnAboutus?.setTitleColor(UIColor.CustomColor.TextColor, for: .normal)
        self.btnAboutus?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        delay(seconds: 0.2) {
            if let vwprofile = self.viewProfilePic {
                vwprofile.cornerRadius = vwprofile.frame.height / 2
                vwprofile.maskToBounds = true
                vwprofile.borderColor = UIColor.CustomColor.categoriesBorderColor
                vwprofile.borderWidth = 5.0
                vwprofile.layoutIfNeeded()
            }
           
        }
        delay(seconds: 0.2) {
            if  let vwMenu = self.vwMenu {
                vwMenu.roundCorners(corners: [.topLeft,.bottomLeft], radius: 20.0)

            }
        }
        
        self.switchNotification?.isOn = true
    }
    
    private func configureNavigationBar() {
        
        
              appNavigationController?.setNavigationBarHidden(true, animated: true)
              appNavigationController?.navigationBar.backgroundColor = UIColor.clear
              self.navigationController?.setNavigationBarHidden(false, animated: false)
              
              appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Create Post", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
              
              navigationController?.navigationBar
                  .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
              navigationController?.navigationBar.removeShadowLine()
    }
    @objc func updateProfileObserver(notification: Notification) {
        self.configureProfileData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
       // self.configureProfileData()
        return .default
    }
    func updateSections() {
        prepareSections()
//        tblMenu?.reloadData()
    }
    
    func configureProfileData() {
        
        if let user = UserModel.getCurrentUserFromDefault() {
            
           
        }
    }
    func bindTapGestureToAvatar() {
        //self.imgProfile.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
//        self.imgProfile?.addGestureRecognizer(gesture)
    }
    @objc func tapGestureAction(_ sender: UITapGestureRecognizer) {
        //self.showProfileViewController()
        delay(seconds: 0.2) {
            //self.sideMenuController?.hideLeftViewAnimated(sender: self)
            self.hideLeftViewAnimated(true)
            //self.hideRightViewAnimated(self)
        }
    }

}

// MARK: - Rows definition
extension AppSideMenuViewController {
    enum RowType: Int {
        case ChangePassword
        case HelpSupport
        case AboutUs
        case FeedBack
       
        
        
        var name : String {
            switch self {
            case .ChangePassword:
                return "ChangePassword"
            case .HelpSupport :
                return "Help & Support"
            case .AboutUs :
                return "AboutUs"
            case .FeedBack :
                return "FeedBack"
           
            }
        }
        
        var img : UIImage {
            switch self {
            case .ChangePassword:
                return #imageLiteral(resourceName: "ic_ChangePassword")
            case .HelpSupport :
                return #imageLiteral(resourceName: "ic_HelpSupporticon")
            case .AboutUs :
                return #imageLiteral(resourceName: "ic_AboutUS")
            case .FeedBack :
                return #imageLiteral(resourceName: "ic_FeedBac")
            
            }
        }
    }
    func prepareSections() {
        self.configureProfileData()
        //self.imgProfile.roundedCornerRadius()
        sections.removeAll()
        sections = [.ChangePassword,.HelpSupport,.AboutUs,.FeedBack]
      
        if let user = UserModel.getCurrentUserFromDefault() {
            //if user.invitation_status == InvitationStatus.Enable.rawValue {
               // sections = [.Profile,.Messages,.InviteBlackProfessionals,.Settings,.SendFeedback]
           //}
       }
    }
}
// MARK: - UITableViewDataSource
extension AppSideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForFeaturesSection(tableView, at: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension AppSideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let rowType = sectionData(in: indexPath.row)
//        self.tblMenu?.isUserInteractionEnabled = false;
        didSelectFeaturesItem(rowType)
        tableView.deselectRow(at: indexPath, animated: true)
        
        perform(#selector(self.startUserIntraction), with: nil, afterDelay: 3.0)
    }
}

// MARK: - IBAction
extension AppSideMenuViewController{
    @IBAction func btnManageSubscriptionClick(_ sender: Any) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            //self.sideMenuController?.hideLeftViewAnimated(sender: self)
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(SubscriptionViewController.self)
        }
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            //self.hideRightViewAnimated(true)
            //self.sideMenuController?.hideLeftViewAnimated(sender: self)
            //self.hideLeftViewAnimated(self)
            self.hideRightViewAnimated(self)
            self.appNavigationController?.popToRootViewController(animated: true)
        }
    }
    @IBAction func btnInviteClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            //self.sideMenuController?.hideLeftViewAnimated(sender: self)
            //self.appNavigationController?.push(InviteAppViewController.self)
        }
    }
    @IBAction func btnFeedbackClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            //self.sideMenuController?.hideLeftViewAnimated(sender: self)
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(FeedBackViewController.self)
        }
    }
    @IBAction func btnEditProfileClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            //self.sideMenuController?.hideLeftViewAnimated(sender: self)
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(CompleteProfileViewController.self,configuration: { vc in
                vc.selectedRole = self.selectedRole
                vc.isFromEditProfile = true
                
            })
        }
    }
    
    @IBAction func btnAboutUsClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(AboutUsViewController.self)
        }
    }
    
    
    @IBAction func btnAdvertiseClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(AdvertiseViewController.self)
        }
    }
    
    @IBAction func btnSupportClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(HelpViewController.self)
        }
    }
    
    @IBAction func btnChangePAsswordClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(ChangePasswordViewController.self)
        }
    }
    
    
    @IBAction func btnfeedbackClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(FeedBackViewController.self)
        }
    }
    
    @IBAction func btnManageaddressClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(ManageAddressViewController.self,configuration: { vc in
                vc.isFromMenu = true
            })
        }
    }
    
    @IBAction func btnManageCardClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(ManageCardViewController.self)
        }
    }
    
    @IBAction func btnMyWishlistClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(ProductFavoriteViewController.self)
        }
    }
    
    @IBAction func switchClicked(_ sender: UISwitch) {
        
        self.OnOffNotification()
        
    }
    
    @IBAction func btnReferClicked(_ sender : UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideRightViewAnimated(self)
            self.appNavigationController?.push(ReferFriendViewController.self)
        }
    }

    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideLeftViewAnimated(self)
            self.showAlert(withTitle: "", with: AppConstant.AlertMessages.kLogout, firstButton: "Yes", firstHandler: { (action) in
                self.logout()
            }, secondButton: "No", secondHandler: nil)
        }
    }
    
    @IBAction func btnDeleteAccountClicked(_ sender : UIButton) {
        delay(seconds: 0.2) {
            self.appNavigationController?.detachRightSideMenu()
            self.hideLeftViewAnimated(self)
            self.showAlert(withTitle: "", with: AppConstant.AlertMessages.kDeleteAccount, firstButton: "Yes", firstHandler: { (action) in
                self.DeleteAccount()
            }, secondButton: "No", secondHandler: nil)
        }
    }
    
    @IBAction func btnResumeClicked(_ sendeer : UIButton) {
        if let user = UserModel.getCurrentUserFromDefault(),user.id != "" {
            if user.subscriptionId == "0" || user.subscriptionId == "" {
                self.appNavigationController?.present(SubscriptionPopupViewController.self,configuration: { (vc) in
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                })
            } else {
                self.appNavigationController?.detachRightSideMenu()
                self.hideLeftViewAnimated(self)
                self.appNavigationController?.push(ResumeDetailViewController.self)
            }
        }
    }
}

// MARK: - UITableView helpers
fileprivate extension AppSideMenuViewController {
    func configureTableView() {
//        tblMenu?.backgroundView?.backgroundColor = .clear
//               tblMenu?.backgroundColor = .clear
//
//               tblMenu?.register(MenuCell.self)
//               //tblMenu?.register(MenuHelpCell.self)
//
//               tblMenu?.dataSource = self
//               tblMenu?.delegate = self
    }
    func sectionData(in index: Int) -> RowType {
        return sections[index]
    }
    @objc func startUserIntraction(){
//        self.tblMenu?.isUserInteractionEnabled = true;
    }
}
// MARK: - Private Methods
fileprivate extension AppSideMenuViewController {
    func showHomeViewController() {
        //appNavigationController?.push(HomeViewController.self)
    }
   
    func showFeedBackComposer() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["info@abc.com"])
            mailComposer.setSubject("abc Feedback")
            mailComposer.setMessageBody("", isHTML: false)
            DispatchQueue.main.async {
                self.present(mailComposer,animated: true,completion: nil)
            }
        }
        else {
            self.showMessage(AppConstant.FailureMessage.kMailNoteSetUp, themeStyle: .warning)
            //self.showAlert(with: AppConstant.FailureMessage.kMailNoteSetUp)
        }
    }
}
// MARK: - UITableView Cells definition
fileprivate extension AppSideMenuViewController {
    
    func cellForFeaturesSection(_ tableView: UITableView,
                                at indexPath: IndexPath) -> UITableViewCell {
        let rowType = sectionData(in: indexPath.row)
        
        return appMenuItemNameDescribableTableViewCell(tableView, at: indexPath, menuName: rowType.name, rowType: rowType,img : rowType.img)
        
        
    }
    
    func appMenuItemNameDescribableTableViewCell(_ tableView: UITableView,
                                                 at indexPath: IndexPath,
                                                 menuName: String,
                                                 rowType: RowType,
                                                 img : UIImage,
                                                 configuration: ((MenuCell) -> Void)? = nil) -> UITableViewCell {
        /*if indexPath.row == self.sections.count - 1 {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: MenuHelpCell.self)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            if let imgIcon = cell.imgMenu {
                imgIcon.image = img
            }
            cell.lblHeader?.text = menuName
            return cell
        }*/
        let cell = tableView.dequeueReusableCell(for: indexPath, with: MenuCell.self)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        if let imgIcon = cell.imgMenu {
            imgIcon.image = img
        }
        cell.lblMenuName?.text = menuName
        //        cell.activityType = rowType
        configuration?(cell)
        
        return cell
    }
    
    func didSelectFeaturesItem(_ rowType: RowType) {
        self.appNavigationController?.detachRightSideMenu()
        self.hideRightViewAnimated(self)
        switch rowType {
        case .ChangePassword:
            delay(seconds: 0.2) {
                self.appNavigationController?.detachRightSideMenu()
                self.hideRightViewAnimated(self)
                self.appNavigationController?.push(ChangePasswordViewController.self)
            }
        case .HelpSupport:
            delay(seconds: 0.2) {
                self.appNavigationController?.detachRightSideMenu()
                self.hideRightViewAnimated(self)
                self.appNavigationController?.push(HelpViewController.self)
            }
        case .AboutUs:
            delay(seconds: 0.2) {
                self.appNavigationController?.detachRightSideMenu()
                self.hideRightViewAnimated(self)
                self.appNavigationController?.push(AboutUsViewController.self)
            }
        case .FeedBack:
            delay(seconds: 0.2) {
                self.appNavigationController?.detachRightSideMenu()
                self.hideRightViewAnimated(self)
                self.appNavigationController?.push(FeedBackViewController.self)
            }
        }
    }
    
   
}

extension AppSideMenuViewController {
    
    func logout() {
        self.view.endEditing(true)
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.logoutUser(with: param) { (msg) in
                //self.showMessage(msg, themeStyle: .success)
                appDelegate.clearUserDataForLogout()
                self.appNavigationController?.showLoginViewController(animationType: .fromRight)
            } failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                appDelegate.clearUserDataForLogout()
                self.appNavigationController?.showLoginViewController(animationType: .fromRight)
                /*if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                } else {
                    if !error.isEmpty {
                        self.showMessage(errorType.rawValue, themeStyle: .error)
                    }
                }*/
            }
        }
    }
    
    func OnOffNotification() {
        
        
        self.view.endEditing(true)
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                knotification : (self.switchNotification?.isOn ?? false) ? "1" : "0"
                
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.OnOffNotification(with: param) { (msg) in
                //self.showMessage(msg, themeStyle: .success)
               
            } failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
             
                /*if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                } else {
                    if !error.isEmpty {
                        self.showMessage(errorType.rawValue, themeStyle: .error)
                    }
                }*/
            }
        }
    }
    
    func DeleteAccount() {
        self.view.endEditing(true)
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.DeleteAccount(with: param) { (msg) in
                //self.showMessage(msg, themeStyle: .success)
                appDelegate.clearUserDataForLogout()
                self.appNavigationController?.showLoginViewController(animationType: .fromRight)
            } failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                appDelegate.clearUserDataForLogout()
                self.appNavigationController?.showLoginViewController(animationType: .fromRight)
                /*if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                } else {
                    if !error.isEmpty {
                        self.showMessage(errorType.rawValue, themeStyle: .error)
                    }
                }*/
            }
        }
    }
    
}
// MARK: - ViewControllerDescribable
extension AppSideMenuViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.main
    }
}
// MARK: - AppNavigationControllerInteractable
extension AppSideMenuViewController: AppNavigationControllerInteractable { }

//MARK: - MFMailComposeViewControllerDelegate
extension AppSideMenuViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        //case MFMailComposeResult.cancelled: break
        case MFMailComposeResult.sent:
            controller.dismiss(animated: true) {
                //self.showAlert(with: AppConstant.SuccessMessage.kMailSent)
                self.showMessage(AppConstant.SuccessMessage.kMailSent, themeStyle: .success)
            }
        case MFMailComposeResult.cancelled:
            controller.dismiss(animated: true, completion: nil)
            
        default:
            //            self.dismiss(animated: true, completion: nil)
            controller.dismiss(animated: true, completion: nil)
        }
    }
}

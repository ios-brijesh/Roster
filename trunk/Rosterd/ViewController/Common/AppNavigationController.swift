//
//  AppNavigationController.swift
//  Momentor
//
//  Created by mac on 16/01/2020.
//  Copyright © 2019 Differenzsystem Pvt. LTD. All rights reserved.
//

import UIKit
import ViewControllerDescribable
import SVProgressHUD

protocol AppNavigationControllerMenuDelegate: class {
    func appNavigationController(_ appNavigationController: AppNavigationController,
                                 setrightMenuEnabled isrightMenuEnabled: Bool)
    
    func appNavigationController(_ appNavigationController: AppNavigationController,
                                 setrightMenuSwipeEnabled isrightMenuSwipeEnabled: Bool)
    
    func appNavigationControllerWasInvokedUpdateMenu(_ appNavigationController: AppNavigationController)
}

protocol AppNavigationControllerButtonDelegate: class {
    func btnMoreClicked()
}


class AppNavigationController: UINavigationController {
    
    weak var menuDelegate: AppNavigationControllerMenuDelegate?
    
    weak var btnDelegate : AppNavigationControllerButtonDelegate?
    
    var titleBarButtonItem = UIBarButtonItem()
    
    let lblHomeDashboardAddress : UILabel = UILabel()
    
    var btnNextClickBlock : (() -> ())?
    var btnAddCardClickBlock : (() -> ())?
    var btnMoreClickBlock : (() -> ())?
    
    var btnConfirmNotesClickBlock : (() -> ())?
    var btnEditNotesClickBlock : (() -> ())?
    var btnUndoNotesClickBlock : (() -> ())?
    var btnRedoNotesClickBlock : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        preloadFlow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(tokenExpire(notification:)), name: NSNotification.Name(rawValue: NotificationPostname.KAuthenticationTokenExpire), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(OpenNotificationDetails(notification:)), name: NSNotification.Name(rawValue: NotificationPostname.kPushNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(openRosterdDetail(notification:)), name: NSNotification.Name(rawValue: NotificationPostname.kOpenRosterdDetail), object: nil)
        //self.showAlert(with: "App Navigation Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func tokenExpire(notification: Notification) {
        self.AuthTokenExpire()
    }
    
    @objc func openRosterdDetail(notification: Notification) {
        if let userinfo = notification.userInfo, let id = userinfo["linkid"] as? String,let type = userinfo["linktype"] as? String {
            if type == "product" {
                self.push(ProductDetailViewController.self) { vc in
                    vc.selectedproductdata = id
                }
            }
            if type == "post" {
                
            }
            if type == "event" {
                self.push(EventDetailsViewController.self) { vc in
                    vc.SelectedEventData = id
                    vc.isPublish = true
                }
            }
        }
    }
    
    @objc func OpenNotificationDetails(notification: Notification) {
        if notification.object != nil {
            if let notificationdata : [String : Any] = notification.object as? [String : Any] {
                print(notificationdata)
                //print("g")
                /*if let msgdic = notificationdata["messages"] as? [String:Any] {
                    print(msgdic)
                    if let msgdata = msgdic["messageData"] as? [String:Any] {
                        print(msgdata)
                        print(msgdata[kmodel_id])
                    }
                }*/
                if let msgdic = notificationdata["messages"] as? [String:Any], let msgdata = msgdic["messageData"] as? [String:Any] {
                    if let modeldtata = msgdata["model"] as? String {
                        if modeldtata == "userFollow" {
                            if let modelid = msgdata[kPushModelId] as? String {
                                self.detachRightSideMenu()
                                self.push(ProfileViewController.self, configuration: { (vc) in
                                    vc.selectedUserID = "\(modelid)"
                                })
                            }
                        } else if modeldtata == "chatMessage" {
                            if let modelid = msgdata[kPushModelId] as? String {
                                self.detachRightSideMenu()
                                self.push(MessageChatViewController.self, configuration: { (vc) in
                                    vc.chatUserID = "\(modelid)"
                                })
                            }
                        }  else if modeldtata == "orderPlaced" {
                            if let modelid = msgdata[kPushModelId] as? String {
                                self.detachRightSideMenu()
                                self.push(OrderDetailViewController.self, configuration: { (vc) in
                                    vc.ProductData = "\(modelid)"
                                })
                            }
                        }  else if modeldtata == "orderCancelled" {
                            if let modelid = msgdata[kPushModelId] as? String {
                                self.detachRightSideMenu()
                                self.push(OrderDetailViewController.self, configuration: { (vc) in
                                    vc.ProductData = "\(modelid)"
                                })
                            }
                        }  else if modeldtata == "userLike" {
                            if let modelid = msgdata[kpostId] as? String {
                                self.detachRightSideMenu()
                                self.push(FeedLikeViewController.self, configuration: { (vc) in
                                    vc.LikeId = "\(modelid)"
                                })
                            }
                        }  else if modeldtata == "userComment" {
                            if let modelid = msgdata[kpostId] as? String {
                                self.detachRightSideMenu()
                                self.push(FeedCommentViewController.self, configuration: { (vc) in
                                    vc.CommentId = "\(modelid)"
                                })
                            }
                        } else if modeldtata == "eventBooked" {
                            if let modelid = msgdata[kPushModelId] as? String {
                                self.detachRightSideMenu()
                                self.push(EventDetailsViewController.self, configuration: { (vc) in
                                    vc.SelectedEventData = "\(modelid)"
                                    vc.isPublish = true
                                })
                            }
                        } else if modeldtata == "userGalleryUpdate" {
                            if let modelid = msgdata[kmodel_id] as? String {
                                self.detachRightSideMenu()
                                self.push(InsideAlbumViewController.self, configuration: { (vc) in
                                    vc.selectedAlbumdata = "\(modelid)"
                                   
                                })
                            }
                        } else if modeldtata == "userNewPost" {
                            if let modelid = msgdata[kmodel_id] as? String {
                                self.detachRightSideMenu()
                                self.showDashBoardViewController()
                            }
                        }
                    }
                }
            }
        }
    }
    
}
// MARK: - ViewControllerDescribable
extension AppNavigationController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.main
    }
}
// MARK: - SideAnimatable
extension AppNavigationController: SideAnimatable { }

// MARK: - Public helpers
extension AppNavigationController {
    
    func AuthTokenExpire() {
        self.showMessage(AppConstant.AlertMessages.AuthTokenExpire, themeStyle: .warning)
        //self.showAlert(withTitle: "", with: AppConstant.AlertMessages.AuthTokenExpire, firstButton: ButtonTitle.OK, firstHandler: { (UIAlertAction) in
        self.detachRightSideMenu()
        appDelegate.clearUserDataForLogout()
        self.showTutorialViewController(animationType: .fromRight)
        // }, secondButton: nil, secondHandler: nil)
    }
    
    func signOut() {
        detachRightSideMenu()
       // showSignInViewController(animationType: .fromRight)
        appDelegate.clearUserDataForLogout()
    }
    
    func updateMenu() {
        menuDelegate?.appNavigationControllerWasInvokedUpdateMenu(self)
    }
}
// MARK: - UI helpers
fileprivate extension AppNavigationController {
    func configureUI() {
        clearBackBarButtonItem()
        
        navigationBar
            .makeTranslucent()
            .configure(barTintColor: .clear, tintColor: UIColor.CustomColor.appColor)
//        navigationBar
//        .makeTranslucent()
//        .configure(barTintColor: .clear, tintColor: #colorLiteral(red: 1, green: 0.7725490196, blue: 0.3254901961, alpha: 1))
        //self.view.layer.borderColor = UIColor.CustomColor.appColor as! CGColor
    }
    
    func preloadFlow() {
//        showTutorialViewController(animationType: .fromRight)
//        showTutorialViewController(animationType: .fromRight)
//        WebSocketChat.shared.connectSocket()
//        self.showEventsViewController()
//        self.showDashBoardViewController()
         if UserDefaults.isUserLogin {
            Rosterd.sharedInstance.currentUser =  UserModel.getCurrentUserFromDefault()
            if let user = UserModel.getCurrentUserFromDefault() {
                if !user.token.isEmpty {
                    print("Login Token : \(user.token)")
                    self.detachRightSideMenu()
//                Rosterd.sharedInstance.selectedUserType = user.String
                if user.profileStatus == "1" {
                    self.push(SelectProfileTypeViewController.self) { vc in
                        vc.isFromLogin = true
                    }
//                } else if user.profileStatus == "2" {
//                    self.push(CompleteProfileViewController.self) { vc in
//                        vc.isFromLogin = true
//                    }
                }   else {
                    WebSocketChat.shared.connectSocket()
                    self.showDashBoardViewController()
                }
            } else {
                    showTutorialViewController(animationType: .fromRight)
                }
            } else {
                showTutorialViewController(animationType: .fromRight)
            }
        } else {
            showTutorialViewController(animationType: .fromRight)
        }
    }
    
    func setUpLoginNavigationTitle(btntitle : String,btnTitleColor : UIColor,navigationItem : UINavigationItem,isFromMentorProfile : Bool = false,isHideFollow : Bool = false) {
        
        let rightbtn = UIBarButtonItem.makBarButtonItem(with: btntitle, color: btnTitleColor, font: isFromMentorProfile ? UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0)) : UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 13.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
        if isFromMentorProfile {
            let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
            navigationItem.leftBarButtonItems = [backBarButtonItem]
        } else {
            let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
            navigationItem.leftBarButtonItems = [backBarButtonItem]
        }
        if isHideFollow {
            navigationItem.rightBarButtonItems = []
        } else {
            navigationItem.rightBarButtonItems = [rightbtn]
        }
    }
    
    
    func setUpNavigationTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isHideBackButton : Bool = false,isfromDirect : Bool = false) {
        //let fontSize: CFloat = DeviceType.IS_PAD ? 28 : 22
        //let img = #imageLiteral(resourceName: "ic_BackImg")
        //let backBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backbuttonClicked(sender:)))
        let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: isfromDirect ? #selector(self.backLoginButtonClicked(sender:)) : #selector(self.backbuttonClicked(sender:)))
        //itemWithProfilePic(colorfulImage: #imageLiteral(resourceName: "UserProfileNav"), target: self, action: #selector(profilebuttonClicked(sender:)),url: UserModel.getCurrentUserFromDefault()?.profileimage ?? "")
//        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 22.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        if isHideBackButton {
            navigationItem.leftBarButtonItems = []
        } else {
            navigationItem.leftBarButtonItems = [backBarButtonItem]
        }
        //} else {
            //navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        //}
        //navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        
    }
    func setUpBackWithTitleNavigationBar(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_BackImg"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem]
    }
    
    func setUpBackWithTitleWhiteNavigationBar(title : String,TitleColor : UIColor,isShowRightButton : Bool,navigationItem : UINavigationItem) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: TitleColor, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        
        if isShowRightButton {
            let rightbtn = UIBarButtonItem.itemWithBackOtherPic(colorfulImage: #imageLiteral(resourceName: "ic_Searchicon"), target: self, action: #selector(self.searchButtonClicked(sender:)))
            navigationItem.rightBarButtonItems = [rightbtn]
        }
        
    }
    func setUpBackWithFAQPaymentNavigationBar(title : String,TitleColor : UIColor,isShowRightButton : Bool,navigationItem : UINavigationItem) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: TitleColor, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        
        if isShowRightButton {
            let rightbtn = UIBarButtonItem.itemWithBackOtherPic(colorfulImage: #imageLiteral(resourceName: "ic_Paymenticon"), target: self, action: #selector(self.searchButtonClicked(sender:)))
            navigationItem.rightBarButtonItems = [rightbtn]
        }
        
    }
    func setUpBackEventNavigationBar(title : String,TitleColor : UIColor,isShowRightButton : Bool,navigationItem : UINavigationItem) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: TitleColor, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        
        if isShowRightButton {
            let Forwardtbtn = UIBarButtonItem.itemWithBackOtherPic(colorfulImage: #imageLiteral(resourceName: "ic_forwardEvent"), target: self, action: #selector(self.searchButtonClicked(sender:)))
            let Likebtn = UIBarButtonItem.itemWithBackOtherPic(colorfulImage: #imageLiteral(resourceName: "ic_LikeEvent"), target: self, action: #selector(self.searchButtonClicked(sender:)))
            navigationItem.rightBarButtonItems = [Likebtn,Forwardtbtn]
        }
        
    }
    
    func SetUpTicketTransferNAvigationBar(title : String,TitleColor : UIColor,isShowRightButton :Bool,navigationItem : UINavigationItem) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: TitleColor, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        
        if isShowRightButton {
            let Forwardtbtn = UIBarButtonItem.makBarButtonDisableItem(with: "Transfer", color: UIColor.CustomColor.appColor, font: UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0)), target: self, action: #selector(self.searchButtonClicked(sender:)))
            let Likebtn = UIBarButtonItem.itemWithBackOtherPic(colorfulImage: #imageLiteral(resourceName: "ic_Transferic"), target: self, action: #selector(self.searchButtonClicked(sender:)))
            navigationItem.rightBarButtonItems = [Likebtn,Forwardtbtn]
        }
    }
    
    func setUpNavigationMyProfile(title : String,rightTitle : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        
        let rightbtn = UIBarButtonItem.makBarButtonItemImageWithText(with: rightTitle, colorfulImage: #imageLiteral(resourceName: "ic_Setting"), color: TitleColor, font: UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0)), target: self, action: #selector(self.menubuttonClicked(sender:)))
        //makBarButtonItem(with: title, color: TitleColor, font: UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
    
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        navigationItem.rightBarButtonItems = [rightbtn]
    }
    
    
    
    func setUpBackWithTitleNavigationBarWithColor(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isShowBackButton : Bool = true) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : TitleColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        if isShowBackButton{
            let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_BackImg"), target: self, action: #selector(self.backbuttonClicked(sender:)))
            navigationItem.leftBarButtonItems = [backBarButtonItem]
        } else {
            navigationItem.leftBarButtonItems = []
            navigationItem.setHidesBackButton(true, animated: false)
        }
    }
    
    func setUpBackTitleandRightButtonColorNavigationBar(titlecolor : UIColor, buttontitle : String,ButtonColor : UIColor,isMoveDashboard : Bool ,isShowRightButton : Bool,navigationItem : UINavigationItem) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titlecolor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_LeftArrowWhite"), target: self, action: isMoveDashboard ? #selector(self.dashboardBackbuttonClicked(sender:)) : #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem]
        
        if isShowRightButton {
            let rightbtn = UIBarButtonItem.makBarButtonItem(with: buttontitle, color: ButtonColor, font: UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
            
            navigationItem.rightBarButtonItems = [rightbtn]
        }
        navigationItem.leftBarButtonItems = [backBarButtonItem]
    }
    
    func setUpNavigationBackWithTitleButton(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
    }
    
    func setUpBackTitleRightBackBtnNavigationBar(title : String,TitleColor : UIColor,rightBtntitle : String,rightBtnColor : UIColor,navigationItem : UINavigationItem) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        
        let rightbtn = UIBarButtonItem.makBarButtonItem(with: rightBtntitle, color: rightBtnColor, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
        
        navigationItem.rightBarButtonItems = [rightbtn]
        //navigationItem.leftBarButtonItems = [backBarButtonItem]
    }
       
    func setUpBackTitleRightBackBtnNavigationBarBlack(title : String,TitleColor : UIColor,rightBtntitle : String,rightBtnColor : UIColor,navigationItem : UINavigationItem) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.white, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        
        let rightbtn = UIBarButtonItem.makBarButtonItem(with: rightBtntitle, color: rightBtnColor, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
        
        navigationItem.rightBarButtonItems = [rightbtn]
        //navigationItem.leftBarButtonItems = [backBarButtonItem]
    }
    
    func setUpNavigationShopnav(title : String,rightTitle : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        
        let rightbtn = UIBarButtonItem.makBarButtonItemImageWithText(with: rightTitle, colorfulImage: #imageLiteral(resourceName: "ic_doticon"), color: TitleColor, font: UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
        //makBarButtonItem(with: title, color: TitleColor, font: UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
    
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        navigationItem.rightBarButtonItems = [rightbtn]
    }
    
    func setUpNotification(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        
        
    
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
       
    }
    func setUpNavigationBarVideoCall(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackVideoCall(colorfulImage: #imageLiteral(resourceName: "ic_LeftArrowWhite"), target: self, action: #selector(self.backbuttonClicked(sender:)))
    
        navigationItem.leftBarButtonItems = [backBarButtonItem]
    }
    
    func setUpNavigationFAQ(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
    
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
    }
    
    func setUpMyMomentorNavigationBackWithTitleButton(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.black, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackRoundPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        let searchBarButtonItem = UIBarButtonItem.itemWithBackOtherPic(colorfulImage: #imageLiteral(resourceName: "ic_SearchGray"), target: self, action: #selector(self.searchButtonClicked(sender:)))
    
        navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
    }
    
    func setUpChatNavigationBackWithTitleButton(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isShowDot : Bool = false, isHideTitleBar : Bool = false,isHideSearch : Bool = false) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : TitleColor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.CustomColor.whitecolor, font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_LeftArrowWhite"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        
        let searchBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage:isShowDot ? #imageLiteral(resourceName: "ic_3DotWhite") : #imageLiteral(resourceName: "ic_SearchWhite"), target: self, action: #selector(self.searchButtonClicked(sender:)))
        
        if isHideTitleBar {
            navigationItem.leftBarButtonItems = [backBarButtonItem]
        } else {
            navigationItem.leftBarButtonItems = [backBarButtonItem,titleBarButtonItem]
        }
        if isHideSearch {
            navigationItem.rightBarButtonItems = []
            if isShowDot {
                navigationItem.rightBarButtonItems = [searchBarButtonItem]
            }
        } else {
            navigationItem.rightBarButtonItems = [searchBarButtonItem]
        }
    }
    
    func setUpEditNotesNavigationBar(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isFromEdit : Bool) {
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackOtherPic(colorfulImage: #imageLiteral(resourceName: "ic_navBack"), target: self, action: #selector(self.backbuttonClicked(sender:)))
        
        let editBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_NotesEdit"), target: self, action: #selector(self.EditNotesButtonClicked(sender:)))
        let reduBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_NotesRedu"), target: self, action: #selector(self.RedoNotesButtonClicked(sender:)))
        let undoBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_NotesUndo"), target: self, action: #selector(self.undoNotesButtonClicked(sender:)))
        let confirmBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_NotesTickDone"), target: self, action: #selector(self.ConfirmNotesButtonClicked(sender:)))
    
        navigationItem.leftBarButtonItems = [backBarButtonItem]
        if isFromEdit {
            navigationItem.rightBarButtonItems = [confirmBarButtonItem,reduBarButtonItem,undoBarButtonItem]
        } else {
            navigationItem.rightBarButtonItems = [editBarButtonItem]
        }
    }
    
    func setUpNavigationTitleDashBoard(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isHideLogo : Bool = true) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.whitecolor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
       
        let menuBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_Menu"), target: self, action: #selector(self.menubuttonClicked(sender:)))
        //itemWithProfilePic(colorfulImage: #imageLiteral(resourceName: "UserProfileNav"), target: self, action: #selector(profilebuttonClicked(sender:)),url: UserModel.getCurrentUserFromDefault()?.profileimage ?? "")
        //let titleBarButtonItem = UIBarButtonItem.makBarButtonDisableItem(with: title, color: UIColor.CustomColor.whitecolor, font: UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 15.0)), target: self, action: #selector(titlebuttonClicked(sender:)))
        //let logoBtn = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_LogoNavDashboard"), target: self, action: #selector(self.titlebuttonClicked(sender:)))
        let logoBtn = UIBarButtonItem.makBarButtonItem(with: #imageLiteral(resourceName: "ic_LogoNavDashboard"), color: .white, target: nil, action: nil)
        /*if isHideLogo {
            navigationItem.leftBarButtonItems = [backBarButtonItem]
        } else {
            let btnlogo = UIBarButtonItem.btnWithLogoPic(colorfulImage: #imageLiteral(resourceName: "ic_MenuChiryLogo"), target: self, action: #selector(self.logobuttonClicked(sender:)))
            navigationItem.leftBarButtonItems = [backBarButtonItem,btnlogo]
        }*/
        navigationItem.leftBarButtonItems = [menuBarButtonItem,logoBtn]
        
        let quoteBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_QuotsNav"), target: self, action: #selector(self.quotebuttonClicked(sender:)))
        let notificationBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_NotificationNav"), target: self, action: #selector(self.notificationbuttonClicked(sender:)))
        let chatBarButtonItem = UIBarButtonItem.btnWithPicDashboard(colorfulImage: #imageLiteral(resourceName: "ic_ChatNav"), target: self, action: #selector(self.chatbuttonClicked(sender:)))
        navigationItem.rightBarButtonItems = [notificationBarButtonItem,chatBarButtonItem]
        
    }
    
    /*func setUpBackTitleandRightButtonColorNavigationBar(titlecolor : UIColor, buttontitle : String,ButtonColor : UIColor,isMoveDashboard : Bool ,isShowRightButton : Bool,navigationItem : UINavigationItem,isMoreButtonRight : Bool) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titlecolor,NSAttributedString.Key.font: UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))]
        
        let backBarButtonItem = UIBarButtonItem.itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_BackImg"), target: self, action: isMoveDashboard ? #selector(self.dashboardBackbuttonClicked(sender:)) : #selector(self.backbuttonClicked(sender:)))
        navigationItem.leftBarButtonItems = [backBarButtonItem]
        
        if isShowRightButton {
            if isMoreButtonRight {
                let rightbtn = UIBarButtonItem.btnWithPic(colorfulImage: #imageLiteral(resourceName: "ic_Morebtn"), target: self, action: #selector(self.moreButtonClicked(sender:)))
                //itemWithBackPic(colorfulImage: #imageLiteral(resourceName: "ic_Morebtn"), target: self, action: isMoveDashboard ? #selector(self.dashboardBackbuttonClicked(sender:)) : #selector(self.backbuttonClicked(sender:)))
                navigationItem.rightBarButtonItems = [rightbtn]
            } else {
                let rightbtn = UIBarButtonItem.makBarButtonItem(with: buttontitle, color: ButtonColor, font: UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 15.0)), target: self, action: #selector(self.rightNextbuttonClicked(sender:)))
                
                navigationItem.rightBarButtonItems = [rightbtn]
            }
        }
        navigationItem.leftBarButtonItems = [backBarButtonItem]
    }*/
    
    func setUpHomeNavigationTitle(title : String,TitleColor : UIColor,font : UIFont,navigationItem : UINavigationItem) {
        let img = #imageLiteral(resourceName: "side-menu")
        let menuBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(menubuttonClicked))

        self.lblHomeDashboardAddress.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: self.navigationBar.frame.height)
        //label.font = UIFont(name: "Arial-BoldMT", size: 16)
        lblHomeDashboardAddress.text = title
        lblHomeDashboardAddress.font = font
        lblHomeDashboardAddress.textAlignment = .left
        lblHomeDashboardAddress.textColor = TitleColor
        lblHomeDashboardAddress.backgroundColor = UIColor.clear
        
        self.titleBarButtonItem = UIBarButtonItem(customView: lblHomeDashboardAddress)
        navigationItem.leftBarButtonItems = [menuBarButtonItem,self.titleBarButtonItem]
    }
    
    @objc func rightNextbuttonClicked(sender: UIBarButtonItem) {
        //self.view.endEditing(true)
        self.btnNextClickBlock?()
    }
    
    @objc func messagebuttonClicked(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    @objc func logobuttonClicked(sender: UIBarButtonItem) {
    }
    
    @objc func menubuttonClicked(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        //sideMenuController?.showLeftViewAnimated(sender: self)
        //sideMenuController?.toggleLeftView(sender: self)
        //sideMenuController?.showLeftView()
        //self.showLeftViewAnimated(self)
        //self.showRightViewAnimated(self)
        self.showRightViewAnimated(self)
        //menuDelegate?.appNavigationControllerWasInvokedUpdateMenu(self)
        //self.showRightView(self)
    }
    
    func OpoenMenuj(){
        self.showRightViewAnimated(self)
        menuDelegate?.appNavigationControllerWasInvokedUpdateMenu(self)
    }
    
    @objc func moreButtonClicked(sender: UIBarButtonItem) {
        if let del = self.btnDelegate {
            del.btnMoreClicked()
        }
        self.btnMoreClickBlock?()
    }
    
    @objc func titlebuttonClicked(sender: UIBarButtonItem) {
    }
    
    @objc func referbuttonClicked(sender: UIBarButtonItem) {
    }
    
    @objc func quotebuttonClicked(sender: UIBarButtonItem) {
        detachRightSideMenu()
        //self.push(QuoteDayViewController.self)
    }
    
    @objc func chatbuttonClicked(sender: UIBarButtonItem) {
        detachRightSideMenu()
        //self.push(ChatParentViewController.self)
    }
    
    @objc func notificationbuttonClicked(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        detachRightSideMenu()
        //self.push(NotificationViewController.self)
        //self.showNotificationViewController(animationType: .fromRight)
        //self.push(NotificationViewController.self)
    }
    
    @objc func dashboardBackbuttonClicked(sender: UIBarButtonItem) {
        //self.showDashBoardViewController()
    }
    
    @objc func showProfileViewController(sender: UIBarButtonItem) {
        //self.showDashBoardViewController()
    }
    
    
    @objc func backbuttonClicked(sender: UIBarButtonItem) {
        self.popViewController(animated: true)
    }
    @objc func backLoginButtonClicked(sender: UIBarButtonItem) {
        appDelegate.clearUserDataForLogout()
        //self.showSignInViewController(animationType: .fromRight, configuration: nil)
    }
    
    @objc func searchButtonClicked(sender: UIBarButtonItem) {
        self.btnMoreClickBlock?()
    }
    
    @objc func addCardbuttonClicked(sender: UIBarButtonItem) {
        //self.push(AddCardViewController.self)
        self.btnAddCardClickBlock?()
    }
    
    @objc func undoNotesButtonClicked(sender: UIBarButtonItem) {
        self.btnUndoNotesClickBlock?()
    }
    @objc func RedoNotesButtonClicked(sender: UIBarButtonItem) {
        self.btnRedoNotesClickBlock?()
    }
    @objc func EditNotesButtonClicked(sender: UIBarButtonItem) {
        self.btnEditNotesClickBlock?()
    }
    @objc func ConfirmNotesButtonClicked(sender: UIBarButtonItem) {
        self.btnConfirmNotesClickBlock?()
    }
}

// MARK: - Presentation
extension AppNavigationController {
    
    
    func attachRightSideMenu() {
        menuDelegate?.appNavigationController(self, setrightMenuEnabled: true)
        menuDelegate?.appNavigationController(self, setrightMenuSwipeEnabled: true)
        
        //menuDelegate?.app
    }
    
    func detachRightSideMenu() {
        //hideLeftViewAnimated(self)
        self.hideRightViewAnimated(self)
        //sideMenuController?.showLeftViewAnimated(sender: self)
        //sideMenuController?.hideLeftViewAnimated(sender: self)
        //hideRightViewAnimated(self)
        
        menuDelegate?.appNavigationController(self, setrightMenuEnabled: false)
        menuDelegate?.appNavigationController(self, setrightMenuSwipeEnabled: false)
    }
    
    func showTutorialViewController(animationType: SideAnimationType,
                                  configuration: ((TutorialViewController) -> Void)? = nil) {
        let signInViewController = TutorialViewController.instantiated ()
        
        setViewController(signInViewController, with: animationType) { vc in
            configuration?(vc)
        }
        
        detachRightSideMenu()
    }
    
    func showDashBoardViewController() {
        
        let dashController = DashboardViewController.instantiated { [unowned self] dashController in
            _ = self.viewControllers.first as? DashboardViewController
        }
        setViewControllers([dashController], animated: true)
        //detachLeftSideMenu()
        detachRightSideMenu()
        menuDelegate?.appNavigationControllerWasInvokedUpdateMenu(self)
    }
    
    func showProfileViewController() {
        
        let dashController = ProfileViewController.instantiated { [unowned self] dashController in
            _ = self.viewControllers.first as? ProfileViewController
        }
        setViewControllers([dashController], animated: true)
        //detachLeftSideMenu()
        detachRightSideMenu()
        menuDelegate?.appNavigationControllerWasInvokedUpdateMenu(self)
    }
    
    
    func showEventsViewController() {
        
        let dashController = EventsViewController.instantiated { [unowned self] dashController in
            _ = self.viewControllers.first as? EventsViewController
        }
        setViewControllers([dashController], animated: true)
        //detachLeftSideMenu()
        detachRightSideMenu()
        menuDelegate?.appNavigationControllerWasInvokedUpdateMenu(self)
    }
    
   /* func showLanguageSelectionViewController(animationType: SideAnimationType,
                                  configuration: ((SelectLanguageViewController) -> Void)? = nil) {
        let languageSelectionViewController = SelectLanguageViewController.instantiated ()
        
        setViewController(languageSelectionViewController, with: animationType) { vc in
            configuration?(vc)
        }
        
        detachLeftSideMenu()
    } */

   func showSignInViewController(animationType: SideAnimationType,
                                  configuration: ((LoginViewController) -> Void)? = nil) {
        let signInViewController = LoginViewController.instantiated ()
        
        setViewController(signInViewController, with: animationType) { vc in
            configuration?(vc)
        }
        
       detachRightSideMenu()
    }
    func showLoginViewController(animationType: SideAnimationType,
                                  configuration: ((LoginViewController) -> Void)? = nil) {
        let signInViewController = LoginViewController.instantiated ()
        
        setViewController(signInViewController, with: animationType) { vc in
            configuration?(vc)
        }
        
        detachRightSideMenu()
    }
    
    
//    func showUserSelectionViewController(animationType: SideAnimationType,
//                                  configuration: ((UserSelectionViewController) -> Void)? = nil) {
//        let signInViewController = UserSelectionViewController.instantiated ()
//
//        setViewController(signInViewController, with: animationType) { vc in
//            configuration?(vc)
//        }
//
//        detachLeftSideMenu()
//    }
}

// MARK: - AppSideMenuViewControllerDelegate
extension AppNavigationController: AppSideMenuViewControllerDelegate {
    func appSideMenuViewControllerDidChooseHome(_ sideMenuViewController: AppSideMenuViewController) {
        //sideMenuController?.hideLeftViewAnimated(sender: self)
        self.hideRightViewAnimated(self)
    }
    func appNavigationControllerLogin(btntitle : String,btnTitleColor : UIColor,navigationItem : UINavigationItem,isFromMentorProfile : Bool = false,isHideFollow : Bool = false) {
        self.setUpLoginNavigationTitle(btntitle: btntitle, btnTitleColor: btnTitleColor, navigationItem: navigationItem,isFromMentorProfile: isFromMentorProfile,isHideFollow : isHideFollow)
    }
    
    func setNavigationBackTitleRightBackBtnNavigationBar(title : String,TitleColor : UIColor,rightBtntitle : String,rightBtnColor : UIColor,navigationItem : UINavigationItem) {
        
        self.setUpBackTitleRightBackBtnNavigationBar(title: title, TitleColor: TitleColor, rightBtntitle: rightBtntitle, rightBtnColor: rightBtnColor, navigationItem: navigationItem)
    }
    
    func setNavigationBackTitleRightBackBtnNavigationBarBlack(title : String,TitleColor : UIColor,rightBtntitle : String,rightBtnColor : UIColor,navigationItem : UINavigationItem) {
        
        self.setUpBackTitleRightBackBtnNavigationBarBlack(title: title, TitleColor: TitleColor, rightBtntitle: rightBtntitle, rightBtnColor: rightBtnColor, navigationItem: navigationItem)
    }
    
    
//    func appNavigationControllerTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isHideBackButton : Bool = false,isfromDirect : Bool = false) {
//        self.setUpNavigationTitle(title: title, TitleColor: TitleColor, navigationItem: navigationItem,isHideBackButton: isHideBackButton,isfromDirect : isfromDirect)
//    }
    func appNavigationControllerTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isHideBackButton : Bool = false) {
        self.setUpNavigationTitle(title: title, TitleColor: TitleColor, navigationItem: navigationItem,isHideBackButton: isHideBackButton)
    }
    
    func appNavigationControllersetUpBackWithTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        self.setUpNavigationBackWithTitleButton(title: title, TitleColor: TitleColor, navigationItem: navigationItem)
    }
    
    func appNavigationControllersetUpMyProfileWithTitle(title : String,TitleColor : UIColor,righttitle : String,navigationItem : UINavigationItem) {
        
        self.setUpNavigationMyProfile(title: title,rightTitle: righttitle, TitleColor: TitleColor, navigationItem: navigationItem)
    }
    func appNavigationControllersetUpShopnavTitle(title : String,TitleColor : UIColor,righttitle : String,navigationItem : UINavigationItem) {
        
        self.setUpNavigationShopnav(title: title,rightTitle: righttitle, TitleColor: TitleColor, navigationItem: navigationItem)
    }
    func appsetUpNotificationWithTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        self.setUpNotification(title: title, TitleColor: TitleColor, navigationItem: navigationItem)
    }
    
    func appNavigationControllersetUpBackVideoCall(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        self.setUpNavigationBarVideoCall(title: title, TitleColor: TitleColor, navigationItem: navigationItem)
    }
    
    func appNavigationControllerMyMomentorsetUpBackWithTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        self.setUpMyMomentorNavigationBackWithTitleButton(title: title, TitleColor: TitleColor, navigationItem: navigationItem)
    }
    
    func appNavigationControllerChatVCWithTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isShowDot : Bool = false, isHideTitleBar : Bool = false,isHideSearch : Bool = true) {
        
        self.setUpChatNavigationBackWithTitleButton(title: title, TitleColor: TitleColor, navigationItem: navigationItem,isShowDot: isShowDot,isHideTitleBar: isHideTitleBar,isHideSearch : isHideSearch)
    }
    
    func appNavigationControllerEditNotesUpBackWithTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isFromEdit : Bool) {
        
        self.setUpEditNotesNavigationBar(title: title, TitleColor: TitleColor, navigationItem: navigationItem, isFromEdit: isFromEdit)
    }
    
    func appNavigationControllersetTitleWithBack(title : String,TitleColor : UIColor,navigationItem : UINavigationItem) {
        
        self.setUpBackWithTitleNavigationBar(title: title, TitleColor: TitleColor, navigationItem: navigationItem)
    }
    
    func appNavigationControllersetWhiteTitleWithBack(title : String,TitleColor : UIColor,isShowRightButton : Bool = false,navigationItem : UINavigationItem) {
        
        self.setUpBackWithTitleWhiteNavigationBar(title: title, TitleColor: TitleColor,isShowRightButton : isShowRightButton, navigationItem: navigationItem)
    }
    func appNavigationControllersetFAQPaymentWithBack(title : String,TitleColor : UIColor,isShowRightButton : Bool = false,navigationItem : UINavigationItem) {
        
        self.setUpBackWithFAQPaymentNavigationBar(title: title, TitleColor: TitleColor,isShowRightButton : isShowRightButton, navigationItem: navigationItem)
    }
    func appnavigationEventNavBack(title : String ,TitleColor : UIColor,isShowRightButton : Bool = false,navigationItem : UINavigationItem ) {
         
        self.setUpBackEventNavigationBar(title: title, TitleColor: TitleColor,isShowRightButton : isShowRightButton, navigationItem: navigationItem)
    }
    
    func appnavigationSetUpTicketTransferNAvigationBar(title : String ,TitleColor : UIColor,isShowRightButton : Bool = false,navigationItem : UINavigationItem ) {
         
        self.SetUpTicketTransferNAvigationBar(title: title, TitleColor: TitleColor,isShowRightButton : isShowRightButton, navigationItem: navigationItem)
    }
  
    func appNavigationControllersetTitleWithBackWithColor(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isshowBackButton : Bool) {
        
        self.setUpBackWithTitleNavigationBarWithColor(title: title, TitleColor: TitleColor, navigationItem: navigationItem,isShowBackButton: isshowBackButton)
    }
    
    func appNavigationControllersetUpDashBoardTitle(title : String,TitleColor : UIColor,navigationItem : UINavigationItem,isHideLogo : Bool = true) {
        
        //self.setUpTabbarNavigationTitle(title: title, TitleColor: TitleColor, navigationItem: navigationItem, isHideMsgButton: isHideMsgButton)
        self.setUpNavigationTitleDashBoard(title: title, TitleColor: TitleColor, navigationItem: navigationItem,isHideLogo : isHideLogo)
        self.detachRightSideMenu()
    }

    func appNavigationControllersetTitleAndButtonColor(Titlecolor : UIColor, Buttontitle : String,buttonColor : UIColor,navigationItem : UINavigationItem,ismoveDashboard : Bool = false,isShowRightButton : Bool = true) {
    
        self.setUpBackTitleandRightButtonColorNavigationBar(titlecolor: Titlecolor, buttontitle: Buttontitle, ButtonColor: buttonColor, isMoveDashboard: ismoveDashboard, isShowRightButton: isShowRightButton, navigationItem: navigationItem)
    }
    
    func appHomeNavigationControllerTitle(title : String,TitleColor : UIColor,font : UIFont = UIFont.systemFont(ofSize: CGFloat(DeviceType.IS_PAD ? 28 : 24)),navigationItem : UINavigationItem) {
        self.setUpHomeNavigationTitle(title: title, TitleColor: TitleColor, font: font, navigationItem: navigationItem)
    }
}

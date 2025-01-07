//
//  DashboardViewController.swift
//  Rosterd
//
//  Created by WM-KP on 08/01/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var vwContainer: UIView?
    @IBOutlet weak var vwTabHome: TabBarItemView?
    @IBOutlet weak var vwTabEvents: TabBarItemView?
    @IBOutlet weak var vwTabShop: TabBarItemView?
    @IBOutlet weak var vwTabMessages: TabBarItemView?
    @IBOutlet weak var vwTabview: UIView?
    
    @IBOutlet weak var btnProfile: UIButton?
    @IBOutlet weak var vwImgBG: UIView?
    @IBOutlet weak var imgProfile: UIImageView?
    @IBOutlet weak var vwNotificationCount: UIView?
    // MARK: - Variables
    private var selectedTab : TabbarItemType = .Home
    var isFromLogin : Bool = false
    private var userProfileData : UserModel?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabbarIndex()
        self.InitConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.getUserInfo()
        self.appNavigationController?.detachRightSideMenu()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setChangeTabObserver(notification:)), name: NSNotification.Name(rawValue: NotificationPostname.kChangeTabbar), object: nil)
        
        delay(seconds: 0.4) {
            self.getNotificationCount()
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       
        if let img = self.imgProfile {
            img.cornerRadius = img.frame.height / 2.0
        }
     
        if  let vwTabview = self.vwTabview {
           
            vwTabview.clipsToBounds = true
            vwTabview.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwTabview.maskToBounds = false

        }
    }
}
// MARK: - Init Configure
extension DashboardViewController {
    private func InitConfig(){
        self.selectedTab = .Home
             
        self.vwTabHome?.isSelectedTab(selecetdTab: true, tabType: TabbarItemType.Home)
        self.vwTabEvents?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Events)
        self.vwTabShop?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Shop)
        self.vwTabMessages?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Message)
        
        self.vwTabHome?.imgTab?.image = TabbarItemType.Home.imgSelected
        self.vwTabHome?.btnSelect?.tag = TabbarItemType.Home.rawValue
        
        self.vwTabEvents?.imgTab?.image = TabbarItemType.Events.imgDeSelect
        self.vwTabEvents?.btnSelect?.tag = TabbarItemType.Events.rawValue
        
        self.vwTabShop?.imgTab?.image = TabbarItemType.Shop.imgDeSelect
        self.vwTabShop?.btnSelect?.tag = TabbarItemType.Shop.rawValue
        
        self.vwTabMessages?.imgTab?.image = TabbarItemType.Message.imgDeSelect
        self.vwTabMessages?.btnSelect?.tag = TabbarItemType.Message.rawValue
        self.vwNotificationCount?.cornerRadius = (self.vwNotificationCount?.frame.height ?? 0) / 2
        [self.vwTabHome,self.vwTabEvents,self.vwTabShop,self.vwTabMessages].forEach({
            $0?.delegate = self
        })
               
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
    @objc func setChangeTabObserver(notification: Notification) {
        self.selectedTab = .Events
        self.setTabbarIndex()
    }
        
    private func setTabbarIndex() {
        switch self.selectedTab {
        case .Home:
            self.setHomeTab()
            break;
        case .Events:
            self.setEventsTab()
            break;
        case .Shop:
            self.setShopTab()
            break;
        case .Message:
            self.setMessagesTab()
            break;
        }
    }
    
    private func setHomeTab() {
    
        self.removeChild()
        self.selectedTab = .Home
        self.vwTabHome?.isSelectedTab(selecetdTab: true, tabType: TabbarItemType.Home)
        self.vwTabEvents?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Events)
        self.vwTabShop?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Shop)
        self.vwTabMessages?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Message)
        
        self.title = ""
        
        let st = UIStoryboard.getStoryboard(for: UIStoryboard.Name.Home.rawValue)
        
        if let vc = st.getViewController(with: VCIdentifier.HomeViewController) as? HomeViewController {
            self.addChild(vc)
            if let vwcontainer = self.vwContainer {
                vc.view.frame = CGRect(x: 0, y: 0, width: vwcontainer.frame.width, height: vwcontainer.frame.height)//self.vwContainer.frame
                vc.view.backgroundColor = UIColor.clear
                vwcontainer.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
        }
    }
    private func setEventsTab() {
        self.removeChild()
        self.selectedTab = .Events
        self.vwTabHome?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Home)
        self.vwTabEvents?.isSelectedTab(selecetdTab: true, tabType: TabbarItemType.Events)
        self.vwTabShop?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Shop)
        self.vwTabMessages?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Message)
        
        self.title = ""
        
        let st = UIStoryboard.getStoryboard(for: UIStoryboard.Name.Events.rawValue)
        
        if let vc = st.getViewController(with: VCIdentifier.EventsViewController) as? EventsViewController {
            self.addChild(vc)
            if let vwcontainer = self.vwContainer {
                vc.view.frame = CGRect(x: 0, y: 0, width: vwcontainer.frame.width, height: vwcontainer.frame.height)//self.vwContainer.frame
                vc.view.backgroundColor = UIColor.clear
                vwcontainer.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
        }
    }
    private func setShopTab() {
    
        self.removeChild()
        self.selectedTab = .Shop
        self.vwTabHome?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Home)
        self.vwTabEvents?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Events)
        self.vwTabShop?.isSelectedTab(selecetdTab: true, tabType: TabbarItemType.Shop)
        self.vwTabMessages?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Message)
        
        self.title = ""
        
        let st = UIStoryboard.getStoryboard(for: UIStoryboard.Name.Shop.rawValue)
        
        if let vc = st.getViewController(with: VCIdentifier.ShopViewController) as? ShopViewController {
            self.addChild(vc)
            if let vwcontainer = self.vwContainer {
                vc.view.frame = CGRect(x: 0, y: 0, width: vwcontainer.frame.width, height: vwcontainer.frame.height)//self.vwContainer.frame
                vc.view.backgroundColor = UIColor.clear
                vwcontainer.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
        }
    }
    private func setMessagesTab() {
      
        self.removeChild()
        self.selectedTab = .Message
        self.vwTabHome?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Home)
        self.vwTabEvents?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Events)
        self.vwTabShop?.isSelectedTab(selecetdTab: false, tabType: TabbarItemType.Shop)
        self.vwTabMessages?.isSelectedTab(selecetdTab: true, tabType: TabbarItemType.Message)
        
        self.title = ""
        
        
        let st = UIStoryboard.getStoryboard(for: UIStoryboard.Name.Message.rawValue)
        
        if let vc = st.getViewController(with: VCIdentifier.MessageViewController) as? MessageViewController {
            self.addChild(vc)
            if let vwcontainer = self.vwContainer {
                vc.view.frame = CGRect(x: 0, y: 0, width: vwcontainer.frame.width, height: vwcontainer.frame.height)//self.vwContainer.frame
                vc.view.backgroundColor = UIColor.clear
                vwcontainer.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
        }
    }
}
// MARK: - ViewControllerDescribable
extension DashboardViewController : TabbarItemDelegate {
    func selectTabButton(_ sender: UIButton) {
        self.selectedTab = TabbarItemType(rawValue: sender.tag) ?? .Home
        self.setTabbarIndex()
    }
}
//MARK: - IBAction Method
extension DashboardViewController {
    
    @IBAction func btnProfileClick() {
        self.appNavigationController?.push(ProfileViewController.self,configuration: { vc in
            vc.isbtnchat = true
            vc.isbtnMore = true
            
        })
    }
    @IBAction func btnSearchClick(_ sender : UIButton) {
        
        self.appNavigationController?.push(SuggestionsViewController.self,configuration: { vc in
            vc.isfromdashboard = true
        })
    }
    @IBAction func btnNotificationClick() {
        self.appNavigationController?.push(NotificationViewController.self)
    }
}
// MARK: - API Call
extension DashboardViewController {
    
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
            self.imgProfile?.setImage(withUrl: obj.profileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
    }
    
    func getNotificationCount() {
           if let user = UserModel.getCurrentUserFromDefault() {
               let dict : [String:Any] = [
                   klangType : Rosterd.sharedInstance.languageType,
                   ktoken : user.token,
               ]
               let param : [String:Any] = [
                   kData : dict
               ]
               UserModel.getNotificationCount(with: param) { (stCount) in
                   self.vwNotificationCount?.isHidden = stCount == "0" || stCount == "" ? true : false
               } failure: {[unowned self] (statuscode,error, errorType) in
                   print(error)
                   self.vwNotificationCount?.isHidden = true
               }
           }
       }
}
// MARK: - ViewControllerDescribablea
extension DashboardViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.DashBoard
    }
}
// MARK: - AppNavigationControllerInteractable
extension DashboardViewController: AppNavigationControllerInteractable { }

extension CALayer {
    func addGradienBorder(colors:[UIColor],width:CGFloat = 1) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: .zero, size: self.bounds.size)
        gradientLayer.startPoint =  CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = colors.map({$0.cgColor})

        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer

        self.addSublayer(gradientLayer)
    }
}

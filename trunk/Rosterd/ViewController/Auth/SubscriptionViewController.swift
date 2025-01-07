//
//  SubscriptionViewController.swift
//  Rosterd
//
//  Created by Haresh Flynaut on 22/06/23.
//

import UIKit
import StoreKit

class SubscriptionViewController: UIViewController {
    // MARK: - IBOutlet
  
    @IBOutlet weak var btnmonthly: UIButton?
    @IBOutlet weak var btnYearly: UIButton?
    @IBOutlet weak var btnLifeTime: UIButton?
    
    @IBOutlet var lblHeaderPriceCollection: [UILabel]?
    @IBOutlet var vwSubscriptionBGMain: [UIView]?
    @IBOutlet var lblHeaderCollection: [UILabel]?
    @IBOutlet weak var btnShowMoreLessBasic: UIButton?
    @IBOutlet weak var btnShowMoreLessPro: UIButton?
    @IBOutlet weak var lblFreePrice: UILabel?
    @IBOutlet weak var vwFreePrice: UIView?
    @IBOutlet weak var vwMonthlyPrice: UIView?
    @IBOutlet weak var vwYearlyPrice: UIView?
    @IBOutlet weak var vwLifetimePrice: UIView?
    @IBOutlet weak var lblMonthly: UILabel?
    @IBOutlet weak var lblMonthlyPrice: UILabel?
    @IBOutlet weak var lblYearly: UILabel?
    @IBOutlet weak var lblYearlyPrice: UILabel?
    @IBOutlet weak var lblLifetimeAccess: UILabel?
    @IBOutlet weak var lblLifetimeAccessPrice: UILabel?
    @IBOutlet weak var tblViewBasicPlan: UITableView?{
        didSet {
            self.tblViewBasicPlan?.delegate = self
            self.tblViewBasicPlan?.dataSource = self
            self.tblViewBasicPlan?.register(SubscriptionFeaturesCell.self)
            self.tblViewBasicPlan?.separatorStyle = .none
            self.tblViewBasicPlan?.rowHeight = 30
        }
    }
    @IBOutlet weak var constraintHeightTblViewBasicPlan: NSLayoutConstraint?
    @IBOutlet weak var vwBasicPlan: UIView?
    @IBOutlet weak var vwProPlan: UIView?
    @IBOutlet weak var tblViewProPlan: UITableView?{
        didSet {
            self.tblViewProPlan?.delegate = self
            self.tblViewProPlan?.dataSource = self
            self.tblViewProPlan?.register(SubscriptionFeaturesCell.self)
            self.tblViewProPlan?.separatorStyle = .none
            self.tblViewProPlan?.rowHeight = 30
        }
    }
    @IBOutlet weak var constraintHeightTblViewProPlan: NSLayoutConstraint?
    @IBOutlet var lblConditions: [UILabel]?
    var stSubscriptionPrice = ""
    // MARK: - Variables
    var arrBasicPlanList = [String]()
    var arrProPlanList = [String]()
    var isFromLogin : Bool = false
    @IBOutlet weak var btnPromoCode: UIButton?
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        if UserModel.getCurrentUserFromDefault()?.subscriptionId == "1" {
            self.vwMonthlyPrice?.cornerRadius = 14
            self.vwMonthlyPrice?.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: [UIColor.CustomColor.gradiantColorTop60,UIColor.CustomColor.gradiantColorBottom60])
        } else if UserModel.getCurrentUserFromDefault()?.subscriptionId == "2" {
            self.vwYearlyPrice?.cornerRadius = 14
            self.vwYearlyPrice?.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: [UIColor.CustomColor.gradiantColorTop60,UIColor.CustomColor.gradiantColorBottom60])
        } else if UserModel.getCurrentUserFromDefault()?.subscriptionId == "3"  {
            self.vwLifetimePrice?.cornerRadius = 14
            self.vwLifetimePrice?.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: [UIColor.CustomColor.gradiantColorTop60,UIColor.CustomColor.gradiantColorBottom60])
        } else if UserModel.getCurrentUserFromDefault()?.subscriptionId == "0" {
            self.vwFreePrice?.cornerRadius = 14
            self.vwFreePrice?.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: [UIColor.CustomColor.gradiantColorTop60,UIColor.CustomColor.gradiantColorBottom60])
        }
    }
    
    @IBAction func btnPrivacyPolicyClick() {
        self.appNavigationController?.push(TermConditionViewController.self,configuration: { vc in
            vc.pageid = .PrivacyPolicy
        })
    }
    @IBAction func btnTermsConditionClick() {
        self.appNavigationController?.push(TermConditionViewController.self,configuration: { vc in
            vc.pageid = .TermCondition
        })
    }
    
    @IBAction func btnPromoCodeClick() {
        let paymentQueue = SKPaymentQueue.default()
            if #available(iOS 14.0, *) {
                paymentQueue.presentCodeRedemptionSheet()
            }
    }
}

// MARK: - Init Configure
extension SubscriptionViewController {
    private func InitConfig(){
        self.vwSubscriptionBGMain?.forEach({
            $0.cornerRadius = 16
        })
        self.lblHeaderPriceCollection?.forEach({
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
            $0.textColor = UIColor.CustomColor.subscriptionPriceTextColor
        })
        self.lblHeaderCollection?.forEach({
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
            $0.textColor = UIColor.CustomColor.subscriptionHeaderTextColor
        })
        
        [self.lblMonthly,self.lblYearly,self.lblLifetimeAccess].forEach({
            if let lbl = $0 {
                lbl.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 18.0))
                lbl.textColor = UIColor.CustomColor.whitecolor
            }
        })
        
        self.lblConditions?.forEach({
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 13.0))
            $0.textColor = UIColor.CustomColor.whitecolor
        })
    
        [self.vwFreePrice,self.vwMonthlyPrice,self.vwYearlyPrice,self.vwLifetimePrice].forEach({
            if let view = $0 {
                view.cornerRadius = 14
                view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
            }
        })
        
        [self.btnShowMoreLessBasic,self.btnShowMoreLessPro].forEach({
            if let btn = $0{
                btn.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 11.0))
                btn.setTitleColor(UIColor.CustomColor.subscriptionPriceTextColor, for: .normal)
                btn.setTitleColor(UIColor.CustomColor.subscriptionPriceTextColor, for: .selected)
            }
        })
        
        self.btnPromoCode?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
        self.btnPromoCode?.setTitleColor(UIColor.CustomColor.whitecolor, for: .normal)
    
        self.lblFreePrice?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblFreePrice?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblMonthlyPrice?.setSubscriptionPriceStrokeLabel(firstText: "$4.99 ", SecondText: "Regular $9.99")
        self.lblYearlyPrice?.setSubscriptionPriceStrokeLabel(firstText: "$49.99 ", SecondText: "Regular $99.99")
        self.lblLifetimeAccessPrice?.setSubscriptionPriceStrokeLabel(firstText: "$249.99 ", SecondText: "Regular $499.99")
        
        self.arrBasicPlanList = ["Upload Pics","Upload Video","Nutrition Tips","Fitness Tips","Shop Roster'd Gear","RoSTAR's badging","RoSTAR'd bonus points (100)"]
        self.arrProPlanList = ["Upload Pics","Upload Video","Nutrition Tips","Fitness Tips","Shop Roster'd Gear","RoSTAR'd badging","RoSTAR'd bonus points (500)","RoSTAR'd Level Up - 1 Star","Advertising Free","Edit Video / Highlight Reel","Filters","Annual Scholarship Drawing","Create Sports Resume","Create Events"]
        
        self.constraintHeightTblViewBasicPlan?.constant = CGFloat(self.arrBasicPlanList.count * 30)
        self.constraintHeightTblViewProPlan?.constant = CGFloat(self.arrProPlanList.count * 30)
        self.tblViewBasicPlan?.reloadData()
        self.tblViewProPlan?.reloadData()
        
        SwiftyStoreKit.retrieveProductsInfo(["monthlypremium","yearlypremium","lifetimepremium"]) { result in
            if result.retrievedProducts.count > 0 {
                for product in result.retrievedProducts {
                    print("Product Description: \(product.localizedDescription), Price: \(product.localizedPrice ?? ""),Product Identifire: \(product.productIdentifier),Product Title: \(product.localizedTitle)")
                }
            }
            else if result.invalidProductIDs.count > 0 {
                for product in result.invalidProductIDs {
                    let invalidProductId = product
                    print("Invalid product identifier: \(invalidProductId)")
                }
            }
            else {
                print("Result error")
                print(result.error ?? "")
            }
        }
    }
    
    func Subscription(subscriptionkey : String) {
        SVProgressHUD.show()
        SwiftyStoreKit.purchaseProduct(subscriptionkey, quantity: 1, atomically: false) { result in
            switch result {
            case .success(let product):
                SVProgressHUD.dismiss()
                // fetch content from your server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                print("Purchase Success: \(product.productId)")
                
                SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
                    switch result {
                    case .success(let receiptData):
                        let encryptedReceipt = receiptData.base64EncodedString(options: [])
                        print("Fetch receipt success:\n\(encryptedReceipt)")
                        self.setSubscriptionPlan(encryptedReceipt, PlanId: subscriptionkey)
                    case .error(let error):
                        print("Fetch receipt failed: \(error)")
                    }
                }
            case .error(let error):
                SVProgressHUD.dismiss()
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        appNavigationController?.setNavigationBackTitleRightBackBtnNavigationBarBlack(title: "Subscription", TitleColor: UIColor.CustomColor.whitecolor, rightBtntitle: "", rightBtnColor: UIColor.CustomColor.whitecolor, navigationItem: self.navigationItem)
        appNavigationController?.btnNextClickBlock = {
            
        }
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

//MARK:- UITableView Delegate
extension SubscriptionViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tblViewBasicPlan ? self.arrBasicPlanList.count : self.arrProPlanList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: SubscriptionFeaturesCell.self)
        if tableView == self.tblViewBasicPlan {
            let b_Info = self.arrBasicPlanList[indexPath.row]
            cell.lblFeatureText?.text = b_Info
        }
        else {
            let p_Info = self.arrProPlanList[indexPath.row]
            cell.lblFeatureText?.text = p_Info
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

// MARK: - UIButton Click
extension SubscriptionViewController {
    @IBAction func btnShowMoreLessBasicClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.3) {
            self.vwBasicPlan?.isHidden = sender.isSelected ? false : true
            self.vwBasicPlan?.alpha = sender.isSelected ? 1 : 0
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func btnShowMoreLessProClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.3) {
            self.vwProPlan?.isHidden = sender.isSelected ? false : true
            self.vwProPlan?.alpha = sender.isSelected ? 1 : 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnFreeClick(_ sender : UIButton) {
        if self.isFromLogin == true {
            self.appNavigationController?.push(ProfileCreatedViewController.self)
        } else {
            self.appNavigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnMonthlyClick(_ sender : UIButton) {
        self.stSubscriptionPrice = "monthlypremium"
        self.Subscription(subscriptionkey: "monthlypremium")
    }
    
    @IBAction func btnYearlyClick(_ sedner : UIButton) {
        self.stSubscriptionPrice = "yearlypremium"
        self.Subscription(subscriptionkey: "yearlypremium")
    }
    
    @IBAction func btnLifeTimeClick(_ sender : UIButton) {
        self.stSubscriptionPrice = "lifetimepremium"
        self.Subscription(subscriptionkey: "lifetimepremium")
    }
}
// MARK: - ViewControllerDescribable
extension SubscriptionViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension SubscriptionViewController: AppNavigationControllerInteractable{}


// MARK: - API Calling
extension SubscriptionViewController {
    private func setSubscriptionPlan(_ stReceipt:String, PlanId : String) {
        if let user = UserModel.getCurrentUserFromDefault(), user.token != "" {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kreceipt : stReceipt,
                kplan_id : PlanId
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.setSubscriptionPlan(with: param, success: { (userData,msg) in
                self.showMessage(msg, themeStyle: .success)
                if self.isFromLogin == true {
                    self.appNavigationController?.push(ProfileCreatedViewController.self)
                } else {
                    self.appNavigationController?.popViewController(animated: true)
                }
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error,presentationStyle: .top,errorBackgroundColor: UIColor.CustomColor.appColor)
                }
            })
        }
    }
}

//
//  FaqDetailViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 08/07/22.
//

import UIKit

class FaqDetailViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var webContentView: WKWebView?
    
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var vwWeb: UIView?
    
    // MARK: - Variables
    var faqInfo:FAQModel?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBar()
        self.getFaqDetailAPI()
        
    }
}

 // MARK: - Init Configure
 extension FaqDetailViewController {
     private func InitConfig(){
         self.webContentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         self.webContentView?.isOpaque = false
        
         self.lblHeader?.textColor = UIColor.CustomColor.labelTextColor
         self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
         
         if let faqData = self.faqInfo,faqData.name != "" {
             lblHeader?.text = faqData.name
         }
         
         self.webContentView?.uiDelegate = self
         self.webContentView?.navigationDelegate = self
     }
     
     private func configureNavigationBar() {
         
         appNavigationController?.setNavigationBarHidden(true, animated: true)
         appNavigationController?.navigationBar.backgroundColor = UIColor.clear
         self.navigationController?.setNavigationBarHidden(false, animated: false)
         
         appNavigationController?.appNavigationControllerTitle(title: "Help & Support", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
         

         navigationController?.navigationBar
             .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
         navigationController?.navigationBar.removeShadowLine()
     }
 }

 // MARK: - WKUIDelegate
 extension FaqDetailViewController : WKUIDelegate {
     
 }

 extension FaqDetailViewController {
     private func getFaqDetailAPI(){
        if let user = UserModel.getCurrentUserFromDefault() {
             let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                 kfaqId : faqInfo?.id ?? "",
                 ktoken : user.token
             ]
             
             let param : [String:Any] = [
                 kData : dict
             ]
             
             FAQModel.getFAQDetail(with: param, success: { (cmsdata, msg) in
                 
                 let css = """
                                <head>\
                                <link rel="stylesheet" type="text/css" href="iPhoneResources.css">\
                                </head>
                                """
                
                 let newString = cmsdata.FAQdescription.replacingOccurrences(of: "<style>*,p{font-size:15px !important;}</style>", with: "")
                 let content = """
                 <body> \(newString)</body>
                 """
                 SVProgressHUD.show()
                 
                 self.webContentView?.loadHTMLString("\(css)\(content)", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "iPhoneResources", ofType: "css") ?? ""))
                 
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
 extension FaqDetailViewController : WKNavigationDelegate {
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         SVProgressHUD.dismiss()
     }
 }

 // MARK: - ViewControllerDescribable
 extension FaqDetailViewController: ViewControllerDescribable {
     static var storyboardName: StoryboardNameDescribable {
         return UIStoryboard.Name.CMS
     }
 }

 // MARK: - AppNavigationControllerInteractable
 extension FaqDetailViewController: AppNavigationControllerInteractable{}

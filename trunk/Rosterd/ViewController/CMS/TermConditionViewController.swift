//
//  TermConditionViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 03/02/22.
//

import UIKit
import SafariServices

class TermConditionViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var webContentView: WKWebView?
    
    @IBOutlet weak var viewWeb: UIView?
    
    // MARK: - Variables
    var faqInfo:FAQModel?
    var selectedFAQId : String = ""
    var titleName : String = ""
    var pageid : pageIDEnum = .PrivacyPolicy
   
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBar()
            self.getCMSData()
    }
}

// MARK: - Init Configure
extension TermConditionViewController {
    private func InitConfig(){
        //webContentView = WKWebView(frame: viewWeb.bounds, configuration: WKWebViewConfiguration())
        webContentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
        self.webContentView?.isOpaque = false
        
        webContentView?.uiDelegate = self
        webContentView?.navigationDelegate = self
        
        
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "  \(pageid.name)", TitleColor: UIColor.CustomColor.whitecolor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

// MARK: - WKUIDelegate
extension TermConditionViewController : WKUIDelegate {
    
}

// MARK: - ViewControllerDescribable
extension TermConditionViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link")
            if let url = navigationAction.request.url {
                print(url.absoluteString)
                
                if let scheme = url.scheme {
                    if (scheme.lowercased() == "mailto") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else {
                    
                    guard let url = URL(string: url.absoluteString) else {
                        return
                    }
                    
                    if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                        let safariVC = SFSafariViewController(url: url)
                        safariVC.delegate = self
                        self.present(safariVC, animated: true, completion: nil)
                    } else {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        print("no link")
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}

// MARK: - SFSafariViewControllerDelegate
extension TermConditionViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension TermConditionViewController {
    
    
    private func getCMSData(){
        
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType,
            kpageId : self.pageid.pageid
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        CMSModel.getCMSContent(with: param, success: { (cmsdata, msg) in
            
            let css = """
                               <head>\
                               <link rel="stylesheet" type="text/css" href="iPhone.css">\
                               </head>
                               """
            let content = """
            <body> \(cmsdata.cmsdescription)</body>
            """
            SVProgressHUD.show()
            self.webContentView?.loadHTMLString("\(css)\(content)", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "iPhone", ofType: "css") ?? ""))
            
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
               
            }
            
        })
        
    }
}
// MARK: - ViewControllerDescribable
extension TermConditionViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.CMS
    }
}

// MARK: - AppNavigationControllerInteractable
extension TermConditionViewController: AppNavigationControllerInteractable{}

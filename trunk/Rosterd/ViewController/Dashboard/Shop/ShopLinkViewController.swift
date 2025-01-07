//
//  ShopLinkViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 01/06/22.
//

import UIKit

class ShopLinkViewController: UIViewController, WKUIDelegate{
    
    // MARK: - IBOutlet
    @IBOutlet weak var webContentView: WKWebView!
    
    @IBOutlet weak var viewWeb: UIView!
    
    // MARK: - Variables
    var Url : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        webContentView?.uiDelegate = self
        webContentView?.navigationDelegate = self
        let url = URL(string: Url)
        let requestObj = URLRequest(url: url!)
        SVProgressHUD.show()
          webContentView.load(requestObj)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
       
        
    }

}

// MARK: - Init Configure
extension ShopLinkViewController {
    private func InitConfig() {
        
        
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}

// MARK: - ViewControllerDescribable
extension ShopLinkViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}

// MARK: - ViewControllerDescribable
extension ShopLinkViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Shop
    }
}

// MARK: - AppNavigationControllerInteractable
extension ShopLinkViewController: AppNavigationControllerInteractable{}

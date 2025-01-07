//
//  ProfileResumeViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 18/08/22.
//

import UIKit

class ProfileResumeViewController: UIViewController {

    
    // MARK: - IBOutlet
    @IBOutlet weak var webContentView: WKWebView!
    
    @IBOutlet weak var viewWeb: UIView!
    
    // MARK: - Variables
    var Url : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()

        let url = URL(string: Url)
        let requestObj = URLRequest(url: url!)
          webContentView.load(requestObj)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
       
        
    }

}

// MARK: - Init Configure
extension ProfileResumeViewController {
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
extension ProfileResumeViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ProfileResumeViewController: AppNavigationControllerInteractable{}

//
//  AboutUsViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 03/02/22.
//

import UIKit

class AboutUsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblTerms: UILabel?
    @IBOutlet weak var lblprivacy: UILabel?
    @IBOutlet weak var btnfacebook: UIButton?
    @IBOutlet weak var btninsta: UIButton?
    @IBOutlet weak var btnlinkedin: UIButton?
    @IBOutlet weak var btnwhatsapp: UIButton?
    
 
    @IBOutlet weak var lblCMScontent: UILabel?
    @IBOutlet weak var lblConnectWithus: UILabel?
    //    MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        
       
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
       
        

    }
    }


        // MARK: - Init Configure
        extension AboutUsViewController {
          private func InitConfig() {
              
              self.lblCMScontent?.textColor = UIColor.CustomColor.aboutDetailColor
              self.lblCMScontent?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
              
              self.lblConnectWithus?.textColor = UIColor.CustomColor.ConnectWithColor
              self.lblConnectWithus?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 16.0))
              
              [self.lblprivacy,self.lblTerms].forEach({
                  $0?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 15.0))
                  $0?.textColor = UIColor.CustomColor.appColor
              })
           
              self.getCMSData()
         }

          private func configureNavigationBar() {
        
              appNavigationController?.setNavigationBarHidden(true, animated: true)
              appNavigationController?.navigationBar.backgroundColor = UIColor.clear
              self.navigationController?.setNavigationBarHidden(false, animated: false)
              
              appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "About Us", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
              
              navigationController?.navigationBar
                  .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
              navigationController?.navigationBar.removeShadowLine()
         }
       }


// MARK: - IBAction
extension AboutUsViewController {
    
    @IBAction func btnfacebookClicked(_ sender : UIButton) {
        if let url = URL(string: "https://www.facebook.com/rosteredapp") {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @IBAction func btninstaClicked(_ sender : UIButton) {
        if let url = URL(string: "https://instagram.com/rosteredapp/") {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
        
    }
    @IBAction func btnlinkdinClicked(_ sender : UIButton) {
        if let url = URL(string: "https://www.linkedin.com/company/rosteredapp/") {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @IBAction func btnwhatsappClicked(_ sender : UIButton) {
        
    }
    
    @IBAction func btntermConditionClicked(_ sender: UIButton) {
        self.appNavigationController?.push(TermConditionViewController.self,configuration: { vc in
            vc.pageid = .TermCondition
        })
    }
    
    @IBAction func btnprivacyClicked(_ sender: UIButton) {
        self.appNavigationController?.push(TermConditionViewController.self,configuration: { vc in
            vc.pageid = .PrivacyPolicy
        })
    }
    
    
}

// MARK: - SFSafariViewControllerDelegate
extension AboutUsViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - API Call
extension AboutUsViewController {
    private func getCMSData(){
        
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType,
            kpageId : "aboutus"
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        CMSModel.getCMSContent(with: param, success: { (cmsdata, msg) in
            
            self.lblCMScontent?.setHTMLFromString(text: cmsdata.cmsdescription)
            
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
                //self.showAlert(withTitle: errorType.rawValue, with: error)
            }
            
        })
        
    }
}
// MARK: - ViewControllerDescribable
extension AboutUsViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.CMS
        
    }
}

// MARK: - AppNavigationControllerInteractable
extension AboutUsViewController: AppNavigationControllerInteractable{}




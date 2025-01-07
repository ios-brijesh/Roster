//
//  ResumeCompleteViewController.swift
//  Rosterd
//
//  Created by iMac on 21/04/23.
//

import UIKit

class ResumeCompleteViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var btnSahre: UIButton!
    @IBOutlet weak var btnResume: AppButton!
    
    @IBOutlet weak var lblShare: UILabel!
    @IBOutlet weak var lblsubHeader: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    // MARK: - Variables
    var resumeShareProfileId : String = ""
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
// MARK: - Init Configure
extension ResumeCompleteViewController {
    private func InitConfig(){
        self.btnSahre?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnSahre?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btnSahre?.cornerRadius = 22
        self.btnSahre?.backgroundColor = UIColor.white
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblsubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblsubHeader?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblShare?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.lblShare?.textColor = UIColor.CustomColor.whitecolor
    }
}
// MARK: -IBAction
extension ResumeCompleteViewController {
    
    @IBAction func btnShare(_ sender : UIButton) {
        self.appNavigationController?.push(ResumeShareViewController.self,configuration:  { vc in
            vc.userResumeId = self.resumeShareProfileId
        })
    }
    @IBAction func btnREsume(_ sedner : AppButton) {
        self.appNavigationController?.push(ResumeViewController.self)
    }
}
// MARK: - ViewControllerDescribable
extension ResumeCompleteViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}
// MARK: - AppNavigationControllerInteractable
extension ResumeCompleteViewController: AppNavigationControllerInteractable { }

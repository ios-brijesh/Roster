//
//  ChatAttachmentViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 08/04/22.
//

import UIKit

class ChatAttachmentViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var btnscroll: UIButton!
    @IBOutlet weak var btncamera: UIButton?
    @IBOutlet weak var btndocs: UIButton?
    @IBOutlet weak var btnfiles: UIButton?
    
    @IBOutlet weak var lblcamera: UILabel?
    @IBOutlet weak var lbldocs: UILabel?
    @IBOutlet weak var lblfiles: UILabel?
    
    @IBOutlet weak var vwcamera: UIView?
    @IBOutlet weak var vwDocs: UIView?
    @IBOutlet weak var vwFiles: UIView?
    @IBOutlet weak var vwmainview: UIView?
    
    
    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.InitConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       
//        if let vw = self.vwcamera {
//            vw.cornerRadius = vw.frame.height / 2.0
//        }
//
//        if let vw = self.vwDocs {
//            vw.cornerRadius = vw.frame.height / 2.0
//        }
//
//        if let vw = self.vwFiles {
//            vw.cornerRadius = vw.frame.height / 2.0
//        }
        
        self.vwcamera?.cornerRadius = 20.0
        self.vwDocs?.cornerRadius = 20.0
        self.vwFiles?.cornerRadius = 20.0
        
        if let vw = self.vwmainview {
            vw.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
       
    }
}


// MARK: - Init Configure
extension ChatAttachmentViewController {
    private func InitConfig(){
        
        
        self.lbldocs?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lbldocs?.textColor = UIColor.CustomColor.blackColor
        
        self.lblfiles?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblfiles?.textColor = UIColor.CustomColor.blackColor
        
        self.lblcamera?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblcamera?.textColor = UIColor.CustomColor.blackColor
    
        self.vwcamera?.backgroundColor = UIColor.CustomColor.appColor
        self.vwDocs?.backgroundColor = UIColor.CustomColor.appColor
        self.vwFiles?.backgroundColor = UIColor.CustomColor.appColor
        

    }
}


// MARK: - ViewControllerDescribable
extension ChatAttachmentViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Message
    }
}

// MARK: - AppNavigationControllerInteractable
extension ChatAttachmentViewController: AppNavigationControllerInteractable { }


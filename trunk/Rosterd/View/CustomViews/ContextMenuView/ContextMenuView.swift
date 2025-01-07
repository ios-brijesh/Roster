//
//  ContextMenuView.swift
//  DDD
//
//  Created by Wdev3 on 24/11/20.
//  Copyright © 2020 Wdev3. All rights reserved.
//

import UIKit

enum contentMenuBtn : Int {
    case Block
    case ReportUser
    case Archive
    //case UpgradeCourse
    //case ExitLesson
    
    var name : String {
        switch self {
        case .Block:
            return "Block"
        case .ReportUser:
            return "Report User"
        case .Archive:
            return "Archive"
        }
    }
    
    var textColor : UIColor{
        switch self {
        case .Block:
            return UIColor.CustomColor.blackColor
        case .ReportUser:
            return UIColor.CustomColor.blackColor
        case .Archive:
            return UIColor.CustomColor.blackColor
        }
    }
}

class ContextMenuView: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var vwMainContent: UIView!
   
    @IBOutlet var btnBlock: UIButton!
    @IBOutlet var btnReportUser: UIButton!
    @IBOutlet var btnArchive: UIButton!
    
    @IBOutlet weak var constarintTopVwMainContent: NSLayoutConstraint!
    //MARK: Variables
    var contentView:UIView?
    let nibName = "ContextMenuView"
    
    private var selectedMenu : contentMenuBtn = .Block
    
    var onBtnClick: ((_ menubtn : contentMenuBtn)-> (Void))?
    
    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.vwMainContent.clipsToBounds = true
        self.vwMainContent.cornerRadius = 10.0
        self.vwMainContent.shadow(UIColor.CustomColor.shadowColorTenPerBlack, radius: 5.0, offset: CGSize(width: 4, height: 2), opacity: 1)
        self.vwMainContent.maskToBounds = false
    }
    
    private func InitConfig(){
        /*self.btnMenu.forEach({
            $0.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
            $0.setTitleColor(UIColor.CustomColor.labelTextColor, for: .normal)
            $0.setTitle($0.titleLabel?.text?.localized(), for: .normal)
        })*/
        
        [self.btnBlock,self.btnReportUser,self.btnArchive].forEach({
            $0?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        })
       
        self.btnBlock.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
        self.btnReportUser.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
        self.btnArchive.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
        
        self.vwMainContent.cornerRadius = 10.0
    }
}
// MARK: - IBAction
extension ContextMenuView {
    @IBAction func btnBlockClicked(_ sender: UIButton) {
        self.removeFromSuperview()
        self.onBtnClick?(contentMenuBtn.Block)
    }
    @IBAction func btnRrportUserClicked(_ sender: UIButton) {
        self.removeFromSuperview()
        self.onBtnClick?(contentMenuBtn.ReportUser)
    }
    
    @IBAction func btnArchiveClicked(_ sender : UIButton) {
        self.removeFromSuperview()
        self.onBtnClick?(contentMenuBtn.Archive)
    }
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.removeFromSuperview()
    }
  
}

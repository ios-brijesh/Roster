//
//  CommonListCell.swift
//  XtraHelpCaregiver
//
//  Created by wm-devIOShp on 18/11/21.
//

import UIKit

class CommonListCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var vwSelectMain: UIView?
    @IBOutlet weak var btnSelect: UIButton?
    @IBOutlet weak var btnSelectMain: UIButton?
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    private func InitConfig(){
        self.lblName?.textColor = UIColor.CustomColor.TextColor
        self.lblName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
    }
    
    func setSportsData(obj: SportsModel){
        self.lblName?.text = obj.name
        self.btnSelect?.isSelected = obj.isSelect
    }
    
    func setEventCategoryData(obj: EventCategoryModel){
        self.lblName?.text = obj.name
        self.btnSelect?.isSelected = obj.isSelectCategory
    }
    func setFeedbackCategoryData(obj: FeedBackCategoryModel){
        self.lblName?.text = obj.name
        self.btnSelect?.isSelected = obj.isSelect
    }
}

// MARK: - NibReusable
extension CommonListCell : NibReusable {}

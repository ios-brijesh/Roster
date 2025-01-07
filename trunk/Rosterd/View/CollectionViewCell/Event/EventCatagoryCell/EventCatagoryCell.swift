//
//  EventCatagoryCell.swift
//  Rosterd
//
//  Created by wm-devIOShp on 22/01/22.
//

import UIKit

class EventCatagoryCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblCategoryName: UILabel?
    
    // MARK: - Variables
    var isSelectCell : Bool = false {
        didSet{
            self.lblCategoryName?.font = isSelectCell ? UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)) : UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        }
    }
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    private func initConfig() {
        self.lblCategoryName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblCategoryName?.textColor = UIColor.CustomColor.textfieldTextColor
    }

    func SetEventCategoryData(obj : EventCategoryModel){
        
        self.lblCategoryName?.text = obj.name
    }
    
}

// MARK: - NibReusable
extension EventCatagoryCell: NibReusable { }

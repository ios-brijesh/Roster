//
//  YesNOButton.swift
//  Rosterd
//
//  Created by WMiosdev01 on 13/05/22.
//

import Foundation
import UIKit

class YesNoButton : UIButton
{

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    @IBInspectable var isSelectBtn: Bool = false {
        didSet {
            self.setTitleColor(isSelectBtn ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.blackColor, for: .normal)
            self.borderColor = isSelectBtn ? UIColor.CustomColor.appColor : UIColor.CustomColor.yesnoColor
            self.backgroundColor = isSelectBtn ? UIColor.CustomColor.appColor : .clear
        }
    }
    
    func setupView()
    {
        
        self.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.setTitleColor(UIColor.CustomColor.whitecolor, for: .normal)
        self.cornerRadius = frame.height * 0.50
        self.backgroundColor = UIColor.clear
        self.borderWidth = 1.0
        self.borderColor = UIColor.CustomColor.yesnoColor
    }
}
 

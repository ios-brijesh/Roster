//
//  MomentorButton.swift
//  Momentor
//
//  Created by wmdevios-h on 14/08/21.
//

import Foundation
import UIKit

class AppButton : UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        
        self.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.setTitleColor(UIColor.CustomColor.whitecolor, for: .normal)
        
        delay(seconds: 0.1, execute: {
            self.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: self.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        })
        delay(seconds: 0.1, execute: {
            self.maskToBounds = true
            self.cornerRadius = 22

            self.maskToBounds = false
        })
    }
}

//
//  AppGradiantDashboardBG.swift
//  Momentor
//
//  Created by wmdevios-h on 28/08/21.
//

import Foundation

class AppGradiantDashboardBG: UIView {
    
    //MARK: - Life Cycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: self.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
    }
}

//
//  RoundBorderGradiantView.swift
//  Rosterd
//
//  Created by wm-devIOShp on 22/01/22.
//

import Foundation

class RoundBorderGradiantView: UIView {
    
    // MARK: - IBOutlet
    
    
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
        self.rotate(angle: 360.0)
        self.cornerRadius = self.frame.height / 2.0
        self.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: self.frame, colors: [UIColor.CustomColor.BorderColorOne,UIColor.CustomColor.whitecolor])
    }
}

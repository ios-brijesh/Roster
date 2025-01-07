//
//  BlurView.swift
//  Momentor
//
//  Created by wmdevios-h on 14/08/21.
//

import Foundation
import UIKit
class BlurView: UIView {
    
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
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = UIColor.CustomColor.black50Per
            //self.cornerRadius = 18.0
            let blurEffect = UIBlurEffect(style: .dark)
            
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = 0.8
            blurEffectView.clipsToBounds = true
            blurEffectView.layer.cornerRadius = 18.0
            //blurEffectView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            self.backgroundColor = UIColor.CustomColor.black50Per
        }
    }
}

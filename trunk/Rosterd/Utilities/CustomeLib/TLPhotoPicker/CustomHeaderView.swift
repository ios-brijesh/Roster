//
//  CustomHeaderView.swift
//  TLPhotoPicker_Example
//
//  Created by wade.hawk on 21/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class CustomHeaderView: UICollectionReusableView {
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.font = UIFont.PoppinsMedium(ofSize: 12.0)
        self.titleLabel.textColor = UIColor.CustomColor.blackColor
    }
}

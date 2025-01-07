//
//  DateCollectionViewCell.swift
//  Rosterd
//
//  Created by wm-devIOShp on 22/01/22.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var vwMain: UIView?
    
    // MARK: - Variables
    var selecteDate : Date = Date()
    var isSelectCell : Bool = false {
        didSet{
            if let vw = self.vwMain {
                vw.borderWidth = isSelectCell ? 0.0 : 1.0
                vw.backgroundColor = isSelectCell ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.dateGradiantColorOne,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor
                vw.borderColor = isSelectCell ? UIColor.clear : UIColor.CustomColor.dateBorderColor
               
                
            }
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
        self.lblDate?.setCreateEventAttributedText(firstText: "Sat", SecondText: "\n1")
        self.vwMain?.cornerRadius = 18.0
    }

}

// MARK: - NibReusable
extension DateCollectionViewCell: NibReusable { }

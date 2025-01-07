//
//  ReferCoinCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/11/22.
//

import UIKit

class ReferCoinCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var VwMAinView: UIView?
    
    @IBOutlet weak var lblheader: UILabel?
    @IBOutlet weak var lblSubheader: UILabel?
    @IBOutlet weak var lblCoin: UILabel?
    
    // MARK: - Variables

    
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
        
        self.lblheader?.textColor = UIColor.CustomColor.blackColor
        self.lblheader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblSubheader?.textColor = UIColor.CustomColor.black50Per
        self.lblSubheader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 11.0))
        
        self.lblCoin?.textColor = UIColor.CustomColor.CoinColor
        self.lblCoin?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        
        self.VwMAinView?.backgroundColor =  UIColor.CustomColor.writeSomethingBGColor
        self.VwMAinView?.cornerRadius = 17.0
        self.VwMAinView?.borderWidth = 1.0
        self.VwMAinView?.borderColor = UIColor.CustomColor.borderColor4
    }
    func SetReferData(obj : RefercoinModel) {
        
        self.lblCoin?.text = "+\(obj.reward)"
        self.lblSubheader?.text = obj.createdDate
        if obj.type == "3" {
          self.lblheader?.text = "points  earned for new followers"
        } else if obj.type == "2" {
            self.lblheader?.text = "points  earned for new Referral"
        } else {
            self.lblheader?.text = "Points earned for Daily Login"
        }
        
    }
}
// MARK: - NibReusable
extension ReferCoinCell: NibReusable { }

//
//  MastercardCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 31/01/22.
//

import UIKit

class MastercardCell: UITableViewCell {
    @IBOutlet weak var vwMainView: UIView?
    @IBOutlet weak var lblMasterCard: UILabel?
    @IBOutlet weak var lblCardNumber:UILabel?
    
    @IBOutlet weak var imgCard: UIImageView?
    @IBOutlet weak var btnSelect: UIButton?
    @IBOutlet weak var btnREmove: UIButton!
    
    
    @IBOutlet weak var vwPlusview: UIView!
    @IBOutlet weak var vwREmoveview: UIView!
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
         self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        self.vwMainView?.borderColor = UIColor.CustomColor.MinusBtnColor
        self.vwMainView?.borderWidth = 2
        self.vwMainView?.cornerRadius = 25
        
        
        self.lblMasterCard?.textColor = UIColor.CustomColor.ProductPrizeColor
        self.lblMasterCard?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 16.0))
        
        
        self.lblCardNumber?.textColor = UIColor.CustomColor.ProductListColor
        self.lblCardNumber?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
       
        
        self.btnREmove?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
        self.btnREmove?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
    }
    
    @IBAction func btnselectclicked(_ sender : UIButton) {
        
        self.btnSelect?.isSelected = (self.btnSelect?.isSelected ?? false)
        
    }
       
    
    
    func setupCardData(obj : CardModel){
        self.lblCardNumber?.text = "**** **** **** \(obj.cardNumber)"
        let cardtye = CardAPIType.init(rawValue: obj.type) ?? .None
        self.imgCard?.image = cardtye.image
        self.lblMasterCard?.text = obj.cardHolder

    }
}

// MARK: - NibReusable
extension MastercardCell: NibReusable { }

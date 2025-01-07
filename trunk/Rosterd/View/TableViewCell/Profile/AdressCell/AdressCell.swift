//
//  AdressCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/05/22.
//

import UIKit


class AdressCell: UITableViewCell {

    
    // MARK: - IBOutlet
    @IBOutlet weak var vwMainview: UIView?
    @IBOutlet weak var vwdefaultadd: UIView?
   
    @IBOutlet weak var lbldefaultadd: UILabel!
    @IBOutlet weak var lblDetailadd: UILabel?
    @IBOutlet weak var lblphonenumber: UILabel!
    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnEdit: UIButton?
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
        self.lblDetailadd?.textColor = UIColor.CustomColor.labelTextColor
        self.lblDetailadd?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lbldefaultadd?.textColor = UIColor.CustomColor.addressLabelTextColor
        self.lbldefaultadd?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblphonenumber?.textColor = UIColor.CustomColor.addressLabelTextColor
        self.lblphonenumber?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        self.btnEdit?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnEdit?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
                
        self.vwMainview?.cornerRadius = 14.0
        self.vwMainview?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        
    }
        func setAdressData(obj : AdresssModel) {
                        
            let houseNumber = "House No \(obj.houseNumber)"
            let address = obj.address
            let landMark = obj.landMark
            let city = obj.city
            let FullAdress = houseNumber + ", " + address + ", " + landMark + ", " + city
            self.lblphonenumber?.text = obj.phonenumber
            self.lblDetailadd?.text = FullAdress
            
            if obj.isDefault == "1"{
                self.vwdefaultadd?.isHidden = false
            } else {
                self.vwdefaultadd?.isHidden = true
            }
        }
        
    @IBAction func btnselectclicked(_ sender : UIButton) {
        self.btnSelect?.isSelected = (self.btnSelect?.isSelected ?? false)
    }
}

// MARK: - NibReusable
extension AdressCell: NibReusable { }

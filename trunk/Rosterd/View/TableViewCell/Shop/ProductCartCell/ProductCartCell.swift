//
//  ProductCartCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 28/01/22.
//

import UIKit

class ProductCartCell: UITableViewCell {

    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    
    @IBOutlet weak var lblPrize: UILabel!
    @IBOutlet weak var lblShowQuantaty: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblRemove: UILabel?
    @IBOutlet weak var btnRemove: UIButton!
    
    @IBOutlet weak var ProfileImg: UIImageView!
    
    @IBOutlet weak var vwMainView: UIView!
    
    private var count : Int = 1
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
        
        
        self.lblShowQuantaty?.textColor = UIColor.CustomColor.ProductPrizeColor
        self.lblShowQuantaty?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 14.0))
        
        
        self.lblCategory?.textColor = UIColor.CustomColor.ProductListColor
        self.lblCategory?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblProductName?.textColor = UIColor.CustomColor.ProductPrizeColor
        self.lblProductName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 18.0))
        
        
        self.lblPrize?.setPriceAttributesText(firstText: "$12", SecondText: ".99")
        
        self.btnRemove?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 10.0))
        self.btnRemove?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
        
        self.ProfileImg?.cornerRadius = 15.0
        
        
        self.btnMinus?.backgroundColor = UIColor.CustomColor.MinusBtnColor
        self.btnMinus?.cornerRadius = 10
        
        
        if let btnPlus = self.btnPlus {
            btnPlus.cornerRadius = 10.0
            btnPlus.backgroundColor = UIColor.CustomColor.appColor
        }
        
        self.lblShowQuantaty?.text = "\(self.count)"
    }
}


extension ProductCartCell {
    @IBAction func btnPlusClick(_ sender: UIButton) {
        //self.count = self.count + 1
       // self.lblShowQuantaty?.text = "\(self.count)"

    }
    @IBAction func btnMinusClick(_ sender: UIButton) {
        //self.count = self.count - 1
        //self.count = self.count <= 0 ? 1 : self.count
       // self.lblShowQuantaty?.text = "\(self.count)"

    }
    
    func setcartData(obj : CartModel) {
        self.ProfileImg?.setImage(withUrl: obj.primaryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.ProfileImg?.cornerRadius = 15.0
        self.lblProductName?.text = obj.product_name
        self.lblCategory?.text = obj.category
        self.lblShowQuantaty?.text = obj.qty
        self.count = Int(obj.qty) ?? 1
        let arrPrice = obj.price.components(separatedBy: ".")
        
        if arrPrice.count == 2 {
            self.lblPrize?.setPriceAttributesText(firstText: "$\(arrPrice.first ?? "0").", SecondText: "\(arrPrice.last ?? "00")")
        }
        else {
            self.lblPrize?.text = "$\(obj.price)"
        }
    }

    func setEventcartData(obj : TicketdataModel) {
        self.ProfileImg?.setImage(withUrl: obj.coverImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblProductName?.text = obj.eventName
        self.lblCategory?.text = obj.ticketName
        self.lblShowQuantaty?.text = obj.qty
        let arrPrice = obj.ticketPrice.components(separatedBy: ".")
        
        if arrPrice.count == 2 {
            self.lblPrize?.setPriceAttributesText(firstText: "$\(arrPrice.first ?? "0").", SecondText: "\(arrPrice.last ?? "00")")
        }
        else {
            self.lblPrize?.text = "$\(obj.ticketPrice)"
        }
    }
}


// MARK: - NibReusable
extension ProductCartCell: NibReusable { }

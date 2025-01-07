//
//  OrderDetailCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 26/07/22.
//

import UIKit

class OrderDetailCell: UITableViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var vwimgview: UIView!
    @IBOutlet weak var imgproduct: UIImageView!
    
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var lblshowdetail: UILabel!
    @IBOutlet weak var lblprize: UILabel!
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.initConfig()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func initConfig() {
        
        self.lblproductname?.textColor = UIColor.CustomColor.blackColor
        self.lblproductname?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 13.0))
        
        self.lblprize?.textColor = UIColor.CustomColor.blackColor
        self.lblprize?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblshowdetail?.textColor = UIColor.CustomColor.labelordercolor
        self.lblshowdetail?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.vwimgview?.borderWidth = 1.0
        self.vwimgview?.borderColor = UIColor.CustomColor.sepratorFeedColor
        self.vwimgview?.cornerRadius = 10.0
        
    }
    
    func SetOrderData(obj : CartModel) {
        self.lblproductname?.text = obj.product_name
        self.imgproduct?.setImage(withUrl: obj.primaryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
        let oneprice = obj.price
        let oneqty = obj.qty
        
        let showdetail = "$ " + oneprice + " x " + oneqty
        self.lblshowdetail?.text = showdetail
        self.lblprize?.text = obj.totalAmount
        
        let price = Float(obj.price) ?? 0.00
        let qty = Float(obj.qty) ?? 0
        
        let total = price * qty
        self.lblprize?.text = "$\(String(format: "%.2f", total))"
        
    }
    
}

// MARK: - NibReusable
extension OrderDetailCell: NibReusable { }

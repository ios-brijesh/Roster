//
//  TicketDetailCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 28/07/22.
//

import UIKit

class TicketDetailCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var vwShowTicketview: UIView?
    @IBOutlet weak var vwMainView: UIView?
    
    @IBOutlet weak var imgEvent: UIImageView?
    
    @IBOutlet weak var imgBarcode: UIImageView?
    
    @IBOutlet weak var lblEventName: UILabel?
    @IBOutlet weak var lblNumberticket: UILabel?
    @IBOutlet weak var lblTicket: UILabel?
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblShowDate: UILabel?
    @IBOutlet weak var lblTime: UILabel?
    @IBOutlet weak var lblShowTime: UILabel?
    @IBOutlet weak var lblPlace: UILabel?
    @IBOutlet weak var lblShowPlace: UILabel?
    @IBOutlet weak var lblShowBarcodeNumber: UILabel?
    
    // MARK: - Variables
    
 
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.InitConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let vw = self.vwShowTicketview {
            vw.cornerRadius = vw.frame.height / 2.0
            vw.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if  let vwMainView = self.vwMainView {
            //
            vwMainView.cornerRadius = 10.0
            //
            vwMainView.clipsToBounds = true
            vwMainView.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwMainView.maskToBounds = false

        }
        self.imgEvent?.cornerRadius = 10
        
    }
    
    
    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        
        [self.lblDate,self.lblTime,self.lblPlace].forEach({
            $0?.textColor = UIColor.CustomColor.dateBorderColor
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size:12.0))
        })
        
        [self.lblShowDate,self.lblShowTime,self.lblShowPlace].forEach({
            $0?.textColor = UIColor.CustomColor.blackColor
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size:16.0))
        })
        
        self.lblShowBarcodeNumber?.textColor = UIColor.CustomColor.dateBorderColor
        self.lblShowBarcodeNumber?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 16.0))
        
        
        self.lblEventName?.textColor = UIColor.CustomColor.blackColor
        self.lblEventName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 22.0))
        
        
        self.lblNumberticket?.textColor = UIColor.CustomColor.whitecolor
        self.lblNumberticket?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 18.0))
        
        self.lblTicket?.textColor = UIColor.CustomColor.whitecolor
        self.lblTicket?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 06.0))
        
    }
    
    func SetTicketDetail(obj : EventModel){
        self.lblShowDate?.text = obj.eventFormetDate
        self.lblNumberticket?.text = obj.totalTickets
        self.lblShowPlace?.text = obj.place
        self.lblShowTime?.text = obj.Time
        self.lblEventName?.text = obj.eventName
        self.imgEvent?.setImage(withUrl: obj.coverImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.imgBarcode?.setImage(withUrl: obj.qrcodeImageUrl, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

    }
    
}
// MARK: - NibReusable
extension TicketDetailCell: NibReusable { }


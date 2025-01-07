//
//  TicketTransferCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 27/12/22.
//

import UIKit

class TicketTransferCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var lblEventName: UILabel?
    @IBOutlet weak var lblNumberticket: UILabel?
    @IBOutlet weak var lblTicket: UILabel?
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblShowDate: UILabel?
    @IBOutlet weak var lblTime: UILabel?
    @IBOutlet weak var lblShowTime: UILabel?
    @IBOutlet weak var lblPlace: UILabel?
    @IBOutlet weak var lblShowPlace: UILabel?
    @IBOutlet weak var lblHeader : UILabel?
    @IBOutlet weak var lbluserName : UILabel?
    
    @IBOutlet weak var vwRight: UIView!
    @IBOutlet weak var vwLeft: UIView!
    @IBOutlet weak var vwMiddleview: UIView?
    @IBOutlet weak var vwplaceview: UIView?
    @IBOutlet weak var vwEventview: UIView?
    @IBOutlet weak var vwDateView: UIView?
    @IBOutlet weak var vwShowTicketview: UIView?
    @IBOutlet weak var vwMainView: UIView?
    @IBOutlet weak var vwUserview: UIView?
    
    @IBOutlet weak var img_user : UIImageView?
    
    var isselectCell : Bool = false {
        didSet{
            self.vwMainView?.backgroundColor = isselectCell ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.whitecolor50
            self.vwMainView?.borderWidth = isselectCell ? 2.0 : 0.0
            self.vwMainView?.borderColor = isselectCell ? UIColor.CustomColor.appColor : .clear
            self.vwMainView?.shadowColor = isselectCell ? UIColor.CustomColor.whiteShadow80 : UIColor.CustomColor.shadow28appcolour
        }
    }
   
    // MARK: - Variables
    
    // MARK: - LIfe Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let vw = self.vwShowTicketview {
            vw.cornerRadius = vw.frame.height / 2.0
            vw.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if  let vwMainView = self.vwMainView {
            vwMainView.cornerRadius = 10.0
//            vwMainView.backgroundColor = UIColor.white
            vwMainView.clipsToBounds = true
            vwMainView.shadow(UIColor.CustomColor.shadow28appcolour, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwMainView.maskToBounds = false
        }
        
        if let imgUser = self.img_user {
            imgUser.cornerRadius = imgUser.frame.height / 2
        }
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
        
        self.lblEventName?.textColor = UIColor.CustomColor.blackColor
        self.lblEventName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 22.0))
        
        
        self.lblNumberticket?.textColor = UIColor.CustomColor.whitecolor
        self.lblNumberticket?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 18.0))
        
        self.lbluserName?.textColor = UIColor.CustomColor.messageColor
        self.lbluserName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        self.lblHeader?.textColor = UIColor.CustomColor.dateBorderColor
        self.lblHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblTicket?.textColor = UIColor.CustomColor.whitecolor
        self.lblTicket?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 06.0))
        
    }
    
    func SetTicketDetail(obj : TicketDetailModel){
        self.lblShowDate?.text = obj.eventFormetDate
        self.lblNumberticket?.text = "1"
        self.lblShowPlace?.text = obj.place
        self.lblShowTime?.text = obj.time
        self.lblEventName?.text = obj.eventName

        self.isselectCell = obj.isSelect
        self.lbluserName?.text = obj.fullName        

//        self.isselectCell = obj.isSelect
        self.lbluserName?.text = obj.fullName

        if obj.TransferToBy == "0" {
            self.vwUserview?.isHidden = true
        } else if obj.TransferToBy == "1" {
            self.vwUserview?.isHidden = false
            self.lblHeader?.text = "Transferred  to"
        } else if obj.TransferToBy == "2" {
            self.vwUserview?.isHidden = false
            self.lblHeader?.text = "Transferred  by"
        } else {
            self.vwUserview?.isHidden = true
        }
        self.img_user?.setImage(withUrl: obj.profileImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
//        self.imgBarcode?.setImage(withUrl: obj.qrcodeImageUrl, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)

    }
}
// MARK: - NibReusable
extension TicketTransferCell: NibReusable { }

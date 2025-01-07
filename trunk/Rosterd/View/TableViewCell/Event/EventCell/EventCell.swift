//
//  EventCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 24/01/22.
//

import UIKit
import OnlyPictures


protocol  EventCellDelegate {

    func btnLikeSelect(btn : UIButton,cell : EventCell)
    
}

class EventCell: UITableViewCell, OnlyPicturesDelegate{
 
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgEvnet: UIImageView!
    @IBOutlet weak var vwLike: UIView!
    @IBOutlet weak var vwCategory: UIView!
    @IBOutlet weak var veDateview: UIView!
    
   
   
    @IBOutlet weak var vwProfiles: OnlyHorizontalPictures!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblCityname: UILabel!
    
    
    private var arrimages : [bookingUserDataModel] = []
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.InitConfig()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
    }
    
    
    var Delegate : EventCellDelegate?
    
    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        self.veDateview?.cornerRadius = 15
        self.veDateview?.backgroundColor = UIColor.CustomColor.whitecolor
        
        self.vwCategory?.backgroundColor = UIColor.CustomColor.blackColor
        self.vwCategory?.cornerRadius = 10
        
        self.imgEvnet?.cornerRadius = 30.0
        
        self.vwLike?.cornerRadius = 10
        self.vwLike?.backgroundColor = UIColor.CustomColor.whitecolor30Per
        
        self.lblEventName?.textColor = UIColor.CustomColor.whitecolor
        self.lblEventName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 21.0))
        
        self.lblCityname?.textColor = UIColor.CustomColor.whitecolor
        self.lblCityname?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        
        self.lblCategory?.textColor = UIColor.CustomColor.whitecolor
        self.lblCategory?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        self.lblDate?.setEventDateAttributedText(firstText: "", SecondText: "")
        
        self.vwProfiles?.dataSource = self
        self.vwProfiles?.delegate = self
        self.vwProfiles?.order = .ascending
        self.vwProfiles?.alignment = .left
        self.vwProfiles?.recentAt = .right
        self.vwProfiles?.spacingColor = UIColor.CustomColor.whitecolor
        self.vwProfiles?.defaultPicture = #imageLiteral(resourceName: "AppPlaceholder")
        self.vwProfiles?.gap = 20
        self.vwProfiles?.spacing = 1
        self.vwProfiles?.backgroundColor = UIColor.clear
        
       
       
    }
    
   
    
    func SetEventData(obj : EventModel){
        self.lblEventName?.text = obj.name
        
        self.lblCityname?.text = obj.location
        self.imgEvnet?.setImage(withUrl: obj.coverImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.btnLike?.isSelected = obj.isFavourite == "1"
        self.lblCategory?.text = obj.categoryName
        self.arrimages = obj.bookingUserData
        self.vwProfiles?.reloadData()
      
        let arrPrice = obj.eventDateFormat.components(separatedBy: ",")
        if arrPrice.count == 2 {
            if let stDate = arrPrice.first,stDate != "" {
                let arrdate  = stDate.components(separatedBy: " ")
                if arrdate.count == 2 {
                    
                    
                    self.lblDate?.setEventDateAttributedText(firstText: "\(arrdate.last ?? "")\n", SecondText: (arrdate.first ?? ""))
                  
                    
                }
            }
            else {
                
            }
            
            
        }
        else {
            self.lblDate?.text = "\(obj.eventDateFormat)"
        }
       
    }
    
    func SetCreateEventData(obj : EventModel){
        self.lblEventName?.text = obj.name
        
        self.lblCityname?.text = obj.location
        self.imgEvnet?.setImage(withUrl: obj.coverImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.btnLike?.isSelected = obj.isFavourite == "1"
        self.lblCategory?.text = obj.categoryName
        self.arrimages = obj.bookingUserData
        self.vwProfiles?.reloadData()
      
        let arrPrice = obj.eventDateFormat.components(separatedBy: ",")
        if arrPrice.count == 2 {
            if let stDate = arrPrice.first,stDate != "" {
                let arrdate  = stDate.components(separatedBy: " ")
                if arrdate.count == 2 {
                    
                    
                    self.lblDate?.setEventDateAttributedText(firstText: "\(arrdate.last ?? "")\n", SecondText: (arrdate.first ?? ""))
                  
                    
                }
            }
            else {
                
            }
            
            
        }
        else {
            self.lblDate?.text = "\(obj.eventDateFormat)"
        }
        self.vwLike?.isHidden = true
       
    }
    
    
    func SetFavoritesData(obj : EventModel){
        self.lblEventName?.text = obj.eventName
        self.lblCityname?.text = obj.eventLocation
        self.imgEvnet?.setImage(withUrl: obj.coverImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.btnLike?.isSelected = obj.isFavourite == "1"
        self.lblCategory?.text = obj.eventCategoryName
        self.arrimages = obj.bookingUserData
        self.vwProfiles?.reloadData()
        self.vwLike?.isHidden = false
        let arrPrice = obj.eventDateFormat.components(separatedBy: ",")
        if arrPrice.count == 2 {
            if let stDate = arrPrice.first,stDate != "" {
                let arrdate  = stDate.components(separatedBy: " ")
                if arrdate.count == 2 {
                    self.lblDate?.setEventDateAttributedText(firstText: "\(arrdate.last ?? "")\n", SecondText: (arrdate.first ?? ""))
                }
            }
            else {
                
            }
        }
        else {
            self.lblDate?.text = "\(obj.eventDateFormat)"
        }
    }
    
    func setMyBookEventData(obj : EventModel){
        self.lblEventName?.text = obj.eventName
        self.lblCityname?.text = obj.place
        self.imgEvnet?.setImage(withUrl: obj.coverImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.btnLike?.isSelected = obj.isFavourite == "1"
        self.lblCategory?.text = obj.eventCategoryName
        
        
        self.arrimages = obj.bookingUserData
        self.vwProfiles?.reloadData()
      
        let arrPrice = obj.eventFormetDate.components(separatedBy: " ")
        if arrPrice.count == 2 {
            self.lblDate?.setEventDateAttributedText(firstText: "\(arrPrice.first ?? " ")\n", SecondText: arrPrice.last ?? " ")
        }
        else {
            self.lblDate?.text = "\(obj.eventDateFormat)"
        }
    }
    @IBAction func btnlikeClicked(_ sender : UIButton) {
     
        if let btn = self.btnLike {
            self.btnLike?.isSelected = !(self.btnLike?.isSelected ?? false)
            self.Delegate?.btnLikeSelect(btn: btn, cell: self)
           
        }
    }
}
extension EventCell: OnlyPicturesDataSource {
    func numberOfPictures() -> Int {
        return self.arrimages.count
    }
    
    func pictureViews(_ imageView: UIImageView, index: Int) {
        
        let m_Info = arrimages[index]
        imageView.setImage(withUrl: m_Info.thumbprofileimage, placeholderImage: #imageLiteral(resourceName: "AppPlaceholder"), indicatorStyle: .medium, isProgressive: true, imageindicator: .gray)
        }
    
    func pictureView(_ imageView: UIImageView, didSelectAt index: Int) {
        
    }
}
// MARK: - NibReusable
extension EventCell: NibReusable { }

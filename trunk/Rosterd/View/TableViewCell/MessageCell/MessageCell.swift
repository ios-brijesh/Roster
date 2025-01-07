//
//  MessageCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/01/22.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel?
    @IBOutlet weak var lblSubname: UILabel?
    @IBOutlet weak var lblfollow: UILabel!
    
    @IBOutlet weak var btnAccept: UIButton?
    @IBOutlet weak var imageview: UIImageView?
    @IBOutlet weak var imgpro: UIImageView!
    
    @IBOutlet weak var vwLastview: UIView!
    @IBOutlet weak var vwProfileview: UIView?
    @IBOutlet weak var vwMainview: UIView!
    @IBOutlet weak var vwSeprateview: UIView!
    
    
    // MARK: - Variables
    var isSelectedTab : SegmentMessageTabEnum = .Message {
        didSet {
            switch isSelectedTab {
            case .Message:
                self.vwLastview?.isHidden = true
                self.lblfollow?.isHidden = true
                
                
                break
            case .Request:
                self.imgpro?.isHidden = true
                self.lblSubname?.isHidden = true
//                self.vwMainview?.borderColor?.isHidden = false
                self.vwSeprateview?.isHidden = true
                self.vwMainview?.borderWidth = 1.2
                self.vwMainview?.cornerRadius = 20
                break
            case .Archieve:
                self.imgpro?.isHidden = true
                self.lblfollow?.isHidden = true
                self.vwLastview?.isHidden = true
                
                break
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.InitConfig()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
            if let imageview = self.imageview {
                imageview.cornerRadius = imageview.frame.height / 2
      }
    }
    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        self.btnAccept?.setTitleColor(UIColor.CustomColor.SuccessStaus, for: .normal)
        self.btnAccept?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
      
        
        self.lblUsername?.textColor = UIColor.CustomColor.messageColor
        self.lblUsername?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        self.lblSubname?.textColor = UIColor.CustomColor.UsersubColor
        self.lblSubname?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        
        self.lblfollow?.textColor = UIColor.CustomColor.followersLabelTextColor
        self.lblfollow?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        
        self.vwSeprateview?.backgroundColor = UIColor.CustomColor.borderColorMsg
        
        self.vwMainview?.borderColor = UIColor.CustomColor.borderColorMsg
        self.vwMainview?.borderWidth = 0.2
        
    }
    
    func setChatRequestMentorData(obj : ChatModel){
        self.lblUsername?.text = obj.name
       
        self.lblfollow?.text = "\(obj.followers) Followers"
        self.imageview?.setImage(withUrl: obj.image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
        if obj.isAdmin == "0" {
        
            self.btnAccept?.setTitle("Accept", for: .normal)
            self.btnAccept?.setTitleColor(UIColor.CustomColor.SuccessStaus, for: .normal)
            
        }
        else {
            
            self.btnAccept?.setTitle("Remove", for: .normal)
            self.btnAccept?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
        }
        
    }
    
    func setChatMessageMentorData(obj : ChatModel){
        self.lblUsername?.text = obj.name
        self.lblSubname?.text = obj.message.decodingEmoji()
        self.imageview?.setImage(withUrl: obj.image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
    }
    
    func setArchieveData(obj : ChatModel){
        self.lblUsername?.text = obj.name
        self.lblSubname?.text = obj.message.decodingEmoji()
        self.imageview?.setImage(withUrl: obj.image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        
    }
}

    




// MARK: - NibReusable
extension MessageCell: NibReusable { }

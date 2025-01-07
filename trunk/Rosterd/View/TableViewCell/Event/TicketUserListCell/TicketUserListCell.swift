//
//  TicketUserListCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 30/12/22.
//

import UIKit

class TicketUserListCell: UITableViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var img_user: UIImageView?
    @IBOutlet weak var lblname: UILabel?
    @IBOutlet weak var lblFollowers: UILabel?
    @IBOutlet weak var btnSelect: UIButton?
    
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
        
        if let vw = self.img_user {
            vw.cornerRadius = vw.frame.height / 2.0
        }
    }
    
    
    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        
        self.lblname?.textColor = UIColor.CustomColor.messageColor
        self.lblname?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        self.lblFollowers?.textColor = UIColor.CustomColor.followersLabelTextColor
        self.lblFollowers?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
    }
    
    func setTicketuserlist(obj : followModel) {
        self.lblname?.text = obj.userName
        self.lblFollowers?.text = "\(obj.totalFollower) Followers"
        self.img_user?.setImage(withUrl: obj.profileImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
    }
}
// MARK: - NibReusable
extension TicketUserListCell: NibReusable { }

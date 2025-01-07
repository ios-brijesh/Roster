//
//  CommentReplyCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/04/22.
//

import UIKit

class CommentReplyCell: UITableViewCell {
    
    
    @IBOutlet weak var vwSeprateview: UIView?
  
    @IBOutlet weak var imgUser: UIImageView?
    @IBOutlet weak  var lblUsername: UILabel?
    @IBOutlet weak  var lblComment: UILabel?
    @IBOutlet weak  var lblDate: UILabel?
    @IBOutlet   weak var btnReply: UIButton?
    
    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }

   

    override func layoutSubviews() {

    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        if let imgUser = self.imgUser {
            imgUser.cornerRadius = imgUser.frame.height / 2
        }
   

       
        self.vwSeprateview?.backgroundColor = UIColor.CustomColor.reusableTextColor40
  
    }
    
    
    // MARK: - Init Configure
    private func InitConfig() {
    
        [self.lblDate ].forEach({
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
            $0?.textColor = UIColor.CustomColor.sepretorColor
            
        })
        
        [self.lblUsername ].forEach({
            $0?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
            $0?.textColor = UIColor.CustomColor.appColor
            
        })
        
        
        [self.lblComment].forEach({
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
            $0?.textColor = UIColor.CustomColor.blackColor
            
        })
      
        self.btnReply?.setTitleColor(UIColor.CustomColor.sepretorColor, for: .normal)
        self.btnReply?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
    }
    
    func setCommentReplyFeedUserData(obj : FeedUserLikeModel){
        self.imgUser?.setImage(withUrl: obj.profileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
//        self.imgReplyUser?.setImage(withUrl: obj.profileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblUsername?.text = obj.userName
        self.lblDate?.text = obj.createdDate
//        self.lblReplyTime?.text = obj.createdDate
//        self.lblReplyUsername?.text = obj.userName
//        self.lblReplycomment?.text = obj.comment.decodingEmoji()
        self.lblComment?.text = obj.comment.decodingEmoji()
        
    }
}
// MARK: - NibReusable
extension CommentReplyCell: NibReusable { }

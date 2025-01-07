//
//  ChatCell.swift
//  FiveDollarBill
//
//  Created by WMiosdev01 on 06/01/22.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var vwSendingmainview: UIView?
    @IBOutlet weak var vwIncomingmainview: UIView?
    @IBOutlet weak var vwincomingimgmain: UIView?
    @IBOutlet weak var vwsendingimgmain: UIView?
    @IBOutlet weak var vwMainIncomingDocFilesView: UIView!
    @IBOutlet weak var vwMainSendingDocFilesView: UIView!
    @IBOutlet weak var vwSendingStoryMainView: UIView!
    @IBOutlet weak var VwIncomingStoryMainView: UIView!
    @IBOutlet weak var VWExpireStoryView: UIView!
    @IBOutlet weak var vwResumeMainview: UIView?
    @IBOutlet weak var vwIncomingResumeView: UIView?
    @IBOutlet weak var vwSendingResumeView: UIView?
    
    @IBOutlet weak var lblincomingtime: UILabel?
    @IBOutlet weak var lblsendingtime: UILabel?
    @IBOutlet weak var lblincomingimgTime: UILabel!
    @IBOutlet weak var lblSendingimgTime: UILabel!
    @IBOutlet weak var lblincomingdocTime: UILabel!
    @IBOutlet weak var lblSendingdocTime: UILabel!
    @IBOutlet weak var lblSendingDocName: UILabel!
    @IBOutlet weak var lblIncomingDocName: UILabel!
    @IBOutlet weak var lblSendingStoryTime: UILabel!
    @IBOutlet weak var lblIncomingStoryTime: UILabel!
    @IBOutlet weak var vwincomingStoryexpire: UIView!
    @IBOutlet weak var VwSendingStoryExpire: UIView!
    
    
    @IBOutlet weak var imgIncomeUser: UIImageView!
    @IBOutlet weak var imgSenderUser: UIImageView!
    
    @IBOutlet weak var imgSenderDoc: UIImageView!
    @IBOutlet weak var imgincomeDoc: UIImageView!
    
    @IBOutlet weak var imgincomingimg: UIImageView!
    @IBOutlet weak var imgsendingimg: UIImageView!
    @IBOutlet weak var imgincoming: UIImageView?
    @IBOutlet weak var imgsending: UIImageView?
    @IBOutlet weak var imgIncomingUserdoc: UIImageView!
    @IBOutlet weak var imgSendingUserDoc: UIImageView!
    @IBOutlet weak var imgSendingStoryUser: UIImageView!
    @IBOutlet weak var imgIncomingStoryUser: UIImageView!
    @IBOutlet weak var imgIncomingStory: UIImageView!
    @IBOutlet weak var imgSendingStory: UIImageView!
    @IBOutlet weak var imgExpireuser: UIImageView!
    @IBOutlet weak var imgIncomingResumeUser: UIImageView?
    @IBOutlet weak var imgIncomingResume: UIImageView?
    @IBOutlet weak var imgSendingResume: UIImageView?
    @IBOutlet weak var vwIcomingview: UIView?
    @IBOutlet weak var vwSendingview: UIView?
    
    @IBOutlet weak var lblIncomingmsg: UILabel?
    @IBOutlet weak var lblSendingmsg: UILabel?
    @IBOutlet weak var lblIncomingStoryheader: UILabel!
    @IBOutlet weak var lblIncomingStoryDesc: UILabel!
    @IBOutlet weak var lblSendingStoryheader: UILabel!
    @IBOutlet weak var lblSendingStoryDesc: UILabel!
    @IBOutlet weak var lblSendingResumeName: UILabel?
    @IBOutlet weak var lblIncomingResumeName: UILabel?
    @IBOutlet weak var lblSendingResumeRole: UILabel?
    @IBOutlet weak var lblIncomingResumeRole: UILabel?
    
    
    @IBOutlet weak var btnIncomingOpendoc: UIButton!
    @IBOutlet weak var btnSendingOpendoc: UIButton!
    @IBOutlet weak var btnincomingimg: UIButton?
    @IBOutlet weak var btnSendingimg: UIButton?
    @IBOutlet weak var btnSendingStory: UIButton!
    @IBOutlet weak var btnIncomingStory: UIButton!
    @IBOutlet weak var btnIncomingResume: UIButton?
    @IBOutlet weak var btnSendingResume: UIButton?
    // MARK: - Variables
    //    private var wordsLink : [String] = []
    //    var delegate : ChatCellDelegate?
    
    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InitConfig()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        delay(seconds: 0.0) {
            if let vw = self.vwSendingview {
                vw.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 40.0)
            }
            if let vw = self.imgincoming {
                vw.roundCorners(corners: [.bottomRight,.topRight,.bottomLeft], radius: 35.0)
            }
            if let vw = self.imgsending {
                vw.roundCorners(corners: [.topRight,.bottomLeft,.topLeft], radius: 35.0)
            }
            if let vw = self.vwIcomingview {
                vw.roundCorners(corners: [.bottomRight,.topRight,.bottomLeft], radius: 40.0)
            }
            self.imgSendingStory?.cornerRadius = 10.0
            self.imgIncomingStory?.cornerRadius = 10.0
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        [self.imgSendingResume,self.imgIncomingResume,self.imgIncomingResumeUser,self.imgExpireuser,self.imgIncomingStoryUser,self.imgSendingStoryUser,self.imgIncomingUserdoc,self.imgSenderUser,self.imgIncomeUser,self.imgincomingimg,self.imgsendingimg,self.imgSendingUserDoc].forEach({
            $0?.cornerRadius = ($0?.frame.height ?? 0) / 2
        })
    }
    
    // MARK: - Init Configure
    private func InitConfig() {
        
        self.vwIcomingview?.backgroundColor = UIColor.CustomColor.chatbgcolor
        self.vwSendingview?.backgroundColor = UIColor.CustomColor.appColor
        
        self.lblSendingmsg?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblSendingmsg?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblIncomingmsg?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblIncomingmsg?.textColor = UIColor.CustomColor.appColor
        
        [self.lblincomingtime,self.lblsendingtime,self.lblincomingimgTime,self.lblSendingimgTime,self.lblSendingdocTime,self.lblincomingdocTime,self.lblIncomingStoryTime,self.lblSendingStoryTime].forEach({
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
            $0?.textColor = UIColor.CustomColor.followersLabelTextColor
        })
        
        [self.lblIncomingStoryheader,self.lblSendingStoryheader].forEach({
            $0?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
            $0?.textColor = UIColor.CustomColor.blackColor
        })
        
        [self.lblIncomingStoryDesc,self.lblSendingStoryDesc].forEach({
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
            $0?.textColor = UIColor.CustomColor.blackColor
        })
        
        self.lblSendingDocName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblSendingDocName?.textColor = UIColor.CustomColor.blackColor
        
        self.lblIncomingDocName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblIncomingDocName?.textColor = UIColor.CustomColor.blackColor
    }
    
    func setSupportChatData(obj : SupportChatModel){
        if obj.forReply == .user {
            if (supportReplyType.init(rawValue: obj.replyType) ?? .message) == .message {
                self.vwsendingimgmain?.isHidden = true
                self.vwIncomingmainview?.isHidden = true
                self.vwincomingimgmain?.isHidden = true
                self.vwSendingmainview?.isHidden = false
                self.lblSendingmsg?.text = obj.SupportDescription.decodingEmoji()
                self.lblsendingtime?.text = obj.time
                self.imgSenderUser?.setImage(withUrl: obj.thumbSenderImage, placeholderImage: #imageLiteral(resourceName: "ic_Rosterdplaceholder"), indicatorStyle: .medium, isProgressive: true, imageindicator: .gray)
            } else {
                self.vwsendingimgmain?.isHidden = false
                self.vwIncomingmainview?.isHidden = true
                self.vwincomingimgmain?.isHidden = true
                self.vwSendingmainview?.isHidden = true
                self.lblSendingimgTime?.text = obj.time
                
                self.vwsendingimgmain?.isHidden = false
                self.vwincomingimgmain?.isHidden = true
                self.imgsending?.setImage(withUrl: obj.SupportDescription, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                self.lblSendingimgTime?.text = obj.time
                self.imgsendingimg?.setImage(withUrl: obj.thumbSenderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                
            }
        } else {
            if (supportReplyType.init(rawValue: obj.replyType) ?? .message) == .message {
                self.vwsendingimgmain?.isHidden = true
                self.vwIncomingmainview?.isHidden = false
                self.vwincomingimgmain?.isHidden = true
                self.vwSendingmainview?.isHidden = true
                self.lblIncomingmsg?.text = obj.SupportDescription.decodingEmoji()
                self.lblincomingtime?.text = obj.time
                self.imgIncomeUser?.setImage(withUrl: obj.thumbSenderImage, placeholderImage: #imageLiteral(resourceName: "ic_Rosterdplaceholder"), indicatorStyle: .medium, isProgressive: true, imageindicator: .gray)
                
            } else {
                self.vwsendingimgmain?.isHidden = true
                self.vwIncomingmainview?.isHidden = true
                self.vwincomingimgmain?.isHidden = false
                self.vwSendingmainview?.isHidden = true
                
                self.imgincoming?.setImage(withUrl: obj.SupportDescription, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                self.lblincomingimgTime?.text = obj.time
                self.imgincomingimg?.setImage(withUrl: obj.thumbSenderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            }
        }
    }
    
    
    func SetChatMessageData(obj : ChatModel,loginUserId : String){
        if loginUserId == obj.sender {
            self.vwSendingmainview?.isHidden = false
            self.vwIncomingmainview?.isHidden = true
            self.lblSendingmsg?.text = obj.message.decodingEmoji()
            self.lblsendingtime?.text = obj.time
            self.imgSenderUser?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            
        } else {
            self.vwSendingmainview?.isHidden = true
            self.vwIncomingmainview?.isHidden = false
            self.lblIncomingmsg?.text = obj.message.decodingEmoji()
            self.lblincomingtime?.text = obj.time
            self.imgIncomeUser?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
        
        self.vwincomingimgmain?.isHidden = true
        self.vwsendingimgmain?.isHidden = true
        self.vwMainIncomingDocFilesView?.isHidden = true
        self.vwMainSendingDocFilesView?.isHidden = true
        self.vwSendingStoryMainView?.isHidden = true
        self.VwIncomingStoryMainView?.isHidden = true
        self.VWExpireStoryView?.isHidden = true
        self.vwResumeMainview?.isHidden = true
    }
    
    func SetChatImageViewData(obj : ChatModel,loginUserId : String){
        if loginUserId == obj.sender {
            self.vwsendingimgmain?.isHidden = false
            self.vwincomingimgmain?.isHidden = true
            self.imgsending?.setImage(withUrl: obj.message, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.lblSendingimgTime?.text = obj.time
            self.imgsendingimg?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        } else {
            self.vwsendingimgmain?.isHidden = true
            self.vwincomingimgmain?.isHidden = false
            self.imgincoming?.setImage(withUrl: obj.message, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.lblincomingimgTime?.text = obj.time
            self.imgincomingimg?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
        
        self.vwSendingmainview?.isHidden = true
        self.vwIncomingmainview?.isHidden = true
        self.vwMainIncomingDocFilesView?.isHidden = true
        self.vwMainSendingDocFilesView?.isHidden = true
        self.vwSendingStoryMainView?.isHidden = true
        self.VwIncomingStoryMainView?.isHidden = true
        self.VWExpireStoryView?.isHidden = true
        self.vwResumeMainview?.isHidden = true
    }
    
    
    func SetChatFilesData(obj : ChatModel,loginUserId : String){
        if loginUserId == obj.sender {
            self.vwMainSendingDocFilesView?.isHidden = false
            self.vwMainIncomingDocFilesView?.isHidden = true
            self.lblSendingDocName?.text = obj.message
            self.lblSendingdocTime?.text = obj.time
            self.imgSendingUserDoc?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.imgSenderDoc?.setImage(withUrl: obj.fileImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        } else {
            self.vwMainSendingDocFilesView?.isHidden = true
            self.vwMainIncomingDocFilesView?.isHidden = false
            self.lblincomingdocTime?.text = obj.message
            self.imgIncomingUserdoc?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.imgincomeDoc?.setImage(withUrl: obj.fileImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.lblincomingdocTime?.text = obj.time
        }
        
        self.vwincomingimgmain?.isHidden = true
        self.vwsendingimgmain?.isHidden = true
        self.vwSendingmainview?.isHidden = true
        self.vwIncomingmainview?.isHidden = true
        self.vwSendingStoryMainView?.isHidden = true
        self.VwIncomingStoryMainView?.isHidden = true
        self.VWExpireStoryView?.isHidden = true
        self.vwResumeMainview?.isHidden = true
        
    }
    
    func SetChatStorysData(obj : ChatModel,loginUserId : String){
        if  let storyData = obj.storyData {
            if loginUserId == obj.sender {
                self.vwSendingStoryMainView?.isHidden = false
                self.VwIncomingStoryMainView?.isHidden = true
                self.lblSendingDocName?.text = obj.message
                self.lblSendingStoryTime?.text = obj.time
                self.imgSendingStoryUser?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                self.imgSendingStory?.setImage(withUrl: storyData.mediaUrl , placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            } else {
                self.vwSendingStoryMainView?.isHidden = true
                self.VwIncomingStoryMainView?.isHidden = false
                self.lblincomingdocTime?.text = obj.message
                self.imgIncomingStoryUser?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                self.imgIncomingStory?.setImage(withUrl: storyData.mediaUrl , placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                self.lblIncomingStoryTime?.text = obj.time
            }
            
            self.vwincomingimgmain?.isHidden = true
            self.vwsendingimgmain?.isHidden = true
            self.vwSendingmainview?.isHidden = true
            self.vwIncomingmainview?.isHidden = true
            self.vwMainIncomingDocFilesView?.isHidden = true
            self.vwMainSendingDocFilesView?.isHidden = true
            self.VWExpireStoryView?.isHidden = true
            self.vwResumeMainview?.isHidden = true
        }
        else {
            if loginUserId == obj.sender {
                self.VwSendingStoryExpire?.isHidden = false
                self.vwincomingStoryexpire?.isHidden = true
            } else {
                self.VwSendingStoryExpire?.isHidden = true
                self.vwincomingStoryexpire?.isHidden = false
                self.imgExpireuser?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            }
            
            self.vwincomingimgmain?.isHidden = true
            self.vwsendingimgmain?.isHidden = true
            self.vwSendingmainview?.isHidden = true
            self.vwIncomingmainview?.isHidden = true
            self.vwMainIncomingDocFilesView?.isHidden = true
            self.vwMainSendingDocFilesView?.isHidden = true
            self.vwSendingStoryMainView?.isHidden = true
            self.VwIncomingStoryMainView?.isHidden = true
            self.VWExpireStoryView?.isHidden = false
            self.vwResumeMainview?.isHidden = true
        }
    }
    
    func SetChatResumeData(obj : ChatModel,loginUserId : String){
        if loginUserId == obj.sender {
            self.vwSendingResumeView?.isHidden = false
            self.vwIncomingResumeView?.isHidden = true
            self.lblSendingResumeName?.text = obj.resumeUserName
            self.lblSendingResumeRole?.text = obj.resumeUserRoleName
            self.imgSendingResume?.setImage(withUrl: obj.resumeUserImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        } else {
            self.vwSendingResumeView?.isHidden = true
            self.vwIncomingResumeView?.isHidden = false
            self.imgIncomingResumeUser?.setImage(withUrl: obj.senderImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.imgIncomingResume?.setImage(withUrl: obj.resumeUserImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.lblIncomingResumeName?.text = obj.resumeUserName
            self.lblIncomingResumeRole?.text = obj.resumeUserRoleName
        }
        self.vwincomingimgmain?.isHidden = true
        self.vwsendingimgmain?.isHidden = true
        self.vwSendingmainview?.isHidden = true
        self.vwIncomingmainview?.isHidden = true
        self.vwSendingStoryMainView?.isHidden = true
        self.VwIncomingStoryMainView?.isHidden = true
        self.VWExpireStoryView?.isHidden = true
        self.vwMainSendingDocFilesView?.isHidden = true
        self.vwMainIncomingDocFilesView?.isHidden = true
        self.vwResumeMainview?.isHidden = false
    }
}
    // MARK: - NibReusable
    extension ChatCell : NibReusable{}

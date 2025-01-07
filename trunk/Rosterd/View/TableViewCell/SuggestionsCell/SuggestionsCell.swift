//
//  SuggestionsCell.swift
//  Rosterd
//
//  Created by WM-KP on 07/01/22.
//

import UIKit

protocol SuggestionsCelldelegate {
    func btnplusSelect(btn : UIButton,cell : SuggestionsCell)
  
}


class SuggestionsCell: UITableViewCell {

    @IBOutlet weak var imgSuggestion: UIImageView?
    @IBOutlet weak var lblSuggestionName: UILabel?
    @IBOutlet weak var lblSuggestionFollowers: UILabel?
    @IBOutlet weak var btnAddSuggestion: UIButton?
    @IBOutlet weak var btnUnfollow: UIButton?
    @IBOutlet weak var vwMainBG: UIView?
    @IBOutlet weak var vwUnfollow: UIView?
    @IBOutlet weak var vwaddSuggestion: UIView?
    @IBOutlet weak var imgPro: UIImageView?
    
    @IBOutlet weak var lblReddem: UILabel!
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var vwREdemView: UIView!
    
    // MARK: - Variables
    var isAdd : Bool = false
    var isUnfollow : Bool = false
    
    var isSelectPlus : Bool = false {
        didSet{
            self.vwaddSuggestion?.isHidden = isSelectPlus ? true : false
        }
    }
    var delegate : SuggestionsCelldelegate?
    
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let imgSuggestion = self.imgSuggestion {
            imgSuggestion.cornerRadius = imgSuggestion.frame.height / 2
        }
    }
    private func initConfig() {
        self.lblSuggestionName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.lblSuggestionName?.textColor = UIColor.CustomColor.appColor
        
        self.lblSuggestionFollowers?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblSuggestionFollowers?.textColor = UIColor.CustomColor.followersLabelTextColor
        
        self.lblReddem?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 11.0))
        self.lblReddem?.textColor = UIColor.CustomColor.messageColor
        
        self.lblTicket?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 11.0))
        self.lblTicket?.textColor = UIColor.CustomColor.messageColor
        
        self.btnUnfollow?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.btnUnfollow?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        
//        self.vwaddSuggestion?.isHidden = self.isAdd
//        self.vwUnfollow?.isHidden = self.isUnfollow
        
        self.vwMainBG?.setCornerRadius(withBorder: 1, borderColor: UIColor.CustomColor.viewSuggestionBorderColor, cornerRadius: 20)
    }
    
    func setLikeFeedUserData(obj : FeedUserLikeModel){
        self.imgSuggestion?.setImage(withUrl: obj.thumbprofileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblSuggestionName?.text = obj.userName
        self.lblSuggestionFollowers?.text = "\(obj.isFollow) Followers"
        self.vwREdemView?.isHidden = true
        if obj.isFollow == "0" {
            self.btnAddSuggestion?.isSelected = false
        } else if obj.isFollow == "1" {
            self.btnAddSuggestion?.isSelected = true
        } else {
            self.vwUnfollow?.isHidden = true
        }
    }
    
    func setsuggestion(obj : UserModel) {
        self.imgSuggestion?.setImage(withUrl: obj.thumbprofileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblSuggestionName?.text = obj.userName
        self.lblSuggestionFollowers?.text = "\(obj.TotalFollower) Followers"
         self.btnAddSuggestion?.isSelected = obj.isFollow == "1"
        self.vwUnfollow?.isHidden = false
        self.vwREdemView?.isHidden = true
//        self.vwaddSuggestion?.isHidden = false
//        self.vwUnfollow?.isHidden = true
//
    }
    
    func setUserData(obj : UserModel) {
        self.vwREdemView?.isHidden = true
        self.imgSuggestion?.setImage(withUrl: obj.thumbprofileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblSuggestionName?.text = obj.userName
        
    }
    
    func setEventUserData(obj : EventModel) {
        self.imgSuggestion?.setImage(withUrl: obj.thumbprofileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblSuggestionName?.text = obj.userName
        self.lblTicket?.text = "x\(obj.eventTicketBooked) Tickets"
        self.lblReddem?.text = "x\(obj.eventTicketRedeemed) Redeemed"
        self.lblSuggestionFollowers?.text = "\(obj.userFollower) Followers"
        self.vwREdemView?.isHidden = false
    }

   
    @IBAction func btnAddsuggestionClicked(_ sender: UIButton) {
            if let btn = self.btnAddSuggestion {
                self.btnAddSuggestion?.isSelected = !(self.btnAddSuggestion?.isSelected ?? false)
                self.delegate?.btnplusSelect(btn: btn, cell: self)
               
            }
        }
   
}
// MARK: - NibReusable
extension SuggestionsCell: NibReusable { }




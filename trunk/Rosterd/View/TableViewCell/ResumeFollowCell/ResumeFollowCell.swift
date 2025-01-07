//
//  ResumeFollowCell.swift
//  Rosterd
//
//  Created by iMac on 20/04/23.
//

import UIKit

protocol AcademicoDelegate {
    func Value(text : String,cell : ResumeFollowCell)
}

class ResumeFollowCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var btnYes: UIButton?
    @IBOutlet weak var btnNo: UIButton?
    @IBOutlet weak var txtTeamName: UITextField?
    @IBOutlet weak var vwtextView: UIView?
    @IBOutlet weak var vwYes: UIView?
    @IBOutlet weak var vwNo: UIView?
    @IBOutlet weak var vwyesno: UIView?
    // MARK: - Variables
    var delegate : AcademicoDelegate?

    
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
        
        if let imgsending = self.btnNo {
            imgsending.cornerRadius = imgsending.frame.height / 2
        }
                
        if let imgsending = self.btnYes {
            imgsending.cornerRadius = imgsending.frame.height / 2
        }
    }
    
    private func initConfig() {
        
        self.txtTeamName?.delegate = self
        self.vwtextView?.isHidden = true
        
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        self.lblHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        self.txtTeamName?.font = UIFont.PoppinsRegular(ofSize: 12.0)
        self.txtTeamName?.textColor = UIColor.CustomColor.blackColor
        self.txtTeamName?.setPlaceHolderColor(text: self.txtTeamName?.placeholder?.localized() ?? "", color: UIColor.CustomColor.reusablePlaceholderColor)
        self.vwtextView?.backgroundColor = UIColor.white
        self.vwtextView?.cornerRadius = 17.0
        self.vwtextView?.borderColor = UIColor.CustomColor.borderColor4
        self.vwtextView?.borderWidth = 1.0
        
        self.btnYes?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        self.btnNo?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
    }
    
    @IBAction func btnYesClicked(_ sender : UIButton) {
         
    }
    
    @IBAction func btnNoClicked(_ sender : UIButton) {
          
    }
}

    // MARK: - NibReusable
    extension ResumeFollowCell: NibReusable { }

//MARK: - UITextField Delegate Methods
extension ResumeFollowCell : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let del = self.delegate {
            del.Value(text: textField.text ?? "", cell: self)
        }
        return true
    }
  
}

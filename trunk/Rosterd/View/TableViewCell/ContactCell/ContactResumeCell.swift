//
//  ContactResumeCell.swift
//  Rosterd
//
//  Created by iMac on 20/04/23.
//

import UIKit
protocol ContactInfoDelegate {
    func Email(text : String,cell : ContactResumeCell)
    func Address(text : String,cell : ContactResumeCell)
   
}
class ContactResumeCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHederFiled: UILabel?
    @IBOutlet weak var txtFiled: UITextField?
    @IBOutlet weak var vwtxtFiled: UIView?
    @IBOutlet weak var vwMaintxtFiled: UIView?
    
    @IBOutlet weak var vwMaitxtView: UIView?
    @IBOutlet weak var vwtxtView: UIView?
    @IBOutlet weak var lblHederTxtView: UILabel?
    @IBOutlet weak var txtView: UITextView?
    // MARK: - Variables
    var delegate : ContactInfoDelegate?
    // MARK: - LIfe Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func initConfig() {
        
        self.lblHederFiled?.textColor = UIColor.CustomColor.whitecolor
        self.lblHederFiled?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        self.lblHederTxtView?.textColor = UIColor.CustomColor.whitecolor
        self.lblHederTxtView?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        self.vwtxtFiled?.backgroundColor = UIColor.white
        self.vwtxtFiled?.cornerRadius = 17.0
        self.vwtxtFiled?.borderColor = UIColor.CustomColor.borderColor4
        self.vwtxtFiled?.borderWidth = 1.0
        self.txtFiled?.font = UIFont.PoppinsRegular(ofSize: 12.0)
        self.txtFiled?.textColor = UIColor.CustomColor.blackColor
        self.txtFiled?.setPlaceHolderColor(text: self.txtFiled?.placeholder?.localized() ?? "", color: UIColor.CustomColor.reusablePlaceholderColor)
        
        self.vwtxtView?.backgroundColor = UIColor.white
        self.vwtxtView?.cornerRadius = 17.0
        self.vwtxtView?.borderColor = UIColor.CustomColor.borderColor4
        self.vwtxtView?.borderWidth = 1.0
        
        self.txtFiled?.delegate = self
        self.txtView?.delegate = self
    }
}

// MARK: - NibReusable
extension ContactResumeCell: NibReusable { }

//MARK: - UITextField Delegate Methods
extension ContactResumeCell : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let del = self.delegate {
            del.Email(text: textField.text ?? "", cell: self)
        }
        return true
    }
  
}
//MARK: - UITextView Delegate Methods
extension ContactResumeCell : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let del = self.delegate {
            del.Address(text: textView.text ?? "", cell: self)
        }
        return true
    }
  
}

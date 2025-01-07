//
//  ReferencesCell.swift
//  Rosterd
//
//  Created by iMac on 21/04/23.
//

import UIKit

protocol ReferenceDelegate {
    func name(text : String,cell : ReferencesCell)
    func email(text : String,cell : ReferencesCell)
    func phone(text : String,cell : ReferencesCell)
    func academic(text : String,cell : ReferencesCell)
}
class ReferencesCell: UITableViewCell, UITextFieldDelegate {

    // MARK: - IBOutlet
    @IBOutlet var lblHeader : [UILabel]?
    @IBOutlet weak var vwName: UIView!
    @IBOutlet weak var vwPosition: UIView!
    @IBOutlet weak var vwPhonenumber: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var btnDelete: UIButton?
    @IBOutlet weak var txtName: ResumetextView?
    @IBOutlet weak var txtacademic: ResumetextView?
    @IBOutlet weak var txtphone: ResumetextView?
    @IBOutlet weak var txtEmail: ResumetextView?
    // MARK: - Variables
    var delegate : ReferenceDelegate?
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initConfig() {
        self.txtName?.txtInput?.delegate = self
        self.txtphone?.txtInput?.delegate = self
        self.txtacademic?.txtInput?.delegate = self
        self.txtEmail?.txtInput?.delegate = self
        
        
        self.lblHeader?.forEach({
            $0.textColor = UIColor.CustomColor.whitecolor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        })
        
//        [self.vwName,self.vwPosition,self.vwPhonenumber,self.vwEmail].forEach({
//            $0?.backgroundColor = UIColor.white
//            $0?.cornerRadius = 17.0
//            $0?.borderColor = UIColor.CustomColor.borderColor4
//            $0?.borderWidth = 1.0
//        })
    }
}

//MARK: - UITextField Delegate Methods
extension ReferencesCell : UITextViewDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtphone?.txtInput {
            if let del = self.delegate {
                del.phone(text: textField.text ?? "", cell: self)
            }
        }
        else if textField == self.txtacademic?.txtInput {
            if let del = self.delegate {
                del.academic(text: textField.text ?? "", cell: self)
            }
        }
        else if textField == self.txtName?.txtInput {
            if let del = self.delegate {
                del.name(text: textField.text ?? "", cell: self)
            }
        } else if textField == self.txtEmail?.txtInput {
            if let del = self.delegate {
                del.email(text: textField.text ?? "", cell: self)
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      if textField == self.txtphone?.txtInput {
            if textField.keyboardType == .phonePad {
                guard let text = textField.text else { return false }
                let newString = (text as NSString).replacingCharacters(in: range, with: string)
                textField.text = format(with: Masking.kPhoneNumberMasking, phone: newString)
                return false
            }
        }
        return true
    }
}
// MARK: - NibReusable
extension ReferencesCell: NibReusable { }

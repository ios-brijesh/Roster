//
//  TicketCell.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/06/22.
//

import UIKit

protocol TicketDataDelegate {
    func TicketName(text : String,cell : TicketCell)
    func TicketPrize(text : String,cell : TicketCell)
    func TicketSeat(text : String,cell : TicketCell)
}

class TicketCell: UITableViewCell, UITextFieldDelegate {
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var vwMainView: UIView!
    
    @IBOutlet weak var vwTicketName: TextReusableView?
    @IBOutlet weak var vwTicketPrice: TextReusableView?
    @IBOutlet weak var vwTicketSeat: TextReusableView?
    
    @IBOutlet weak var btnCancel: UIButton!
    
    // MARK: - Variables
    
    var delegate : TicketDataDelegate?
    
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
    
    
    override func layoutSubviews() {
        

        self.vwTicketName?.txtInput.backgroundColor = UIColor.CustomColor.whitecolor
        self.vwTicketName?.txtInput.cornerRadius = 17.0
        self.vwTicketSeat?.txtInput.backgroundColor = UIColor.CustomColor.whitecolor
        self.vwTicketSeat?.txtInput.cornerRadius = 17.0
        self.vwTicketPrice?.txtInput.backgroundColor = UIColor.CustomColor.whitecolor
        self.vwTicketPrice?.txtInput.cornerRadius = 17.0
    
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }

    // MARK: - Init Configure Methods
    private func InitConfig(){
        
        
        self.vwMainView?.cornerRadius = 25.0
        self.vwTicketName?.txtInput.autocapitalizationType = .sentences
        self.vwTicketPrice?.txtInput.keyboardType = .decimalPad
        self.vwTicketSeat?.txtInput.keyboardType = .numberPad
        
        self.vwTicketName?.txtInput?.delegate = self
        self.vwTicketPrice?.txtInput?.delegate = self
        self.vwTicketSeat?.txtInput?.delegate = self
        
        
    }
    
}
//MARK: - UITextField Delegate Methods
extension TicketCell : UITextViewDelegate {
    

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.vwTicketName?.txtInput {
            if let del = self.delegate {
                del.TicketName(text: textField.text ?? "", cell: self)
            }
        }
        else if textField == self.vwTicketPrice?.txtInput {
            if let del = self.delegate {
                del.TicketPrize(text: textField.text ?? "", cell: self)
            }
        }
        else if textField == self.vwTicketSeat?.txtInput {
            if let del = self.delegate {
                del.TicketSeat(text: textField.text ?? "", cell: self)
            }
        }
        return true
    }
    
}
// MARK: - NibReusable
extension TicketCell: NibReusable { }

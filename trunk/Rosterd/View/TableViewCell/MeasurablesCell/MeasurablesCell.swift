//
//  MeasurablesCell.swift
//  Rosterd
//
//  Created by iMac on 21/04/23.
//

import UIKit
protocol MeasurableDelegate {
func key(text : String,cell : MeasurablesCell)
func value(text : String,cell : MeasurablesCell)

}

class MeasurablesCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtValue: UITextField!
    
    @IBOutlet weak var vwValue: UIView!
    @IBOutlet weak var vwNAme: UIView!
    // MARK: - Variables
    var delegate : MeasurableDelegate?
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
       
        self.txtName?.delegate = self
        self.txtValue?.delegate = self
        [self.vwNAme,self.vwValue].forEach({
            $0?.backgroundColor = UIColor.white
            $0?.cornerRadius = 17.0
            $0?.borderColor = UIColor.CustomColor.borderColor4
            $0?.borderWidth = 1.0
        })
        
    }
}

//MARK: - UITextField Delegate Methods
extension MeasurablesCell : UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtName {
            if let del = self.delegate {
                del.key(text: textField.text ?? "", cell: self)
                
            }
        }
        else if textField == self.txtValue {
            if let del = self.delegate {
                del.value(text: textField.text ?? "", cell: self)
            }
        }
        return true
    }
}
// MARK: - NibReusable
extension MeasurablesCell: NibReusable { }

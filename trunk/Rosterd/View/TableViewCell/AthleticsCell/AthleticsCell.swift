//
//  AthleticsCell.swift
//  Rosterd
//
//  Created by iMac on 20/04/23.
//

import UIKit

protocol AthlaticDelegate {
    func TeamName(text : String,cell : AthleticsCell)
    func Position(text : String,cell : AthleticsCell)
    func Season(text : String,cell : AthleticsCell)
}

protocol AchievementDelegate {
    func text(text : String,cell : AthleticsCell)
    
}
protocol CurriculersDelegate {
    func textvalue(text : String,cell : AthleticsCell)
    
}

class AthleticsCell: UITableViewCell, UITextFieldDelegate {
    // MARK: - IBOutlet
    @IBOutlet var lblHeader : [UILabel]?
    @IBOutlet weak var txtteamname: ResumetextView?
    @IBOutlet weak var txtLocation: ResumetextView?
    @IBOutlet weak var txtstatReson: ResumetextView?
    @IBOutlet weak var vwMainView: UIView?
    
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var btnDeleteFiled: UIButton?
    @IBOutlet weak var vwMainSeason: UIView?
    @IBOutlet weak var vwMainPosition: UIView?
    @IBOutlet weak var btnCancel: UIButton?
    @IBOutlet weak var vwTeamName: UIView?
    @IBOutlet weak var vwPosition: UIView?
    @IBOutlet weak var vwSeason: UIView?
    // MARK: - Variables
    var delegate : AthlaticDelegate?
    var AchivementDelegate : AchievementDelegate?
    var curriculerDelegate : CurriculersDelegate?
    // MARK: - LIfe Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initConfig() {
        self.txtteamname?.txtInput?.delegate = self
        self.txtLocation?.txtInput?.delegate = self
        self.txtstatReson?.txtInput?.delegate = self
        
        self.lblHeader?.forEach({
            $0.textColor = UIColor.CustomColor.whitecolor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        })
        
        self.lblMain?.textColor = UIColor.CustomColor.whitecolor
        self.lblMain?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        
        [self.vwTeamName].forEach({
            $0?.backgroundColor = UIColor.white
            $0?.cornerRadius = 17.0
            $0?.borderColor = UIColor.CustomColor.borderColor4
            $0?.borderWidth = 1.0
        })
    }
}

//MARK: - UITextField Delegate Methods
extension AthleticsCell : UITextViewDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtteamname?.txtInput {
            if let del = self.delegate {
                del.TeamName(text: textField.text ?? "", cell: self)
                
            } else if let achievementDel =  self.AchivementDelegate {
                achievementDel.text(text: textField.text ?? "", cell: self)
            } else if let CurriculerDel = self.curriculerDelegate {
                CurriculerDel.textvalue(text: textField.text ?? "", cell: self)
            }
        }
        else if textField == self.txtLocation?.txtInput {
            if let del = self.delegate {
                del.Position(text: textField.text ?? "", cell: self)
            }
        }
        else if textField == self.txtstatReson?.txtInput {
            if let del = self.delegate {
                del.Season(text: textField.text ?? "", cell: self)
            }
        }
        return true
    }
}

// MARK: - NibReusable
extension AthleticsCell: NibReusable { }

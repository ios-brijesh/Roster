//
//  TransactionListCell.swift
//  FiveDollarBill
//
//  Created by WM-KP on 30/12/21.
//

import UIKit

class TransactionListCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblTransactionId: UILabel?
    @IBOutlet weak var lblTransactionNumber: UILabel?
    @IBOutlet weak var vwMainImage: UIView?
    @IBOutlet weak var imgTransaction: UIImageView?
    @IBOutlet weak var lblAmount: UILabel?
    @IBOutlet weak var lblIncomeType: UILabel?
    @IBOutlet weak var vwMAinview: UIView!
    
    
    // MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.initConfig()
    }
    
    private func initConfig() {
        
        self.lblDate?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 16.0))
        self.lblDate?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblTransactionId?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        self.lblTransactionId?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblTransactionNumber?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblTransactionNumber?.textColor = UIColor.CustomColor.labelTextColor
     
        self.lblIncomeType?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 13.0))
        self.lblIncomeType?.textColor = UIColor.CustomColor.cardLabelColor
        
        self.lblAmount?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 18.0))
        self.lblAmount?.textColor = UIColor.CustomColor.labelTextColor
        
        
        self.vwMAinview?.backgroundColor = UIColor.CustomColor.chatBackColor2
        self.vwMAinview?.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func setIncomeData(_ incomeData:IncomeModel?) {
//        if let incomeInfo = incomeData {
//            let stIncomeType = incomeInfo.incomeType == "0" ? "Monthly" : incomeInfo.incomeType == "1" ? "Weekly" : incomeInfo.incomeType == "2" ? "Bi-Weekly" : incomeInfo.incomeType == "3" ? "One Time " : ""
//            self.lblIncomeType?.text = stIncomeType
//            self.lblTransactionTitle?.text = incomeInfo.incomeName
//            //self.lblTransactionTitle?.text = incomeInfo.incomeName
//            self.lblAmount?.text = "$\(incomeInfo.incomeAmount)"
//            self.lblDate?.setBillDateTextLabel(firstText: "\(incomeInfo.dateMonth)\n", SecondText:"\(incomeInfo.dateDay)",color1: UIColor.CustomColor.reusableTextColor,color2: UIColor.CustomColor.labelTextColor)
//            
//        }
//    }
    
//    func setExpenseData(_ expenseData:ExpenseModel?) {
//        if let expenseInfo = expenseData {
//            self.lblIncomeType?.text = ""
//            self.lblTransactionTitle?.text = expenseInfo.transactionName
//            self.lblAmount?.text = "$\(expenseInfo.expnsAmount)"
//            self.lblDate?.setBillDateTextLabel(firstText: "\(expenseInfo.dateMonth)\n", SecondText:"\(expenseInfo.dateDay)",color1: UIColor.CustomColor.reusableTextColor,color2: UIColor.CustomColor.labelTextColor)
//            let expenseStaus = ExpenseStatus.init(rawValue: expenseInfo.expnsStatus)
//            self.lblTransactionStatus?.text = expenseStaus?.expenseStatusName
//            self.lblTransactionStatus?.textColor = expenseStaus?.expenseStatusColor
//        }
//    }
    
    func setTransction(obj : TransctionModel) {
        self.lblTransactionNumber?.text = obj.id
        self.lblAmount?.text = "$\(obj.totalAmount)"
    }
}


// MARK: - NibReusable
extension TransactionListCell: NibReusable { }


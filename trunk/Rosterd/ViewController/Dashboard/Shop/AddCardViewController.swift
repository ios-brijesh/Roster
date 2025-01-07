//
//  AddCardViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 03/02/22.
//

import UIKit


protocol addCardDelegate {
    func reloadCard()
}

class AddCardViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwMainVIew: UIView?
    
    @IBOutlet weak var vwScanview: UIView?
    @IBOutlet weak var btnSlide: UIButton?
    @IBOutlet weak var btnScanCard: UIButton?
    @IBOutlet weak var btnSaveCard: AppButton?
    @IBOutlet weak var lblAddPayement: UILabel?
    
    
    @IBOutlet weak var vwnNameoncard: TextReusableView!
    @IBOutlet weak var vwCardnumber: TextReusableView!
    
    @IBOutlet weak var vwExpiryDate: TextReusableView!
    @IBOutlet weak var vwCVV: TextReusableView!
    
    @IBOutlet weak var btnMarkDefault: UIButton?
    @IBOutlet weak var lblDefault: UILabel?
    
    
    
    // MARK: - Variables
    var delegate : addCardDelegate?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.vwMainVIew?.roundCornersTest(corners: [.topLeft,.topRight], radius: 40.0)
    }
    }


// MARK: - Init Configure
extension AddCardViewController {
    private func InitConfig() {
        
        self.lblAddPayement?.textColor = UIColor.CustomColor.blackColor
        self.lblAddPayement?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 18.0))
        
        
        self.lblDefault?.textColor = UIColor.CustomColor.blackColor
        self.lblDefault?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
              
              
        self.btnSlide?.backgroundColor = UIColor.CustomColor.AddcardColor
        self.btnSlide?.cornerRadius = 5.0
         
        self.vwScanview?.borderColor = UIColor.CustomColor.borderColor
        self.vwScanview?.cornerRadius = 20
        self.vwScanview?.borderWidth = 2.0
        
        self.btnScanCard?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btnScanCard?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
                
        vwnNameoncard.txtInput.keyboardType = .default
        self.vwCardnumber?.isFromCardNumber = true
        self.vwExpiryDate?.isFromCardExpire = true
        self.vwCVV?.isFromCardCVV = true
        self.vwCVV?.txtInput.keyboardType = .numberPad
        self.vwCardnumber?.txtInput.keyboardType = .numberPad
        self.vwExpiryDate?.txtInput.keyboardType = .numberPad
        self.vwCVV?.isPassword = true
  }
 
}

//MARK: - IBAction Method
extension AddCardViewController {
    
    
    @IBAction func btnSaveClick() {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage, themeStyle: .warning, presentationStyle: .top)
            return
        }
        self.addNewCardAPI()
       
    }
    
    @IBAction func btnScanCardClick() {
//        self.dismiss(animated: true, completion: nil)
       /* let scannerView = CardScanner.getScanner { name, card, date, cvv in
//            self.resultsLabel.text = "\(card) \(date) \(cvv)"
            self.vwnNameoncard?.txtInput.text = name
            self.vwCardnumber?.txtInput.text = card
            self.vwExpiryDate?.txtInput.text = date
            self.vwCVV?.txtInput.text = cvv
            
        } */
        
        let scannerView = CardScanner.getScanner { card, date, cvv in
//            self.resultsLabel.text = "\(card) \(date) \(cvv)"
            self.vwnNameoncard?.txtInput.text = ""
            self.vwCardnumber?.txtInput.text = card
            self.vwExpiryDate?.txtInput.text = date
            self.vwCVV?.txtInput.text = cvv
            
        }
        present(scannerView, animated: true, completion: nil)
    }
    
    @IBAction func btnDownClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDefaultClick() {
        self.btnMarkDefault?.isSelected = !(self.btnMarkDefault?.isSelected ?? false)
    }

}


// MARK: - API
extension AddCardViewController {
    func validateFields() -> String? {
        if self.vwnNameoncard?.txtInput.isEmpty ?? false{
            self.vwnNameoncard?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.KCardHolderName
        } else if self.vwCardnumber?.txtInput.isEmpty ?? false {
            self.vwCardnumber?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.KCardNumber
        } else if !(self.vwCardnumber?.txtInput.isValidCard() ?? false) {
            self.vwCardnumber?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.KInvalidCardNumber
        } else if self.vwExpiryDate?.txtInput.isEmpty ?? false {
            self.vwExpiryDate?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.KExpiryDate
        } else if !(self.vwExpiryDate?.txtInput.isValidCardExpiryDate() ?? false){
            self.vwExpiryDate?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.KValidExpiryDate
        } else if self.vwCVV?.txtInput.isEmpty ?? false  {
            self.vwCVV?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.KCVV
        } else if !(self.vwCVV?.txtInput.isValidCVV() ?? false) {
            self.vwCVV?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.KInvalidCVV
        }
        return nil
    }
}

// MARK: - API
extension AddCardViewController {
    private func addNewCardAPI(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            var month : String = ""
            var year : String = ""
            let exdate = (self.vwExpiryDate?.txtInput.text ?? "00/0000").components(separatedBy: "/")
            for i in stride(from: 0, to: exdate.count, by: 1) {
                if i == 0 {
                    month = exdate[i]
                }
                if i == 1 {
                    year = exdate[i]
                }
            }
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kholder_name : self.vwnNameoncard?.txtInput.text ?? "",
                knumber : (self.vwCardnumber?.txtInput.text ?? "").replacingOccurrences(of: " ", with: ""),
                kexp_month : month,
                kexp_year : year,
                kcvv : self.vwCVV?.txtInput.text ?? "",
                kisDefault : (self.btnMarkDefault?.isSelected ?? false) ? "1" : "0"
  
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            CardModel.addNewCard(with: param, success: { (msg) in
                self.dismiss(animated: true) {
                    self.delegate?.reloadCard()
                }
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
}

// MARK: - ViewControllerDescribable
extension AddCardViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
return UIStoryboard.Name.Shop
}
}

// MARK: - AppNavigationControllerInteractable
extension AddCardViewController: AppNavigationControllerInteractable { }

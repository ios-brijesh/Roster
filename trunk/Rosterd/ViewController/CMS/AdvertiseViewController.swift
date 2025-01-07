//
//  AdvertiseViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 03/05/22.
//

import UIKit

class AdvertiseViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var vwfirstname: TextReusableView!
    @IBOutlet weak var velastname: TextReusableView!
    @IBOutlet weak var vwphonenumber: TextReusableView!
    @IBOutlet weak var vwemailaddres: TextReusableView!
    @IBOutlet weak var selectcatergory: TextReusableView!
    @IBOutlet weak var vwdetails: ReusableTextview!
    @IBOutlet weak var VwCompanyName: TextReusableView!
    @IBOutlet weak var VwBrand: TextReusableView!
    
    @IBOutlet weak var btnsubmit: AppButton!
    
    // MARK: - Variables
    var delegate : addNewTicketDelegate?
    private var selectedAdvertiseCategory : SupportCategoryModel?
    //    MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
       
        
       
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
       
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        

    }
    }


// MARK: - Init Configure
extension AdvertiseViewController {
    private func InitConfig() {
        
        self.vwphonenumber?.txtInput.keyboardType = .phonePad
        self.vwfirstname?.txtInput.autocapitalizationType = .words
        self.velastname?.txtInput.autocapitalizationType = .words
        self.selectcatergory?.textreusableViewDelegate = self
        self.selectcatergory?.btnSelect.isHidden = false
        
        
       
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Advertise With Us", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}


// MARK: - ReusableView Delegate
extension AdvertiseViewController : TextReusableViewDelegate {
    func buttonClicked(_ sender: UIButton) {
        
        self.appNavigationController?.present(ListcommondataPopupViewController.self,configuration: { (vc) in
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            vc.OpenFromType = .Advertise
            if let obj = self.selectedAdvertiseCategory {
                vc.selectAdvertiseData = obj
            }
        })
    }
    
    func rightButtonClicked(_ sender: UIButton) {
       
    }
    
    func leftButtonClicked(_ sender: UIButton) {
        
    }
    
    
    
}


//MARK: - Validation
extension AdvertiseViewController: ListcommoncataDelegate {
    func selectAdvertiseData(obj: SupportCategoryModel) {
        self.selectedAdvertiseCategory = obj
        self.selectcatergory?.txtInput.text = obj.name
    }
    
    func selectFeedbackData(obj: FeedBackCategoryModel) {
        
    }
    
    func selectsupportData(obj: SupportCategoryModel) {
       
    }
    
    func selectSportsData(arr: [SportsModel]) {
        
    }
    
   
   
   
}

extension AdvertiseViewController {
    
    private func setAdvertiseAPI() {
        
        let phoneData : String = self.vwphonenumber?.txtInput.text?.removeSpecialCharsFromString ?? ""
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token ,
                kfirstName: self.vwfirstname?.txtInput.text ?? "",
                klastName: self.velastname?.txtInput.text ?? "",
                kphone : phoneData,
                kemail : self.vwemailaddres?.txtInput.text ?? "",
                kcompanyname : self.VwCompanyName?.txtInput.text ?? "",
                kcompanytype : self.VwBrand?.txtInput.text ?? "",
                kdescription: self.vwdetails?.txtInput?.text ?? "",
                kcategoryId: self.selectedAdvertiseCategory?.id ?? ""
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.setAdvertiseWithUs(withParam: param) { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.appNavigationController?.popViewController(animated: true)
            } failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                    }
                }
            }
        }
    }
}

extension AdvertiseViewController {
    
    @IBAction func btnOnClickSubmit(_ sender: AppButton) {
        
        self.view.endEditing(true)
        if self.vwfirstname?.txtInput.text?.trimWhiteSpace == "" {
            self.showMessage(AppConstant.ValidationMessages.kFirstName)
        }
        else if self.velastname?.txtInput.text?.trimWhiteSpace == "" {
            self.showMessage(AppConstant.ValidationMessages.kLastName)
        }
        else if self.vwphonenumber?.txtInput?.text == "" {
            self.showMessage(AppConstant.ValidationMessages.kPhoneNumber)
        }
        else if !(self.vwphonenumber?.txtInput.isValidContactPhoneno() ?? false) {
            self.showMessage(AppConstant.ValidationMessages.kInValidPhoneNo)
        }
        else if self.vwemailaddres?.txtInput.text?.trimWhiteSpace == ""{
            self.showMessage(AppConstant.ValidationMessages.kEmptyEmail)
        }
        else if !(self.vwemailaddres?.txtInput.isValidEmail() ?? false){
            self.showMessage(AppConstant.ValidationMessages.kInValidEmail)
        }
        else if self.selectcatergory?.txtInput?.text == "" {
            self.showMessage(AppConstant.ValidationMessages.kEmptyAdvCategory)
        }
        else if self.VwCompanyName?.txtInput.text?.trimWhiteSpace == ""{
            self.showMessage(AppConstant.ValidationMessages.kEmptyCompanyName)
        }
        else if self.VwBrand?.txtInput.text?.trimWhiteSpace == ""{
            self.showMessage(AppConstant.ValidationMessages.kEmptyCompanyType)
        }
        else if self.vwdetails?.txtInput?.text?.trimWhiteSpace == "" {
            self.showMessage(AppConstant.ValidationMessages.kEmptyadvDesc)
        }
        else{
            self.setAdvertiseAPI()
        }
    }
}

// MARK: - ViewControllerDescribable
extension AdvertiseViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.CMS
    }
}

// MARK: - AppNavigationControllerInteractable
extension AdvertiseViewController: AppNavigationControllerInteractable { }
//9725284318

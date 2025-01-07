//
//  CreateTicketViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 05/02/22.
//

import UIKit

protocol addNewTicketDelegate {
    func addnewticket()
}


class CreateTicketViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var btnsubmit: AppButton?
    @IBOutlet weak var vwTickettittle: TextReusableView?
    @IBOutlet weak var vwCategory: TextReusableView?
    @IBOutlet weak var vwDescribeissue: ReusableTextview?
    
    
    // MARK: - Variables
    var delegate : addNewTicketDelegate?
    private var selectedSupportCategory : SupportCategoryModel?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func btnOnClickSubmit(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.vwTickettittle?.txtInput.text?.trimWhiteSpace == "" {
            self.showMessage(AppConstant.ValidationMessages.kEmptyTicketTile)
        }
        else if self.vwCategory?.txtInput?.text == "" {
            self.showMessage(AppConstant.ValidationMessages.kEmptyTicketCategory)
        }
        else if self.vwDescribeissue?.txtInput?.text?.trimWhiteSpace == "" {
            self.showMessage(AppConstant.ValidationMessages.kEmptyTicketDesc)
        }
        else{
            self.setTicketAPI()
        }
    }
    
}


// MARK: - Init Configure
extension CreateTicketViewController {
    private func InitConfig(){
        
        self.vwCategory?.textreusableViewDelegate = self
        self.vwCategory?.btnSelect.isHidden = false
        
     
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Support", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}


// MARK: - ReusableView Delegate
extension CreateTicketViewController : TextReusableViewDelegate {
    func buttonClicked(_ sender: UIButton) {
        
        self.appNavigationController?.present(ListcommondataPopupViewController.self,configuration: { (vc) in
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            vc.OpenFromType = .Support
            if let obj = self.selectedSupportCategory {
                vc.selectsupportData = obj
            }
        })
    }
    
    func rightButtonClicked(_ sender: UIButton) {
       
    }
    
    func leftButtonClicked(_ sender: UIButton) {
        
    }
    
    
    
}

//MARK: - Validation
extension CreateTicketViewController: ListcommoncataDelegate {
    func selectAdvertiseData(obj: SupportCategoryModel) {
        
    }
    
    func selectFeedbackData(obj: FeedBackCategoryModel) {
        
    }
    
    func selectsupportData(obj: SupportCategoryModel) {
        self.selectedSupportCategory = obj
        self.vwCategory?.txtInput.text = obj.name
    }
    
 
    
    func selectSportsData(arr: [SportsModel]) {
        
    }
    
   
   
   
}

extension CreateTicketViewController {
    
    private func setTicketAPI() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token ,
                ktitle: self.vwTickettittle?.txtInput.text ?? "",
                kdescription: self.vwDescribeissue?.txtInput?.text ?? "",
                kticketCategoryId: self.selectedSupportCategory?.id ?? ""
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            SupportChatModel.setTicket(withParam: param) { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.delegate?.addnewticket()
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

// MARK: - ViewControllerDescribable
extension CreateTicketViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Chat
    }
}

// MARK: - AppNavigationControllerInteractable
extension CreateTicketViewController: AppNavigationControllerInteractable{}

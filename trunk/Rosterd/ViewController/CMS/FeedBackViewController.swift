//
//  FeedBackViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 04/02/22.
//

import UIKit



class FeedBackViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwNeedimproveMain: UIView?
    @IBOutlet weak var vwokMain: UIView?
    @IBOutlet weak var vwgoodMain: UIView?
    @IBOutlet weak var vwgreatMain: UIView?
    @IBOutlet weak var vwLoveAppMain: UIView?
    @IBOutlet weak var vwNeedimproveSub: UIView?
    @IBOutlet weak var vwokSub: UIView?
    @IBOutlet weak var vwgoodSub: UIView?
    @IBOutlet weak var vwgreatSub: UIView?
    @IBOutlet weak var vwLoveAppSub: UIView?
    @IBOutlet weak var vwSelecttopic: TextReusableView?
    @IBOutlet weak var vwFeedback: ReusableTextview?
        
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblNeedimprove: UILabel?
    @IBOutlet weak var lblok: UILabel?
    @IBOutlet weak var lblgood: UILabel?
    @IBOutlet weak var lblgreat: UILabel?
    @IBOutlet weak var lblLoveApp: UILabel?
    
    @IBOutlet weak var btnRateus: UIButton?
    @IBOutlet weak var btnneedimprove: UIButton?
    @IBOutlet weak var btnok: UIButton?
    @IBOutlet weak var btngood: UIButton?
    @IBOutlet weak var btngreat: UIButton?
    @IBOutlet weak var btnLoveApp: UIButton?
   
    @IBOutlet weak var btnSubmit: AppButton?
    
    @IBOutlet weak var txtFeedback: UITextView?
    
    // MARK: - Variables
    var isSelectNeedimprove : Bool = false {
        didSet{
            self.vwNeedimproveSub?.backgroundColor = isSelectNeedimprove ? UIColor.CustomColor.appColor : UIColor.clear
        }
    }
    var isSelectok : Bool = false {
        didSet{
            self.vwokSub?.backgroundColor = isSelectok ? UIColor.CustomColor.appColor : UIColor.clear
        }
    }
    var isSelectgood : Bool = false {
        didSet{
            self.vwgoodSub?.backgroundColor = isSelectgood ? UIColor.CustomColor.appColor : UIColor.clear
        }
    }
    var isSelectgreat : Bool = false {
        didSet{
            self.vwgreatSub?.backgroundColor = isSelectgreat ? UIColor.CustomColor.appColor : UIColor.clear
        }
    }
    var isSelectLoveApp : Bool = false {
        didSet{
            self.vwLoveAppSub?.backgroundColor = isSelectLoveApp ? UIColor.CustomColor.appColor : UIColor.clear
        }
    }
    private var selectedRating : String = ""
    private var selectedFeedbackCatergory : FeedBackCategoryModel?
    //MARK: - Life Cycle Methods
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
extension FeedBackViewController {
    private func InitConfig(){
        
        [self.lblNeedimprove,self.lblLoveApp,self.lblok
         ,self.lblgood,self.lblgreat].forEach({
            $0?.textColor = UIColor.CustomColor.blackColor
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 9.0))
        })
        
        self.lblHeader?.textColor = UIColor.CustomColor.blackColor
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        
        [self.vwNeedimproveMain,self.vwLoveAppMain,self.vwokMain,self.vwgoodMain,self.vwgreatMain].forEach({
            $0?.borderColor = UIColor.CustomColor.feedbackcolor
            $0?.borderWidth = 2.0
        })
        
        [self.vwNeedimproveSub,self.vwLoveAppSub,self.vwokSub,self.vwgoodSub,self.vwgreatSub].forEach({
            $0?.backgroundColor = UIColor.CustomColor.appColor.withAlphaComponent(0.4)
        })
       
        self.vwSelecttopic?.textreusableViewDelegate = self
        self.vwSelecttopic?.btnSelect.isHidden = false
        
        
        self.txtFeedback?.placeholder = "How are we doing"
        self.txtFeedback?.placeholderColor = UIColor.CustomColor.writeSomethingBGColor
        self.txtFeedback?.textColor = UIColor.CustomColor.blackColor
        self.txtFeedback?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.txtFeedback?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        self.txtFeedback?.cornerRadius = 15
        self.txtFeedback?.borderWidth = 2.0
        self.txtFeedback?.borderColor = UIColor.CustomColor.borderColor4
        self.txtFeedback?.delegate = self
        
        self.isSelectNeedimprove = false
        self.isSelectok = false
        self.isSelectgood = true
        self.isSelectgreat = false
        self.isSelectLoveApp = false
        
        delay(seconds: 0.2) {
            [self.vwNeedimproveMain,self.vwLoveAppMain,self.vwokMain,self.vwgoodMain,self.vwgreatMain,self.vwNeedimproveSub,self.vwLoveAppSub,self.vwokSub,self.vwgoodSub,self.vwgreatSub].forEach({
                $0?.cornerRadius = ($0?.frame.height ?? 1.0) / 2
            })
        }
//        1642025428
        
        self.getFeedbackAPI()
    }
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Feedback", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

// MARK: - ReusableView Delegate
extension FeedBackViewController : TextReusableViewDelegate {
    func buttonClicked(_ sender: UIButton) {
        
        self.appNavigationController?.present(ListcommondataPopupViewController.self,configuration: { (vc) in
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            vc.OpenFromType = .Feedback
            if let obj = self.selectedFeedbackCatergory {
                vc.selectFeedbackData = obj
            }
        })
    }
    
    func rightButtonClicked(_ sender: UIButton) {
       
    }
    
    func leftButtonClicked(_ sender: UIButton) {
        
    }
    
    
    
}

//MARK: - Validation
extension FeedBackViewController: ListcommoncataDelegate {
    func selectAdvertiseData(obj: SupportCategoryModel) {
        
    }
    
    func selectsupportData(obj: SupportCategoryModel) {
        
    }
    
    func selectFeedbackData(obj: FeedBackCategoryModel) {
        self.selectedFeedbackCatergory = obj
        self.vwSelecttopic?.txtInput.text = obj.name
    }
    
    func selectSportsData(arr: [SportsModel]) {
        
    }
}

// MARK: - IBAction
extension FeedBackViewController {
    @IBAction func btnNeedimproveClicked(_ sender: UIButton) {
        self.isSelectNeedimprove = true
        self.isSelectok = false
        self.isSelectgood = false
        self.isSelectgreat = false
        self.isSelectLoveApp = false
        self.selectedRating = "1"
    }
    @IBAction func btnokClicked(_ sender: UIButton) {
        self.isSelectNeedimprove = false
        self.isSelectok = true
        self.isSelectgood = false
        self.isSelectgreat = false
        self.isSelectLoveApp = false
        self.selectedRating = "2"
    }
    @IBAction func btnGoodClicked(_ sender: UIButton) {
        self.isSelectNeedimprove = false
        self.isSelectok = false
        self.isSelectgood = true
        self.isSelectgreat = false
        self.isSelectLoveApp = false
        self.selectedRating = "3"
    }
    @IBAction func btnGreatClicked(_ sender: UIButton) {
        self.isSelectNeedimprove = false
        self.isSelectok = false
        self.isSelectgood = false
        self.isSelectgreat = true
        self.isSelectLoveApp = false
        self.selectedRating = "4"
    }
    @IBAction func btnLoveAppClicked(_ sender: UIButton) {
        self.isSelectNeedimprove = false
        self.isSelectok = false
        self.isSelectgood = false
        self.isSelectgreat = false
        self.isSelectLoveApp = true
        self.selectedRating = "5"
    }
 
    @IBAction func btnSubmitClicked(_ sender: AppButton) {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
            return
        }
        self.setFeedbackAPI()
    }
    
    @IBAction func btnRateonAppstoreClicked(_ sender : UIButton) {
        self.openLink(str: "https://itunes.apple.com/app/id\(1642025428)?action=write-review")
    }
   
    private func openLink(str : String) {
        guard let urldata = URL(string: str) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urldata, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(urldata)
        }
    }
}

//1642025428
//MARK: - Validation
extension FeedBackViewController {
    private func validateFields() -> String? {
         if self.vwFeedback?.txtInput?.isEmpty ?? false {
            self.vwFeedback?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kFeedbackdesc
      
        } else {
            return nil
        }
    }
}
// MARK: - API Call
extension FeedBackViewController{
    
    private func setFeedbackAPI() {
        if let user = UserModel.getCurrentUserFromDefault(){
//            , let feedback = selectedFeedbackCatergory
            self.view.endEditing(true)
            if self.selectedRating.isEmpty {
                self.showMessage(AppConstant.ValidationMessages.kEmptyFeedback, themeStyle: .warning)
                return
            }
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kfeedback : self.vwFeedback?.txtInput?.text ?? "",
                krating: self.selectedRating
//                kfeedbackCategoryId : feedback.id
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedbackModel.setAppFeedback(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.navigationController?.popViewController(animated: true)

            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func getFeedbackAPI() {
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FeedbackModel.getAppFeedback(with: param, success: { (model, message) in
                
                self.vwFeedback?.txtInput?.text = model.feedback
                self.vwSelecttopic?.txtInput?.text = model.feedBackCategory
//                self.selectedFeedbackCatergory = FeedBackCategoryModel.init(id: model.feedbackCategoryId, createdDate: "", name :model.feedBackCategory, status : "", updatedDate : "")
 
                self.selectedRating = model.rating
                if model.rating == "1" {
                    self.isSelectNeedimprove = true
                    self.isSelectok = false
                    self.isSelectgood = false
                    self.isSelectgreat = false
                    self.isSelectLoveApp = false
                } else if model.rating == "2" {
                    self.isSelectNeedimprove = false
                    self.isSelectok = true
                    self.isSelectgood = false
                    self.isSelectgreat = false
                    self.isSelectLoveApp = false
                } else if model.rating == "3" {
                    self.isSelectNeedimprove = false
                    self.isSelectok = false
                    self.isSelectgood = true
                    self.isSelectgreat = false
                    self.isSelectLoveApp = false
                } else if model.rating == "4" {
                    self.isSelectNeedimprove = false
                    self.isSelectok = false
                    self.isSelectgood = false
                    self.isSelectgreat = true
                    self.isSelectLoveApp = false
                } else if model.rating == "5" {
                    self.isSelectNeedimprove = false
                    self.isSelectok = false
                    self.isSelectgood = false
                    self.isSelectgreat = false
                    self.isSelectLoveApp = true
                }
                
            }, failure: {(statuscode,error, errorType) in
                print(error)
            })
        }
    }
}

//MARK: - UITextView Delegate
extension FeedBackViewController: UITextViewDelegate {


    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count

        if numberOfChars <= 300 {
            return true
        }
        else{
            return false
        }
    }
}

// MARK: - ViewControllerDescribable
extension FeedBackViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.CMS
    }
}

// MARK: - AppNavigationControllerInteractable
extension FeedBackViewController: AppNavigationControllerInteractable { }

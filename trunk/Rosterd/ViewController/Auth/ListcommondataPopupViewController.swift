//
//  ListcommondataPopupViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 18/05/22.
//




import UIKit

protocol ListcommoncataDelegate {
    func selectFeedbackData(obj : FeedBackCategoryModel)
//    func selectCertificateTypeData(obj : licenceTypeModel,selectIndex : Int)
    func selectSportsData(arr : [SportsModel])
    func selectsupportData(obj : SupportCategoryModel)
    func selectAdvertiseData(obj : SupportCategoryModel)
//    func selectWorkMethodTransportationData(obj : WorkMethodOfTransportationModel)
//    func selectDisabilitiesData(obj : [WorkDisabilitiesWillingTypeModel])
//    func selectAdditionalQuestionData(obj : [AdditionalQuestionModel],isFromModifyQuestion : Bool)
//    func selectSubstituteCaregiverData(obj : CaregiverListModel)
}

enum CommonEnumFromType {
    case Feedback
//    case CertificateLicence
    case SportsData
    case Support
    case Advertise
//    case WorkMethodTransportation
//    case Disabilities
//    case AdditionalQuestion
//    case SubstituteJob
}

class ListcommondataPopupViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblNoData: NoDataFoundLabel?

    @IBOutlet weak var vwSub: UIView?
    @IBOutlet weak var vwDataMain: UIView?
    @IBOutlet weak var vwSubBottom: UIView?
    @IBOutlet weak var tblData: UITableView?

    @IBOutlet weak var btnSubmit: AppButton?
    @IBOutlet weak var btnClose: UIButton?
    @IBOutlet weak var btnCloseTouch: UIButton?

    @IBOutlet weak var vwSearch: SearchView?

    // MARK: - Variables
    var arrSelectedSports : [String] = []
    var delegate : ListcommoncataDelegate?
    private var arrFeedback : [FeedBackCategoryModel] = []
    var selectFeedbackData : FeedBackCategoryModel?
    
    private var arrSupport : [SupportCategoryModel] = []
    var selectsupportData : SupportCategoryModel?
    
    private var arrAdvertiseCategory : [SupportCategoryModel] = []
    var selectAdvertiseData : SupportCategoryModel?
//
//    private var arCertificateTypeData : [licenceTypeModel] = []
//    var selectedCertificateTypeData : licenceTypeModel?
//    var selectedCertificateTypeIndex : Int = 0

    private var arrSportsData : [SportsModel] = []
    var SelectedSportsData : SportsModel?

//    private var arrInsuranceTypeData : [InsuranceTypeModel] = []
//    var selectedInsuranceTypeData : InsuranceTypeModel?
//
//    private var arrWorkMethodTransportationData : [WorkMethodOfTransportationModel] = []
//    var selectedWorkMethodTransportationData : WorkMethodOfTransportationModel?
//
//    private var arrDisabilitiesData : [WorkDisabilitiesWillingTypeModel] = []
//    var selectedDisabilitiesData : [WorkDisabilitiesWillingTypeModel] = []
//
    var OpenFromType : CommonEnumFromType = .SportsData
//    var isFromModifyAdditionalQuestionJob : Bool = false
//
//    private var selectedSubstituteCargiver : CaregiverListModel?
//
//    var arrAddiotinalQuestion : [AdditionalQuestionModel] = []
//
//    private var arrCaregiver : [CaregiverListModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false

    private var isSearchAPICall : Bool = false
    private var isSearchClick : Bool = false

    var isFromChatDetailCaregiverShare : Bool = false

    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.vwSub?.clipsToBounds = true
        self.vwSub?.shadow(UIColor.CustomColor.shadowColorBlack, radius: 5.0, offset: CGSize(width: 0, height: 0), opacity: 1)
        self.vwSub?.maskToBounds = false
        
        
        if let btn = self.btnClose {
            btn.cornerRadius = btn.frame.height / 2.0
        }
    }
}

// MARK: - Init Configure
extension ListcommondataPopupViewController {
    private func InitConfig(){

        self.lblHeader?.textColor = UIColor.CustomColor.TextColor
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))

        self.tblData?.register(CommonListCell.self)
//        self.tblData?.register(FeedLikeCell.self)
//        self.tblData?.register(AdditionalQuestionsCell.self)
        self.tblData?.estimatedRowHeight = 60.0
        self.tblData?.rowHeight = UITableView.automaticDimension
        self.tblData?.delegate = self
        self.tblData?.dataSource = self

        //delay(seconds: 0.2) {
        self.vwSub?.roundCornersTest(corners: [.topLeft,.topRight], radius: 40.0)
//        //}
//        self.vwSub?.backgroundColor = UIColor.CustomColor.tutorialBGColor
//        self.vwSubBottom?.backgroundColor = UIColor.CustomColor.tutorialBGColor

        switch self.OpenFromType {
        case .SportsData:
            self.lblHeader?.text = "Select Sports"
            self.getCommonDataAPICall()

        case .Feedback:
            self.lblHeader?.text = "Select Feedback Category"
            self.getFeedbackCategoryApi()
        case .Support:
            self.lblHeader?.text = "Select Support Category"
            self.getTicketCategory()
        case .Advertise:
            self.lblHeader?.text = "Select Advertise Category"
            self.getCategoryList()
        }

    }
}



//MARK:- UITableView Delegate
extension ListcommondataPopupViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.OpenFromType {
        case .SportsData:
            return self.arrSportsData.count
//
        case .Feedback:
            return self.arrFeedback.count
        case .Support:
            return self.arrSupport.count
        case .Advertise:
            return self.arrAdvertiseCategory.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: CommonListCell.self)
        switch self.OpenFromType {
//
        case .SportsData:
            if self.arrSportsData.count > 0 {
//                let obj = self.arrSportsData[indexPath.row]
//                cell.lblName?.text = obj.name
//                if let data = self.SelectedSportsData {
//                    cell.btnSelect?.isSelected = (data.id == obj.id)
//                } else {
//                    cell.btnSelect?.isSelected = false
//                }
                cell.setSportsData(obj: self.arrSportsData[indexPath.row])

                cell.btnSelectMain?.tag = indexPath.row
                cell.btnSelectMain?.addTarget(self, action: #selector(self.btnSelectSportsClicked(_:)), for: .touchUpInside)
            }
            return cell
//
        case .Feedback:
            if self.arrFeedback.count > 0 {
                let obj = self.arrFeedback[indexPath.row]
                cell.lblName?.text = obj.name
                if let data = self.selectFeedbackData {
                    cell.btnSelect?.isSelected = (data.id == obj.id)
                } else {
                    cell.btnSelect?.isSelected = false
                }
                
                cell.btnSelectMain?.tag = indexPath.row
                cell.btnSelectMain?.addTarget(self, action: #selector(self.btnSelectFeedbackClicked(_:)), for: .touchUpInside)
            }
            return cell
        case .Support:
            if self.arrSupport.count > 0 {
                let obj = self.arrSupport[indexPath.row]
                cell.lblName?.text = obj.name
                if let data = self.selectsupportData {
                    cell.btnSelect?.isSelected = (data.id == obj.id)
                } else {
                    cell.btnSelect?.isSelected = false
                }
                
                cell.btnSelectMain?.tag = indexPath.row
                cell.btnSelectMain?.addTarget(self, action: #selector(self.btnSelectSupportClicked(_:)), for: .touchUpInside)
            }
            return cell
        case .Advertise:
            if self.arrAdvertiseCategory.count > 0 {
                let obj = self.arrAdvertiseCategory[indexPath.row]
                cell.lblName?.text = obj.id
                if let data = self.selectAdvertiseData {
                    cell.btnSelect?.isSelected = (data.id == obj.id)
                } else {
                    cell.btnSelect?.isSelected = false
                }
                
                cell.btnSelectMain?.tag = indexPath.row
                cell.btnSelectMain?.addTarget(self, action: #selector(self.btnSelectadvertiseClicked(_:)), for: .touchUpInside)
            }
            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

//

    @objc func btnSelectSportsClicked(_ btn : UIButton){
        if self.arrSportsData.count > 0 {
            let obj = self.arrSportsData[btn.tag]
//            self.SelectedSportsData = obj
            obj.isSelect = !obj.isSelect
            self.tblData?.reloadData()
        }
    }
    @objc func btnSelectFeedbackClicked(_ btn : UIButton){
        if self.arrFeedback.count > 0 {
            let obj = self.arrFeedback[btn.tag]
            self.selectFeedbackData = obj
            self.tblData?.reloadData()
        }
    }
    @objc func btnSelectSupportClicked(_ btn : UIButton){
        if self.arrSupport.count > 0 {
            let obj = self.arrSupport[btn.tag]
            self.selectsupportData = obj
            self.tblData?.reloadData()
        }
    }
    
    @objc func btnSelectadvertiseClicked(_ btn : UIButton){
        if self.arrAdvertiseCategory.count > 0 {
            let obj = self.arrAdvertiseCategory[btn.tag]
            self.selectAdvertiseData = obj
            self.tblData?.reloadData()
        }
    }
}
// MARK: - IBAction
extension ListcommondataPopupViewController {
    @IBAction func btnSubmitClicked(_ sender: UIButton) {

        switch self.OpenFromType {
//
        case .SportsData:
            let filter = self.arrSportsData.filter({$0.isSelect})
            if filter.isEmpty {
                self.showMessage(AppConstant.ValidationMessages.kEmptySportsSelect,themeStyle: .warning)
                return
            } else {
                self.delegate?.selectSportsData(arr: filter)
                self.dismiss(animated: true)
//                self.appNavigationController?.popViewController(animated: true)
            }
//            if let data = self.SelectedSportsData {
//                self.dismiss(animated: true) {
//                    self.delegate?.selectSportsData(arr: [data])
//                }
//            }

        case .Feedback:
            if let data = self.selectFeedbackData {
                self.dismiss(animated: true) {
                    self.delegate?.selectFeedbackData(obj: data)
                }
            }
            
        case .Support:
            if let data = self.selectsupportData {
                self.dismiss(animated: true) {
                    self.delegate?.selectsupportData(obj: data)
                }
            }
        case .Advertise:
            if let data = self.selectAdvertiseData {
                self.dismiss(animated: true) {
                    self.delegate?.selectAdvertiseData(obj: data)
                }
            }
        }
    }
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension ListcommondataPopupViewController {
    private func getCommonDataAPICall() {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]

        let param : [String:Any] = [
            kData : dict
        ]

        CommonModel.getCommonData(with: param, success: { (arrSportsData,message) in
            switch self.OpenFromType {
            case .SportsData:
                self.arrSportsData = arrSportsData
                
                for i in stride(from: 0, to: self.arrSportsData.count, by: 1) {
                    let obj = self.arrSportsData[i]
                    if self.arrSelectedSports.contains(obj.name) {
                        obj.isSelect = true
                    }
                    if i == self.arrSportsData.count - 1 {
                        self.tblData?.reloadData()
                    }
                }
//            case .CertificateLicence:
//                self.arCertificateTypeData = arrlicenceType
//            case .WorkSpeciality:
//                self.arrWorkSpecialityData = arrWorkSpeciality
//            case .InsuranceType:
//                self.arrInsuranceTypeData = arrInsuranceType
//            case .WorkMethodTransportation:
//                self.arrWorkMethodTransportationData = arrWorkMethodOfTransportation
//            case .Disabilities:
//                self.arrDisabilitiesData = arrWorkDisabilitiesWillingType
//                //let selctedDisabilityId : [String] = self.selectedDisabilitiesData.map({$0.workDisabilitiesWillingTypeId})
//                for i in stride(from: 0, to: self.arrDisabilitiesData.count, by: 1) {
//                    let obj = self.arrDisabilitiesData[i]
//                    if self.selectedDisabilitiesData.contains(where: {obj.workDisabilitiesWillingTypeId == $0.workDisabilitiesWillingTypeId}) {
//                        obj.isSelectDisabilitiesWilling = true
//                    }
//                }
//            case .AdditionalQuestion:
//                break
//            case .SubstituteJob:
//                break
            case .Feedback:
                break
            case .Support:
                break
            case .Advertise:
                break
            }
//            self.tblData?.reloadData()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    
    private func getFeedbackCategoryApi() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            FeedBackCategoryModel.getFeedbackCatergory(with: param, success: { (arr,msg) in
                self.arrFeedback = arr
                self.tblData?.reloadData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error,themeStyle : .error)
                }
            })
        }
    }
    
    private func getTicketCategory() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            SupportCategoryModel.getTicketCategory(with: param, success: { (arr,msg) in
                self.arrSupport = arr
                self.tblData?.reloadData()
               
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error,themeStyle : .error)
                }
            })
        }
    }
    
    private func getCategoryList() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            SupportCategoryModel.getCategoryList(with: param, success: { (arr,msg) in
                self.arrAdvertiseCategory = arr
                self.tblData?.reloadData()
               
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error,themeStyle : .error)
                }
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension ListcommondataPopupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension ListcommondataPopupViewController: AppNavigationControllerInteractable { }

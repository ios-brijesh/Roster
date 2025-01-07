//
//  ResumeDetailViewController.swift
//  Rosterd
//
//  Created by iMac on 20/04/23.
//

import UIKit

enum AcademicEnum : Int {
    
    case teamName
    case School
    case GPA
    case ACT
    case SAT
    
    var HeaderName : String {
        switch self {
        case .teamName:
            return "What is your school name?"
        case .School:
            return "What is the address of your school?"
        case .GPA :
            return "What is your current GPA?"
        case .ACT :
            return "What is your ACT score?"
        case .SAT :
            return "What is your SAT score?"
        }
    }
    
    var HeaderPlace : String {
        switch self {
        case .teamName:
            return "Team name"
        case .School:
            return "Address"
        case .GPA :
            return "GPA"
        case .ACT :
            return "ACT score"
        case .SAT :
            return "SAT score"
        }
    }
}

class ResumeDetailViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var ConstraintReferences: NSLayoutConstraint!
    @IBOutlet weak var ConstraintCurricular: NSLayoutConstraint?
    @IBOutlet weak var tblreferences: UITableView!
    @IBOutlet weak var tblCurricular: UITableView?
    @IBOutlet weak var constrainttblAchievement: NSLayoutConstraint?
    @IBOutlet weak var tblAchievement: UITableView?
    @IBOutlet weak var ConstrainttblAthletics: NSLayoutConstraint?
    @IBOutlet weak var tblAthletics: UITableView?
    @IBOutlet weak var tblContact: UITableView?
    @IBOutlet weak var ConstainttblContact: NSLayoutConstraint?
    @IBOutlet weak var tblAcademics: UITableView?
    @IBOutlet weak var ConstainttblAcademics: NSLayoutConstraint?
    @IBOutlet weak var lblHEader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var lblCount: UILabel?
    @IBOutlet weak var cvStatus: UICollectionView?
    @IBOutlet weak var tblMeasure: UITableView!
    @IBOutlet weak var ConstrainttblMeasure: NSLayoutConstraint!
    
    @IBOutlet weak var vwMainmeasure: UIView!
    @IBOutlet weak var vwMainReference: UIView!
    @IBOutlet weak var vwMainCurricular: UIView!
    @IBOutlet weak var vwMainFollow: UIView!
    @IBOutlet weak var vwMainContact: UIView!
    @IBOutlet weak var vwMainAcdemic: UIView!
    @IBOutlet weak var vwMainathlics: UIView!
    @IBOutlet weak var vwMainAchievement: UIView!
    
    @IBOutlet weak var btnmeasure: UIButton!
    @IBOutlet weak var btnReference: UIButton?
    @IBOutlet weak var btnCurricular: UIButton?
    @IBOutlet weak var btnAchievement: UIButton?
    @IBOutlet weak var btnAthlicAdd: UIButton?
    
    @IBOutlet var FollowHeader : [UILabel]?
    
    @IBOutlet weak var txtTwitter : UITextField?
    @IBOutlet weak var btnTwitterYes : UIButton?
    @IBOutlet weak var btnTwitterNo : UIButton?
    @IBOutlet weak var vwtxtTwitterView : UIView?
    
    @IBOutlet weak var txtInsta : UITextField?
    @IBOutlet weak var btnInstaYes : UIButton?
    @IBOutlet weak var btnInstaNo : UIButton?
    @IBOutlet weak var vwtxtinstaView : UIView?
    
    @IBOutlet weak var txtfb : UITextField?
    @IBOutlet weak var btnfbYes : UIButton?
    @IBOutlet weak var btnfbNo : UIButton?
    @IBOutlet weak var vwtxtfbView : UIView?
    
    @IBOutlet weak var txtlinked : UITextField?
    @IBOutlet weak var bvtnlinkYes : UIButton?
    @IBOutlet weak var btnLinkNo : UIButton?
    @IBOutlet weak var vwtxtLinkView : UIView?
    // MARK: - Variables
    var GetResume : ResumeModel?
    var Phonenumber : String = ""
    var Email : String = ""
    var Address : String = ""
    var schoolName : String = ""
    var schoolAddress : String = ""
    var gpa : String = ""
    var actScore : String = ""
    var satScore : String = ""
    private var arrAcademic : [AcademicEnum] = [.teamName,.School,.GPA,.ACT,.SAT]
    private var arrAthlics : [AthlicsModel] = []
    private var arrAchievement : [AchievementsModel] = []
    private var arrCurricular : [CurricularsModel] = []
    private var arrReference : [ReferenceModel] = []
    private var arrMeasure : [MeasureModel] = []
    var isFromYes: Bool = false
    var isFromNo: Bool = false
    private var selectedNext : Int = 0
    var counter = 0
    var academicEnum : AcademicEnum = .teamName
    var isSelectTwitterYes : Bool = false {
        didSet{
            if let vw = self.btnTwitterYes {
                vw.borderWidth = isSelectTwitterYes ? 2.0 : 0.0
                vw.backgroundColor = isSelectTwitterYes ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectTwitterYes ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectTwitterYes ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
            }
        }
    }
    var isSelectInstaYes : Bool = false {
        didSet{
            if let vw = self.btnInstaYes {
                vw.borderWidth = isSelectInstaYes ? 2.0 : 0.0
                vw.backgroundColor = isSelectInstaYes ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectInstaYes ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectInstaYes ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
            }
        }
    }
    var isSelectfbYes : Bool = false {
        didSet{
            if let vw = self.btnfbYes {
                vw.borderWidth = isSelectfbYes ? 2.0 : 0.0
                vw.backgroundColor = isSelectfbYes ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectfbYes ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectfbYes ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
               
                
            }
        }
    }
    var isSelectlinkYes : Bool = false {
        didSet{
            if let vw = self.bvtnlinkYes {
                vw.borderWidth = isSelectlinkYes ? 2.0 : 0.0
                vw.backgroundColor = isSelectlinkYes ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectlinkYes ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectlinkYes ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
               
                
            }
        }
    }
    var isSelectTwitterNo: Bool = false {
        didSet{
            if let vw = self.btnTwitterNo {
                vw.borderWidth = isSelectTwitterNo ? 2.0 : 0.0
                vw.backgroundColor = isSelectTwitterNo ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectTwitterNo ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectTwitterNo ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
               
                
            }
        }
    }
    var isSelectInstaNo: Bool = false {
        didSet{
            if let vw = self.btnInstaNo {
                vw.borderWidth = isSelectInstaNo ? 2.0 : 0.0
                vw.backgroundColor = isSelectInstaNo ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectInstaNo ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectInstaNo ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
            }
        }
    }
    var isSelectfbNo: Bool = false {
        didSet{
            if let vw = self.btnfbNo {
                vw.borderWidth = isSelectfbNo ? 2.0 : 0.0
                vw.backgroundColor = isSelectfbNo ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectfbNo ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectfbNo ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
               
                
            }
        }
    }
    var isSelectLinkNo: Bool = false {
        didSet{
            if let vw = self.btnLinkNo {
                vw.borderWidth = isSelectLinkNo ? 2.0 : 0.0
                vw.backgroundColor = isSelectLinkNo ? GradientColor(gradientStyle: .topToBottom, frame: vw.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo]) : UIColor.CustomColor.whitecolor50
                vw.borderColor = isSelectLinkNo ? UIColor.CustomColor.YesBorderColor : .clear
                vw.setTitleColor(isSelectLinkNo ? UIColor.white : UIColor.CustomColor.viewAllColor, for: .normal)
               
                
            }
        }
    }
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableviewOberver()
        self.getUserResume()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
       
    }
}
// MARK: - Init Configure
extension ResumeDetailViewController {
    
    private func InitConfig(){
        self.view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.dateGradiantColorTwo])
        
        self.lblHEader?.textColor = UIColor.CustomColor.whitecolor
        self.lblHEader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 36.0))
        
        self.lblSubHeader?.textColor = UIColor.CustomColor.whitecolor
        self.lblSubHeader?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 11.0))
        
        self.btnAthlicAdd?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 10.0))
        self.btnAthlicAdd?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnAthlicAdd?.backgroundColor = UIColor.white
        self.btnAthlicAdd?.cornerRadius = 20.0
        
        [self.txtfb,self.txtlinked,self.txtInsta,self.txtTwitter].forEach({
            $0?.font = UIFont.PoppinsRegular(ofSize: 12.0)
            $0?.textColor = UIColor.CustomColor.blackColor
            $0?.setPlaceHolderColor(text: $0?.placeholder?.localized() ?? "", color: UIColor.CustomColor.reusablePlaceholderColor)
        })
        
        [self.vwtxtfbView,self.vwtxtinstaView,self.vwtxtLinkView,self.vwtxtTwitterView].forEach({
            $0?.backgroundColor = UIColor.white
            $0?.cornerRadius = 17.0
            $0?.borderColor = UIColor.CustomColor.borderColor4
            $0?.borderWidth = 1.0
        })
        
        self.FollowHeader?.forEach({
            $0.textColor = UIColor.CustomColor.whitecolor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 15.0))
        })
        [self.btnTwitterYes,self.btnTwitterNo,self.btnfbNo,self.btnfbYes,self.btnInstaYes,self.btnInstaNo,self.btnLinkNo,self.bvtnlinkYes].forEach({
            $0?.cornerRadius = ($0?.frame.height ?? 0) / 2
        })
       
        self.btnAchievement?.backgroundColor = UIColor.white
        self.btnAchievement?.cornerRadius = 20.0
        
        self.btnCurricular?.backgroundColor = UIColor.white
        self.btnCurricular?.cornerRadius = 20.0
        
        self.btnReference?.backgroundColor = UIColor.white
        self.btnReference?.cornerRadius = 20.0
        
        self.btnmeasure?.backgroundColor = UIColor.white
        self.btnmeasure?.cornerRadius = 20.0
        
        self.cvStatus?.register(ResumeStatusCell.self)
        self.cvStatus?.dataSource = self
        self.cvStatus?.delegate = self
    
        self.tblAcademics?.register(ResumeFollowCell.self)
        self.tblAcademics?.rowHeight = UITableView.automaticDimension
        self.tblAcademics?.delegate = self
        self.tblAcademics?.dataSource = self
        
        self.tblContact?.register(ContactResumeCell.self)
        self.tblContact?.rowHeight = UITableView.automaticDimension
        self.tblContact?.delegate = self
        self.tblContact?.dataSource = self
        self.tblContact?.reloadData()
        
        self.tblAthletics?.register(AthleticsCell.self)
        self.tblAthletics?.rowHeight = UITableView.automaticDimension
        self.tblAthletics?.delegate = self
        self.tblAthletics?.dataSource = self
        
        self.tblAchievement?.register(AthleticsCell.self)
        self.tblAchievement?.rowHeight = UITableView.automaticDimension
        self.tblAchievement?.delegate = self
        self.tblAchievement?.dataSource = self
        
        self.tblCurricular?.register(AthleticsCell.self)
        self.tblCurricular?.rowHeight = UITableView.automaticDimension
        self.tblCurricular?.delegate = self
        self.tblCurricular?.dataSource = self
        
        self.tblreferences?.register(ReferencesCell.self)
        self.tblreferences?.rowHeight = UITableView.automaticDimension
        self.tblreferences?.delegate = self
        self.tblreferences?.dataSource = self
        
        self.tblMeasure?.register(MeasurablesCell.self)
        self.tblMeasure?.rowHeight = UITableView.automaticDimension
        self.tblMeasure?.delegate = self
        self.tblMeasure?.dataSource = self
        
        self.vwMainContact?.isHidden = true
        self.vwMainathlics?.isHidden = true
        self.vwMainAcdemic?.isHidden = true
        self.vwMainAchievement?.isHidden = true
        self.vwMainReference?.isHidden = true
        self.vwMainCurricular?.isHidden = true
        self.vwMainmeasure?.isHidden = true
        
        let model = AthlicsModel.init(Name: "", Position: "", season: "",teamId: "")
        self.arrAthlics.append(model)
        
        let modelAchievemnt = AchievementsModel.init(achievementId: "", text: "")
        self.arrAchievement.append(modelAchievemnt)
        
        let modelCurricular = CurricularsModel.init(curricularId: "", text: "")
        self.arrCurricular.append(modelCurricular)
        
        let modelre = ReferenceModel.init(Name: "", academic: "", Phone: "", Email: "", referenceId: "")
        self.arrReference.append(modelre)
        
        let modelme = MeasureModel.init(key: "", Value: "", measurementId: "")
        self.arrMeasure.append(modelme)
        
        self.isSelectTwitterNo = true
        self.vwtxtTwitterView?.isHidden = true
        self.isSelectTwitterYes = false
        self.isSelectInstaNo = true
        self.vwtxtinstaView?.isHidden = true
        self.isSelectInstaYes = false
        self.isSelectfbNo = true
        self.vwtxtfbView?.isHidden = true
        self.isSelectfbYes = false
        self.isSelectLinkNo = true
        self.vwtxtLinkView?.isHidden = true
        self.isSelectlinkYes = false
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        appNavigationController?.setNavigationBackTitleRightBackBtnNavigationBarBlack(title: "My Resume", TitleColor: UIColor.CustomColor.whitecolor, rightBtntitle: "", rightBtnColor: UIColor.CustomColor.whitecolor, navigationItem: self.navigationItem)
        appNavigationController?.btnNextClickBlock = {
            
        }
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
    
    func manageProfileViews(_ counter:Int) {
        if counter == 0 {
            self.vwMainContact?.isHidden = true
            self.vwMainathlics?.isHidden = true
            self.vwMainAcdemic?.isHidden = true
            self.vwMainAchievement?.isHidden = true
            self.vwMainFollow?.isHidden = false
            self.vwMainCurricular?.isHidden = true
            self.vwMainReference?.isHidden = true
            self.vwMainmeasure?.isHidden = true
            self.lblHEader?.text = "Where can you be followed?"
        } else if counter == 1 {
            self.vwMainContact?.isHidden = false
            self.vwMainathlics?.isHidden = true
            self.vwMainAcdemic?.isHidden = true
            self.vwMainAchievement?.isHidden = true
            self.vwMainFollow?.isHidden = true
            self.vwMainCurricular?.isHidden = true
            self.vwMainReference?.isHidden = true
            self.vwMainmeasure?.isHidden = true
            self.lblHEader?.text = "Contact Info"
        } else if counter == 2 {
            self.vwMainContact?.isHidden = true
            self.vwMainathlics?.isHidden = true
            self.vwMainAcdemic?.isHidden = false
            self.vwMainAchievement?.isHidden = true
            self.vwMainFollow?.isHidden = true
            self.vwMainCurricular?.isHidden = true
            self.vwMainReference?.isHidden = true
            self.vwMainmeasure?.isHidden = true
            self.lblHEader?.text = "Academics"
        } else if counter == 3 {
            self.vwMainContact?.isHidden = true
            self.vwMainathlics?.isHidden = false
            self.vwMainAcdemic?.isHidden = true
            self.vwMainAchievement?.isHidden = true
            self.vwMainFollow?.isHidden = true
            self.vwMainCurricular?.isHidden = true
            self.vwMainReference?.isHidden = true
            self.vwMainmeasure?.isHidden = true
            self.lblHEader?.text = "Athletics"
        } else if counter == 4 {
            self.vwMainContact?.isHidden = true
            self.vwMainathlics?.isHidden = true
            self.vwMainAcdemic?.isHidden = true
            self.vwMainAchievement?.isHidden = false
            self.vwMainFollow?.isHidden = true
            self.vwMainCurricular?.isHidden = true
            self.vwMainReference?.isHidden = true
            self.vwMainmeasure?.isHidden = true
            self.lblHEader?.text = "Athletic Achievements"
        } else if counter == 5 {
            self.vwMainContact?.isHidden = true
            self.vwMainathlics?.isHidden = true
            self.vwMainAcdemic?.isHidden = true
            self.vwMainAchievement?.isHidden = true
            self.vwMainFollow?.isHidden = true
            self.vwMainCurricular?.isHidden = true
            self.vwMainReference?.isHidden = true
            self.vwMainmeasure?.isHidden = false
            self.lblHEader?.text = "Measurables"
        } else if counter == 6 {
            self.vwMainContact?.isHidden = true
            self.vwMainathlics?.isHidden = true
            self.vwMainAcdemic?.isHidden = true
            self.vwMainAchievement?.isHidden = true
            self.vwMainFollow?.isHidden = true
            self.vwMainCurricular?.isHidden = false
            self.vwMainReference?.isHidden = true
            self.vwMainmeasure?.isHidden = true
            self.lblHEader?.text = "Extra Curriculars"
        } else if counter == 7 {
            self.vwMainContact?.isHidden = true
            self.vwMainathlics?.isHidden = true
            self.vwMainAcdemic?.isHidden = true
            self.vwMainAchievement?.isHidden = true
            self.vwMainFollow?.isHidden = true
            self.vwMainCurricular?.isHidden = true
            self.vwMainReference?.isHidden = false
            self.vwMainmeasure?.isHidden = true
            self.lblHEader?.text = "References"
        }
        else {
            self.setUserResume()
          
        }
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension ResumeDetailViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ResumeStatusCell.self)
        cell.isSelectedStatus = ((indexPath.row) <= selectedNext) ? true : false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height / 0.20, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.counter = indexPath.row
        self.manageProfileViews(self.counter)
        self.lblSubHeader?.text = "\(self.counter + 1) of 8"
        self.selectedNext = indexPath.row
        self.cvStatus?.reloadData()
    }
}
//MARK: - Tableview Observer
extension ResumeDetailViewController {
    
    private func addTableviewOberver() {
        self.tblAcademics?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblContact?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblAthletics?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblAchievement?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblCurricular?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblreferences?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblMeasure?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
       
    }
    func removeTableviewObserver() {

        if self.tblAcademics?.observationInfo != nil {
            self.tblAcademics?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblContact?.observationInfo != nil {
            self.tblContact?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblAthletics?.observationInfo != nil {
            self.tblAthletics?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblAchievement?.observationInfo != nil {
            self.tblAchievement?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblCurricular?.observationInfo != nil {
            self.tblCurricular?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblreferences?.observationInfo != nil {
            self.tblreferences?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblMeasure?.observationInfo != nil {
            self.tblMeasure?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblAcademics && keyPath == ObserverName.kcontentSize {
                self.ConstainttblAcademics?.constant = self.tblAcademics?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblContact && keyPath == ObserverName.kcontentSize {
                self.ConstainttblContact?.constant = self.tblContact?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblAthletics && keyPath == ObserverName.kcontentSize {
                self.ConstrainttblAthletics?.constant = self.tblAthletics?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblAchievement && keyPath == ObserverName.kcontentSize {
                self.constrainttblAchievement?.constant = self.tblAchievement?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblCurricular && keyPath == ObserverName.kcontentSize {
                self.ConstraintCurricular?.constant = self.tblCurricular?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblreferences && keyPath == ObserverName.kcontentSize {
                self.ConstraintReferences?.constant = self.tblreferences?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblMeasure && keyPath == ObserverName.kcontentSize {
                self.ConstrainttblMeasure?.constant = self.tblMeasure?.contentSize.height ?? 0.0
            }
            
        }
    }
}

//MARK:- UITableView Delegate
extension ResumeDetailViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblAcademics {
            return self.arrAcademic.count
        } else if tableView == self.tblContact {
            return 3
        } else if tableView == self.tblAthletics {
            return self.arrAthlics.count
        } else if tableView == self.tblAchievement {
            return self.arrAchievement.count
        } else if tableView == self.tblCurricular {
            return self.arrCurricular.count
        } else if tableView == self.tblreferences {
            return self.arrReference.count
        } else if tableView == self.tblMeasure {
            return self.arrMeasure.count
        }
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if tableView == self.tblAcademics {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: ResumeFollowCell.self)
            cell.vwyesno?.isHidden = true
            cell.vwtextView?.isHidden = false
            cell.lblHeader?.text = self.arrAcademic[indexPath.row].HeaderName
            cell.txtTeamName?.placeholder = self.arrAcademic[indexPath.row].HeaderPlace
           switch indexPath.row {
           case 0:
               cell.txtTeamName?.text = self.GetResume?.schoolName
               self.schoolName = self.GetResume?.schoolName ?? ""
           case 1:
               cell.txtTeamName?.text = self.GetResume?.schoolAddress
               self.schoolAddress = self.GetResume?.schoolAddress ?? ""
           case 2:
               cell.txtTeamName?.text = self.GetResume?.gpa
               self.gpa = self.GetResume?.gpa ?? ""
           case 3:
               cell.txtTeamName?.text = self.GetResume?.actScore
               self.actScore = self.GetResume?.actScore ?? ""
           case 4:
               cell.txtTeamName?.text = self.GetResume?.satScore
               self.satScore = self.GetResume?.satScore ?? ""
           default:
               break
           }
           cell.delegate = self
            return cell
        } else if tableView == self.tblContact {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: ContactResumeCell.self)
            if indexPath.row == 0  {
                cell.vwMaintxtFiled?.isHidden = false
                cell.vwMaitxtView?.isHidden = true
                cell.txtFiled?.isUserInteractionEnabled = false
                cell.lblHederFiled?.text = "Enter Phone Number"
                cell.txtFiled?.setPlaceHolderColor(text: cell.txtFiled?.placeholder?.localized() ?? "", color: UIColor.CustomColor.reusablePlaceholderColor)
                cell.txtFiled?.placeholder = "Enter Phone Number"
                if self.GetResume?.phone == "" {
                    if let user = UserModel.getCurrentUserFromDefault() {
                        cell.txtFiled?.text = format(with: Masking.kPhoneNumberMasking, phone: user.phone)
                    }
                } else {
                    cell.txtFiled?.text = format(with: Masking.kPhoneNumberMasking, phone: self.GetResume?.phone ?? "")
                }
            } else if indexPath.row == 1 {
                cell.vwMaintxtFiled?.isHidden = false
                cell.vwMaitxtView?.isHidden = true
                cell.txtFiled?.isUserInteractionEnabled = false
                cell.lblHederFiled?.text = "Enter Email Address"
                cell.txtFiled?.setPlaceHolderColor(text: cell.txtFiled?.placeholder?.localized() ?? "", color: UIColor.CustomColor.reusablePlaceholderColor)
                cell.txtFiled?.placeholder = "Enter Email Address"
                if self.GetResume?.email == "" {
                    if let user = UserModel.getCurrentUserFromDefault() {
                        cell.txtFiled?.text = user.email
                    }
                } else {
                    cell.txtFiled?.text = self.GetResume?.email
                }
            } else {
                cell.vwMaintxtFiled?.isHidden = true
                cell.vwMaitxtView?.isHidden = false
                cell.lblHederTxtView?.text = "Enter Address"
                cell.txtView?.placeholder = "Enter Address.."
                if self.GetResume?.address == "" {
                    if let user = UserModel.getCurrentUserFromDefault() {
                        cell.txtView?.text = user.address
                    }
                } else {
                    cell.txtView?.text = self.GetResume?.address
                    self.Address = self.GetResume?.address ?? ""
                }
            }
            cell.delegate = self
            return cell
        } else if tableView == self.tblAthletics {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: AthleticsCell.self)
            cell.btnCancel?.isHidden = (self.arrAthlics.count == 1)
            cell.btnDeleteFiled?.isHidden = true
            if self.arrAthlics.count > 3 {
                self.btnAthlicAdd?.isHidden = true
            } else {
                self.btnAthlicAdd?.isHidden = false
            }
            if self.arrAthlics.count > 0 {
                let obj = self.arrAthlics[indexPath.row]
                cell.txtteamname?.txtInput?.text = obj.Name
                cell.txtLocation?.txtInput?.text = obj.Position
                cell.txtstatReson?.txtInput?.text = obj.season
                cell.layoutIfNeeded()
                cell.delegate = self
            }
            
            cell.btnCancel?.tag = indexPath.row
            cell.btnCancel?.addTarget(self, action: #selector(self.btnCancelClicked(_:)), for: .touchUpInside)
            return cell 
        } else if tableView == self.tblAchievement {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: AthleticsCell.self)
            cell.vwMainSeason?.isHidden = true
            cell.vwMainPosition?.isHidden = true
            cell.btnCancel?.isHidden = true
            cell.txtteamname?.txtInput?.placeholder = "Enter Achievement"
            cell.btnDeleteFiled?.isHidden = (self.arrAchievement.count == 1)
            if indexPath.row == 0 {
                cell.lblMain?.isHidden = false
                cell.lblMain?.text = "Enter Your Achievements"
            } else {
                cell.lblMain?.isHidden = true
            }
            if self.arrAchievement.count > 5 {
                self.btnAchievement?.isHidden = true
            } else {
                self.btnAchievement?.isHidden = false
            }
            if self.arrAchievement.count > 0 {
                let obj = self.arrAchievement[indexPath.row]
                cell.txtteamname?.txtInput?.text = obj.text
                cell.AchivementDelegate = self
            }
            cell.btnDeleteFiled?.tag = indexPath.row
            cell.btnDeleteFiled?.addTarget(self, action: #selector(self.btnCancelAchivementClicked(_:)), for: .touchUpInside)
            return cell
        } else if tableView == self.tblCurricular {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: AthleticsCell.self)
            cell.vwMainSeason?.isHidden = true
            cell.vwMainPosition?.isHidden = true
            cell.btnCancel?.isHidden = true
            cell.txtteamname?.txtInput?.placeholder = "Enter Curricular"
            cell.btnDeleteFiled?.isHidden = (self.arrCurricular.count == 1)
            if indexPath.row == 0 {
                cell.lblMain?.isHidden = false
                cell.lblMain?.text = "What Extra Curricular activity do you participate? "
            } else {
                cell.lblMain?.isHidden = true
            }
            if self.arrCurricular.count > 5 {
                self.btnCurricular?.isHidden = true
            } else {
                self.btnCurricular?.isHidden = false
            }
            if self.arrCurricular.count > 0 {
                let obj = self.arrCurricular[indexPath.row]
                cell.txtteamname?.txtInput?.text = obj.text
                cell.curriculerDelegate = self
            }
            cell.btnDeleteFiled?.tag = indexPath.row
            cell.btnDeleteFiled?.addTarget(self, action: #selector(self.btnCancelCurricularClicked(_:)), for: .touchUpInside)
            return cell
        } else if tableView == self.tblreferences {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: ReferencesCell.self)
            cell.btnDelete?.isHidden = (self.arrReference.count == 1)
            if self.arrReference.count > 3 {
                self.btnReference?.isHidden = true
            } else {
                self.btnReference?.isHidden = false
            }
            if self.arrReference.count > 0 {
                let obj = self.arrReference[indexPath.row]
                cell.txtphone?.txtInput?.text = format(with: Masking.kPhoneNumberMasking, phone: obj.Phone)
                cell.txtacademic?.txtInput?.text = obj.academic
                cell.txtName?.txtInput?.text = obj.Name
                cell.txtEmail?.txtInput?.text = obj.Email
                cell.delegate = self
            }
            cell.btnDelete?.tag = indexPath.row
            cell.btnDelete?.addTarget(self, action: #selector(self.btnCancelreferenceClicked(_:)), for: .touchUpInside)
            return cell
        } else if tableView == self.tblMeasure {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: MeasurablesCell.self)
            cell.btnCancel?.isHidden = (self.arrMeasure.count == 1)
            if self.arrMeasure.count > 7 {
                self.btnmeasure?.isHidden = true
            } else {
                self.btnmeasure?.isHidden = false
            }
            if self.arrMeasure.count > 0 {
                let obj = self.arrMeasure[indexPath.row]
                cell.txtName?.text = obj.key
                cell.txtValue?.text = obj.Value
                cell.delegate = self
            }
            cell.btnCancel?.tag = indexPath.row
            cell.btnCancel?.addTarget(self, action: #selector(self.btnCancelMeasureClicked(_:)), for: .touchUpInside)
            return cell
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    @objc func btnCancelMeasureClicked(_ btn : UIButton){
        if self.arrMeasure.count > 1 {
            self.arrMeasure.remove(at: btn.tag)
            self.tblMeasure?.reloadData()
        }
    }
    
    @objc func btnCancelClicked(_ btn : UIButton){
        if self.arrAthlics.count > 0 {
            self.arrAthlics.remove(at: btn.tag)
        }
        self.tblAthletics?.reloadData()
    }
    
    @objc func btnCancelreferenceClicked(_ btn : UIButton){
        if self.arrReference.count > 0 {
            self.arrReference.remove(at: btn.tag)
        }
        self.tblreferences?.reloadData()
    }
    
    @objc func btnCancelCurricularClicked(_ btn : UIButton){
        if self.arrCurricular.count > 1 {
            self.arrCurricular.remove(at: btn.tag)
            self.tblCurricular?.reloadData()
        }
    }
    
    @objc func btnCancelAchivementClicked(_ btn : UIButton){
        if self.arrAchievement.count > 1 {
            self.arrAchievement.remove(at: btn.tag)
            self.tblAchievement?.reloadData()
        }
    }
    
}

// MARK: - IBAction
extension ResumeDetailViewController {
    
    @IBAction func btnAthlicAddCLicked(_ sender : UIButton) {
        
        self.view.endEditing(true)
        let model = AthlicsModel.init(Name: "", Position: "", season: "", teamId: "")
            self.arrAthlics.append(model)
            self.tblAthletics?.reloadData()
    }
    
    @IBAction func btnAchievementClicked(_ sender : UIButton) {
        self.view.endEditing(true)
        let modelAchievemnt = AchievementsModel.init(achievementId: "", text: "")
            self.arrAchievement.append(modelAchievemnt)
            self.tblAchievement?.reloadData()
    }
    
    @IBAction func btnNextClicked(_ sender : UIButton) {
        
        if self.counter == 0 {
            if self.isSelectTwitterYes == true && self.txtTwitter?.text == "" {
                self.showMessage("Please Enter Twitter Account", themeStyle: .warning)
            } else if self.isSelectInstaYes == true && self.txtInsta?.text == "" {
                self.showMessage("Please Enter Instagram Account", themeStyle: .warning)
            } else if self.isSelectfbYes == true && self.txtfb?.text == "" {
                self.showMessage("Please Enter Facebook Account", themeStyle: .warning)
            } else if self.isSelectlinkYes == true && self.txtlinked?.text == "" {
                self.showMessage("Please Enter Linkedin Account", themeStyle: .warning)
            } else {
                self.counter += 1
                self.manageProfileViews(self.counter)
                self.lblSubHeader?.text = "\(self.counter + 1) of 8"
                self.selectedNext += 1
                self.cvStatus?.reloadData()
            }
        } else if self.counter == 3 {
            if self.arrAthlics.count > 0 {
                for Athlics in self.arrAthlics {
                    print(Athlics.Name)
                    if Athlics.Name == "" {
                        self.showMessage("Enter team Name", themeStyle: .error)
                        return
                    } else if Athlics.season == "" {
                        self.showMessage("Enter your Sports", themeStyle: .error)
                        return
                    }  else if Athlics.Position == "" {
                        self.showMessage("Enter your position", themeStyle: .error)
                        return
                    }
                }
            }
            self.counter += 1
            self.manageProfileViews(self.counter)
            self.lblSubHeader?.text = "\(self.counter + 1) of 8"
            self.selectedNext += 1
            self.cvStatus?.reloadData()
       } else if self.counter == 7 {
            if self.arrReference.count > 0 {
                print(self.arrReference.count)
                for Reference in self.arrReference {
                    print(Reference.Name)
                    if Reference.Name == "" {
                        self.showMessage("Enter Name", themeStyle: .error)
                        return
                    } else if Reference.academic == "" {
                        self.showMessage("Enter academic", themeStyle: .error)
                        return
                    } else if Reference.Phone == "" {
                        self.showMessage("Enter Phone Number", themeStyle: .error)
                        return
                    } else if Reference.Email == "" {
                        self.showMessage("Enter Phone Email", themeStyle: .error)
                        return
                    } else if !(Reference.Email.isValidEmail() ) {
                        self.showMessage("Please enter valid email address", themeStyle: .error)
                        return
                    }
                }
            }
                self.counter += 1
                self.manageProfileViews(self.counter)
                self.lblSubHeader?.text = "\(self.counter + 1) of 8"
                self.selectedNext += 1
                self.cvStatus?.reloadData()
        }
        else {
            self.counter += 1
            self.manageProfileViews(self.counter)
            self.lblSubHeader?.text = "\(self.counter + 1) of 8"
            self.selectedNext += 1
            self.cvStatus?.reloadData()
        }
    }
    
    @IBAction func btnAddCurricularClicked(_ sender : UIButton) {
        self.view.endEditing(true)
        let modelCurricular = CurricularsModel.init(curricularId: "", text: "")
            self.arrCurricular.append(modelCurricular)
            self.tblCurricular?.reloadData()
    }
    
    @IBAction func btnreferencesClicked(_ sedner : UIButton) {
        self.view.endEditing(true)
        let modelre = ReferenceModel.init(Name: "", academic: "", Phone: "", Email: "", referenceId: "")
        self.arrReference.append(modelre)
        self.tblreferences?.reloadData()
    }
    
    @IBAction func btnMeasureClicked(_ sender : UIButton) {
        self.view.endEditing(true)
        let modelmesure = MeasureModel.init(key: "", Value: "", measurementId: "")
        self.arrMeasure.append(modelmesure)
        self.tblMeasure?.reloadData()
    }
    
    @IBAction func btnTwitteryesClicked(_ sender : UIButton) {
        self.isSelectTwitterYes = true
        self.isSelectTwitterNo = false
        self.vwtxtTwitterView?.isHidden = false
    }
    
    @IBAction func btnTwitternoClick(_ sender : UIButton) {
        self.isSelectTwitterNo = true
        self.isSelectTwitterYes = false
        self.vwtxtTwitterView?.isHidden = true
        self.txtTwitter?.text = ""
    }
    
    @IBAction func btninstYesCLick(_ sedner : UIButton) {
        self.isSelectInstaYes = true
        self.isSelectInstaNo = false
        self.vwtxtinstaView?.isHidden = false
    }
    
    @IBAction func btninstaNoClick(_ sedner : UIButton) {
        self.isSelectInstaYes = false
        self.isSelectInstaNo = true
        self.vwtxtinstaView?.isHidden = true
        self.txtInsta?.text = ""
    }
    
    @IBAction func btnfbyesClick(_ sender : UIButton) {
        self.isSelectfbYes = true
        self.isSelectfbNo = false
        self.vwtxtfbView?.isHidden = false
    }
    
    @IBAction func btnfbNoClick(_ sender : UIButton) {
        self.isSelectfbYes = false
        self.isSelectfbNo = true
        self.vwtxtfbView?.isHidden = true
        self.txtfb?.text = ""
    }
    
    @IBAction func btnLinkyesClick(_ sender : UIButton) {
        self.isSelectlinkYes = true
        self.isSelectLinkNo = false
        self.vwtxtLinkView?.isHidden = false
    }
    
    @IBAction func btnLinknoClick(_ sender : UIButton) {
        self.isSelectlinkYes = false
        self.isSelectLinkNo = true
        self.vwtxtLinkView?.isHidden = true
        self.txtlinked?.text = ""
    }
}

// MARK: - ViewControllerDescribable
extension ResumeDetailViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ResumeDetailViewController: AppNavigationControllerInteractable { }

// MARK: - ContactResumeCellDelegate
extension ResumeDetailViewController : ContactInfoDelegate {
    func Email(text: String, cell: ContactResumeCell) {
        if let indexpath = self.tblContact?.indexPath(for: cell) {
            if indexpath.row == 0 {
                self.Phonenumber = text
            } else {
                self.Email = text
            }
        }
    }
    
    func Address(text: String, cell: ContactResumeCell) {
        if let indexpath = self.tblContact?.indexPath(for: cell) {
            self.Address = text
           
        }
    }
}
// MARK: - AcademicCellDelegate
extension ResumeDetailViewController : AcademicoDelegate {
    func Value(text: String, cell: ResumeFollowCell) {
        if let indexpath = self.tblAcademics?.indexPath(for: cell) {
            if indexpath.row == 0 {
                self.schoolName = text
            } else if indexpath.row == 1 {
                self.schoolAddress = text
            } else if indexpath.row == 2 {
                self.gpa = text
            } else if indexpath.row == 3 {
                self.actScore = text
            } else if indexpath.row == 4 {
                self.satScore = text
            }
        }
    }
}
// MARK: - AthlaticDelegate
extension ResumeDetailViewController : AthlaticDelegate {
    func TeamName(text: String, cell: AthleticsCell) {
        print(self.arrAthlics)
        if let indexpath = self.tblAthletics?.indexPath(for: cell) {
            if self.arrAthlics.count > 0 {
                self.arrAthlics[indexpath.row].Name = text
            }
            self.tblAthletics?.reloadData()
        }
    }
    
    func Position(text: String, cell: AthleticsCell) {
        if let indexpath = self.tblAthletics?.indexPath(for: cell) {
            if self.arrAthlics.count > 0 {
                self.arrAthlics[indexpath.row].Position = text
            }
            self.tblAthletics?.reloadData()
        }
    }
    
    func Season(text: String, cell: AthleticsCell) {
        if let indexpath = self.tblAthletics?.indexPath(for: cell) {
            if self.arrAthlics.count > 0 {
                self.arrAthlics[indexpath.row].season = text
            }
            self.tblAthletics?.reloadData()
        }
    }
}

// MARK: - AchievementDelegate
extension ResumeDetailViewController : AchievementDelegate {
    func text(text: String, cell: AthleticsCell) {
        if let indexpath = self.tblAchievement?.indexPath(for: cell) {
            if self.arrAchievement.count > 0 {
                self.arrAchievement[indexpath.row].text = text
            }
            self.tblAchievement?.reloadData()
        }
    }
}
// MARK: - AchievementDelegate
extension ResumeDetailViewController : CurriculersDelegate {
    func textvalue(text: String, cell: AthleticsCell) {
        if let indexpath = self.tblCurricular?.indexPath(for: cell) {
            if self.arrCurricular.count > 0 {
                self.arrCurricular[indexpath.row].text = text
            }
            self.tblCurricular?.reloadData()
        }
    }
}
// MARK: - MeasurableDelegate
extension ResumeDetailViewController : MeasurableDelegate {
    func key(text: String, cell: MeasurablesCell) {
        if let indexpath = self.tblMeasure?.indexPath(for: cell) {
            if self.arrMeasure.count > 0 {
                self.arrMeasure[indexpath.row].key = text
            }
            self.tblMeasure?.reloadData()
        }
    }
    
    func value(text: String, cell: MeasurablesCell) {
        if let indexpath = self.tblMeasure?.indexPath(for: cell) {
            if self.arrMeasure.count > 0 {
                self.arrMeasure[indexpath.row].Value = text
            }
            self.tblMeasure?.reloadData()
        }
    }
}
// MARK: - ReferenceDelegate
extension ResumeDetailViewController : ReferenceDelegate {
    func name(text: String, cell: ReferencesCell) {
        if let indexpath = self.tblreferences?.indexPath(for: cell) {
            if self.arrReference.count > 0 {
                self.arrReference[indexpath.row].Name = text
            }
            self.tblreferences?.reloadData()
        }
    }
    
    func email(text: String, cell: ReferencesCell) {
        if let indexpath = self.tblreferences?.indexPath(for: cell) {
            if self.arrReference.count > 0 {
                self.arrReference[indexpath.row].Email = text
            }
            self.tblreferences?.reloadData()
        }
    }
    
    func phone(text: String, cell: ReferencesCell) {
        if let indexpath = self.tblreferences?.indexPath(for: cell) {
            if self.arrReference.count > 0 {
                self.arrReference[indexpath.row].Phone = format(with: Masking.kPhoneNumberMasking, phone: text)
            }
            self.tblreferences?.reloadData()
        }
    }
    
    func academic(text: String, cell: ReferencesCell) {
        if let indexpath = self.tblreferences?.indexPath(for: cell) {
            if self.arrReference.count > 0 {
                self.arrReference[indexpath.row].academic = text
            }
            self.tblreferences?.reloadData()
        }
    }
}
// MARK: - Api
extension ResumeDetailViewController {
    private func setUserResume(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            var arrAthletic : [[String:Any]] = []
            for i in stride(from: 0, to: self.arrAthlics.count, by: 1) {
                let obj = self.arrAthlics[i]
                let dict : [String:Any] = [
                    kteamId : obj.teamId,
                    kname : obj.Name,
                    kposition : obj.Position,
                    kseason : obj.season
                    
                ]
                arrAthletic.append(dict)
            }
            
            var arrAchiveemnt : [[String:Any]] = []
            for i in stride(from: 0, to: self.arrAchievement.count, by: 1) {
                let obj = self.arrAchievement[i]
                let dict : [String:Any] = [
                    kachievementId : obj.achievementId,
                    ktext : obj.text
                    
                ]
                arrAchiveemnt.append(dict)
            }
            var arrcurricul : [[String:Any]] = []
            for i in stride(from: 0, to: self.arrCurricular.count, by: 1) {
                let obj = self.arrCurricular[i]
                let dict : [String:Any] = [
                    kcurricularId : obj.curricularId,
                    ktext : obj.text
                    
                ]
                arrcurricul.append(dict)
            }
            
            var arrMeasure : [[String:Any]] = []
            for i in stride(from: 0, to: self.arrMeasure.count, by: 1) {
                let obj = self.arrMeasure[i]
                let dict : [String:Any] = [
                    kkey : obj.key,
                    kvalue : obj.Value
                    
                ]
                arrMeasure.append(dict)
            }
            
            var arrReference : [[String:Any]] = []
            for i in stride(from: 0, to: self.arrReference.count, by: 1) {
                let obj = self.arrReference[i]
                let phoneData : String = obj.Phone.removeSpecialCharsFromString
                let dict : [String:Any] = [
                    kreferenceId : obj.referenceId,
                    kname : obj.Name,
                    kemail : obj.Email,
                    kphone : phoneData,
                    kacademic : obj.academic
                    
                ]
                arrReference.append(dict)
            }
            let phoneUser : String = self.Phonenumber.removeSpecialCharsFromString
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                ktwitter : self.txtTwitter?.text ?? "",
                kinstagram : self.txtInsta?.text ?? "",
                kfacebook : self.txtfb?.text ?? "",
                klinkedIn : self.txtlinked?.text ?? "",
                kaddress : self.Address,
                kemail : self.Email,
                kphone : phoneUser,
                kschoolName : self.schoolName,
                kschoolAddress : self.schoolAddress,
                kgpa : self.gpa,
                kactScore : self.actScore,
                ksatScore : self.satScore,
                kteams : arrAthletic,
                kachievements : arrAchiveemnt,
                kmeasurements : arrMeasure,
                kcurriculars : arrcurricul,
                kreferences : arrReference,
                kuserResumeId : self.GetResume?.userResumeId ?? ""
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ResumeModel.setUserResume(with: param, success: { (resumeShareProfileId,msg) in
                self.showMessage(msg, themeStyle: .success)
                self.appNavigationController?.push(ResumeCompleteViewController.self,configuration: { vc in
                    vc.resumeShareProfileId = resumeShareProfileId
                })
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func getUserResume(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            
            ResumeModel.getUserResume(with: param, success: { (Resume, message) in
                self.GetResume = Resume
                self.getResume()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.tblAcademics?.reloadData()
                    self.tblContact?.reloadData()
                }
            })
        }
    }
    
    func getResume() {
        if let Data = self.GetResume {
            self.tblAcademics?.reloadData()
            self.tblContact?.reloadData()
            if Data.instagram == "" {
                self.isSelectInstaNo = true
                self.isSelectInstaYes = false
            } else {
                self.isSelectInstaNo = false
                self.isSelectInstaYes = true
                self.vwtxtinstaView?.isHidden = false
                self.txtInsta?.text = Data.instagram
            }
            if Data.twitter == "" {
                self.isSelectTwitterNo = true
                self.isSelectTwitterYes = false
            } else {
                self.isSelectTwitterNo = false
                self.isSelectTwitterYes = true
                self.vwtxtTwitterView?.isHidden = false
                self.txtTwitter?.text = Data.twitter
            }
            if Data.facebook == "" {
                self.isSelectfbNo = true
                self.isSelectfbYes = false
            } else {
                self.isSelectfbNo = false
                self.isSelectfbYes = true
                self.vwtxtfbView?.isHidden = false
                self.txtfb?.text = Data.facebook
            }
            if Data.linkedIn == "" {
                self.isSelectLinkNo = true
                self.isSelectlinkYes = false
            } else {
                self.isSelectLinkNo = false
                self.isSelectlinkYes = true
                self.vwtxtLinkView?.isHidden = false
                self.txtlinked?.text = Data.linkedIn
            }
            if Data.achievements != [] {
                self.arrAchievement = Data.achievements
                self.tblAchievement?.reloadData()
            } else {
                let modelAchievemnt = AchievementsModel.init(achievementId: "", text: "")
                self.arrAchievement.append(modelAchievemnt)
                self.tblAchievement?.reloadData()
            }
            if Data.measurements != [] {
                self.arrMeasure = Data.measurements
                self.tblMeasure?.reloadData()
            } else {
                let modelmesure = MeasureModel.init(key: "", Value: "", measurementId: "")
                self.arrMeasure.append(modelmesure)
                self.tblMeasure?.reloadData()
            }
            if Data.curriculars != [] {
                self.arrCurricular = Data.curriculars
                self.tblCurricular?.reloadData()
            } else {
                let modelCurricular = CurricularsModel.init(curricularId: "", text: "")
                self.arrCurricular.append(modelCurricular)
                self.tblCurricular?.reloadData()
            }
            if Data.references != [] {
                self.arrReference = Data.references
                self.tblreferences?.reloadData()
            } else {
                let modelre = ReferenceModel.init(Name: "", academic: "", Phone: "", Email: "", referenceId: "")
                self.arrReference.append(modelre)
                self.tblreferences?.reloadData()
            }
            if Data.teams != [] {
                self.arrAthlics = Data.teams
                self.tblAthletics?.reloadData()
            } else {
                let model = AthlicsModel.init(Name: "", Position: "", season: "", teamId: "")
                    self.arrAthlics.append(model)
                    self.tblAthletics?.reloadData()
            }
        }
    }
}

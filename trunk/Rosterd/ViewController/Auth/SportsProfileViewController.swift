//
//  SportsProfileViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit


enum SportsEnum : Int {
    case Sports
    case HomeTown
    case YearofCoach
    case AgeGroups
    case AgeRecreational
    case AgeClubGroups
    case Grades
    case Height
    
}

class SportsProfileViewController: UIViewController {
    
    
    // MARK: - IBOutlet
    @IBOutlet var lblHeaderCollection: [UILabel]?
    @IBOutlet weak var constraintSportsCollectionHeight: NSLayoutConstraint?
    @IBOutlet weak var cvSportsSelection: UICollectionView?
    @IBOutlet weak var vwHeadline: ReusableView?
    @IBOutlet weak var vwSportParticipate: ReusableView?
    @IBOutlet weak var vwSportsSelection: UIView?
    @IBOutlet weak var vwTeamName: ReusableView?
    @IBOutlet weak var vwPlayerPosition: ReusableView?
    @IBOutlet weak var vwHeight: ReusableView?
    @IBOutlet weak var vwWeight: ReusableView?
    @IBOutlet weak var vwGPA: ReusableView?
    @IBOutlet weak var vwFavouriteSports: ReusableView?
    @IBOutlet weak var vwAgeGroups: ReusableView?
    @IBOutlet weak var vwrecreational: ReusableView?
    @IBOutlet weak var vwageGroupsdrop: ReusableView?
    @IBOutlet weak var vwAdultLeagues: ReusableView?
    @IBOutlet weak var VwFax: ReusableView?
    @IBOutlet weak var vwAthleticDirector: ReusableView?
    @IBOutlet weak var vwAthleticEmail: ReusableView?
    @IBOutlet weak var vwGrades: ReusableView?
    @IBOutlet weak var vwmasot: ReusableView?
    @IBOutlet weak var vwhometown: ReusableView?
    @IBOutlet weak var vwyearscoaching: ReusableView?
    @IBOutlet weak var vwWins: ReusableView?
    @IBOutlet weak var vwloses: ReusableView?
    @IBOutlet weak var vwties: ReusableView?
    @IBOutlet weak var vwexperience: ReusableView?
    
    @IBOutlet weak var vwclubname: ReusableView?
    
    @IBOutlet weak var vwclubadress: ReusableView?
    
    
    @IBOutlet weak var lblAgeGroups: UILabel!
    @IBOutlet weak var lblRecrationalteam: UILabel!
    @IBOutlet weak var lblClubTeams: UILabel!
    @IBOutlet weak var lblHederlabel: UILabel!
    
    
    @IBOutlet weak var vwAgegroup: UIView!
    @IBOutlet weak var vwRecreationalTeams: UIView!
    @IBOutlet weak var vwClubTeams: UIView!
    @IBOutlet weak var vwContactinfo: UIView!
    @IBOutlet weak var vwPErsonal: UIView!
    @IBOutlet weak var vwRecords: UIView!
    @IBOutlet weak var vwExperience: UIView!
    
    
    
    @IBOutlet weak var ageNo: YesNoButton!
    @IBOutlet weak var ageYes: YesNoButton!
    
    @IBOutlet weak var RecreationalNo: YesNoButton!
    @IBOutlet weak var RecreationalYes: YesNoButton!
    
    @IBOutlet weak var ClubNo: YesNoButton!
    @IBOutlet weak var ClubYes: YesNoButton!
    
    // MARK: - Variables
    

    var selectedCoach : CoachEnum?
    var selectedRole : userRole?
    var selectedschool : SchoolClubEnum?
//    var dicprofiledetail:[String:Any]?
    var dicprofiledetail  : [String:Any] = [:]
   
    private var arrGrades : [GradeEnum] = [.GradeA,.GradeB,.GradeC,.GradeD,.GradeE]
    private var SelectedGrade : GradeEnum?
//    private var arrHomeTown : [HomwTownEnum] = [.homeTown1,.homeTown2,.homeTown3,.homeTown4,.homeTown5]
//    private var selectedHomeTown : HomwTownEnum?
    private var arrYearcoach : [YearCoachingEnum] = [.oneyear,.twoyear,.threeyear,.fouryear,.fiveyear,.fiveyearPlus]
    private var selectedYearcoach : YearCoachingEnum?
    private var arrageGroup : [String] = ["5-20","20-40","40-60","60-80","80-100"]
    private var arrHeight : [String] = ["3'0\"","3'1\"","3'2\"","3'3\"","3'4\"","3'5\"","3'6\"","3'7\"","3'8\"","3'9\"","3'10\"","3'11\"","4'0\"","4'1\"","4'2\"","4'3\"","4'4\"","4'5\"","4'6\"","4'7\"","4'8\"","4'9\"","4'10\"","4'11\"","5'0\"","5'1\"","5'2\"","5'3\"","5'4\"","5'5\"","5'6\"","5'7\"","5'8\"","5'9\"","5'10\"","5'11\"","6'0\"","6'1\"","6'2\"","6'3\"","6'4\"","6'5\""]
    private var arrSports : [SportsModel] = []
    var selectedSportsData : SportsModel?
    private var userProfileData : UserModel?
    var isFromEditProfile : Bool = false
 
        //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addCollectionViewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeCollectionViewObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: - Init Configure
extension SportsProfileViewController {
    private func InitConfig(){
        
        self.VwFax?.txtInput.keyboardType = .numberPad
        self.vwWeight?.txtInput.keyboardType = .numberPad
        self.vwHeadline?.txtInput.autocapitalizationType = .sentences
        self.vwclubname?.txtInput.autocapitalizationType = .sentences
        self.vwclubadress?.txtInput.autocapitalizationType = .sentences
        
        self.lblHeaderCollection?.forEach({
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
            $0.textColor = UIColor.CustomColor.headerTextColor
        })
        
        self.lblHederlabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblHederlabel?.textColor = UIColor.CustomColor.headerTextColor
        
        if let cvSports = self.cvSportsSelection {
            cvSports.register(SportParticipationCell.self)
            cvSports.dataSource = self
            cvSports.delegate = self
            let alignedLayout = cvSports.collectionViewLayout as? AlignedCollectionViewFlowLayout
            alignedLayout?.horizontalAlignment = .leading
            alignedLayout?.minimumInteritemSpacing = 10
            alignedLayout?.minimumLineSpacing = 10
            alignedLayout?.estimatedItemSize = .init(width: 120, height: 60)
        }
        if let obj = self.selectedRole{
            switch obj {
            case .fan:
                self.vwclubname?.isHidden = true
                self.vwclubadress?.isHidden = true
                self.vwAgegroup?.isHidden = true
                self.vwRecreationalTeams?.isHidden = true
                self.vwClubTeams?.isHidden = true
                self.vwContactinfo?.isHidden = true
                self.vwRecords?.isHidden = true
                self.vwExperience?.isHidden = true
                
                
            case .athlete:
                self.vwclubname?.isHidden = true
                self.vwclubadress?.isHidden = true
                self.vwAgegroup?.isHidden = true
                self.vwHeadline?.isHidden = false
                self.vwRecreationalTeams?.isHidden = true
                self.vwClubTeams?.isHidden = true
                self.vwRecords?.isHidden = true
                self.vwTeamName?.isHidden = false
                self.vwPlayerPosition?.isHidden = false
                self.vwContactinfo?.isHidden = true
                self.vwExperience?.isHidden = true
                self.vwGrades?.isHidden = true
                self.vwmasot?.isHidden = true
                self.vwhometown?.isHidden = true
                self.vwyearscoaching?.isHidden = true
                
                
                
            case .schoolclub:
                self.vwclubname?.isHidden = true
                self.vwclubadress?.isHidden = true
                self.vwAgegroup?.isHidden = false
                self.vwRecreationalTeams?.isHidden = false
                self.vwClubTeams?.isHidden = false
                self.vwHeadline?.isHidden = true
                self.vwPErsonal?.isHidden = true
                self.vwContactinfo?.isHidden = false
                self.vwTeamName?.isHidden = true
                self.vwPlayerPosition?.isHidden = true
                self.vwExperience?.isHidden = true
                self.lblHederlabel?.text = "Basic Information"
                self.vwhometown?.isHidden = true
                self.vwyearscoaching?.isHidden = true
                
            case .coachrecruiter:
                
                self.vwAgegroup?.isHidden = true
                self.vwRecreationalTeams?.isHidden = true
                self.vwClubTeams?.isHidden = true
                self.vwWeight?.isHidden = true
                self.vwPErsonal?.isHidden = true
                self.vwContactinfo?.isHidden = true
                self.vwRecords?.isHidden = false
                self.vwExperience?.isHidden = false
                self.vwHeadline?.isHidden = true
                self.lblHederlabel?.text = "Basic Information"
                
                
            }
        }
        if let obj = self.selectedschool{
            switch obj {
           
            case .Club:
                self.vwGrades?.isHidden = true
                self.vwmasot?.isHidden = true
                self.vwRecords?.isHidden = true
            case .School:
                self.vwClubTeams?.isHidden = true
                self.vwRecreationalTeams?.isHidden = true
                self.vwAgegroup?.isHidden = true
                self.vwGrades?.isHidden = false
                self.vwmasot?.isHidden = false
                self.vwRecords?.isHidden = true
                
            }
        }
        if let obj = self.selectedCoach{
            
            switch obj {
            case .Coach:
                self.vwGrades?.isHidden = true
                self.vwTeamName?.isHidden = true
                self.vwPlayerPosition?.isHidden = true
                self.vwmasot?.isHidden = true
                self.vwRecords?.isHidden = false
               
            case .Recruiter:
                self.vwRecords?.isHidden = true
                self.vwGrades?.isHidden = true
                self.vwTeamName?.isHidden = true
                self.vwPlayerPosition?.isHidden = true
                self.vwmasot?.isHidden = true
            }
        }
        [self.vwSportParticipate,self.vwhometown,self.vwyearscoaching,self.vwGrades,self.vwageGroupsdrop,self.vwrecreational,self.vwAgeGroups,self.vwHeight].forEach({
            $0?.reusableViewDelegate = self
        })
        
        self.vwSportParticipate?.btnSelect.tag = SportsEnum.Sports.rawValue
        self.vwhometown?.btnSelect.tag = SportsEnum.HomeTown.rawValue
        self.vwyearscoaching?.btnSelect.tag = SportsEnum.YearofCoach.rawValue
        self.vwageGroupsdrop?.btnSelect.tag = SportsEnum.AgeClubGroups.rawValue
        self.vwrecreational?.btnSelect.tag = SportsEnum.AgeRecreational.rawValue
        self.vwAgeGroups?.btnSelect.tag = SportsEnum.AgeGroups.rawValue
        self.vwGrades?.btnSelect.tag = SportsEnum.Grades.rawValue
        self.vwHeight?.btnSelect.tag = SportsEnum.Height.rawValue
        
        self.vwTeamName?.txtInput.autocapitalizationType = .words
       
        
        self.ageNo?.isSelectBtn = true
        self.vwAgeGroups?.isHidden = true
        self.ageYes?.isSelectBtn = false
        
        self.RecreationalNo?.isSelectBtn = true
        self.vwrecreational?.isHidden = true
        self.RecreationalYes?.isSelectBtn = false
        
        self.ClubNo?.isSelectBtn = true
        self.vwageGroupsdrop?.isHidden = true
        self.ClubYes?.isSelectBtn = false
        
      if self.isFromEditProfile == true {
            self.getUserInfo()
        }
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
    
}



//MARK: - Validation
extension SportsProfileViewController: ListcommoncataDelegate {
    func selectAdvertiseData(obj: SupportCategoryModel) {
        
    }
    
    func selectFeedbackData(obj: FeedBackCategoryModel) {
        
    }
    
    func selectsupportData(obj: SupportCategoryModel) {
        
    }
    

    func selectSportsData(arr: [SportsModel]) {
        self.arrSports = arr
        self.cvSportsSelection?.reloadData()
    }
    
    
}


// MARK: - UISlider Delegates
extension SportsProfileViewController : jobCategoryDelegate {
    func selectedCategories(arr: [SportsModel]) {
        self.arrSports = arr
        self.cvSportsSelection?.reloadData()
    }
}
//MARK: - Tableview Observer
extension SportsProfileViewController {
    
    private func addCollectionViewOberver() {
        self.cvSportsSelection?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    private func removeCollectionViewObserver() {
        
        if self.cvSportsSelection?.observationInfo != nil {
            self.cvSportsSelection?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UICollectionView {
            if obj == self.cvSportsSelection && keyPath == ObserverName.kcontentSize {
                self.constraintSportsCollectionHeight?.constant = self.cvSportsSelection?.contentSize.height ?? 0.0
                self.view.layoutIfNeeded()
                self.view.updateConstraints()
            }
        }
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension SportsProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrSports.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SportParticipationCell.self)
        
        
        if self.arrSports.count > 0{
            cell.lblSportsName?.text = self.arrSports[indexPath.row].name
            
            cell.btnClose?.tag = indexPath.row
            cell.btnClose?.addTarget(self, action: #selector(self.btnDeleteCatgoryClicked(_:)), for: .touchUpInside)
        }
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @objc func btnDeleteCatgoryClicked(_ btn : UIButton){
        if self.arrSports.count > 0 {
            let obj = self.arrSports[btn.tag]
            self.arrSports.removeAll(where: {$0.id == obj.id})
            self.cvSportsSelection?.reloadData()
        }
    }
}
// MARK: - ReusableView Delegate
extension SportsProfileViewController : ReusableViewDelegate {
    func leftButtonClicked(_ sender: UIButton) {
        
    }
    func rightButtonClicked(_ sender: UIButton) {
    }
   
    func buttonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        switch SportsEnum.init(rawValue: sender.tag) ?? .HomeTown {
        case .Sports:
            self.appNavigationController?.present(ListcommondataPopupViewController.self,configuration: { vc in
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                vc.delegate = self
                vc.arrSelectedSports = self.arrSports.map({$0.name})
//                vc.OpenFromType = .SportsData
//                if let data = self.selectedSportsData {
//                    vc.SelectedSportsData = data
//                }
            })
            
        case .HomeTown:
           return
        case .AgeGroups:
            self.openAgeGroupsClicked(sender)
        case .YearofCoach:
            self.openYearCoachingClicked(sender)
        case .AgeRecreational:
            self.openAgeRecreationalClicked(sender)
        case .AgeClubGroups:
            self.openAgeClubClicked(sender)

        case .Grades:
            self.GradesClicked(sender)
        case .Height:
            self.openHeightClicked(sender)
        }
    }

    @objc func openYearCoachingClicked(_ sender : UIButton){
        
//    private func openGender(sender : UIButton){
        let arr = self.arrYearcoach.map({$0.name})
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrYearcoach.count, by: 1){
            if (self.vwyearscoaching?.txtInput.text ?? "") == self.arrYearcoach[i].name {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select Year Coach  ", rows: arr, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            //self.selectedGender = self.arrGender[indexes]
            if self.arrYearcoach.count > 0{
                self.vwyearscoaching?.txtInput.text = self.arrYearcoach[indexes].name
                self.selectedYearcoach = self.arrYearcoach[indexes]
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    
    @objc func openAgeGroupsClicked(_ sender : UIButton){
        
//    private func openGender(sender : UIButton){
       
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrageGroup.count, by: 1){
            if (self.vwAgeGroups?.txtInput.text ?? "") == self.arrageGroup[i] {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select Duration", rows: self.arrageGroup, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            self.vwAgeGroups?.txtInput.text = self.arrageGroup[indexes]
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    @objc func openAgeRecreationalClicked(_ sender : UIButton){
        
//    private func openGender(sender : UIButton){
       
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrageGroup.count, by: 1){
            if (self.vwrecreational?.txtInput.text ?? "") == self.arrageGroup[i] {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select Duration", rows: self.arrageGroup, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            self.vwrecreational?.txtInput.text = self.arrageGroup[indexes]
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    
    @objc func openAgeClubClicked(_ sender : UIButton){
        
//    private func openGender(sender : UIButton){
       
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrageGroup.count, by: 1){
            if (self.vwageGroupsdrop?.txtInput.text ?? "") == self.arrageGroup[i] {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select Duration", rows: self.arrageGroup, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            self.vwageGroupsdrop?.txtInput.text = self.arrageGroup[indexes]
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    
    
    @objc func GradesClicked(_ sender : UIButton){
        
//    private func openGender(sender : UIButton){
        let arr = self.arrGrades.map({$0.name})
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrGrades.count, by: 1){
            if (self.vwyearscoaching?.txtInput.text ?? "") == self.arrGrades[i].name {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select Grades ", rows: arr, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            //self.selectedGender = self.arrGender[indexes]
            if self.arrGrades.count > 0{
                self.vwyearscoaching?.txtInput.text = self.arrGrades[indexes].name
                self.SelectedGrade = self.arrGrades[indexes]
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    
    @objc func openHeightClicked(_ sender : UIButton){
        
//    private func openGender(sender : UIButton){
       
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrHeight.count, by: 1){
            if (self.vwHeight?.txtInput.text ?? "") == self.arrHeight[i] {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select weight", rows: self.arrHeight, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            self.vwHeight?.txtInput.text = self.arrHeight[indexes]
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
   
}



//MARK: - IBAction Method
extension SportsProfileViewController {
    @IBAction func btnNextClick() {
        if arrSports.count > 0 {
        var arrsport = [String]()
            for i in 0..<arrSports.count {
                let selectSport = arrSports[i]
                arrsport.append(selectSport.name)
            }
        
      
        let YearofCoach = self.selectedYearcoach
        let Grades = self.SelectedGrade
        
        var selectAge : String = (self.ageNo?.isSelectBtn ?? false) ? "0" : "1"
        var selectRecreational : String = (self.RecreationalNo?.isSelectBtn ?? false) ? "0" : "1"
        var selectClub : String = (self.ClubNo?.isSelectBtn ?? false) ? "0" : "1"
//        var selectClubYes : String = (self.ClubYes?.isSelectBtn ?? false) ? "0" : "1"
        
       
        dicprofiledetail[kheadline] = vwHeadline?.txtInput.text ?? ""
        dicprofiledetail[kteamName] = vwTeamName?.txtInput.text ?? ""
        dicprofiledetail[kplayerPosition] = vwPlayerPosition?.txtInput.text ?? ""
        dicprofiledetail[kheight] = vwHeight?.txtInput.text ?? ""
        dicprofiledetail[kweight] = vwWeight?.txtInput.text ?? ""
        dicprofiledetail[kgpa] = vwGPA?.txtInput.text ?? ""
        dicprofiledetail[kfavoriteSportsTeam] = vwFavouriteSports?.txtInput.text ?? ""
        dicprofiledetail[kadultLeagues] = vwAdultLeagues?.txtInput.text ?? ""
        dicprofiledetail[kfax] = VwFax?.txtInput.text ?? ""
        dicprofiledetail[kathleticDirector] = vwAthleticDirector?.txtInput.text ?? ""
        dicprofiledetail[kathleticDirectorEmail] = vwAthleticEmail?.txtInput.text ?? ""
        dicprofiledetail[kgrades] = Grades?.apiValue
        dicprofiledetail[kmascot] = vwmasot?.txtInput.text ?? ""
        dicprofiledetail[khometown] = vwhometown?.txtInput.text ?? ""
        dicprofiledetail[kcoachYear] = YearofCoach?.apiValue
        dicprofiledetail[kwinRecord] = vwWins?.txtInput.text ?? ""
        dicprofiledetail[klossesRecord] = vwloses?.txtInput.text ?? ""
        dicprofiledetail[ktiesRecord] = vwties?.txtInput.text ?? ""
        dicprofiledetail[kpreviousExperience] = vwexperience?.txtInput.text ?? ""
        dicprofiledetail[kschoolName] = vwclubname?.txtInput.text ?? ""
        dicprofiledetail[kschoolAddress] = vwclubadress?.txtInput.text ?? ""
        dicprofiledetail[kisAgeGroup] = selectAge
        dicprofiledetail[kclubsTeams] = selectClub
        dicprofiledetail[krecreationalTeams] = selectRecreational
        dicprofiledetail[kageGroups] = vwAgeGroups?.txtInput.text ?? ""
        dicprofiledetail[krecreationalTeamsAgeGroup] = vwrecreational?.txtInput.text ?? ""
        dicprofiledetail[kclubTeamsAge] = vwageGroupsdrop?.txtInput.text ?? ""
        dicprofiledetail[kprofileStatus] = "2"
      
        
        if self.isFromEditProfile {
            dicprofiledetail[ksport] = arrsport
        } else {
            dicprofiledetail[ksport] = self.arrSports.map({$0.name})
        }
        
        if isFromEditProfile {
            self.UpdateProfile()
        }
        else {
            self.completeProfile()
        }
    }
//        self.completeProfile()
    }
    
    @IBAction func btnageNoClicked(_ sender: YesNoButton) {
        self.ageNo?.isSelectBtn = true
        self.vwAgeGroups?.isHidden = true
        self.ageYes?.isSelectBtn = false
    }
    
    @IBAction func btnageYesClicked(_ sender: YesNoButton) {
        self.ageNo?.isSelectBtn = false
        self.vwAgeGroups?.isHidden = false
        self.ageYes?.isSelectBtn = true
    }
    
    @IBAction func btnrecreationalNoClicked(_ sender: YesNoButton) {
        self.RecreationalNo?.isSelectBtn = true
        self.vwrecreational?.isHidden = true
        self.RecreationalYes?.isSelectBtn = false
    }
    
    
    @IBAction func btnrecreationalYesClicked(_ sender: YesNoButton) {
        self.RecreationalNo?.isSelectBtn = false
        self.vwrecreational?.isHidden = false
        self.RecreationalYes?.isSelectBtn = true
    }
    
    @IBAction func btnClubNoClicked(_ sender: YesNoButton) {
        self.ClubNo?.isSelectBtn = true
        self.vwageGroupsdrop?.isHidden = true
        self.ClubYes?.isSelectBtn = false
    }
    
    @IBAction func btnClubYesClicked(_ sender: YesNoButton) {
        self.ClubNo?.isSelectBtn = false
        self.vwageGroupsdrop?.isHidden = false
        self.ClubYes?.isSelectBtn = true
    }
}
// MARK: - API Call
extension SportsProfileViewController {
    private func getUserInfo(){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.getUserInfo(with: param, success: { (user,msg) in
                self.userProfileData = user
                self.setProfileData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    private func completeProfile(){
            if let user = UserModel.getCurrentUserFromDefault() {
                dicprofiledetail[klangType] = Rosterd.sharedInstance.languageType
                dicprofiledetail[ktoken] = user.token

                    let param : [String:Any] = [
                        kData : dicprofiledetail
                        
                    ]
            UserModel.completeProfile(with: param, success: { (model, msg) in
                self.appNavigationController?.push(SuggestionsViewController.self,configuration: { vc in

                })
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error,themeStyle : .error)
                }
            })
     }
    }

    private func UpdateProfile(){
      
            if let user = UserModel.getCurrentUserFromDefault() {

                dicprofiledetail[klangType] = Rosterd.sharedInstance.languageType
                dicprofiledetail[ktoken] = user.token

                    let param : [String:Any] = [
                        kData : dicprofiledetail
                    ]
            UserModel.SaveProfileUser(with: param, success: { (model, msg) in
                self.appNavigationController?.popToRootViewController(animated: true)
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error,themeStyle : .error)
                }
            })
     }
    }
    
    private func setProfileData(){
        if let obj = self.userProfileData {
            
            if obj.recreationalTeams == "0" {
                self.RecreationalNo?.isSelectBtn = true
                self.vwrecreational?.isHidden = true
                self.RecreationalYes?.isSelectBtn = false
            } else {
                self.RecreationalNo?.isSelectBtn = false
                self.RecreationalYes?.isSelectBtn = true
                self.vwrecreational?.isHidden = false
            }            
            if obj.clubsTeams == "0" {
                self.ClubNo?.isSelectBtn = true
                self.vwageGroupsdrop?.isHidden = true
                self.ClubYes?.isSelectBtn = false
            } else {
                self.ClubNo?.isSelectBtn = false
                self.ClubYes?.isSelectBtn = true
                self.vwageGroupsdrop?.isHidden = false
            }
            if obj.isAgeGroup == "0" {
                self.ageNo?.isSelectBtn = true
                self.vwAgeGroups?.isHidden = true
                self.ageYes?.isSelectBtn = false
            } else {
                self.ageYes?.isSelectBtn = true
                self.ageNo?.isSelectBtn = false
                self.vwAgeGroups?.isHidden = false
            }
            self.arrSports = obj.sport
            self.cvSportsSelection?.reloadData()
            self.vwrecreational?.txtInput.text = obj.recreationalTeamsAgeGroup
            self.vwAgeGroups?.txtInput.text = obj.ageGroups
            self.vwageGroupsdrop?.txtInput.text = obj.clubTeamsAge
            self.vwHeadline?.txtInput.text = obj.headline
            self.vwclubname?.txtInput.text = obj.clubName
            self.vwclubadress?.txtInput.text = obj.clubAddress
            self.vwhometown?.txtInput.text = obj.hometown
            self.vwPlayerPosition?.txtInput.text = obj.playerPosition
            self.vwHeight?.txtInput.text = obj.height
            self.vwWeight?.txtInput.text = obj.weight
            self.vwGPA?.txtInput.text = obj.gpa
            self.vwFavouriteSports?.txtInput.text = obj.favoriteSportsTeam
            self.VwFax?.txtInput.text = obj.fax
            self.vwAthleticDirector?.txtInput.text = obj.athleticDirector
            self.vwAthleticEmail?.txtInput.text = obj.athleticDirectorEmail
            self.vwclubname?.txtInput.text = obj.schoolName
            self.vwclubadress?.txtInput.text = obj.schoolAddress
            self.vwWins?.txtInput.text = obj.winRecord
            self.vwloses?.txtInput.text = obj.lossesRecord
            self.vwties?.txtInput.text = obj.tiesRecord
            self.vwexperience?.txtInput.text = obj.previousExperience
            self.vwGrades?.txtInput.text = obj.grades.name
            self.vwmasot?.txtInput.text = obj.mascot
            self.vwyearscoaching?.txtInput.text = obj.coachYear.name
            self.vwAdultLeagues?.txtInput.text = obj.adultLeagues
            self.vwTeamName?.txtInput.text = obj.teamName
            self.selectedRole = obj.role
            if let obj = self.selectedRole{
                switch obj {
                case .fan:
                    self.vwclubname?.isHidden = true
                    self.vwclubadress?.isHidden = true
                    self.vwAgegroup?.isHidden = true
                    self.vwRecreationalTeams?.isHidden = true
                    self.vwClubTeams?.isHidden = true
                    self.vwContactinfo?.isHidden = true
                    self.vwRecords?.isHidden = true
                    self.vwExperience?.isHidden = true
                case .athlete:
                    self.vwclubname?.isHidden = true
                    self.vwclubadress?.isHidden = true
                    self.vwAgegroup?.isHidden = true
                    self.vwHeadline?.isHidden = false
                    self.vwRecreationalTeams?.isHidden = true
                    self.vwClubTeams?.isHidden = true
                    self.vwRecords?.isHidden = true
                    self.vwTeamName?.isHidden = false
                    self.vwPlayerPosition?.isHidden = false
                    self.vwContactinfo?.isHidden = true
                    self.vwExperience?.isHidden = true
                    self.vwGrades?.isHidden = true
                    self.vwmasot?.isHidden = true
                    self.vwhometown?.isHidden = true
                    self.vwyearscoaching?.isHidden = true
                case .schoolclub:
                    self.vwclubname?.isHidden = true
                    self.vwclubadress?.isHidden = true
                    self.vwAgegroup?.isHidden = false
                    self.vwRecreationalTeams?.isHidden = false
                    self.vwClubTeams?.isHidden = false
                    self.vwHeadline?.isHidden = true
                    self.vwPErsonal?.isHidden = true
                    self.vwContactinfo?.isHidden = false
                    self.vwTeamName?.isHidden = true
                    self.vwPlayerPosition?.isHidden = true
                    self.vwExperience?.isHidden = true
                    self.lblHederlabel?.text = "Basic Information"
                    self.vwhometown?.isHidden = true
                    self.vwyearscoaching?.isHidden = true
                case .coachrecruiter:
                    self.vwAgegroup?.isHidden = true
                    self.vwRecreationalTeams?.isHidden = true
                    self.vwClubTeams?.isHidden = true
                    self.vwWeight?.isHidden = true
                    self.vwPErsonal?.isHidden = true
                    self.vwContactinfo?.isHidden = true
                    self.vwRecords?.isHidden = false
                    self.vwExperience?.isHidden = false
                    self.vwHeadline?.isHidden = true
                    self.lblHederlabel?.text = "Basic Information"
                }
            }
//            self.selectedschool = obj.isClubTeams
//            if let obj = self.selectedschool{
//                switch obj {
//                case .School:
//                    self.vwClubTeams?.isHidden = true
//                    self.vwRecreationalTeams?.isHidden = true
//                    self.vwAgegroup?.isHidden = true
//                    self.vwGrades?.isHidden = false
//                    self.vwmasot?.isHidden = false
//                    self.vwRecords?.isHidden = true
//                case .Club:
//                    self.vwGrades?.isHidden = true
//                    self.vwmasot?.isHidden = true
//                    self.vwRecords?.isHidden = true
//
//                }
//            }
//            self.selectedCoach = obj.isCoach
//            if let obj = self.selectedCoach{
//
//                switch obj {
//                case .Coach:
//                    self.vwGrades?.isHidden = true
//                    self.vwTeamName?.isHidden = true
//                    self.vwPlayerPosition?.isHidden = true
//                    self.vwmasot?.isHidden = true
//                    self.vwRecords?.isHidden = false
//
//                case .Recruiter:
//                    self.vwRecords?.isHidden = true
//                    self.vwGrades?.isHidden = true
//                    self.vwTeamName?.isHidden = true
//                    self.vwPlayerPosition?.isHidden = true
//                    self.vwmasot?.isHidden = true
//                }
//            }
            
            
        }
    }
}
// MARK: - ViewControllerDescribable
extension SportsProfileViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension SportsProfileViewController: AppNavigationControllerInteractable { }

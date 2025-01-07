//
//  ResumeViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 15/02/22.
//

import UIKit

class ResumeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwEmptyview: UIView?
    @IBOutlet weak var lblEmpty: UILabel?
    @IBOutlet weak var vwUserview: UIView?
    @IBOutlet weak var vwHighlightsview: UIView?
    @IBOutlet weak var vwAboutview: UIView?
    @IBOutlet weak var vwAcademicsview: UIView?
    @IBOutlet weak var vwAthleticParticipationview: UIView?
    @IBOutlet weak var vwAwardsview: UIView?
    @IBOutlet weak var vwCoachingview: UIView?
    
    @IBOutlet weak var imgUser: UIImageView?
    
    @IBOutlet weak var lblFirstName: UILabel?
    @IBOutlet weak var lblLastName: UILabel?
    @IBOutlet weak var lblSportName: UILabel?
    @IBOutlet weak var lblinsta : UILabel?
    @IBOutlet weak var lblfb : UILabel?
    @IBOutlet weak var lbllink : UILabel?
    @IBOutlet weak var lblTwitter: UILabel?
    @IBOutlet weak var lblSubAcdemicPhone: UILabel?
    @IBOutlet weak var lblSubSat: UILabel?
    @IBOutlet weak var lblsubAct: UILabel?
    @IBOutlet weak var lblSubGpa: UILabel?
    @IBOutlet weak var lblSubSchoolAdress: UILabel?
    @IBOutlet weak var lblsubSchool: UILabel?
    @IBOutlet weak var lblsubPhone: UILabel?
    @IBOutlet weak var lblSubEmail: UILabel?
    @IBOutlet weak var lblsubAdress: UILabel?
    @IBOutlet weak var cvAlbum: UICollectionView?
    
    @IBOutlet  var lblHeaderMain: [UILabel]?
    @IBOutlet  var lblHeader: [UILabel]?
    @IBOutlet  var lblSubHeader: [UILabel]?
    
    @IBOutlet weak var ConstraintExtracurriculars: NSLayoutConstraint?
    @IBOutlet weak var tblExtracurriculars: UITableView?
    @IBOutlet weak var tblAthletic: UITableView?
    @IBOutlet weak var ConstrainttblAthletic: NSLayoutConstraint?
    @IBOutlet weak var tblAchievement: UITableView?
    @IBOutlet weak var ConstrainttblAchievement: NSLayoutConstraint?
    @IBOutlet weak var tblReference: UITableView?
    @IBOutlet weak var ConstrainttblReference: NSLayoutConstraint?
    
    @IBOutlet weak var vwMAinCurricular: UIView?
    @IBOutlet weak var vwMAinAwards: UIView?
    @IBOutlet weak var vwTwitter : UIView?
    @IBOutlet weak var vwinsta : UIView?
    @IBOutlet weak var vwTfb : UIView?
    @IBOutlet weak var vwlink : UIView?
    
    @IBOutlet weak var btnBack : UIButton?
    @IBOutlet weak var lblMyresume : UILabel?
    
    @IBOutlet weak var vwMore: UIView!
    @IBOutlet weak var MainView: UIScrollView?
    // MARK: - Variables
    var GetResume : ResumeModel?
    private var arrAthlics : [AthlicsModel] = []
    private var arrCurricular : [CurricularsModel] = []
    private var arrAchievement : [AchievementsModel] = []
    private var arrReference : [ReferenceModel] = []
    private var arrHighlights : [AddPhotoVideoModel] = []
    var Twitter : String = ""
    var Insta : String = ""
    var Fb : String = ""
    var Link : String = ""
    var userId : String = ""
    let popover = Popover()
    let deleteView: HighlightsView = .fromNib()
    var isFromChat : Bool = false
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.addTableviewOberver()
        self.vwEmptyview?.isHidden = true
        self.getUserResume()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.imgUser?.cornerRadius = 30
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
       
    }
    
    @IBAction func btnTwitterClick(_ sender : UIButton) {
        if let url = URL(string: self.Twitter) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @IBAction func btninstaClick(_ sender : UIButton) {
        if let url = URL(string: self.Insta) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @IBAction func btnfbClick(_ sender : UIButton) {
        if let url = URL(string: self.Fb) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @IBAction func btnlinkClick(_ sender : UIButton) {
        if let url = URL(string: self.Link) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            safariVC.modalTransitionStyle = .crossDissolve
            safariVC.modalPresentationStyle = .overFullScreen
            self.present(safariVC, animated: true,completion: nil)
        }
    }
    
    @IBAction func btnBackClick(_ sender : UIButton){
        if self.isFromChat == true {
            self.appNavigationController?.popViewController(animated: true)
        } else {
            self.appNavigationController?.showDashBoardViewController()
        }
        
    }
    
    @IBAction func btnMoreClick(_ sender : UIButton){
        deleteView.btnEdit?.setTitle("Share", for: .normal)
        deleteView.btnDelete?.setTitle("Download", for: .normal)
        deleteView.btnEdit?.setTitleColor(UIColor.CustomColor.messageColor, for: .normal)
        deleteView.btnEdit?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        deleteView.btnDelete?.setTitleColor(UIColor.CustomColor.messageColor, for: .normal)
        deleteView.btnDelete?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        deleteView.frame = CGRect(x: 0, y: 0, width: 120, height: 80)
      
        deleteView.btnEdit?.tag = sender.tag
        deleteView.btnEdit?.addTarget(self, action: #selector(self.btnEditClicked(_:)), for: .touchUpInside)
        
        deleteView.btnDelete?.tag = sender.tag
        deleteView.btnDelete?.addTarget(self, action: #selector(self.btnDeleteClicked(_:)), for: .touchUpInside)
        
        var showpoint : CGPoint = (sender.globalFrame!.origin)
        showpoint.x = showpoint.x + (sender.frame.width)
        showpoint.y = showpoint.y + (sender.frame.height)
        popover.popoverType = .down
     popover.willDismissHandler = { () in
       
     }
        popover.show(deleteView, point: showpoint)
    }
    @objc func btnDeleteClicked(_ sender : UIButton){
        self.showAlert(withTitle: "", with: "Download Resume", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            self.GetResumeAPICall()
        }, secondButton: ButtonTitle.No, secondHandler: nil)
        popover.dismiss()
    }
    
    @objc func btnEditClicked(_ sender : UIButton){
        popover.dismiss()
        self.appNavigationController?.push(ResumeShareViewController.self,configuration:  { vc in
            vc.userResumeId = self.GetResume?.resumeShareProfileId ?? ""
        })
    }
}
// MARK: - Init Configure
extension ResumeViewController {
    
    
    private func InitConfig(){
        self.tblAthletic?.register(AthleticParticipationCell.self)
        self.tblAthletic?.rowHeight = UITableView.automaticDimension
        self.tblAthletic?.delegate = self
        self.tblAthletic?.dataSource = self
        
        self.tblAchievement?.register(AthleticParticipationCell.self)
        self.tblAchievement?.rowHeight = UITableView.automaticDimension
        self.tblAchievement?.delegate = self
        self.tblAchievement?.dataSource = self
        
        self.tblReference?.register(ReferenceDetailCell.self)
        self.tblReference?.rowHeight = UITableView.automaticDimension
        self.tblReference?.delegate = self
        self.tblReference?.dataSource = self
        
        self.tblExtracurriculars?.register(ExtracurricularsCell.self)
        self.tblExtracurriculars?.rowHeight = UITableView.automaticDimension
        self.tblExtracurriculars?.delegate = self
        self.tblExtracurriculars?.dataSource = self
        
        if let cv = self.cvAlbum {
            cv.register(HighlightsCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        self.lblFirstName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 39.0))
        self.lblFirstName?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblLastName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 39.0))
        self.lblLastName?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblMyresume?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblMyresume?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblHeader?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        })
     
        [self.lblsubAct,self.lblsubPhone,self.lblsubSchool,self.lblSubSat,self.lblSubGpa,self.lblSubEmail,self.lblsubAdress,self.lblSubAcdemicPhone,self.lblSubSchoolAdress].forEach({
            $0?.textColor = UIColor.CustomColor.labelTextColor
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        self.lblSubHeader?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.lblHeaderMain?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        })
        
        delay(seconds: 0.2) {
            [self.vwAboutview,self.vwAwardsview,self.vwCoachingview,self.vwAcademicsview,self.vwHighlightsview,self.vwAthleticParticipationview].forEach({
                $0?.cornerRadius = 20
                $0?.backgroundColor = UIColor.CustomColor.SupportTopBGcolor
            })
        }
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpShopnavTitle(title: "My Resume", TitleColor: UIColor.black, righttitle: "", navigationItem: self.navigationItem)
        appNavigationController?.btnNextClickBlock = {
            self.showAlert(withTitle: "", with: "Download Resume", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
                self.GetResumeAPICall()
            }, secondButton: ButtonTitle.No, secondHandler: nil)
        }
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

//MARK: - Tableview Observer
extension ResumeViewController {
    
    private func addTableviewOberver() {
        self.tblAthletic?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblExtracurriculars?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblAchievement?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tblReference?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableviewObserver() {
        if self.tblAthletic?.observationInfo != nil {
            self.tblAthletic?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblExtracurriculars?.observationInfo != nil {
            self.tblExtracurriculars?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblAchievement?.observationInfo != nil {
            self.tblAchievement?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tblReference?.observationInfo != nil {
            self.tblReference?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblAthletic && keyPath == ObserverName.kcontentSize {
                self.ConstrainttblAthletic?.constant = self.tblAthletic?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblExtracurriculars && keyPath == ObserverName.kcontentSize {
                self.ConstraintExtracurriculars?.constant = self.tblExtracurriculars?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblAchievement && keyPath == ObserverName.kcontentSize {
                self.ConstrainttblAchievement?.constant = self.tblAchievement?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UITableView {
            if obj == self.tblReference && keyPath == ObserverName.kcontentSize {
                self.ConstrainttblReference?.constant = self.tblReference?.contentSize.height ?? 0.0
            }
            
        }
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension ResumeViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrHighlights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HighlightsCell.self)
        cell.vwPlusView?.isHidden = true
        cell.VwMainimageView?.isHidden = false
        cell.btnCancel?.isHidden = true
        cell.lblName?.isHidden = false
        cell.lblName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        cell.lblName?.textColor = UIColor.CustomColor.blackColor
        cell.imgVideo?.cornerRadius = 13.0
        cell.setHighlightsData(obj: self.arrHighlights[indexPath.row])
        
        cell.btnImage?.tag = indexPath.row
        cell.btnImage?.addTarget(self, action: #selector(self.btnImageClicked(_:)), for: .touchUpInside)
        
        cell.btnVideo?.tag = indexPath.row
        cell.btnVideo?.addTarget(self, action: #selector(self.btnVideoClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    @objc func btnVideoClicked(_ sender : UIButton){
        
        if self.arrHighlights.count > 0 {
            let obj = self.arrHighlights[sender.tag]
            if let videoURL = URL(string: obj.media) {
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    if let myplayer = playerViewController.player {
                        myplayer.play()
                    }
                }
            }
        }
    }
    
    @objc func btnImageClicked(_ sender : UIButton){
        if self.arrHighlights.count > 0 {
            let obj = self.arrHighlights[sender.tag]
            self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
                vc.imageUrl = obj.media
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
            })
        }
    }
}
//MARK:- UITableView Delegate
extension ResumeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblExtracurriculars {
            return self.arrCurricular.count
        } else if tableView == self.tblAchievement {
            return self.arrAchievement.count
        } else if tableView == self.tblReference {
            return self.arrReference.count
        } else {
            return self.arrAthlics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tblExtracurriculars {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: ExtracurricularsCell.self)
            if self.arrCurricular.count > 0 {
                let obj = self.arrCurricular[indexPath.row]
                cell.lblValue?.text = obj.text
            }
            return cell
        } else if tableView == self.tblAchievement {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: AthleticParticipationCell.self)
            cell.vwUpView?.isHidden = true
            cell.vwDownView?.isHidden = true
            cell.vwSeprate?.isHidden = true
            
            if self.arrAchievement.count > 0 {
                let obj = self.arrAchievement[indexPath.row]
                cell.lblPosition?.text = obj.text
            }
            return cell
        } else if tableView == self.tblReference {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: ReferenceDetailCell.self)
            if self.arrReference.count - 1 == indexPath.row {
                cell.vwSepratoe?.isHidden = true
            } else {
                cell.vwSepratoe?.isHidden = false
            }
            if self.arrReference.count > 0 {
                let obj = self.arrReference[indexPath.row]
                cell.lblPhone?.text = format(with: Masking.kPhoneNumberMasking, phone: obj.Phone)
                cell.lblAcademic?.text = obj.academic
                cell.lblCoachname?.text = obj.Name
                cell.lblEmail?.text = obj.Email
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: AthleticParticipationCell.self)
            if self.arrAthlics.count - 1 == indexPath.row {
                cell.vwSeprate?.isHidden = true
            } else {
                cell.vwSeprate?.isHidden = false
            }
            if self.arrAthlics.count > 0 {
                let obj = self.arrAthlics[indexPath.row]
                cell.lblTeam?.text = obj.Name
                cell.lblPosition?.text = obj.Position
                cell.lblSport?.text = obj.season
                cell.layoutIfNeeded()
            }
            return cell
        }
    }
}
// MARK: - ViewControllerDescribable
extension ResumeViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ResumeViewController: AppNavigationControllerInteractable { }

// MARK: - Api Calling
extension ResumeViewController {
    private func getUserResume(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kuserId : self.userId
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            
            ResumeModel.getUserResume(with: param, success: { (Resume, message) in
                self.GetResume = Resume
                self.getResume()
                self.vwEmptyview?.isHidden = true
                self.MainView?.isHidden = false
                self.vwMore?.isHidden = false
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.vwMore?.isHidden = true
                    self.MainView?.isHidden = true
                    self.vwEmptyview?.isHidden = false
                    self.lblEmpty?.text = error
                }
            })
        }
    }
    private func GetResumeAPICall() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                ktoken : user.token,
                klangType : Rosterd.sharedInstance.languageType,
                kuserId : self.userId
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.GetResume(with: param, success: { (strData,msg) in
                guard let url = URL(string: strData) else { return }
                UIApplication.shared.open(url)
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                //              if !error.isEmpty {
                //                  self.showMessage(error, themeStyle: .error)
                //              }
            })
        }
    }
    
    func getResume() {
        if let Data = self.GetResume {
            if Data.teams != [] {
                self.arrAthlics = Data.teams
                self.tblAthletic?.reloadData()
                self.vwAthleticParticipationview?.isHidden = false
            } else {
                self.vwAthleticParticipationview?.isHidden = true
            }
            if Data.curriculars != [] {
                self.arrCurricular = Data.curriculars
                self.tblExtracurriculars?.reloadData()
                self.vwMAinCurricular?.isHidden = false
            } else {
                self.vwMAinCurricular?.isHidden = true
            }
            if Data.achievements != [] {
                self.arrAchievement = Data.achievements
                self.tblAchievement?.reloadData()
                self.vwMAinAwards?.isHidden = false
            } else {
                self.vwMAinAwards?.isHidden = true
            }
            if Data.references != [] {
                self.arrReference = Data.references
                self.tblReference?.reloadData()
                self.vwCoachingview?.isHidden = false
            } else {
                self.vwCoachingview?.isHidden = true
            }
            if Data.highlights != [] {
                self.arrHighlights = Data.highlights
                self.cvAlbum?.reloadData()
            } else {
                self.vwHighlightsview?.isHidden = true
            }
            self.lblsubAdress?.text = Data.address
            self.lblSubEmail?.text = Data.email
            self.lblsubPhone?.text = format(with: Masking.kPhoneNumberMasking, phone: Data.phone)
            self.lblsubSchool?.text = Data.schoolName
            self.lblSubSchoolAdress?.text = Data.schoolAddress
            self.lblSubGpa?.text = Data.gpa
            self.lblsubAct?.text = Data.actScore
            self.lblSubSat?.text = Data.satScore
            if Data.twitter == "" {
                self.vwTwitter?.isHidden = true
            } else {
                self.vwTwitter?.isHidden = false
                self.lblTwitter?.text = Data.twitter
                self.Twitter = Data.twitter
            }
            if Data.instagram == "" {
                self.vwinsta?.isHidden = true
            } else {
                self.vwinsta?.isHidden = false
                self.lblinsta?.text = Data.instagram
                self.Insta = Data.instagram
            }
            if Data.facebook == "" {
                self.vwTfb?.isHidden = true
            } else {
                self.vwTfb?.isHidden = false
                self.lblfb?.text = Data.facebook
                self.Fb = Data.facebook
            }
            if Data.linkedIn == "" {
                self.vwlink?.isHidden = true
            } else {
                self.vwlink?.isHidden = false
                self.lbllink?.text = Data.linkedIn
                self.Link = Data.linkedIn
            }
                self.imgUser?.setImage(withUrl: Data.userThumbProfileImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                self.lblSportName?.text = Data.sportsData.compactMap({$0.name}).joined(separator: ", ")
                let fullName = Data.fullName.components(separatedBy: " ")
                if fullName.count == 2 {
                    self.lblFirstName?.text = fullName.first
                    self.lblLastName?.text = fullName.last
                } else {
                    self.lblLastName?.text = Data.fullName
                    self.lblFirstName?.isHidden = true
                }
            
        }
    }
}

// MARK: - SFSafariViewControllerDelegate
extension ResumeViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

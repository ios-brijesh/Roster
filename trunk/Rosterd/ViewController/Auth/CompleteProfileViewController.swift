//
//  CompleteProfileViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit
import YPImagePicker
import SVProgressHUD

enum profileEnum : Int {
    case coach
    case School
    case DOB
    case Gender
}

class CompleteProfileViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var lblHighlights: UILabel?
    
    
    @IBOutlet weak var vwProfile: UIView?
    
    @IBOutlet weak var imgProfile: UIImageView?
    @IBOutlet weak var imgrosterd: UIImageView?
    
    @IBOutlet weak var vwNickName: ReusableView?
    @IBOutlet weak var vwUserName: ReusableView?
    @IBOutlet weak var vwDateOfBirth: ReusableView?
    @IBOutlet weak var vwGender: ReusableView?
    @IBOutlet weak var vwPhoneNumber: ReusableView?
    @IBOutlet weak var vwFavoriteSportsTeam: ReusableView?
    @IBOutlet weak var vwClub: ReusableView?
    @IBOutlet weak var vwCoach: ReusableView?
    @IBOutlet weak var VwClubAddress : ReusableView?
    
    @IBOutlet weak var btnAddProfile: UIButton?
  
    @IBOutlet weak var cvHighlights: UICollectionView?
    
    // MARK: - Variables
    var isFromLogin : Bool = false
    private let imagePicker = ImagePicker()
    private var arrGender : [GenderEnum] = [.Male,.Female,.PreferNotToSay]
    private var selectedGender : GenderEnum = .Male
    private var arrClubSchool : [SchoolClubEnum] = [.Club,.School]
    private var selectedClubSchool : SchoolClubEnum = .Club
    private var arrCoach : [CoachEnum] = [.Coach,.Recruiter]
    private var selectedCoach : CoachEnum = .Coach
    private var mediaName : String = ""
    public var selectedDates = [Date]()
    private var arrYear : [String] = []
    private var userProfileData : UserModel?
    let popover = Popover()
    let deleteView: HighlightsView = .fromNib()
    var selectedRole : userRole = .fan
    var profiledetail  : [String:Any] = [:]
    var isFromEditProfile : Bool = false
    private var arrhighlights : [AddPhotoVideoModel] = []
    var selectedItems = [YPMediaItem]()
    var arrStoryMedia = [typeAliasDictionary]()
    private var selectedDate : Date?
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imgProfile?.cornerRadius = (self.imgProfile?.frame.height ?? 0.0) / 2
        self.imgrosterd?.cornerRadius = (self.imgProfile?.frame.height ?? 0.0) / 2
        self.vwProfile?.setCornerRadius(withBorder: 1, borderColor: UIColor.CustomColor.appColor, cornerRadius: (self.vwProfile?.frame.height ?? 0.0) / 2)
    }
}


// MARK: - Init Configure
extension CompleteProfileViewController {
    private func InitConfig(){
        imagePicker.viewController = self
        imagePicker.isAllowsEditing = true

        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblHighlights?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblHighlights?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.subHeaderTextColor
        
        
        self.vwUserName?.txtInput.autocapitalizationType = .words
        self.vwNickName?.txtInput.autocapitalizationType = .words
        self.vwFavoriteSportsTeam?.txtInput.autocapitalizationType = .words
        
        self.vwGender?.reusableViewDelegate = self
        
        self.cvHighlights?.register(HighlightsCell.self)
        self.cvHighlights?.dataSource = self
        self.cvHighlights?.delegate = self
        
               
        switch self.selectedRole {
        case .fan:
            self.vwClub?.isHidden = true
            self.vwCoach?.isHidden = true
            self.imgrosterd?.isHidden = true
            self.VwClubAddress?.isHidden = true
            self.vwGender?.isHidden = false
            
        case .athlete:
            self.imgrosterd?.isHidden = true
            self.vwClub?.isHidden = true
            self.vwCoach?.isHidden = true
            self.vwFavoriteSportsTeam?.isHidden = true
            self.VwClubAddress?.isHidden = true
            self.vwGender?.isHidden = false
          
        case .schoolclub:
            self.imgProfile?.isHidden = true
            self.vwFavoriteSportsTeam?.isHidden = true
            self.vwCoach?.isHidden = true
            self.vwGender?.isHidden = true
            self.vwNickName?.placeholderText = "Club Name"
            self.vwDateOfBirth?.isHidden = true
            self.VwClubAddress?.placeholderText = "Club address"
        case .coachrecruiter:
            self.imgProfile?.isHidden = true
            self.vwClub?.isHidden = true
            self.vwFavoriteSportsTeam?.isHidden = true
            self.VwClubAddress?.isHidden = true
            self.vwGender?.isHidden = false
        
        }
        
        [self.vwClub,self.vwCoach,self.vwDateOfBirth,self.vwGender].forEach({
            $0?.reusableViewDelegate = self
        })
        
        self.vwClub?.btnSelect.tag = profileEnum.School.rawValue
        self.vwCoach?.btnSelect.tag = profileEnum.coach.rawValue
        self.vwDateOfBirth?.btnSelect.tag = profileEnum.DOB.rawValue
        self.vwGender?.btnSelect.tag = profileEnum.Gender.rawValue
        
        if self.isFromEditProfile == true {
            self.getUserInfo()
        }
        else{
            let hightModel = AddPhotoVideoModel.init(Id: "",  postId: "", postimage: "", FeedId: "",MediaNameUrl: "", MediaName: "", isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: "", VideoImageUrl: "", VideoImageThumbUrl: "",thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage:"", isPost: "", type: false, videoThumbImage: "", thumbMedia: "", media: "", image: "", name: "", videoThumbImgName: "", galleryImage: "")
            self.arrhighlights.insert(hightModel, at: 0)
            self.cvHighlights?.reloadData()
        }
    
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
        //appNavigationControllersetUpTabbarTitle(title: "", TitleColor: UIColor.green, navigationItem: self.navigationItem, isHideMsgButton: true)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
    
}



//MARK: - UICollectionView Delegate and Datasource Method
extension CompleteProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrhighlights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HighlightsCell.self)
        
        if indexPath.row == 0 {
            cell.vwPlusView?.isHidden = false
            cell.VwMainimageView?.isHidden = true
            cell.btnPlus?.isHidden = false
            cell.btnCancel?.isHidden = true
            cell.lblName?.isHidden = true
        } else {
            cell.vwPlusView?.isHidden = true
            cell.VwMainimageView?.isHidden = false
            cell.btnCancel?.isHidden = false
            cell.lblName?.isHidden = false
            cell.lblName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
            cell.lblName?.textColor = UIColor.CustomColor.blackColor
            cell.imgVideo?.cornerRadius = 13.0
            
            cell.setHighlightsData(obj: self.arrhighlights[indexPath.row])
            
        }
    
        cell.btnPlus?.tag = indexPath.row
        cell.btnPlus?.addTarget(self, action: #selector(self.btnPlusClicked(_:)), for: .touchUpInside)
        
        cell.btnImage?.tag = indexPath.row
        cell.btnImage?.addTarget(self, action: #selector(self.btnImageClicked(_:)), for: .touchUpInside)
        
        cell.btnVideo?.tag = indexPath.row
        cell.btnVideo?.addTarget(self, action: #selector(self.btnVideoClicked(_:)), for: .touchUpInside)
        
        cell.btnCancel?.tag = indexPath.row
        cell.btnCancel?.addTarget(self, action: #selector(self.btnCancelClicked(_:)), for: .touchUpInside)
        
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
        return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    @objc func btnPlusClicked(_ btn : UIButton){
        if let user = UserModel.getCurrentUserFromDefault(),user.id != "" {
            if user.subscriptionId == "0" || user.subscriptionId == "" {
                self.appNavigationController?.present(SubscriptionPopupViewController.self,configuration: { (vc) in
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                })
            } else {
                self.showPicker()
            }
        }
    }
    
    @objc func btnCancelClicked(_ btn : UIButton){
        
        deleteView.btnEdit?.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
        deleteView.btnEdit?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        deleteView.btnDelete?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
        deleteView.btnDelete?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        deleteView.frame = CGRect(x: 0, y: 0, width: 140, height: 80)
     
        deleteView.btnEdit?.tag = btn.tag
        deleteView.btnEdit?.addTarget(self, action: #selector(self.btnEditClicked(_:)), for: .touchUpInside)
        
        deleteView.btnDelete?.tag = btn.tag
        deleteView.btnDelete?.addTarget(self, action: #selector(self.btnDeleteClicked(_:)), for: .touchUpInside)
//        deleteView.btnDeleteStory.block_setAction { (button) in
//            self.SPB.isPaused = true
//               let alt = UIAlertController(title: "", message: "Are you sure want to delete this story?", preferredStyle: .alert)
//               alt.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
//               alt.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
//                   popover.dismiss()
//                   self.DeleteUserStory(self.get)
//
//               }))
//               self.present(alt, animated: true, completion: nil)
//
//           }
        var showpoint : CGPoint = (btn.globalFrame!.origin)
        showpoint.x = showpoint.x + (btn.frame.width)
        showpoint.y = showpoint.y + (btn.frame.height)
        popover.popoverType = .down
     popover.willDismissHandler = { () in
       
     }
        popover.show(deleteView, point: showpoint)
//        self.cvHighlights?.reloadData()
//        self.showAlert(withTitle: "", with:"Are you sure want to delete this Image?", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
//            if self.arrhighlights.count > 0 {
//                self.RemoveHighlight(index: btn.tag)
//
//            }
//        }, secondButton: ButtonTitle.No, secondHandler: nil)
        
    }
    
    @objc func btnDeleteClicked(_ sender : UIButton){
        self.showAlert(withTitle: "", with:"Are you sure want to delete this Image?", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            if self.arrhighlights.count > 0 {
                self.RemoveHighlight(index: sender.tag)
                
            }
        }, secondButton: ButtonTitle.No, secondHandler: nil)
        popover.dismiss()
    }
    
    @objc func btnEditClicked(_ sender : UIButton){
        let obj = self.arrhighlights[sender.tag]
        self.appNavigationController?.present(AlbumNameViewController.self,configuration: { vc in
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.selectedHighlightsData = obj
            vc.highlights = obj.id
            vc.isFromHighlights = true
            vc.Delegate = self
            vc.isFromEdit = true
        })
        popover.dismiss()
    }
    
    
    
    @objc func btnVideoClicked(_ btn : UIButton){
        
        if self.arrhighlights.count > 0 {
            let obj = self.arrhighlights[btn.tag]
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
    
    @objc func btnImageClicked(_ btn : UIButton){
        if self.arrhighlights.count > 0 {
            let obj = self.arrhighlights[btn.tag]
            self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
                vc.imageUrl = obj.media
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
            })
        }
    }
}

//MARK:- UITableView Delegate
extension CompleteProfileViewController : addHighlightsNameDelegate {
    func AddName(obj: String, id: String) {
        SetSetHighlight(highlightsName: obj,id: id)
        self.cvHighlights?.reloadData()
        self.arrStoryMedia.removeAll()
    }
    
    func AddName(obj: String) {
        
    }
}
//MARK: - IBAction Method
extension CompleteProfileViewController {
    @IBAction func btnNextClick(_ sender : UIButton)  {
        self.view.endEditing(true)
       
        var arr : [[String:Any]] = []
        for i in stride(from: 0, to: self.arrhighlights.count, by: 1) {
            let obj = self.arrhighlights[i]
            let dict : [String:Any] = [
                kmediaName : obj.mediaName,
                kvideoThumbImgName : obj.mediaNameThumbUrl
            ]
            arr.append(dict)
        }
        
        
//        let gender = self.selectedGender
        let phoneData : String = self.vwPhoneNumber?.txtInput.text?.removeSpecialCharsFromString ?? ""
        var profiledetail : [String:Any] = [
            knickName : vwNickName?.txtInput.text ?? "",
           kuserName : vwUserName?.txtInput.text ?? "",
            krole : self.selectedRole.apiValue,
            kclubName : vwNickName?.txtInput.text ?? "",
            kdob : vwDateOfBirth?.txtInput.text ?? "",
        kgender : self.selectedGender.apiValue,
        kphone : phoneData,
        kfavoriteSportsTeam : vwFavoriteSportsTeam?.txtInput.text ?? "",
            kisCoach : self.selectedCoach.apiValue,
        kclubAddress : VwClubAddress?.txtInput.text ?? "",
            kisClubTeams : self.selectedClubSchool.apiValue,
        kimage : self.mediaName,
        khighlight_media : arr
        ]
        

        switch self.selectedRole {
        case .fan:
            if let errMessage = self.validateFields() {
                self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
                    return
            }
            if isFromEditProfile == true {
                self.UpdateProfile()
            }
            else {
                self.completeProfile()
            }
            
            
        case .athlete:
            if let errMessage = self.validateFields() {
                self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
                    return
            }
             self.appNavigationController?.push(SportsProfileViewController.self,configuration: { vc in
                 vc.selectedRole = self.selectedRole
                 vc.isFromEditProfile = self.isFromEditProfile
                 vc.dicprofiledetail = profiledetail
               
             })
            
        case .schoolclub:
            if let errMessage = self.validateFields() {
                self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
                    return
            }
            self.appNavigationController?.push(SportsProfileViewController.self,configuration: { vc in
                vc.selectedRole = self.selectedRole
                vc.selectedschool = self.selectedClubSchool
 
                vc.isFromEditProfile = self.isFromEditProfile
                vc.dicprofiledetail = profiledetail
                
            })
        case .coachrecruiter:
            self.appNavigationController?.push(SportsProfileViewController.self,configuration: { vc in
                vc.selectedRole = self.selectedRole
                vc.selectedCoach = self.selectedCoach
                vc.isFromEditProfile = self.isFromEditProfile
                vc.dicprofiledetail = profiledetail
            })
        }
    }
    
    @IBAction func btnAddProfileClick(_ sender : UIButton) {
        self.imagePicker.pickImage(sender, "Select Profile Picture") { (img,url) in
            self.imgProfile?.image = img
            self.imgrosterd?.image = img
            self.mediaAPICall(img: img)
        }
        
    }

    func showPicker() {
        var config = YPImagePickerConfiguration()
        /* Uncomment and play around with the configuration 👨‍🔬 🚀 */
        /* Set this to true if you want to force the  library output to be a squared image. Defaults to false */
        // config.library.onlySquare = true
        /* Set this to true if you want to force the camera output to be a squared image. Defaults to true */
        // config.onlySquareImagesFromCamera = false
        /* Ex: cappedTo:1024 will make sure images from the library or the camera will be
           resized to fit in a 1024x1024 box. Defaults to original image size. */
        // config.targetImageSize = .cappedTo(size: 1024)
        /* Choose what media types are available in the library. Defaults to `.photo` */
        config.library.mediaType = .photoAndVideo
        config.library.itemOverlayType = .grid
        /* Enables selecting the front camera by default, useful for avatars. Defaults to false */
        // config.usesFrontCamera = true
        /* Adds a Filter step in the photo taking process. Defaults to true */
        // config.showsFilters = false
        /* Manage filters by yourself */
        // config.filters = [YPFilter(name: "Mono", coreImageFilterName: "CIPhotoEffectMono"),
        //                   YPFilter(name: "Normal", coreImageFilterName: "")]
        // config.filters.remove(at: 1)
        // config.filters.insert(YPFilter(name: "Blur", coreImageFilterName: "CIBoxBlur"), at: 1)
        /* Enables you to opt out from saving new (or old but filtered) images to the
           user's photo library. Defaults to true. */
        config.shouldSaveNewPicturesToAlbum = false

        /* Choose the videoCompression. Defaults to AVAssetExportPresetHighestQuality */
        config.video.compression = AVAssetExportPresetPassthrough

        /* Choose the recordingSizeLimit. If not setted, then limit is by time. */
        // config.video.recordingSizeLimit = 10000000
        /* Defines the name of the album when saving pictures in the user's photo library.
           In general that would be your App name. Defaults to "DefaultYPImagePickerAlbumName" */
        // config.albumName = "ThisIsMyAlbum"
        /* Defines which screen is shown at launch. Video mode will only work if `showsVideo = true`.
           Default value is `.photo` */
        config.startOnScreen = .library

        /* Defines which screens are shown at launch, and their order.
           Default value is `[.library, .photo]` */
        config.screens = [.library, .photo, .video]

        /* Can forbid the items with very big height with this property */
        // config.library.minWidthForItem = UIScreen.main.bounds.width * 0.8
        /* Defines the time limit for recording videos.
           Default is 30 seconds. */
        // config.video.recordingTimeLimit = 5.0
        /* Defines the time limit for videos from the library.
           Defaults to 60 seconds. */
        config.video.libraryTimeLimit = 1000.0

        /* Adds a Crop step in the photo taking process, after filters. Defaults to .none */
        config.showsCrop = .none
//        config.showsCrop = .rectangle(ratio: (13/10))
        /* Changes the crop mask color */
        // config.colors.cropOverlayColor = .green
        /* Defines the overlay view for the camera. Defaults to UIView(). */
        // let overlayView = UIView()
        // overlayView.backgroundColor = .red
        // overlayView.alpha = 0.3
        // config.overlayView = overlayView
        /* Customize wordings */
        config.wordings.libraryTitle = "Gallery"

        /* Defines if the status bar should be hidden when showing the picker. Default is true */
        config.hidesStatusBar = false

        /* Defines if the bottom bar should be hidden when showing the picker. Default is false */
        config.hidesBottomBar = false

        config.maxCameraZoomFactor = 2.0

        config.library.maxNumberOfItems = 5
        config.gallery.hidesRemoveButton = false

        /* Disable scroll to change between mode */
        // config.isScrollToChangeModesEnabled = false
        // config.library.minNumberOfItems = 2
        /* Skip selection gallery after multiple selections */
        // config.library.skipSelectionsGallery = true
        /* Here we use a per picker configuration. Configuration is always shared.
           That means than when you create one picker with configuration, than you can create other picker with just
           let picker = YPImagePicker() and the configuration will be the same as the first picker. */

        /* Only show library pictures from the last 3 days */
        //let threDaysTimeInterval: TimeInterval = 3 * 60 * 60 * 24
        //let fromDate = Date().addingTimeInterval(-threDaysTimeInterval)
        //let toDate = Date()
        //let options = PHFetchOptions()
        // options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", fromDate as CVarArg, toDate as CVarArg)
        //
        ////Just a way to set order
        //let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        //options.sortDescriptors = [sortDescriptor]
        //
        //config.library.options = options
        config.library.preselectedItems = selectedItems
        // Customise fonts
        //config.fonts.menuItemFont = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        //config.fonts.pickerTitleFont = UIFont.systemFont(ofSize: 22.0, weight: .black)
        //config.fonts.rightBarButtonFont = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        //config.fonts.navigationBarTitleFont = UIFont.systemFont(ofSize: 22.0, weight: .heavy)
        //config.fonts.leftBarButtonFont = UIFont.systemFont(ofSize: 22.0, weight: .heavy)
        let picker = YPImagePicker(configuration: config)

        picker.imagePickerDelegate = self

        /* Change configuration directly */
        // YPImagePickerConfiguration.shared.wordings.libraryTitle = "Gallery2"
        /* Multiple media implementation */
       /* picker.didFinishPicking { [weak picker] items, cancelled in

            if cancelled {
                print("Picker was canceled")
                picker?.dismiss(animated: true, completion: nil)
                return
            }
            _ = items.map { print("🧀 \($0)") }

            self.selectedItems = items
            if let firstItem = items.first {
                switch firstItem {
                case .photo(let photo):
                 //   self.selectedImageV.image = photo.image
                    picker?.dismiss(animated: true, completion: nil)
                case .video(let video):
                 //   self.selectedImageV.image = video.thumbnail

                    let assetURL = video.url
                    let playerVC = AVPlayerViewController()
                    let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
                    playerVC.player = player

                    picker?.dismiss(animated: true, completion: { [weak self] in
                        self?.present(playerVC, animated: true, completion: nil)
                        print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                    })
                }
            }
        } */
        var arr : [AVAsset] = []
        var isImageSelected : Bool = false
        var isVideoSelected : Bool = false
        picker.didFinishPicking { [weak picker] items, cancelled in
                    if cancelled {
                        print("Picker was canceled")
                        picker?.dismiss(animated: true, completion: nil)
                        return
                    }
            picker?.dismiss(animated: true, completion: nil)
                    _ = items.map { print("🧀 \($0)") }

                    self.selectedItems = items
                    
                    for i in 0..<items.count {
                        let item = items[i]
                        var dict = typeAliasDictionary()
                        switch item {
                        case .photo(let photo):
                            dict["mediaName"] = "image\(i)"
                            dict["media"] = photo.image
                            dict["isVideo"] = "0"
                            isImageSelected = true
                            //print(item)
                            /*if let asURL = photo.url {
                                let asset = AVAsset(url: asURL)
                               // let currentAsset = AVAsset(url: filePath)
                                arr.append(asset)
                            }*/
                            self.arrStoryMedia.append(dict)
                        case .video(let video):
                            isVideoSelected = true
                            /*dict["mediaName"] = "video\(i)"
                            dict["media"] = video.url
                            dict["isVideo"] = "1"*/
                            /*if let photo = items.singleVideo, let asset = photo.asset {
                                arr.append(asset)
                            }*/
                            
                            //if let asURL = video.url{
                                
                                let asset = AVAsset(url: video.url)
                               // let currentAsset = AVAsset(url: filePath)
                                arr.append(asset)
                           // }
                            break
                        }
                        //self.arrStoryMedia.append(dict)
                        
                    }
            print("Highlights Media:\(self.arrStoryMedia)")
            SVProgressHUD.show()
            
            DispatchQueue.global().async {
                KVVideoManager.shared.merge(arrayVideos: arr) {[weak self] (outputURL, error) in
                    guard let `self` = self else { return }
                    
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()

                        if let error = error {
                            print("Error:\(error.localizedDescription)")
                        }
                        else if let url = outputURL {
                            /*let player = AVPlayer(url: url)
                             let playerViewController = AVPlayerViewController()
                             playerViewController.player = player
                             self.present(playerViewController, animated: true) {
                             if let myplayer = playerViewController.player {
                             myplayer.play()
                             }
                             }*/
                            var dict = typeAliasDictionary()
                            dict["mediaName"] = url.lastPathComponent
                            dict["media"] = url.absoluteString
                            dict["isVideo"] = "1"
                            SVProgressHUD.show()
                            do {
                                let video = try NSData(contentsOf: url, options: .mappedIfSafe)
                                print("movie saved")
                                dict["data"] = video
                                //arrData.append(video)
                                delay(seconds: 0.2) {
                                    SVProgressHUD.dismiss()
                                    self.arrStoryMedia.append(dict)
                                    self.mediaAPIImagesAndVideoCall(self.arrStoryMedia)
                                }
                            } catch {
                                print(error)
                            }
                            
                            
                            
                        }
                    }
                }
            }
            if isImageSelected && !isVideoSelected {
                if self.arrStoryMedia.count > 0 {
                    //picker?.dismiss(animated: true, completion: nil)
                    self.mediaAPIImagesAndVideoCall(self.arrStoryMedia)
                }
            }
        }
//
        /* Single Photo implementation. */
        // picker.didFinishPicking { [weak picker] items, _ in
        //     self.selectedItems = items
        //     self.selectedImageV.image = items.singlePhoto?.image
        //     picker.dismiss(animated: true, completion: nil)
        // }
        /* Single Video implementation. */
        // picker.didFinishPicking { [weak picker] items, cancelled in
        //    if cancelled { picker.dismiss(animated: true, completion: nil); return }
        //
        //    self.selectedItems = items
        //    self.selectedImageV.image = items.singleVideo?.thumbnail
        //
        //    let assetURL = items.singleVideo!.url
        //    let playerVC = AVPlayerViewController()
        //    let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
        //    playerVC.player = player
        //
        //    picker.dismiss(animated: true, completion: { [weak self] in
        //        self?.present(playerVC, animated: true, completion: nil)
        //        print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
        //    })
        //}
        present(picker, animated: true, completion: nil)
    }
    
}

// MARK: - ReusableView Delegate
extension CompleteProfileViewController : ReusableViewDelegate {
    func leftButtonClicked(_ sender: UIButton) {
        
    }
    func rightButtonClicked(_ sender: UIButton) {
            
    }
   
    func buttonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        switch profileEnum.init(rawValue: sender.tag) ?? .coach {
        case .coach:
            self.openCoachClicked(sender)
        case .School:
            self.openSchoolClubClicked(sender)
        case .DOB:
            self.openDOBClicked(sender)
        case .Gender:
            self.openGenderClicked(sender)
        }
       
    }
    
    @objc func openGenderClicked(_ sender : UIButton){
        
//    private func openGender(sender : UIButton){
        let arr = self.arrGender.map({$0.name})
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrGender.count, by: 1){
            if (self.vwGender?.txtInput.text ?? "") == self.arrGender[i].name {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select Gender", rows: arr, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            //self.selectedGender = self.arrGender[indexes]
            if self.arrGender.count > 0{
                self.vwGender?.txtInput.text = self.arrGender[indexes].name
                self.selectedGender = self.arrGender[indexes]
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    
    
    @objc func openSchoolClubClicked(_ sender : UIButton){
        let arr = self.arrClubSchool.map({$0.name})
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrClubSchool.count, by: 1){
            if (self.vwClub?.txtInput.text ?? "") == self.arrClubSchool[i].name {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "Select School/Club", rows: arr, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            //self.selectedGender = self.arrGender[indexes]
            if self.arrClubSchool.count > 0{
                self.vwClub?.txtInput.text = self.arrClubSchool[indexes].name
                self.selectedClubSchool = self.arrClubSchool[indexes]
                
                switch self.selectedClubSchool {
                case .Club:
                    self.vwNickName?.placeholderText = "Club Name"
                    self.VwClubAddress?.placeholderText = "Club address"
                case .School:
                    self.VwClubAddress?.placeholderText = "School address"
                    self.vwNickName?.placeholderText = "School Name"
              
                }
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    
    @objc func openCoachClicked(_ sender : UIButton){
        let arr = self.arrCoach.map({$0.name})
        var selecetdIndex : Int = 0
        for i in stride(from: 0, to: self.arrCoach.count, by: 1){
            if (self.vwCoach?.txtInput.text ?? "") == self.arrCoach[i].name {
                selecetdIndex = i
                break
            }
        }
        
        let picker = ActionSheetStringPicker(title: "SelectCoach/Recruiter", rows: arr, initialSelection: selecetdIndex, doneBlock: { (picker, indexes, values) in
            //self.selectedGender = self.arrGender[indexes]
            if self.arrCoach.count > 0{
                self.vwCoach?.txtInput.text = self.arrCoach[indexes].name
                self.selectedCoach = self.arrCoach[indexes]
                
                switch self.selectedCoach {
                case .Coach:
                    self.vwClub?.isHidden = true
                    self.vwNickName?.isHidden = false
                case .Recruiter:
                    self.vwNickName?.isHidden = true
              
                }
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        picker?.toolbarButtonsColor = UIColor.CustomColor.appColor
        picker?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.CustomColor.labelTextColor]
        picker?.show()
    }
    
    @objc func openDOBClicked(_ sender : UIButton){
        var selecteddate : Date = Date()
        if let date = self.selectedDate{
            selecteddate = date
        }
        
        let datePicker = ActionSheetDatePicker(title: "Select Date of Birth",
                                               datePickerMode: UIDatePicker.Mode.date,
                                               selectedDate: selecteddate,
                                               doneBlock: { picker, date, origin in
            
            if let selectdate = date as? Date {
                self.vwDateOfBirth?.txtInput?.text = selectdate.getFormattedString(format: AppConstant.DateFormat.k_YYYY_MM_dd)
                self.selectedDate = selectdate
            }
            return
        },cancel: { picker in
            return
        },origin: sender)
        let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker?.maximumDate = date
        if #available(iOS 14.0, *) {
            datePicker?.datePickerStyle = .wheels
        }
        
        datePicker?.show()
    }
}
//MARK: - Validation
extension CompleteProfileViewController {
  
    private func validateFields() -> String? {
        
        
        switch self.selectedRole {
        case .fan:
            if self.vwUserName?.txtInput.isEmpty ?? false{
                self.vwUserName?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyName
            } else if self.vwGender?.txtInput.isEmpty ?? false {
                return AppConstant.ValidationMessages.kEmptyGender
            } else if self.vwPhoneNumber?.txtInput.isEmpty ?? false {
                self.vwPhoneNumber?.txtInput?.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyPhoneNumber
            } else if !(self.vwPhoneNumber?.txtInput.isValidContactPhoneno() ?? false) {
                self.vwPhoneNumber?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kInValidPhoneNo
            } else if self.vwDateOfBirth?.txtInput.isEmpty ?? false{
                self.vwDateOfBirth?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyDOB
            } else {
                return nil
            }
        case .athlete:
            if self.vwUserName?.txtInput.isEmpty ?? false{
                self.vwUserName?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyName
            } else if self.vwDateOfBirth?.txtInput.isEmpty ?? false{
                self.vwDateOfBirth?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyDOB
            } else if self.vwGender?.txtInput.isEmpty ?? false {
                return AppConstant.ValidationMessages.kEmptyGender
            } else if self.vwPhoneNumber?.txtInput.isEmpty ?? false {
                self.vwPhoneNumber?.txtInput?.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyPhoneNumber
            } else if !(self.vwPhoneNumber?.txtInput.isValidContactPhoneno() ?? false) {
                self.vwPhoneNumber?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kInValidPhoneNo
            } else {
                return nil
            }
        case .schoolclub:
            if self.vwClub?.txtInput.isEmpty ?? false{
                self.vwClub?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kselectclubschool
            } else if self.vwNickName?.txtInput.isEmpty ?? false{
                self.vwNickName?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyClubName
            } else if self.vwUserName?.txtInput.isEmpty ?? false{
                self.vwUserName?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kUserName
            } else if self.VwClubAddress?.txtInput.isEmpty ?? false{
                self.VwClubAddress?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyClubAdress
            } else if self.vwPhoneNumber?.txtInput.isEmpty ?? false {
                self.vwPhoneNumber?.txtInput?.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyPhoneNumber
            } else if !(self.vwPhoneNumber?.txtInput.isValidContactPhoneno() ?? false) {
                self.vwPhoneNumber?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kInValidPhoneNo
           
            } else {
                return nil
                
            }
        case .coachrecruiter:
            if self.vwCoach?.txtInput.isEmpty ?? false{
                self.vwCoach?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kselectclubschool
            } else if self.vwNickName?.txtInput.isEmpty ?? false{
                self.vwNickName?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyClubName
            } else if self.vwUserName?.txtInput.isEmpty ?? false{
                self.vwUserName?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kUserName
            } else if self.VwClubAddress?.txtInput.isEmpty ?? false{
                self.VwClubAddress?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyClubAdress
            } else if self.vwPhoneNumber?.txtInput.isEmpty ?? false {
                self.vwPhoneNumber?.txtInput?.becomeFirstResponder()
                return AppConstant.ValidationMessages.kEmptyPhoneNumber
            } else if !(self.vwPhoneNumber?.txtInput.isValidContactPhoneno() ?? false) {
                self.vwPhoneNumber?.txtInput.becomeFirstResponder()
                return AppConstant.ValidationMessages.kInValidPhoneNo
           
            } else {
                return nil
            }
        }
     
    }
}

// MARK: - API Call
extension CompleteProfileViewController {
    private func mediaAPICall(img : UIImage) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadMedia(with: dict, image: img, success: { (msg) in
            self.mediaName = msg
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
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
    
    private func SetSetHighlight(highlightsName : String,id : String) {
        
        var arr : [[String:Any]] = []
        for i in stride(from: 0, to: self.arrhighlights.count, by: 1) {
            let obj = self.arrhighlights[i]
            let dict : [String:Any] = [
                kmediaName : obj.mediaName,
                kvideoThumbImgName : obj.mediaNameThumbUrl
            ]
            arr.append(dict)
        }
        
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                ktoken : user.token,
                klangType : Rosterd.sharedInstance.languageType,
                khighlight_media : arr,
                kname : highlightsName,
                khighlightId : id
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.setHighlight(withParam: param, success: { (message, arr) in
                self.arrhighlights.removeAll()
                self.arrhighlights = arr
                //                self.getUserInfo()
                //                self.arrhighlights = arr.compactMap({ (model) -> AddPhotoVideoModel in
                //                    AddPhotoVideoModel.init(Id: model.id, postId: "", postimage: "", FeedId: "", MediaNameUrl: "", MediaName: model.image, isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: model.videoThumbImage, VideoImageUrl: "", VideoImageThumbUrl: "", thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage: "", isPost: "", type: model.videoThumbImage == "" ? false : true, videoThumbImage: model.videoThumbImage, thumbMedia: "", media: model.media, image: model.image)
                //                })
                //
                let hightModel = AddPhotoVideoModel.init(Id: "",  postId: "", postimage: "", FeedId: "",MediaNameUrl: "", MediaName: "", isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: "", VideoImageUrl: "", VideoImageThumbUrl: "",thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage:"", isPost: "", type: false, videoThumbImage: "", thumbMedia: "", media: "", image: "", name: "", videoThumbImgName: "", galleryImage: "")
                self.arrhighlights.insert(hightModel, at: 0)
                self.cvHighlights?.reloadData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func RemoveHighlight(index : Int){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                khighlightId : arrhighlights[index].id
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            UserModel.RemoveHighlight(with: param, success: { (msg) in
                //              self.arrhighlights.removeAll()
                self.arrhighlights.remove(at: index)
                self.cvHighlights?.reloadData()
                
                //              self.getUserInfo()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
        
    }
    
    private func mediaAPIImagesAndVideoCall(_ arrMedia : [typeAliasDictionary],isBoomrang:Bool = false) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadHighlightImagesAndVideo(with: dict, arrMedia: arrMedia) { (mediaName,mediaBaseUrl,videoThumbImgUrl,videoThumbImgName,medialThumUrl) in
            
            let model = AddPhotoVideoModel.init(Id: "",  postId: "", postimage: "", FeedId: "",MediaNameUrl: "", MediaName: mediaName, isvideo: videoThumbImgName == "" ? false : true , VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: videoThumbImgName, VideoImageUrl: "", VideoImageThumbUrl: "",thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage:"", isPost: "", type: videoThumbImgName == "" ? false : true, videoThumbImage: videoThumbImgUrl, thumbMedia: "", media: medialThumUrl, image: "", name: "", videoThumbImgName: "", galleryImage: "")
            
            self.arrhighlights.append(model)
            self.appNavigationController?.present(AlbumNameViewController.self,configuration: { vc in
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                vc.isFromHighlights = true
                vc.Delegate = self
            })
            //            self.SetSetHighlight()
            //            self.cvHighlights?.reloadData()
            //            self.arrStoryMedia.removeAll()
        } failure: { statuscode, error, customError in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        }
    }
    
    
    private func completeProfile(){
        
        var arr : [[String:Any]] = []
        for i in stride(from: 0, to: self.arrhighlights.count, by: 1) {
            let obj = self.arrhighlights[i]
            let dict : [String:Any] = [
                kmediaName : obj.mediaName,
                kvideoThumbImgName : obj.mediaNameThumbUrl
            ]
            arr.append(dict)
        }
        
        
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let phoneData : String = self.vwPhoneNumber?.txtInput.text?.removeSpecialCharsFromString ?? ""
            let dict : [String:Any] = [
                ktoken : user.token,
                klangType : Rosterd.sharedInstance.languageType,
                knickName : vwNickName?.txtInput.text ?? "",
                kuserName : vwUserName?.txtInput.text ?? "",
                kdob :  vwDateOfBirth?.txtInput.text ?? "",
                krole : self.selectedRole.apiValue,
                kgender : self.selectedGender.apiValue,
                kphone : phoneData,
                kfavoriteSportsTeam : vwFavoriteSportsTeam?.txtInput.text ?? "",
                kimage : self.mediaName,
                kprofileStatus : "2",
                //                    khighlight_media : arr
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.completeProfile(with: param, success: { (model, msg) in
                self.appNavigationController?.push(SuggestionsViewController.self,configuration: { vc in
                    //vc.isMoveAnoherVC = false
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
        
        var arr : [[String:Any]] = []
        for i in stride(from: 0, to: self.arrhighlights.count, by: 1) {
            let obj = self.arrhighlights[i]
            let dict : [String:Any] = [
                kmediaName : obj.mediaName,
                kvideoThumbImgName : obj.mediaNameThumbUrl
            ]
            arr.append(dict)
        }
        
        
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let phoneData : String = self.vwPhoneNumber?.txtInput.text?.removeSpecialCharsFromString ?? ""
            let dict : [String:Any] = [
                ktoken : user.token,
                klangType : Rosterd.sharedInstance.languageType,
                knickName : vwNickName?.txtInput.text ?? "",
                kuserName : vwUserName?.txtInput.text ?? "",
                kdob :  user.dob,
                krole : self.selectedRole.apiValue,
                kgender : self.selectedGender.apiValue,
                kphone : phoneData,
                kfavoriteSportsTeam : vwFavoriteSportsTeam?.txtInput.text ?? "",
                kimage : self.mediaName
            ]
            
            let param : [String:Any] = [
                kData : dict
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
            
            self.vwNickName?.txtInput.text = obj.nickName
            
            if obj.dob == "0000-00-00" {
                self.vwDateOfBirth?.txtInput.text = ""
            } else {
                self.vwDateOfBirth?.txtInput.text = obj.dob
                self.selectedDate = (obj.dob).getDateFromString(format: AppConstant.DateFormat.k_YYYY_MM_dd)
            }
            self.vwClub?.txtInput.text = obj.isClubTeams.name
            self.vwCoach?.txtInput.text = obj.isCoach.name
            self.vwGender?.txtInput.text = obj.gender.name
            self.vwPhoneNumber?.txtInput.text = format(with: Masking.kPhoneNumberMasking, phone: obj.phone )
            self.vwFavoriteSportsTeam?.txtInput.text = obj.favoriteSportsTeam
            self.VwClubAddress?.txtInput.text = obj.clubAddress
            
            self.imgrosterd?.setImage(withUrl: obj.profileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.imgProfile?.setImage(withUrl: obj.profileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            
            
            self.selectedRole = obj.role
            self.arrhighlights = obj.highlights.compactMap({ (model) -> AddPhotoVideoModel in
                AddPhotoVideoModel.init(Id: model.id, postId: "", postimage: "", FeedId: "", MediaNameUrl: "", MediaName: model.image, isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: model.videoThumbImage, VideoImageUrl: "", VideoImageThumbUrl: "", thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage: "", isPost: "", type: model.videoThumbImage == "" ? false : true, videoThumbImage: model.videoThumbImage, thumbMedia: "", media: model.media, image: model.image, name: model.name, videoThumbImgName: "", galleryImage: "")
            })
            let hightModel = AddPhotoVideoModel.init(Id: "",  postId: "", postimage: "", FeedId: "",MediaNameUrl: "", MediaName: "", isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: "", VideoImageUrl: "", VideoImageThumbUrl: "",thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage:"", isPost: "", type: false, videoThumbImage: "", thumbMedia: "", media: "", image: "", name: "", videoThumbImgName: "", galleryImage: "")
            self.arrhighlights.insert(hightModel, at: 0)
            self.cvHighlights?.reloadData()
            
            switch self.selectedRole {
            case .fan :
                self.vwUserName?.txtInput.text = obj.userName
            case .athlete :
                self.vwUserName?.txtInput.text = obj.userName
            case .schoolclub :
                self.vwNickName?.txtInput.text  = obj.clubName
                self.vwUserName?.txtInput.text = obj.userName
            case .coachrecruiter :
                self.vwUserName?.txtInput.text = obj.userName
            }
            
            switch self.selectedRole {
            case .fan:
                self.vwClub?.isHidden = true
                self.vwCoach?.isHidden = true
                self.imgrosterd?.isHidden = true
                self.VwClubAddress?.isHidden = true
                self.vwGender?.isHidden = false
                
            case .athlete:
                self.imgrosterd?.isHidden = true
                self.vwClub?.isHidden = true
                self.vwCoach?.isHidden = true
                self.vwFavoriteSportsTeam?.isHidden = true
                self.VwClubAddress?.isHidden = true
                self.vwGender?.isHidden = false
                
            case .schoolclub:
                self.imgProfile?.isHidden = true
                self.imgrosterd?.isHidden = false
                self.vwFavoriteSportsTeam?.isHidden = true
                self.vwCoach?.isHidden = true
                self.vwGender?.isHidden = true
                self.vwNickName?.placeholderText = "Club Name"
                self.vwDateOfBirth?.isHidden = true
                self.VwClubAddress?.placeholderText = "Club address"
                self.vwClub?.isHidden = false
                self.VwClubAddress?.isHidden = false
                
            case .coachrecruiter:
                self.vwCoach?.isHidden = false
                self.imgProfile?.isHidden = true
                self.vwClub?.isHidden = true
                self.vwFavoriteSportsTeam?.isHidden = true
                self.VwClubAddress?.isHidden = true
                self.vwGender?.isHidden = false
                self.imgProfile?.isHidden = true
                self.imgrosterd?.isHidden = false
            }
        }
    }
    
}
// YPImagePickerDelegate
extension CompleteProfileViewController: YPImagePickerDelegate {
    func noPhotos() {
        
    }
    
    func imagePickerHasNoItemsInLibrary(_ picker: YPImagePicker) {
        // PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }

    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
        return true
    }
}



// MARK: - ViewControllerDescribable
extension CompleteProfileViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension CompleteProfileViewController: AppNavigationControllerInteractable { }

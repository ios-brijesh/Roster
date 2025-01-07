//
//  CreateEventViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 24/01/22.
//

import UIKit


protocol EventDelegate {
    func updateEventData()
}


enum CreateEvent : Int {
    case dateOfEvent
    case startTime
    case endTime
    case selectedCategory
    case MapSelect
}


class CreateEventViewController: UIViewController{
    // MARK: - IBOutlet
    @IBOutlet weak var lblPaid: UILabel?
    @IBOutlet weak var lblTicket: UILabel?
    @IBOutlet weak var lblAddTicket: UILabel?
    @IBOutlet weak var lblEventCover: UILabel?
    @IBOutlet weak var lblGallery: UILabel?
    
    @IBOutlet weak var vwEvenInfoMainView: UIView?
    @IBOutlet weak var vwDetailMainView: UIView?
    @IBOutlet weak var vwMediaMainView: UIView?
    @IBOutlet weak var vwevenCovertview: UIView?
    @IBOutlet weak var vwGalleryview: UIView?
    
    @IBOutlet weak var segementMainview: UIView?
    @IBOutlet weak var vwEventName: TextReusableView?
    @IBOutlet weak var vwEventDate: TextReusableView?
    @IBOutlet weak var vwSelectCategory: TextReusableView?
    @IBOutlet weak var vwStartTime: TextReusableView?
    @IBOutlet weak var vwEndTime: TextReusableView?
    @IBOutlet weak var vwEventDescription: ReusableTextview?
    @IBOutlet weak var vwLocation: TextReusableView?
    @IBOutlet weak var vwDetailCategory: TextReusableView?
    @IBOutlet weak var vwImageView: UIView?
    @IBOutlet weak var cvGalleryimgView: UICollectionView?
    @IBOutlet weak var vwpaidticketqty: TextReusableView?
    @IBOutlet weak var vwaddticket: UIView!
    
    @IBOutlet weak var tblTicket: UITableView?
    @IBOutlet weak var constrainttblTicketHeight: NSLayoutConstraint?
    
    @IBOutlet weak var vwticketview: UIView?
    @IBOutlet weak var SwitchOn: UISwitch?
    
    @IBOutlet weak var btnAddTicket: UIButton?
    
    @IBOutlet weak var btnNext: AppButton?
    
    @IBOutlet weak var vwEvenInfoTab: EventSegement?
    @IBOutlet weak var vwDetailTab: EventSegement?
    @IBOutlet weak var vwMediaTab: EventSegement?
    
    @IBOutlet weak var imgEventCover: UIImageView?
    
    // MARK: - Variables
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    private let imagePicker = ImagePicker()
    private let videoPicker = VideoPicker()
    private var selecetdTab : SegementEventTabEnum = .EvenInfo
    var delegate : EventDelegate?
    var selectedEventCategoryData : EventCategoryModel?
    private var selectedLatitude : Double = 0.0
    private var selectedLongitude : Double = 0.0
    private var arrTicketData : [TicketdataModel] = []
    private var mediaName : String = ""
    private var userEventData : [EventModel] = []
    var countryname : String = ""
       var cityname : String = ""
       var statename : String = ""
       var streetname : String = ""
       var zipcode : String = ""
    var selectedStartTime : String = ""
    var selectedFinishTime : String = ""
    var StartTimeSelect : String = ""
    var EndTimeSelect : String = ""
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
       
      
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.segementMainview?.backgroundColor = UIColor.CustomColor.SupportTopBGcolor
        self.segementMainview?.cornerRadius = 10
        
        
        if let SwitchOn = self.SwitchOn {
           
            SwitchOn.layer.cornerRadius = 16.0
            
        }
        self.vwGalleryview?.backgroundColor = UIColor.CustomColor.SupportTopBGcolor
        self.vwevenCovertview?.backgroundColor = UIColor.CustomColor.SupportTopBGcolor
        
        self.vwGalleryview?.cornerRadius = 10.0
        self.vwevenCovertview?.cornerRadius = 10.0
    }
}


// MARK: - Init Configure
extension CreateEventViewController {
    private func InitConfig(){
        
        self.vwEventName?.txtInput.autocapitalizationType = .sentences
        self.imagePicker.viewController = self
        self.videoPicker.viewController = self
        
        let model = TicketdataModel.init(totalcartPriceamount : "",totalticketPriceamount : "",eventName : "",isPaid : "",status : "",price : "",qty : "",ticketId : "",id : "",userId : "",ticketName : "",ticketPrice : "",totalSeat : "",eventId : "",createdDate : "",updatedDate : "",availabletickets : "",isselectTicket : true, coverImage: "")
        self.arrTicketData.append(model)
        
        self.vwImageView?.cornerRadius = 10.0
        self.imgEventCover?.cornerRadius = 10.0
        self.vwImageView?.isHidden = true
        self.vwpaidticketqty?.txtInput.delegate = self
        self.vwEventDate?.textreusableViewDelegate = self
        self.vwStartTime?.textreusableViewDelegate = self
        self.vwEndTime?.textreusableViewDelegate = self
        self.vwSelectCategory?.textreusableViewDelegate = self
        self.vwLocation?.textreusableViewDelegate = self
        
        self.vwEventDate?.btnSelect.isHidden = false
        self.vwStartTime?.btnSelect.isHidden = false
        self.vwEndTime?.btnSelect.isHidden = false
        self.vwSelectCategory?.btnSelect.isHidden = false
        self.vwLocation?.btnSelect.isHidden = false 
        
        
        self.vwEventDate?.btnSelect.tag = CreateEvent.dateOfEvent.rawValue
        self.vwStartTime?.btnSelect.tag = CreateEvent.startTime.rawValue
        self.vwEndTime?.btnSelect.tag = CreateEvent.endTime.rawValue
        self.vwSelectCategory?.btnSelect.tag = CreateEvent.selectedCategory.rawValue
        self.vwLocation?.btnSelect.tag = CreateEvent.MapSelect.rawValue
        
        self.lblPaid?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblPaid?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblTicket?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblTicket?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblGallery?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblGallery?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblEventCover?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblEventCover?.textColor = UIColor.CustomColor.labelTextColor
        
        
        self.btnAddTicket?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnAddTicket?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        
        
        if let SwitchOn = self.SwitchOn {
            SwitchOn.isOn = true
            SwitchOn.cornerRadius = 16.0
            SwitchOn.thumbTintColor = UIColor.CustomColor.whitecolor
        }
        self.vwticketview?.isHidden = false
        self.vwpaidticketqty?.isHidden = true
        self.vwaddticket?.isHidden = false
        
        self.vwEvenInfoTab?.btnSelectTab?.tag = SegementEventTabEnum.EvenInfo.rawValue
        self.vwDetailTab?.btnSelectTab?.tag = SegementEventTabEnum.Detail.rawValue
        self.vwMediaTab?.btnSelectTab?.tag = SegementEventTabEnum.Media.rawValue
        
        
        [self.vwEvenInfoTab,self.vwDetailTab,self.vwMediaTab].forEach({
            $0?.EventsegementDelegate = self
        })
        
        self.setSelectedTab(obj: .EvenInfo, isUpdateVC: false)
        
        self.tblTicket?.register(TicketCell.self)
        self.tblTicket?.estimatedRowHeight = 100.0
        self.tblTicket?.rowHeight = UITableView.automaticDimension
        self.tblTicket?.dataSource = self
        self.tblTicket?.delegate = self
        
        
        self.cvGalleryimgView?.delegate = self
        self.cvGalleryimgView?.dataSource = self
        self.cvGalleryimgView?.register(AlbumCell.self)
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Create Events", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
    
   
}


//MARK: - Tableview Observer
extension CreateEventViewController {
    
    private func addTableviewOberver() {
        self.tblTicket?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
       
    }
    
    func removeTableviewObserver() {
        if self.tblTicket?.observationInfo != nil {
            self.tblTicket?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblTicket && keyPath == ObserverName.kcontentSize {
                self.constrainttblTicketHeight?.constant = self.tblTicket?.contentSize.height ?? 0.0
            }
        }
    }
}


//MARK:- UITableView Delegate
extension CreateEventViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTicketData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketCell.self)
        if self.arrTicketData.count > 0 {
            let obj = self.arrTicketData[indexPath.row]
            cell.vwTicketName?.txtInput?.text = obj.ticketName
            cell.vwTicketPrice?.txtInput?.text = obj.ticketPrice
            cell.vwTicketSeat?.txtInput?.text = obj.totalSeat
           
            cell.btnCancel?.isHidden = (self.arrTicketData.count == 1)
            
            cell.btnCancel?.tag = indexPath.row
            cell.btnCancel?.addTarget(self, action: #selector(self.btnCancelClicked(_:)), for: .touchUpInside)
            
            cell.delegate = self
            
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    @objc func btnCancelClicked(_ btn : UIButton){
        if self.arrTicketData.count > 0 {
            self.arrTicketData.remove(at: btn.tag)
            self.tblTicket?.reloadData()
        }
    }
 
}


//MARK: - UICollectionView Delegate and Datasource Method
extension CreateEventViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPhotoVideo.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AlbumCell.self)
      
        if indexPath.row == arrPhotoVideo.count {
            cell.vwAddview?.isHidden = false
            cell.vwMain?.isHidden = true
         
        } else {
            let obj = self.arrPhotoVideo[indexPath.row]
            cell.vwMain?.isHidden = false
            cell.vwAddview?.isHidden = true
           
            cell.imgFeed?.setImage(withUrl: obj.mediaNameUrl, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
        
        cell.btnAdd?.tag = indexPath.row
        cell.btnAdd?.addTarget(self, action: #selector(self.btnAddClicked(_:)), for: .touchUpInside)
        
        cell.btncancel?.tag = indexPath.row
        cell.btncancel?.addTarget(self, action: #selector(self.btncancelClicked(_:)), for: .touchUpInside)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
        
   
    @objc func btnAddClicked(_ btn : UIButton){
        self.imagePicker.isAllowsEditing = true
        self.imagePicker.pickImage(btn, "Select Image") { (img,url) in
            self.mediaAPICall(img: img,index : btn.tag)
        }
    }
//
//    @objc func btnSelectClicked(_ btn : UIButton){
//        if self.arrPhotoVideo.count > 0 {
//            let obj = self.arrPhotoVideo[btn.tag]
//            if obj.isVideo {
//                if let videoURL = URL(string: obj.mediaNameUrl) {
//                    let player = AVPlayer(url: videoURL)
//                    let playerViewController = AVPlayerViewController()
//                    playerViewController.player = player
//                    self.present(playerViewController, animated: true) {
//                        if let myplayer = playerViewController.player {
//                            myplayer.play()
//                        }
//                    }
//                }
//            } else {
//                self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
//                    vc.imageUrl = obj.mediaNameUrl
//                    vc.modalPresentationStyle = .fullScreen
//                    vc.modalTransitionStyle = .crossDissolve
//                })
//            }
//        }
//    }
    @objc func btncancelClicked(_ btn : UIButton){
        self.arrPhotoVideo.remove(at: btn.tag)
        self.cvGalleryimgView?.reloadData()
    }
}
// MARK: - IBAction
extension CreateEventViewController : TicketDataDelegate {
    func TicketName(text: String, cell: TicketCell) {
        if let indexpath = self.tblTicket?.indexPath(for: cell) {
            if self.arrTicketData.count > 0 {
                self.arrTicketData[indexpath.row].ticketName = text
            }
            self.tblTicket?.reloadData()
        }
    }
    
    func TicketPrize(text: String, cell: TicketCell) {
        if let indexpath = self.tblTicket?.indexPath(for: cell) {
            if self.arrTicketData.count > 0 {
                self.arrTicketData[indexpath.row].ticketPrice = text
            }
            self.tblTicket?.reloadData()
        }
    }
    
    func TicketSeat(text: String, cell: TicketCell) {
        if let indexpath = self.tblTicket?.indexPath(for: cell) {
            if self.arrTicketData.count > 0 {
                self.arrTicketData[indexpath.row].totalSeat = text
            }
            self.tblTicket?.reloadData()
        }
    }
}
//MARK: - SegmentTabDelegate
extension CreateEventViewController : EventSegementDelegate {
    
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: SegementEventTabEnum(rawValue: sender.tag) ?? .EvenInfo)
    }
    
    private func setSelectedTab(obj : SegementEventTabEnum, isUpdateVC : Bool = true){
        switch obj {
        case .EvenInfo:
            self.selecetdTab = .EvenInfo
            self.vwEvenInfoTab?.isSelectTab = true
            self.vwDetailTab?.isSelectTab = false
            self.vwMediaTab?.isSelectTab = false
            if !isUpdateVC {
                self.vwEvenInfoMainView?.isHidden = false
                self.vwDetailMainView?.isHidden = true
                self.vwMediaMainView?.isHidden = true
            }
            else {
                self.vwEvenInfoMainView?.isHidden = false
                self.vwDetailMainView?.isHidden = true
                self.vwMediaMainView?.isHidden = true
                self.view.layoutIfNeeded()
            }
            break
        case .Detail:
            if self.vwEventName?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.KEventName)
                return
            } else if self.vwEventDate?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.KEventDate)
                return
            } else if self.vwStartTime?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventstartTime)
                return
            } else if self.vwEndTime?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventEndTime)
                return
            } else if self.vwSelectCategory?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventCategory)
                return
            }
            self.selecetdTab = .Detail
            self.vwEvenInfoTab?.isSelectTab = false
            self.vwDetailTab?.isSelectTab = true
            self.vwMediaTab?.isSelectTab = false
            if !isUpdateVC {
                self.vwEvenInfoMainView?.isHidden = true
                self.vwDetailMainView?.isHidden = false
                self.vwMediaMainView?.isHidden = true
            }
            self.vwEvenInfoMainView?.isHidden = true
            self.vwDetailMainView?.isHidden = false
            self.vwMediaMainView?.isHidden = true
         
            self.view.layoutIfNeeded()
            break
        case .Media:
            if self.vwEventDescription?.txtInput?.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventDescription)
                return
            } else if self.vwLocation?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventLocation)
                return
            }
            self.selecetdTab = .Media
            self.vwEvenInfoTab?.isSelectTab = false
            self.vwDetailTab?.isSelectTab = false
            self.vwMediaTab?.isSelectTab = true
            if !isUpdateVC {
                self.vwEvenInfoMainView?.isHidden = true
                self.vwDetailMainView?.isHidden = true
                self.vwMediaMainView?.isHidden = false
            }
            self.vwEvenInfoMainView?.isHidden = true
            self.vwDetailMainView?.isHidden = true
            self.vwMediaMainView?.isHidden = false
            self.view.layoutIfNeeded()
            break
        }
    }
}

extension CreateEventViewController {
    
    private func mediaAPICall(img : UIImage) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadMedia(with: dict, image: img, success: { (msg) in
            self.mediaName = msg
            self.vwevenCovertview?.isHidden = true
            self.vwImageView?.isHidden = false
            self.imgEventCover?.isHidden = false
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    private func mediaAPICall(img : UIImage,index : Int) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadFeedMedia(with: dict, image: img, success: { (msg,urldata) in
            //let model = AddPhotoVideoModel.init(Id: "", postId: "", MediaNameUrl: urldata, MediaName: msg, isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: "", VideoImageUrl: "", VideoImageThumbUrl: "")
            let model = AddPhotoVideoModel.init(Id: "",  postId: "", postimage: "", FeedId: "",MediaNameUrl: urldata, MediaName: msg, isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: "", VideoImageUrl: "", VideoImageThumbUrl: "",thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage:"", isPost: "", type: false, videoThumbImage: "", thumbMedia: "", media: "", image: "", name: "", videoThumbImgName: "", galleryImage: "")
            
            self.arrPhotoVideo.append(model)
            self.cvGalleryimgView?.reloadData()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    private func setCreateEventAPI() {
    
        if let user = UserModel.getCurrentUserFromDefault(){
            var arr : [[String:Any]] = []
            for i in stride(from: 0, to:self.arrTicketData.count, by: 1){
            let obj = self.arrTicketData[i]
    
                    let dictTicket : [String:Any] = [
                        kticketName : obj.ticketName,
                        kticketPrice : obj.ticketPrice,
                        ktotalSeat : obj.totalSeat,
                    ]
                    arr.append(dictTicket)
            }
            
            var arrGallery : [[String:Any]] = []
            for i in stride(from: 0, to: self.arrPhotoVideo.count, by: 1) {
                let obj = self.arrPhotoVideo[i]
                let dictGallery : [String:Any] = [
                    kmediaName : obj.mediaName,
                    kvideoThumbImage : obj.mediaNameThumbUrl
                ]
                arrGallery.append(dictGallery)
            }
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token ,
                kname: self.vwEventName?.txtInput.text ?? "",
                keventDate : (self.vwEventDate?.txtInput.text ?? "").getDateFromString(format: AppConstant.DateFormat.k_MM_dd_yyyy).getFormattedString(format: AppConstant.DateFormat.k_yyyy_MM_dd),
                kstartTime : self.StartTimeSelect,
                kendTime : self.EndTimeSelect,
                kcategoryId :  self.selectedEventCategoryData?.id ?? "",
                kisPaid : (self.SwitchOn?.isOn ?? false) ? "1" : "0",
                kdescription : self.vwEventDescription?.txtInput?.text ?? "",
                klocation : self.vwLocation?.txtInput.text ?? "",
                klatitude : "\(self.selectedLatitude)",
                klongitude : "\(self.selectedLongitude)",
                kticketData : arr,
                kcoverImage : self.mediaName,
                kgalleryImage : arrGallery,
                kfreeTicketSeat : self.vwpaidticketqty?.txtInput?.text ?? ""
                
          
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            
            EventModel.SetEvent(withParam: param) { (Id,msg,arr) in
//                self.showMessage(msg, themeStyle: .success)
//                self.userEventData = arr
                self.appNavigationController?.push(EventDetailsViewController.self,configuration: { vc in
                 vc.isFromCreateEvent = true
                 vc.isBookview = true
                 vc.isDateview = true
                 vc.SelectedEventData = Id
                 vc.StartTimeSelect = self.StartTimeSelect
                 vc.EndTimeSelect = self.EndTimeSelect
    //                vc.SelectedEventData =
    //                vc.SelectedEventData = self.u
              })
               
            } failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                } else {
                    if !error.isEmpty {
//                        self.showMessage(error, themeStyle: .error)
                    }
                }
            }
        }
    }
}
//MARK: - IBAction Method
extension CreateEventViewController {
    
    @IBAction func SwitchonClicke(_ sender : UISwitch) {
  //
          self.SwitchOn?.backgroundColor = UIColor.CustomColor.whitecolor
          self.SwitchOn?.tintColor = UIColor.CustomColor.whitecolor
  
        if  (self.SwitchOn?.isOn ?? false) {
            self.vwticketview?.isHidden = false
            self.vwpaidticketqty?.isHidden = true
            self.vwaddticket?.isHidden = false
        } else {
            self.vwticketview?.isHidden = true
            self.vwpaidticketqty?.isHidden = false
            self.vwaddticket?.isHidden = true
        }
      }
    

    @IBAction func btnGalleryImglick(_ sender : UIButton) {
        self.view.endEditing(true)
        self.imagePicker.isAllowsEditing = true
        self.imagePicker.pickImage(sender, "Select Image") { (img,url) in
            self.mediaAPICall(img: img,index : sender.tag)
        }
    }
    
    @IBAction  func btnimgCoverClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.imagePicker.isAllowsEditing = true
        self.imagePicker.pickImage(sender, "Select Image") { (img,url) in
            self.imgEventCover?.image = img
            self.mediaAPICall(img: img)
        }
    }
    
    @IBAction func btnNextClick()  {
        if selecetdTab == .EvenInfo {
            if self.vwEventName?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.KEventName)
                return
            } else if self.vwEventDate?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.KEventDate)
                return
            } else if self.vwStartTime?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventstartTime)
                return
            } else if self.vwEndTime?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventEndTime)
                return
            } else if self.vwSelectCategory?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventCategory)
                return
            }
            self.setSelectedTab(obj: .Detail, isUpdateVC: false)
        } else if selecetdTab == .Detail {
            if self.vwEventDescription?.txtInput?.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventDescription)
                return
            } else if self.vwLocation?.txtInput.text == "" {
                self.showMessage(AppConstant.ValidationMessages.kEventLocation)
                return
            }
            self.setSelectedTab(obj: .Media, isUpdateVC: false)
        } else if selecetdTab == .Media {
            if self.mediaName != "" {
                self.setCreateEventAPI()
            } else {
                self.showMessage(AppConstant.ValidationMessages.kEmptyImaage)
            }
        }
    }
    
    @IBAction func AddTicketClick() {
        
        self.view.endEditing(true)
        if  (self.SwitchOn?.isOn ?? false) {
            let model = TicketdataModel.init(totalcartPriceamount : "",totalticketPriceamount : "",eventName : "",isPaid : "",status : "",price : "",qty : "",ticketId : "",id : "",userId : "",ticketName : "",ticketPrice : "",totalSeat : "",eventId : "",createdDate : "",updatedDate : "",availabletickets : "",isselectTicket : true, coverImage: "")
            self.arrTicketData.append(model)
            self.tblTicket?.reloadData()
        }
    }
}


// MARK: - ViewControllerDescribable
extension CreateEventViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension CreateEventViewController: AppNavigationControllerInteractable { }


// MARK: - ReusableView Delegate
extension CreateEventViewController : TextReusableViewDelegate {
    func buttonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        switch CreateEvent.init(rawValue: sender.tag) ?? .dateOfEvent {
        case .dateOfEvent:
            self.openDateOfEventClicked(sender)
        case .startTime:
            self.btnFromTimeClicked(sender)
        case .endTime:
            self.btnToTimeClicked(sender)
        case .selectedCategory:
            self.appNavigationController?.present(SelectCategoryPopupViewController.self,configuration: { vc in
                
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                vc.delegateCategory = self
            })
        case .MapSelect:
            self.MapselectClicked(sender)
        }
    }
    
    func rightButtonClicked(_ sender: UIButton) {
        return
    }
    
    
    @objc func MapselectClicked(_ sender : UIButton) {
        
        let filter = GMSAutocompleteFilter()
        //filter.type = .address
        let placePickerController = GMSAutocompleteViewController()
        placePickerController.delegate = self
        placePickerController.autocompleteFilter = filter
        present(placePickerController, animated: true, completion: nil)
    }
    @objc func openDateOfEventClicked(_ sender : UIButton) {
        var selecteddate : Date = Date()
        if self.vwEventDate?.txtInput.text != "" {
            selecteddate = (self.vwEventDate?.txtInput.text ?? "").getDateFromString(format: AppConstant.DateFormat.k_MM_dd_yyyy)
        }
        
        ActionSheetDatePicker.show(withTitle: "Select date of event", datePickerMode: .date, selectedDate: selecteddate, minimumDate: Date(), maximumDate: nil, doneBlock: { (picker, indexes, values) in
            self.vwEventDate?.txtInput.text = (indexes as? Date ?? Date()).getFormattedString(format: AppConstant.DateFormat.k_MM_dd_yyyy)
            return
        }, cancel: { (actiosheet) in
            return
        }, origin: sender)
    }
    
    @objc func btnFromTimeClicked(_ sender : UIButton){
        var fromPrevDate : Date = Date()
        
        if self.vwStartTime?.txtInput.text != "" {
            fromPrevDate = (self.vwStartTime?.txtInput.text ?? "").getDateFromString(format: AppConstant.DateFormat.k_hh_mm_a)
        }
        ActionSheetDatePicker.show(withTitle: "Select Start Time", datePickerMode: UIDatePicker.Mode.time, selectedDate: fromPrevDate, doneBlock: { (picker, date, origin) in
            if let selectdate = date as? Date {
                print(selectdate.get12HoursTimeString())
                let ftime = selectdate.get24HoursTimeString()
                self.selectedStartTime = ftime
                let mainSeletedDate = ftime.getDateFromString(format: AppConstant.DateFormat.k_hh_mm_a)
                
                if !(self.vwEndTime?.txtInput.isEmpty ?? true) && mainSeletedDate == ((self.vwEndTime?.txtInput.text ?? "").getStringToDateToStringToDate(firstformat: AppConstant.DateFormat.k_hh_mm_a, secondformat: AppConstant.DateFormat.k_hh_mm_a)) {
                    self.showAlert(with: AppConstant.ValidationMessages.kSelectedTimeSameFromTime)
                    
                } else if !(self.vwEndTime?.txtInput.isEmpty ?? true) && mainSeletedDate > ((self.vwEndTime?.txtInput.text ?? "").getStringToDateToStringToDate(firstformat: AppConstant.DateFormat.k_hh_mm_a, secondformat: AppConstant.DateFormat.k_hh_mm_a)) {
                    self.showAlert(with: AppConstant.ValidationMessages.kFromTimeGreterThenFromTime)
                } else {
                    self.vwStartTime?.txtInput.text = selectdate.get12HoursTimeString()
                    self.StartTimeSelect = selectdate.get24HoursTimeString()
                }
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender as UIView)
    }
    
    @objc func btnToTimeClicked(_ sender : UIButton){
        if self.vwStartTime?.txtInput.text == "" {
            self.showAlert(with: AppConstant.ValidationMessages.kEventstartTime)
        } else {
            
            var toPrevDate : Date = Date()
            if self.vwEndTime?.txtInput.text != "" {
                toPrevDate = (self.vwEndTime?.txtInput.text ?? "").getDateFromString(format: AppConstant.DateFormat.k_hh_mm_a)
            }
            ActionSheetDatePicker.show(withTitle: "Select Finish Time", datePickerMode: UIDatePicker.Mode.time, selectedDate: toPrevDate, doneBlock: { (picker, date, origin) in
                if let selectdate = date as? Date {
                    print(selectdate.get12HoursTimeString())
                    let ftime = selectdate.get24HoursTimeString()
                    self.selectedFinishTime = ftime
                    let finalSelectedTime = ftime.getDateFromString(format: AppConstant.DateFormat.k_hh_mm_a)
                    if (finalSelectedTime == ((self.vwStartTime?.txtInput.text ?? "").getStringToDateToStringToDate(firstformat: AppConstant.DateFormat.k_HH_mm_ss, secondformat: AppConstant.DateFormat.k_hh_mm_a))) {
                       
                            self.showAlert(with: AppConstant.ValidationMessages.kSelectedTimeSameFromTime)
                        
                    } else if finalSelectedTime < (self.vwStartTime?.txtInput.text ?? "").getStringToDateToStringToDate(firstformat: AppConstant.DateFormat.k_hh_mm_a, secondformat: AppConstant.DateFormat.k_hh_mm_a){
                            self.showAlert(with: AppConstant.ValidationMessages.kToTimeLessThenFromTime)
                    } else {
                        self.vwEndTime?.txtInput.text = selectdate.get12HoursTimeString()
                        self.EndTimeSelect = selectdate.get24HoursTimeString()
                    }
                }
                return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender as UIView)
        }
    }
}
// MARK: - UITextFieldDelegate
extension CreateEventViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.vwpaidticketqty?.txtInput {
            if  !(self.SwitchOn?.isOn ?? true) {
                let model = TicketdataModel.init(totalcartPriceamount : "",totalticketPriceamount : "",eventName : "",isPaid : "",status : "",price : "",qty : "",ticketId : "",id : "",userId : "",ticketName : "",ticketPrice : "",totalSeat : textField.text ?? "",eventId : "",createdDate : "",updatedDate : "",availabletickets : "",isselectTicket : true, coverImage: "")
             self.arrTicketData.append(model)
             self.tblTicket?.reloadData()
            }
        }
    }
}
// MARK: - SelectedCategory Delegate
extension CreateEventViewController : DelegateEventCategory {
    func selectedCategory(Category: EventCategoryModel) {
        self.selectedEventCategoryData = Category
        self.vwSelectCategory?.txtInput.text = Category.name
        
    }
}
// MARK: - GMSAutocompleteViewControllerDelegate
extension CreateEventViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //print("Place name: \(place.name)")
        //print("Place ID: \(place.placeID)")
        //print("Place attributions: \(place.attributions)")
        //dismiss(animated: true, completion: nil)

        dismiss(animated: true) {
            DispatchQueue.main.async { [self] in
                self.selectedLatitude = place.coordinate.latitude
                self.selectedLongitude = place.coordinate.longitude
                //self.lblLocation.text = place.formattedAddress ?? ""
                self.zipcode = ""
                self.streetname = ""
                var addressShort : String = ""
                for addressComponent in (place.addressComponents)! {
                    for type in (addressComponent.types){
                        print("Type : \(type) = \(addressComponent.name)")
                        switch(type){
                            case "street_number":
                                self.streetname = addressComponent.name
                                print("Street : \(self.streetname)")
                                addressShort = addressComponent.name
                            case "route":
                                addressShort = addressShort + "\(addressShort.isEmpty ? "\(addressComponent.name)" : ",\(addressComponent.name)")"
                            case "premise":
                                addressShort = addressShort + "\(addressShort.isEmpty ? "\(addressComponent.name)" : ",\(addressComponent.name)")"
                            case "neighborhood":
                                addressShort = addressShort + ",\(addressComponent.name)"
                            case "country":
                                self.countryname = addressComponent.name
                                print("Contry : \(self.countryname)")
                            case "postal_code":
                                 self.zipcode = addressComponent.name
                            case "administrative_area_level_2":
                                self.cityname = addressComponent.name
                                print("City : \(self.cityname)")
                            case "administrative_area_level_1":
                                self.statename = addressComponent.name
                                print("State : \(self.statename)")
                            //case "street_number":

                        default:
                            break
                        }
                    }
                }
                print(addressShort)
                self.vwLocation?.txtInput.text = place.name
                //addressShort.isEmpty ? (place.formattedAddress ?? "") : addressShort
            }
        }

    }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}

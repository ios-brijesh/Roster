//
//  EventDetailsViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 17/02/22.
//

import UIKit
import OnlyPictures

class EventDetailsViewController: UIViewController{
   
    
    // MARK: - IBOutlet
    

   
    @IBOutlet weak var imgUser: UIImageView?
    @IBOutlet weak var imhEvent: UIImageView?
    @IBOutlet weak var vwCategoryView: UIView?
    @IBOutlet weak var vwBottomView: UIView?
    @IBOutlet weak var vwUserimage: UIView?
    
    @IBOutlet weak var MapView: GMSMapView!
    @IBOutlet weak var vwLocationMainview: UIView?
    @IBOutlet weak var btnViewall: UIButton?
    @IBOutlet weak var btnbookNow: UIButton?
    
    @IBOutlet weak var lblContent: UILabel?
    @IBOutlet weak var lblAbout: UILabel?
    @IBOutlet weak var lblEventcount: UILabel?
    @IBOutlet weak var lblUsername: UILabel?
    @IBOutlet weak var lblOrganizer: UILabel?
    @IBOutlet weak var lblgalleryimage: UILabel?
    
    @IBOutlet weak var lblTicket: UILabel?
    @IBOutlet weak var lblCategory: UILabel?
    @IBOutlet weak var lblEventname: UILabel?
    @IBOutlet weak var lblCityname: UILabel?
    @IBOutlet weak var lblstartTime: UILabel?
    @IBOutlet weak var lblEndTime: UILabel?
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblBottomdate: UILabel?
    @IBOutlet weak var vwBookView: UIView?
    @IBOutlet weak var vwticketdata: UIView?
    @IBOutlet weak var vwgalleryView: UIView!
    
    @IBOutlet weak var cvGallery: UICollectionView?
    
    @IBOutlet weak var VwPublish: UIView?
    @IBOutlet weak var btnpublic: AppButton?
    
    @IBOutlet weak var tblTicket: UITableView?
    @IBOutlet weak var constrainttblTicketHeight: NSLayoutConstraint?
    
    @IBOutlet weak var vwProfiles: OnlyHorizontalPictures?
    // MARK: - Variables
    var isMyBookview : Bool = false
    var isBookview : Bool = false
    var isDateview : Bool = false
    var isPublish : Bool = false
    var SelectedEventData : String = ""
    var EventUrl : String = ""
    var SelectedTicketData : TicketdataModel?
    private var EventData : EventModel?
    private var arrTicket : [TicketdataModel] = []
    var isFromCreateEvent : Bool = false
    var isFromRsvp : Bool = false
    var ispaid : String = ""
    var userimage : String = ""
//    var isbooked : String = ""
    private var userEventData : [EventModel] = []
    private var arruserImages : [String] = []
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    var StartTimeSelect : String = ""
    var EndTimeSelect : String = ""
    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.InitConfig()
        
       
      
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let btnbookNow = self.btnbookNow {
            btnbookNow.cornerRadius = 10
            btnbookNow.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: btnbookNow.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if  let vwBottomView = self.vwBottomView {
            //
            vwBottomView.roundCornersTest(corners: [.topRight,.topLeft], radius: 25.0)
            //
            vwBottomView.clipsToBounds = true
            vwBottomView.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwBottomView.maskToBounds = false

        }
        self.vwLocationMainview?.cornerRadius = 20.0
        self.MapView?.cornerRadius = 20.0
   
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
    }
}

extension EventDetailsViewController: OnlyPicturesDataSource,OnlyPicturesDelegate{
    func visiblePictures() -> Int {
        return 10
        }
    
    func numberOfPictures() -> Int {
        return arruserImages.count
    }
    
    func pictureViews(_ imageView: UIImageView, index: Int) {
        
        let obj = self.arruserImages[index]
        imageView.image = #imageLiteral(resourceName: "AppPlaceholder")   // placeholder image
        imageView.setImage(withUrl: obj, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
    
    func pictureView(_ imageView: UIImageView, didSelectAt index: Int)  {
       
    }
}


// MARK: - Init Configure
extension EventDetailsViewController {
    private func InitConfig(){
        self.btnbookNow?.setTitle(self.isFromRsvp ? "RSVP" : "Book Now", for: .normal)
        self.vwProfiles?.dataSource = self
        self.vwProfiles?.delegate = self
        self.vwProfiles?.order = .ascending
        self.vwProfiles?.alignment = .left
        self.vwProfiles?.recentAt = .right
        self.vwProfiles?.spacingColor = UIColor.CustomColor.whitecolor
        self.vwProfiles?.defaultPicture = #imageLiteral(resourceName: "AppPlaceholder")
        self.vwProfiles?.gap = 20
        self.vwProfiles?.spacing = 1
        self.vwProfiles?.backgroundColor = UIColor.clear
        
      
        self.vwBookView?.isHidden = self.isBookview
        self.VwPublish?.isHidden = self.isPublish
      
        delay(seconds: 0.2) {
            if  let imhEvent = self.imhEvent {
                imhEvent.roundCorners(corners: [.bottomRight,.bottomLeft], radius: 30.0)

            }
        }
        if let cvGallery = self.cvGallery {
            cvGallery.register(HighlightsCell.self)
            cvGallery.dataSource = self
            cvGallery.delegate = self
        }
        
        self.tblTicket?.register(TicketsDataCell.self)
        self.tblTicket?.estimatedRowHeight = 100.0
        self.tblTicket?.rowHeight = UITableView.automaticDimension
        self.tblTicket?.delegate = self
        self.tblTicket?.dataSource = self
       
        self.lblCategory?.textColor = UIColor.CustomColor.blackColor
        self.lblCategory?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        
        self.vwCategoryView?.backgroundColor = UIColor.CustomColor.whitecolor
        self.vwCategoryView?.cornerRadius = 10
        
        self.lblEventname?.textColor = UIColor.CustomColor.whitecolor
        self.lblEventname?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 21.0))
        
        self.lblCityname?.textColor = UIColor.CustomColor.whitecolor
        self.lblCityname?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        
        
        self.lblContent?.textColor = UIColor.CustomColor.blackColor
        self.lblContent?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.lblUsername?.textColor = UIColor.CustomColor.appColor
        self.lblUsername?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
        
        self.lblEventcount?.textColor = UIColor.CustomColor.sepretorColor
        self.lblEventcount?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        self.lblstartTime?.textColor = UIColor.CustomColor.blackColor
        self.lblstartTime?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        
        self.lblEndTime?.textColor = UIColor.CustomColor.blackColor
        self.lblEndTime?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
    
        
        self.lblDate?.textColor = UIColor.CustomColor.blackColor
        self.lblDate?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        
        self.lblBottomdate?.textColor = UIColor.CustomColor.blackColor
        self.lblBottomdate?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        
        
        [self.lblTicket,self.lblOrganizer,self.lblAbout,self.lblgalleryimage].forEach({
            $0?.textColor = UIColor.CustomColor.blackColor
            $0?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size:14.0))
        })
        
   
        
        self.btnViewall?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnViewall?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 10.0))
        
        self.btnbookNow?.setTitleColor(UIColor.CustomColor.whitecolor, for: .normal)
        self.btnbookNow?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 13.0))
        
        if let imgUser = self.imgUser {
            imgUser.cornerRadius = imgUser.frame.height / 2
        }
            self.EventDetailApi()

    }


    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appnavigationEventNavBack(title: "", TitleColor: UIColor.CustomColor.textfieldTextColor, isShowRightButton: true,navigationItem: self.navigationItem)
       
        appNavigationController?.btnMoreClickBlock = {
            
        
                let textToShare = [ self.EventUrl]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            
        }
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}


//MARK: - Tableview Observer
extension EventDetailsViewController {
    
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
extension EventDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTicket.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(for: indexPath, with: TicketsDataCell.self)
        if self.arrTicket.count > 0 {
            
            if self.isFromCreateEvent == true {
                cell.btnSelect?.isHidden = true
            } else {
                cell.btnSelect?.isHidden = false
            }

            cell.SetTicketData(obj: self.arrTicket[indexPath.row])

            cell.btnSelect?.tag = indexPath.row
            cell.btnSelect?.addTarget(self, action: #selector(self.btnSelectTicketClicked(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    @objc func btnSelectTicketClicked(_ btn : UIButton){
        if self.arrTicket.count > 0 {
            let obj = self.arrTicket[btn.tag]
            self.SelectedTicketData = obj
            obj.isselectTicket = !obj.isselectTicket
            self.tblTicket?.reloadData()
        }
    }

}


///MARK: - UICollectionView Delegate and Datasource Method
extension EventDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPhotoVideo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HighlightsCell.self)
        cell.btnCancel?.isHidden = true
        cell.lblName?.isHidden = true
        cell.imgVideo?.cornerRadius = 13.0
        cell.setGalleryimage(obj: self.arrPhotoVideo[indexPath.row])
        cell.btnImage?.tag = indexPath.row
        cell.btnImage?.addTarget(self, action: #selector(self.btnImageClicked(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    @objc func btnImageClicked(_ sender : UIButton){
//        if self.arrPhotoVideo.count > 0 {
//            let obj = self.arrPhotoVideo[sender.tag]
//        self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
//            vc.imageUrl = obj.galleryImage
//            vc.modalPresentationStyle = .fullScreen
//            vc.modalTransitionStyle = .crossDissolve
//        })
//        }
//
//
        if self.arrPhotoVideo.count > 0 {
       
            var arr : [LightboxImage] = []
            
            for i in stride(from: 0, to: self.arrPhotoVideo.count, by: 1) {
                let objMedia = self.arrPhotoVideo[i]
                if let url = URL(string: objMedia.galleryImage) {
                        arr.append(LightboxImage(imageURL: url))
                    }
            
                if i == self.arrPhotoVideo.count - 1 {
                    self.openLighBoxVC(images: arr)
                }
            }
        }

    }
    
    private func openLighBoxVC(images : [LightboxImage]){
            // Create an instance of LightboxController.
            let controller = LightboxController(images: images)

            // Set delegates.
            controller.pageDelegate = self
            controller.dismissalDelegate = self

            // Use dynamic background.
            controller.dynamicBackground = true

            // Present your controller.
            present(controller, animated: true, completion: nil)
        }
}

extension EventDetailsViewController : LightboxControllerPageDelegate, LightboxControllerDismissalDelegate {
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        
    }
    
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print(page)

    }
}
//MARK: - IBAction Method
extension EventDetailsViewController {
    
    @IBAction func btnBookNowClick(_ sender : UIButton) {
        
        let C_Info = arrTicket[sender.tag]
        self.btnbookNow?.isUserInteractionEnabled = true
        if btnbookNow?.titleLabel?.text == "RSVP" {
            self.RsvpaddEventCart(cart: C_Info)
            self.btnbookNow?.setTitle("RSVPED", for: .normal)

        }
        else {
            let arrSelected = self.arrTicket.filter({$0.isselectTicket})
            if arrSelected.count == 0 {
                self.showMessage(AppConstant.ValidationMessages.kEmptyTicketType,themeStyle: .warning)
                return
            } else {
                self.addEventCart()
            }
        }
    }
    
    @IBAction func btnPublishClick() {
        self.setCreateEventAPI()
//        if self.isMyBookview == true {
//            self.setCreateEventAPI()
//            self.appNavigationController?.push(ProfileCreatedViewController.self,configuration: { vc in
//                vc.isFromCreateEvent = true
//            })
//        } else {
//            self.setCreateEventAPI()
//            self.appNavigationController?.push(ProfileCreatedViewController.self,configuration: { vc in
//                vc.isFromCreateEvent = true
//            })
//        }
        
    }
    
    @IBAction func btnViewAllClick(_ sender : UIButton) {
        self.appNavigationController?.push(ViewAllUserViewController.self,configuration: { vc in
            vc.isFromEvent = true
            vc.EventId = self.EventData?.id ?? ""
        })
    }
}

// MARK: - API Call
extension EventDetailsViewController {
        
    private func EventDetailApi(isshowloader :Bool = true) {
        
        if let user = UserModel.getCurrentUserFromDefault(){
           let dict : [String:Any] = [
               klangType : Rosterd.sharedInstance.languageType,
               ktoken : user.token,
               keventId : self.SelectedEventData
           ]
           let param : [String:Any] = [
               kData : dict
           ]
               EventModel.EventDetail(with: param, isShowLoader: isshowloader,  success: { (arr,attTicket,arrimage,totalPages,message) in
                   self.EventData = arr
                   self.setEventdeailData()
                   self.arrTicket = attTicket
                   self.tblTicket?.reloadData()
                   if arrimage != [] {
                       self.vwgalleryView?.isHidden = false
                       self.arrPhotoVideo = arrimage
                       self.cvGallery?.reloadData()
                   } else {
                       self.vwgalleryView?.isHidden = true
                   }
               }, failure: {[unowned self] (statuscode,error, errorType) in
                   print(error)
                   if statuscode == APIStatusCode.NoRecord.rawValue {
                   
                   } else {
                       if !error.isEmpty {
                           self.showMessage(error, themeStyle: .error)
                       }
                   }
               })
           }
    }
    
    private func setCreateEventAPI() {
        if let user = UserModel.getCurrentUserFromDefault(){
            
            var arr : [[String:Any]] = []
            for i in stride(from: 0, to:self.arrTicket.count, by: 1){
                let obj = self.arrTicket[i]
                
                let dictTicket : [String:Any] = [
                    kticketName : obj.ticketName,
                    kticketPrice : obj.ticketPrice,
                    ktotalSeat : obj.totalSeat,
                    kid : obj.id
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
            if  let obj = self.EventData {
                let dict : [String:Any] = [
                    klangType : Rosterd.sharedInstance.languageType,
                    ktoken : user.token ,
                    kname: obj.name,
                    keventDate : (obj.eventDateFormat).getDateFromString(format: AppConstant.DateFormat.k_MM_dd_yyyy).getFormattedString(format: AppConstant.DateFormat.k_yyyy_MM_dd),
                    kstartTime : self.StartTimeSelect,
                    kendTime : self.EndTimeSelect,
                    kcategoryId :  obj.categoryId,
                    kisPaid : obj.isPaid,
                    kdescription : obj.Description,
                    klocation : obj.location,
                    klatitude : obj.latitude,
                    klongitude : obj.longitude,
                    kticketData : arr,
                    kcoverImage : obj.coverImage,
                    kgalleryImage : arrGallery,
                    kstatus : self.EventData?.status == "0" ? "1" : "0",
                    kid : obj.id,
                    kfreeTicketSeat : obj.freeTicketSeat
                ]
                let param : [String:Any] = [
                    kData : dict
                ]
                
                EventModel.SetEvent(withParam: param) { (Id,msg,arr) in
                    self.appNavigationController?.push(ProfileCreatedViewController.self,configuration: { vc in
                        vc.isFromCreateEvent = true
                    })
                } failure: {[unowned self] (statuscode,error, errorType) in
                    print(error)
                    
                    if statuscode == APIStatusCode.NoRecord.rawValue {
                        
                    } else {
                        if !error.isEmpty {
                            // self.showMessage(error, themeStyle: .error)
                        }
                    }
                }
            }
        }
    }
    
    private func addEventCart() {
        
        if let user = UserModel.getCurrentUserFromDefault(), let TicketData = SelectedTicketData {
                        
            var arr : [[String:Any]] = []
            for i in stride(from: 0, to: 1, by: 1){
            let obj = self.arrTicket[i]
    
                    let dicTicket : [String:Any] = [
                        kid :  TicketData.id,
                        kqty : "1",
                        kprice : TicketData.ticketPrice
                    ]
                    arr.append(dicTicket)
                
            }
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                keventId : self.SelectedEventData,
                kqty : "1",
                kticketData : arr

            ]

            let param : [String:Any] = [
                kData : dict
            ]

            EventModel.addEventCart(with: param, success: { (totalAmount,msg) in
                self.appNavigationController?.push(EventMyCartViewController.self)

            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
    private func RsvpaddEventCart(cart:TicketdataModel) {
        
        if let user = UserModel.getCurrentUserFromDefault() {
            
            var arr : [[String:Any]] = []
            for i in stride(from: 0, to: 1, by: 1){
            let obj = self.arrTicket[i]
                    let dicTicket : [String:Any] = [
                        kid :  cart.id,
                        kqty : "1",
                        kprice : ""
                    ]
                    arr.append(dicTicket)
            }
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                keventId : self.SelectedEventData,
                kticketData : arr
           ]

            let param : [String:Any] = [
                kData : dict
            ]

            EventModel.addEventCart(with: param, success: { (totalAmount,msg) in
                delay(seconds: 0.4) {
                    self.navigationController?.popViewController(animated: true)
                }
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
    private func setEventdeailData() {
        if let obj = self.EventData {
            
            if self.isFromCreateEvent == true {
                self.vwUserimage?.isHidden = true
            } else {
                self.vwUserimage?.isHidden = false
            }
//            
//            if self.isBookview == true {
//                if obj.status == "0" {
//                    self.btnpublic?.setTitle("Publish", for: .normal)
//                } else {
//                    self.vwBottomView?.isHidden = true
//                    self.btnpublic?.setTitle("UnPublish", for: .normal)
//                }
//            }
            
            if obj.status == "0" {
                self.btnpublic?.setTitle("Publish", for: .normal)
            } else {
                self.btnpublic?.setTitle("UnPublish", for: .normal)
            }
            
            if obj.isBooked == "1" {
                self.btnbookNow?.setTitle("RSVPED", for: .normal)
                self.btnbookNow?.isUserInteractionEnabled = false
            }
            else {
                self.btnbookNow?.setTitle("RSVP", for: .normal)
                self.btnbookNow?.isUserInteractionEnabled = true
            }
            if obj.isPaid == "0" {
                self.vwticketdata?.isHidden = true
                self.lblTicket?.isHidden = true
                
            } else {
                self.btnbookNow?.setTitle("Book Now", for: .normal)
                self.btnbookNow?.isUserInteractionEnabled = true
            }
            let user = UserModel.getCurrentUserFromDefault()
            
            if user?.id == obj.userId {
                vwBookView?.isHidden = true
                VwPublish?.isHidden = false
            }
        
            self.arruserImages = obj.userImage
            self.vwProfiles?.reloadData()
            if self.arruserImages.count > 0 {
                self.vwUserimage?.isHidden = false
            } else {
                self.vwUserimage?.isHidden = true
            }
//            if self.arrPhotoVideo.count > 0 {
//                self.vwgalleryView?.isHidden = false
//                self.arrPhotoVideo = obj.galleryImage
//                self.cvGallery?.reloadData()
//            } else {
//                self.vwgalleryView?.isHidden = true
//            }
            self.lblCityname?.text = obj.location
            self.lblEventname?.text = obj.name
            self.lblCategory?.text = obj.categoryName
            self.lblUsername?.text = obj.userName
            self.lblContent?.text = obj.Description
            self.lblEventcount?.text = "\(obj.totalEvent) events"
            self.imgUser?.setImage(withUrl: obj.thumbprofileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.imhEvent?.setImage(withUrl: obj.coverImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.lblstartTime?.text = obj.startTimeFormat
            self.lblEndTime?.text = "- \(obj.endTimeFormat)"
            self.lblDate?.text = obj.eventDateFormat
            self.lblBottomdate?.text = obj.eventDateFormat
            let selecetdLatitude : Double = Double(obj.latitude) ?? 0
            let selecetdLongitude : Double = Double(obj.longitude) ?? 0
            if obj.latitude != "" && obj.longitude != "" {
                self.vwLocationMainview?.isHidden = false
                delay(seconds: 0.2) {
                    
                    let coordinate = CLLocationCoordinate2D(latitude: selecetdLatitude, longitude: selecetdLongitude)
                    self.MapView.camera = GMSCameraPosition.camera(withLatitude:coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
                    let marker: GMSMarker = GMSMarker()
                    marker.icon = #imageLiteral(resourceName: "ic_Location")
                    marker.position = coordinate
                    marker.map = self.MapView
                }
            } else {
                self.vwLocationMainview?.isHidden = true
            }
                        
        }
    }
}
// MARK: - ViewControllerDescribable
extension EventDetailsViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}
// MARK: - AppNavigationControllerInteractable
extension EventDetailsViewController: AppNavigationControllerInteractable { }

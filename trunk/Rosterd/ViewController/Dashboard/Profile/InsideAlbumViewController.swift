//
//  InsideAlbumViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/02/22.
//

import UIKit
import Photos

class InsideAlbumViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var cvAlbum: UICollectionView?
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnNav: UIButton!
    @IBOutlet weak var vwnodatafound: UIView!
    @IBOutlet weak var Nolabel: NoDataFoundLabel!
    @IBOutlet weak var lblAlbumName: UILabel!
    
    private var arrImages : [ProfileImageModel] = []
    var selectedAlbumdata : String = ""
    private let imagePicker = ImagePicker()
    private var mediaName : String = ""
    private var arrSelectedImages : [AddPhotoVideoModel] = []
    private var AlbumData : [ProfileAlbumModel] = []
    var isfromOther : Bool = false
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.getAlbumsAPICall()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}
// MARK: - Init Configure
extension InsideAlbumViewController {

    private func InitConfig(){
        self.imagePicker.viewController = self
        if let cv = self.cvAlbum {
            cv.register(CreateJobAddPhotoVideoCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        self.btnUpload?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.btnUpload?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
       
        self.lblAlbumName?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 15.0))
        self.lblAlbumName?.textColor = UIColor.CustomColor.blackColor
        
         if self.isfromOther {
             self.btnUpload?.isHidden =  true
         } else {
             self.btnUpload?.isHidden =  false
         }
    }
}
//MARK: - UICollectionView Delegate and Datasource Method
extension InsideAlbumViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CreateJobAddPhotoVideoCell.self)
//        cell.btnDelete?.isHidden = true
        cell.vwCancelSubMain?.isHidden = true
        if self.isfromOther {
            cell.btnDelete?.isHidden = true
        } else {
            cell.btnDelete?.isHidden = false
        }
        cell.imgPhoto?.setImage(withUrl: self.arrImages[indexPath.row].media, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        cell.imgVideo?.isHidden = true
      
        cell.btnDelete?.tag = indexPath.row
        cell.btnDelete?.addTarget(self, action: #selector(self.btnDeleteClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 4.0) - 10.0, height: ((collectionView.frame.size.width / 4.0) - 10.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
            vc.imageUrl = self.arrImages[indexPath.row].media
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
        })
    }
    
    @objc func btnDeleteClicked(_ sender : UIButton){
//        self.arrImages.remove(at: btn.tag)
        self.cvAlbum?.reloadData()
//        if self.arrImages.count == 0 {
//            self.cvAlbum?.isHidden = true
//        } else
//        {
//            self.cvAlbum?.isHidden = false
//        }
        self.showAlert(withTitle: "", with:"Are you sure want to delete this Image?", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            if self.arrImages.count > 0 {
                self.DeleteImageApi(mediaId: self.arrImages[sender.tag].id)
                
            }
        }, secondButton: ButtonTitle.No, secondHandler: nil)
                  
    }
}

extension InsideAlbumViewController {
    
    private func getAlbumsAPICall() {
        
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                ktoken : user.token,
                klangType : Rosterd.sharedInstance.languageType,
                kalbumId : self.selectedAlbumdata
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ProfileAlbumModel.getAlbums(with: param, success: { (arr,message) in
                self.arrImages = arr.first?.media ?? []
                self.vwnodatafound?.isHidden = self.arrImages.count == 0 ? false : true
                self.cvAlbum?.reloadData()
                self.lblAlbumName?.text = arr.first?.name
                self.selectedAlbumdata = arr.first?.id ?? ""
                //                self.vwnodatafound?.isHidden = true
                
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
//                self.cvAlbum?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.vwnodatafound?.isHidden = self.arrImages.count == 0 ? false : true

                if statuscode == APIStatusCode.NoRecord.rawValue {
                    self.Nolabel?.text = error
                    self.cvAlbum?.reloadData()
                 
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                    }
                }
            })
        }
    }
    
    private func mediaAPICall(img : UIImage) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadMedia(with: dict, image: img, success: { (msg) in
            self.mediaName = msg
            self.getSetUserAlbumMedia()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    private func DeleteImageApi(mediaId : String){
      if let user = UserModel.getCurrentUserFromDefault() {
          self.view.endEditing(true)
          
          let dict : [String:Any] = [
              klangType : Rosterd.sharedInstance.languageType,
              ktoken : user.token,
              kmediaId : mediaId
          ]
          
          let param : [String:Any] = [
              kData : dict
          ]
          
          ProfileImageModel.DeleteUserAlbumMedia(with: param, success: { (msg) in
              self.arrImages.removeAll()
              self.cvAlbum?.reloadData()
              self.getAlbumsAPICall()
          }, failure: {[unowned self] (statuscode,error, errorType) in
              print(error)
              if !error.isEmpty {
                  self.showMessage(error, themeStyle: .error)
              }
          })
      }
    }
    
    private func mediaMultipleImageAPICall(img : [UIImage]) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadMultipleImagesMedia(with: dict, image: img, success: { (arrImage,msg) in
            self.arrSelectedImages = arrImage
            self.getSetUserAlbumMedia()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    private func getSetUserAlbumMedia() {
    
        var arrGallery : [[String:Any]] = []
        arrGallery = arrSelectedImages.compactMap({ (model) -> [String:Any] in
            return [kmediaName:model.mediaName,kvideoThumbImgName:model.mediaName]
        })
        
    
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                ktoken : user.token,
                klangType : Rosterd.sharedInstance.languageType,
                kalbumId : self.selectedAlbumdata,
                kalbum_media : arrGallery
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ProfileAlbumModel.getSetUserAlbumMedia(with: param, success: { (message) in
                self.mediaName = ""
                self.arrSelectedImages.removeAll()
                self.arrImages.removeAll()
                self.cvAlbum?.reloadData()
                self.getAlbumsAPICall()
                
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
}
//MARK: - IBAction Method/*
extension InsideAlbumViewController {
    
    @IBAction func btnNavClick() {
        self.appNavigationController?.popViewController(animated: true)
       
    }
    
    @IBAction func btnUploadClick(_ sender : UIButton) {
        let viewController = TLPhotosPickerViewController()
        viewController.delegate = self
        viewController.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            self?.showExceededMaximumAlert(vc: picker)
        }
        viewController.customDataSouces = CustomDataSources()
        var configure = TLPhotosPickerConfigure()
        configure.numberOfColumn = 3
        configure.maxSelectedAssets = 6
        configure.allowedVideo = false
        configure.groupByFetch = .day
        configure.mediaType = .image
        viewController.configure = configure
        viewController.selectedAssets = []
        viewController.logDelegate = self
        self.present(viewController, animated: true, completion: nil)
     }
    }

// MARK: - ViewControllerDescribable
extension InsideAlbumViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension InsideAlbumViewController: AppNavigationControllerInteractable { }

extension InsideAlbumViewController : TLPhotosPickerViewControllerDelegate,TLPhotosPickerLogDelegate {
    func selectedCameraCell(picker: TLPhotosPickerViewController) {
        print("selectedCameraCell")
    }
    
    func selectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("selectedPhoto")
    }
    
    func deselectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("deselectedPhoto")
    }
    
    func selectedAlbum(picker: TLPhotosPickerViewController, title: String, at: Int) {
        print("selectedAlbum")
    }
    
    func dismissPhotoPicker(withPHAssets: [PHAsset]) {
        // if you want to used phasset.
    }
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        // use selected order, fullresolution image
        print(withTLPHAssets.count)
        //let img = withTLPHAssets.map({$0.fullResolutionImage})
        if withTLPHAssets.count > 0 {
            SVProgressHUD.show()
            if let first = withTLPHAssets.first {
                if first.type == .photo {
                    self.mediaMultipleImageAPICall(img: withTLPHAssets.map({$0.fullResolutionImage ?? UIImage()}))
                } else {
                    //withTLPHAssets.map({$0.exportVideoFile(completionBlock: <#T##((URL, String) -> Void)##((URL, String) -> Void)##(URL, String) -> Void#>)})
                    var arrData : [NSData] = []
                    for i in stride(from: 0, to: withTLPHAssets.count, by: 1){
                        let obj = withTLPHAssets[i]
                        obj.exportVideoFile { url, filename in
                            do {
                                let video = try NSData(contentsOf: url, options: .mappedIfSafe)
                                print("movie saved")
                                arrData.append(video)
                                if i == withTLPHAssets.count - 1 {
                                    SVProgressHUD.dismiss()
    //                                self.mediaMultipleVideoAPICall(videoData: arrData)
                                }
                                /*AVAsset(url: url).generateThumbnail { [weak self] (image) in
                                    DispatchQueue.main.async {
                                        guard let image = image else { return }
                                        //self?.videomediaAPICall(img: image, videodata: data)
                                        
                                    }
                                }*/
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func photoPickerDidCancel() {
        // cancel
    }

    func dismissComplete() {
        // picker dismiss completion
    }

    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        self.showExceededMaximumAlert(vc: picker)
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        picker.dismiss(animated: true) {
            /*let alert = UIAlertController(title: "", message: "Denied albums permissions granted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)*/
            
            self.showMessage("Denied albums permissions granted",themeStyle: .warning,presentationStyle: .bottom)
        }
    }
    
    
    func showExceededMaximumAlert(vc: UIViewController) {
        /*let alert = UIAlertController(title: "", message: "Exceed Maximum Number Of Selection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)*/
        self.showMessage("Exceed Maximum Number Of Selection",themeStyle: .warning,presentationStyle: .bottom)
    }
    
    func showUnsatisifiedSizeAlert(vc: UIViewController) {
        /*let alert = UIAlertController(title: "Oups!", message: "The required size is: 300 x 300", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)*/
        self.showMessage("The required size is: 300 x 300",themeStyle: .warning,presentationStyle: .bottom)
    }
}

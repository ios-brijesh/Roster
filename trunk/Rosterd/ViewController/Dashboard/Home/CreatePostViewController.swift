//
//  CreatePostViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 10/03/22.
//

import UIKit

protocol FeedDelegate {
    func updateFeedData()
}

class CreatePostViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var vwTopMain: UIView?
    @IBOutlet weak var vwContentMain: UIView?
    
    @IBOutlet weak var vwtxtview: UIView?
    @IBOutlet weak var constraintBottomMain: NSLayoutConstraint?
    
    @IBOutlet weak var txtPost: ReusableTextview?
    @IBOutlet weak var setTxtPost: UITextView?
    
    @IBOutlet weak var btnPost: UIButton?
    
    @IBOutlet weak var imgProfile: UIImageView?
    
    @IBOutlet weak var cvPhotoVideo: UICollectionView?
    
    @IBOutlet weak var btnPostimage: UIButton?
    @IBOutlet weak var btnPostVideo: UIButton?
    
    
    // MARK: - Variables
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    private let imagePicker = ImagePicker()
    private let videoPicker = VideoPicker()
    var delegate : FeedDelegate?
    var selectedFeedData : FeedModel?
    var isFromEdit : Bool = false
    var postid : String = ""
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        self.addKeyboardObserver()
        self.configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObserver()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Enable IQKeyboardManager
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Disable IQKeyboardManager
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let img = self.imgProfile {
            img.cornerRadius = img.frame.height/2
        }
        
        if let img = self.btnPostimage {
            img.cornerRadius = img.frame.height/2
        }
        
        if let img = self.btnPostVideo {
            img.cornerRadius = img.frame.height/2
        }

    }
}

// MARK: - Init Configure
extension CreatePostViewController {
    private func InitConfig(){
        
        self.imagePicker.viewController = self
        self.videoPicker.viewController = self
        
        self.btnPost?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.btnPost?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnPost?.cornerRadius = 10.0
        
        self.cvPhotoVideo?.delegate = self
        self.cvPhotoVideo?.dataSource = self
        self.cvPhotoVideo?.register(CreateJobAddPhotoVideoCell.self)
        
        if let user = UserModel.getCurrentUserFromDefault() {
            self.imgProfile?.setImage(withUrl: user.profileimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
    
        self.setTxtPost?.placeholder = "Write something here....."
        self.setTxtPost?.placeholderColor = UIColor.CustomColor.blackColor
        self.setTxtPost?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.setTxtPost?.textColor = UIColor.CustomColor.blackColor
        self.setTxtPost?.delegate = self
        
        self.cvPhotoVideo?.isHidden = true
        
        if self.isFromEdit,let obj = self.selectedFeedData {
            self.setTxtPost?.text = obj.text.decodingEmoji()
            self.arrPhotoVideo = obj.post
            if obj.post != [] {
                self.cvPhotoVideo?.isHidden = false
            } else {
                self.cvPhotoVideo?.isHidden = true
            }
            self.cvPhotoVideo?.reloadData()
//            if let arrPostMedia = self.selectedFeedData?.post,arrPostMedia.count > 0 {
//                self.arrPhotoVideo = arrPostMedia.compactMap({ (model) -> AddPhotoVideoModel in
//                    return AddPhotoVideoModel.init(Id: "", postId: "", postimage: model.postimage,FeedId: "",MediaNameUrl: "", MediaName: model.mediaName, isvideo: true, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: "", VideoImageUrl: "", VideoImageThumbUrl: "", thumbpostimage:model.thumbpostimage, postvideoThumbImage:model.postvideoThumbImage, thumbpostvideoThumbImage:model.thumbpostvideoThumbImage, isPost: "",  type: false, videoThumbImage: "", thumbMedia: "", media: "", image: "", name: "")
//                })
//                self.cvPhotoVideo?.reloadData()
//            }
           
        }
    }
    
    private func configureNavigationBar() {
              appNavigationController?.setNavigationBarHidden(true, animated: true)
              appNavigationController?.navigationBar.backgroundColor = UIColor.clear
              self.navigationController?.setNavigationBarHidden(false, animated: false)
              
              appNavigationController?.appNavigationControllersetUpBackWithTitle(title: self.isFromEdit ? "   Edit Post" : "   Create Feed", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
              
              navigationController?.navigationBar
                  .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
              navigationController?.navigationBar.removeShadowLine()
    }
}


// MARK: - UITextViewDelegate
extension CreatePostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.setTxtPost {
            self.setTxtPost?.resolveHashTagsAndMentions()
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if let scheme = URL.scheme {
            switch scheme {
            case "hash" :
                print("Hash: \(URL.absoluteString)")
            case "mention" :
                print("mention: \(URL.absoluteString)")
            default:
                print("just a regular url")
            }
        }

        return true
    }
}

//MARK: - NotificateionValueDelegate methods
extension CreatePostViewController {
    
    //MARK:- Notification observer for keyboard
    func addKeyboardObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        self.txtPost?.addGestureRecognizer(tapGesture)
    }
    
    func removeKeyboardObserver () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if #available(iOS 11, *) {
                if keyboardHeight > 0 {
                    keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom + 30.0
                }
            }
            self.constraintBottomMain?.constant = (keyboardHeight > 0) ? keyboardHeight : 30.0
            view.layoutIfNeeded()
        }
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
    
}

//MARK: - UICollectionView Delegate and Datasource Method
extension CreatePostViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPhotoVideo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CreateJobAddPhotoVideoCell.self)
        cell.btnSelect?.isHidden = false
        if indexPath.row != self.arrPhotoVideo.count{
            if self.arrPhotoVideo.count > 0 {
                let obj = self.arrPhotoVideo[indexPath.row]
                cell.imgVideo?.isHidden = !obj.isVideo
                if obj.isVideo {
                    if self.isFromEdit == true {
                        cell.imgPhoto?.setImage(withUrl: obj.postvideoThumbImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    } else {
                        cell.imgPhoto?.image = obj.videoThumpImg
                    }
                } else {
                    if self.isFromEdit == true {
                        cell.imgPhoto?.setImage(withUrl: obj.thumbpostimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    } else {
                        cell.imgPhoto?.setImage(withUrl: obj.mediaNameUrl, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                    }
                }
            }
        }
        cell.btnDelete?.tag = indexPath.row
        cell.btnDelete?.addTarget(self, action: #selector(self.btnDeleteClicked(_:)), for: .touchUpInside)
        
        cell.btnSelect?.tag = indexPath.row
        cell.btnSelect?.addTarget(self, action: #selector(self.btnSelectClicked(_:)), for: .touchUpInside)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @objc func btnDeleteClicked(_ btn : UIButton){
        self.arrPhotoVideo.remove(at: btn.tag)
        self.cvPhotoVideo?.reloadData()
        if self.arrPhotoVideo.count == 0 {
            self.cvPhotoVideo?.isHidden = true
        } else
        {
            self.cvPhotoVideo?.isHidden = false
        }
                  
    }
    
    @objc func btnSelectClicked(_ btn : UIButton){
        if self.arrPhotoVideo.count > 0 {
            let obj = self.arrPhotoVideo[btn.tag]
            if obj.isVideo {
                if self.isFromEdit == true {
                    if let videoURL = URL(string: obj.postimage) {
                        let player = AVPlayer(url: videoURL)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                            if let myplayer = playerViewController.player {
                                myplayer.play()
                            }
                        }
                    }
                } else {
                    if let videoURL = URL(string: obj.mediaNameUrl) {
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
            } else {
                self.appNavigationController?.present(imagePreviewViewController.self, configuration: { (vc) in
                    if self.isFromEdit == true {
                        vc.imageUrl = obj.postimage
                    } else {
                        vc.imageUrl = obj.mediaNameUrl
                    }
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                })
            }
        }
    }
}
// MARK: - IBAction
extension CreatePostViewController {
    @IBAction func btnPostClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        if (self.setTxtPost?.text?.isEmpty ?? false) && self.arrPhotoVideo.isEmpty {
            self.showMessage("Please add feed data", themeStyle: .warning, presentationStyle: .top)
            return
        }
        self.setFeedAPI()
    }
    
    @IBAction func btnAddImageClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.imagePicker.isAllowsEditing = true
        self.imagePicker.pickImage(sender, "Select Image") { (img,url) in
            self.mediaAPICall(img: img,index : sender.tag)
            self.cvPhotoVideo?.isHidden = false
        }
       
    }
    @IBAction func btnAddVideoClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.videoPicker.isAllowsEditing = false
        self.videoPicker.pickImage(sender,Title: "Select Video") { (data,url)  in
            //self.videoData = data
            
            AVAsset(url: url).generateThumbnail { [weak self] (image) in
                DispatchQueue.main.async {
                    guard let image = image else { return }
                    //self?.thumnailImg = image
                    self?.videomediaAPICall(img: image, videodata: data, index: sender.tag)
                    self?.cvPhotoVideo?.isHidden = false
                }
            }
        }
    }
}

// MARK: - API Call
extension CreatePostViewController {
    
    private func mediaAPICall(img : UIImage,index : Int) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadFeedMedia(with: dict, image: img, success: { (msg,urldata) in
            let model = AddPhotoVideoModel.init(Id: "",  postId: "", postimage: "", FeedId: "",MediaNameUrl: urldata, MediaName: msg, isvideo: false, VideoImage: "", videothumpimg: UIImage(), MediaNameThumbUrl: "", VideoImageUrl: "", VideoImageThumbUrl: "",thumbpostimage: "", postvideoThumbImage: "", thumbpostvideoThumbImage:"", isPost: "", type: false, videoThumbImage: "", thumbMedia: "", media: "", image: "", name: "", videoThumbImgName: "", galleryImage: "")
            
            self.arrPhotoVideo.append(model)
            self.cvPhotoVideo?.reloadData()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    private func videomediaAPICall(img : UIImage,videodata : NSData,index : Int) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        AddPhotoVideoModel.addFeedVideoAPI(with: videodata, image: nil, param: dict, success: { (videomedianame,videourldata,videoImgThumnailurl,videoImgName) in
            let model = AddPhotoVideoModel.init(Id: "", postId: "", postimage: "",FeedId: "",MediaNameUrl: videourldata, MediaName: videomedianame, isvideo: true, VideoImage: videoImgName, videothumpimg: img, MediaNameThumbUrl: videoImgName, VideoImageUrl: videoImgThumnailurl, VideoImageThumbUrl: videoImgThumnailurl, thumbpostimage:"", postvideoThumbImage:"", thumbpostvideoThumbImage:"", isPost: "",  type: false, videoThumbImage: "", thumbMedia: "", media: "", image: "", name: "", videoThumbImgName: "", galleryImage: "")
            self.arrPhotoVideo.append(model)
            self.cvPhotoVideo?.reloadData()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    private func setFeedAPI(){
        if let user = UserModel.getCurrentUserFromDefault() {
            //self.view.endEditing(true)
            var arr : [[String:Any]] = []
            for i in stride(from: 0, to: self.arrPhotoVideo.count, by: 1) {
                let obj = self.arrPhotoVideo[i]
                let dict : [String:Any] = [
                    kmediaName : obj.mediaName,
                    kvideoThumbImgName : obj.mediaNameThumbUrl
                ]
                arr.append(dict)
            }
            
            var dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                ktext : (self.setTxtPost?.text ?? "").encodindEmoji(),
                kimage_video : arr
            ]
            
            if self.isFromEdit,let obj = self.selectedFeedData {
                dict[ktbl_post_id] = obj.id
            } else {
                dict[kpostId] = ""
            }
            
            let param : [String:Any] = [
                kData : dict
            ]            
            FeedModel.setuserPost(with: param, success: { (msg) in
                self.delegate?.updateFeedData()
                self.navigationController?.popViewController(animated: true)
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
}

// MARK: - ViewControllerDescribable
extension CreatePostViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}

// MARK: - AppNavigationControllerInteractable
extension CreatePostViewController: AppNavigationControllerInteractable { }


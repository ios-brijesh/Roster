//
//  PreViewController.swift
//  ARStories
//
//  Created by Antony Raphel on 05/10/17.
//

import UIKit
import AVFoundation
import AVKit
import CoreMedia
import Photos


enum StoryType : Int{
    case DefaultStory
    case MyStory
    case OtherStory
    case ChatSTory
}


class PreViewController: UIViewController, SegmentedProgressBarDelegate {
    
    @IBOutlet weak var StackShowView: UIStackView!
    @IBOutlet weak var StackChatView: UIStackView!
    @IBOutlet weak var vwChatView: UIView!
    @IBOutlet weak var btnsend: UIButton!
    @IBOutlet weak var TxtMessage: UITextField!
    @IBOutlet weak var txtMsg: UITextView?
    @IBOutlet weak var VideoView: UIView!
    @IBOutlet weak var imagepreview: UIImageView!
    @IBOutlet weak var Img_Profile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var VwLeft: UIView!
    @IBOutlet weak var VwRight: UIView!
    @IBOutlet weak var btnmore: UIButton!
    @IBOutlet weak var btnNav: UIButton!
    @IBOutlet weak var lblViewstry: UILabel!
    @IBOutlet weak var btnMessageSend: UIButton!
    
    @IBOutlet weak var heightTopViewConstarint: NSLayoutConstraint?
    @IBOutlet weak var constraintVWMainBottom: NSLayoutConstraint?
    @IBOutlet weak var constraintTxtMsgHeight: NSLayoutConstraint?
    private var avplayerTimerObserver : Any?
    var storyType :StoryType = .DefaultStory
    var pageIndex : Int = 0
    var items: [StoryModel] = []
    var item: [StoryListModel] = []
    var itemData:StoryListModel?
    var SPB: SegmentedProgressBar!
    var player: AVPlayer!
    let loader = ImageLoader()
    var storyID = ""
    let popover = Popover()
    let deleteView: ViewDelete = .fromNib()
    var arrViews = [ModelViewStory]()
    
    //    var arrViews = [ModelViewStory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        WebSocketChat.shared.delegate = self
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        if storyType == .MyStory {
            self.vwChatView?.isHidden = true
            self.btnmore?.isHidden = false
            self.StackChatView?.isHidden = true
            self.StackShowView?.isHidden = false
        }
        else if storyType == .OtherStory {
            
            self.btnmore?.isHidden = false
            self.StackShowView?.isHidden = true
            self.StackChatView?.isHidden = false
        }
        else {
            
            self.btnmore?.isHidden = false
            self.StackShowView?.isHidden = true
            self.StackChatView?.isHidden = false
        }
        
        
        if let vw = self.btnmore {
            vw.cornerRadius = vw.frame.height / 2
            vw.backgroundColor = UIColor.CustomColor.black50Per
            
        }
        
        
        self.lblUsername?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        self.lblUsername?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblViewstry?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 10.0))
        self.lblViewstry?.textColor = UIColor.CustomColor.whitecolor
        
        
        self.btnMessageSend?.isHidden = true
        self.txtMsg?.placeholder = "Write a message..."
        self.txtMsg?.placeholderColor = UIColor.CustomColor.whitecolor
        self.txtMsg?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
        self.txtMsg?.textColor = UIColor.CustomColor.whitecolor
        self.txtMsg?.delegate = self
        //        self.txtMessage?.setPlaceHolderColor(text: UIColor.CustomColor.whitecolor50)
        self.Img_Profile?.layer.cornerRadius = self.Img_Profile.frame.size.height / 2;
        self.vwChatView?.cornerRadius = 30.0
        
        self.vwChatView?.backgroundColor = UIColor.CustomColor.black50Per
        self.Img_Profile?.setImage(withUrl: items[pageIndex].userProfileThumbImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        self.lblUsername?.text = items[pageIndex].userName
        item = items[pageIndex].storyList
        
        SPB = SegmentedProgressBar(numberOfSegments: item.count, duration: 5)
        if #available(iOS 11.0, *) {
            SPB.frame = CGRect(x: 18, y: UIApplication.shared.statusBarFrame.height + 5, width: view.frame.width - 35, height: 3)
        } else {
            // Fallback on earlier versions
            SPB.frame = CGRect(x: 18, y: 15, width: view.frame.width - 35, height: 3)
        }
        
        SPB.delegate = self
        SPB.topColor = UIColor.orange
        SPB.bottomColor = UIColor.white.withAlphaComponent(0.25)
        SPB.padding = 2
        SPB.isPaused = true
        SPB.currentAnimationIndex = 0
        SPB.duration = getDuration(at: 0)
        view.addSubview(SPB)
        view.bringSubviewToFront(SPB)
        
        let tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(tapOn(_:)))
        tapGestureImage.numberOfTapsRequired = 1
        tapGestureImage.numberOfTouchesRequired = 1
        self.imagepreview?.addGestureRecognizer(tapGestureImage)
        
        let tapGestureVideo = UITapGestureRecognizer(target: self, action: #selector(tapOn(_:)))
        tapGestureVideo.numberOfTapsRequired = 1
        tapGestureVideo.numberOfTouchesRequired = 1
        self.VideoView?.addGestureRecognizer(tapGestureVideo)
        
        
        let swipeDownImage = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDownImage.direction = .down
        self.imagepreview?.addGestureRecognizer(swipeDownImage)
        
        let swipeDownVideo = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDownVideo.direction = .down
        self.VideoView?.addGestureRecognizer(swipeDownVideo)
        
        let leftGestureImage = UITapGestureRecognizer(target: self, action: #selector(tapOnLeft(_:)))
        tapGestureImage.numberOfTapsRequired = 1
        tapGestureImage.numberOfTouchesRequired = 1
        self.VwLeft?.addGestureRecognizer(leftGestureImage)
        
        let rightGestureImage = UITapGestureRecognizer(target: self, action: #selector(tapOnRight(_:)))
        tapGestureImage.numberOfTapsRequired = 1
        tapGestureImage.numberOfTouchesRequired = 1
        self.VwRight?.addGestureRecognizer(rightGestureImage)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardObserver()
        UIView.animate(withDuration: 0.8) {
            self.view.transform = .identity
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.SPB.startAnimation()
            self.playVideoOrLoadImage(index: 0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeKeyboardObserver()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        DispatchQueue.main.async {
            self.SPB.currentAnimationIndex = 0
            self.SPB.cancel()
            self.SPB.isPaused = true
            self.resetPlayer()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - SegmentedProgressBarDelegate
    //1
    func segmentedProgressBarChangedIndex(index: Int) {
        playVideoOrLoadImage(index: index)
    }
    
    //2
    func segmentedProgressBarFinished() {
        if pageIndex == (self.items.count - 1) {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            _ = ContentViewControllerVC.goNextPage(fowardTo: pageIndex + 1)
        }
    }
    
    @objc func tapOn(_ sender: UITapGestureRecognizer) {
        SPB.isPaused = !SPB.isPaused
        //SPB.skip()
    }
    
    @objc func tapOnLeft(_ sender: UITapGestureRecognizer) {
        SPB.rewind()
    }
    
    @objc func tapOnRight(_ sender: UITapGestureRecognizer) {
        SPB.skip()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case .down:
                self.dismiss(animated: true, completion: nil)
                if let onReload = ContentViewControllerVC.onReloadStory {
                    onReload()
                }
                resetPlayer()
            default:
                break
            }
        }
    }
    
    //MARK: - Play or show image
    func playVideoOrLoadImage(index: NSInteger) {
        let storyItem = item[index]
        viewUserStory(storyItem.id)
        getUserStoryViewList(storyItem.id)
        storyID = storyItem.id
        itemData = storyItem
        if item[index].isVideo == "0" {
            self.SPB.duration = 5
            self.imagepreview?.isHidden = false
            self.VideoView?.isHidden = true
            self.imagepreview?.imageFromServerURL(item[index].mediaUrl)
        } else {
            
            self.imagepreview.isHidden = true
            self.VideoView.isHidden = false
            
            resetPlayer()
            guard let url = NSURL(string: item[index].mediaUrl) as URL? else {return}
            self.player = AVPlayer(url: url)
            
            let videoLayer = AVPlayerLayer(player: self.player)
            videoLayer.frame = view.bounds
            videoLayer.videoGravity = .resizeAspect
            self.VideoView.layer.addSublayer(videoLayer)
            
            let asset = AVAsset(url: url)
            let duration = asset.duration
            let durationTime = CMTimeGetSeconds(duration)
            
            self.SPB.duration = durationTime
            self.player.play()
//            self.imagepreview?.isHidden = true
//            self.VideoView?.isHidden = false
//
//            resetPlayer()
//            guard let url = NSURL(string: item[index].mediaUrl) as URL? else {return}
//
//            //  if let urlData = NSData(contentsOf: url)
//            //       {
//            //            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
//            //           let filePath="\(documentsPath)/tempFile.mp4"
//
//            //                self.player = AVPlayer(url: url)
//            //            self.player.automaticallyWaitsToMinimizeStalling = false
//            //            self.player.playImmediately(atRate: 0)
//            //                let videoLayer = AVPlayerLayer(player: self.player)
//            //                videoLayer.frame = view.bounds
//            //                videoLayer.videoGravity = .resizeAspect
//            //                self.VideoView?.layer.addSublayer(videoLayer)
//            //
//            //                let asset = AVAsset(url: url)
//            //                let duration = asset.duration
//            //                let durationTime = CMTimeGetSeconds(duration)
//            //
//            //                self.SPB.duration = durationTime
//            //                self.player.play()
//            //
//
//            //   }
//            self.player = AVPlayer(url: url)
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = view.bounds
//            playerLayer.videoGravity = .resizeAspect
//            self.VideoView?.layer.addSublayer(playerLayer)
//            //
//            //self.SPB.startAnimation()
//            self.player.play()
//            let asset = AVAsset(url: url)
//            let duration = asset.duration
//            let durationTime = CMTimeGetSeconds(duration)
//
//            self.SPB.duration = durationTime
//            //self.SPB.isPaused = true
//            print("Dureation : \(durationTime)")
//            var isPlay : Bool = false
//            self.avplayerTimerObserver = self.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 60-0), queue: DispatchQueue.main, using: { time in
//                print("start")
//                //self.SPB.isPaused = true
//                if self.player?.currentItem?.status == AVPlayerItem.Status.readyToPlay {
//
//                    if let isPlaybackLikelyToKeepUp = self.player?.currentItem?.isPlaybackBufferFull {
//                        //do what ever you want with isPlaybackLikelyToKeepUp value, for example, show or hide a activity indicator.
//                        print("Finish")
//
//                        //self.player.removeTimeObserver(self)
//                        if !isPlay {
//                            isPlay = true
//                            self.SPB.startAnimation()
//                            print("pplayerb  ; \(isPlaybackLikelyToKeepUp)")
//
//                            //self.SPB.isPaused = false
//                            //self.SPB.startAnimation()
//                        }
//
//                        //MBProgressHUD.hide(for: self.view, animated: true)
//                    }
//                }
//            })
        }
    }
    
    // MARK: Private func
    private func getDuration(at index: Int) -> TimeInterval {
        var retVal: TimeInterval = 5.0
        if item[index].isVideo == "0" {
            retVal = 5.0
        } else {
            guard let url = NSURL(string: item[index].mediaUrl) as URL? else { return retVal }
            let asset = AVAsset(url: url)
            let duration = asset.duration
            retVal = CMTimeGetSeconds(duration)
        }
        return retVal
    }
    
    private func resetPlayer() {
        if player != nil {
            player.pause()
            player.replaceCurrentItem(with: nil)
            player = nil
        }
    }
    
    
    private func removeAVPlayerObserver(){
        if let obj = self.avplayerTimerObserver {
            if self.player != nil{
                self.player.removeTimeObserver(obj)
            }
        }
    }
    
    //MARK: - Button actions
    
    @IBAction func btnmoreClick(_ sender: UIButton) {
        
        if storyType == .MyStory {
            deleteView.lbldelete?.text =  "Delete"
        } else if storyType == .OtherStory {
            deleteView.lbldelete?.text =  "Download"
        }
        
        
        SPB.isPaused = true
        deleteView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        
        deleteView.btnDeleteStory?.tag = sender.tag
        deleteView.btnDeleteStory?.addTarget(self, action: #selector(self.btnDeleteClicked(_:)), for: .touchUpInside)
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
        var showpoint : CGPoint = (sender.globalFrame!.origin)
        showpoint.x = showpoint.x + (sender.frame.width)
        showpoint.y = showpoint.y + (sender.frame.height)
        popover.popoverType = .down
        popover.willDismissHandler = { () in
            self.SPB.isPaused = false
            
        }
        popover.show(deleteView, point: showpoint)
        
        
    }
    
    @objc func btnDeleteClicked(_ sender : UIButton){
        
        if deleteView.lbldelete?.text == "Delete" {
            
            self.showAlert(withTitle: "", with: "Are You Want to delete this Story?", firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
                self.DeleteUserStory(self.storyID)
                
            }, secondButton: ButtonTitle.No, secondHandler: nil)
            popover.dismiss()
        }
        else {
            if itemData?.isVideo == "0" {
                if let stUrl = self.itemData?.mediaUrl,let url = URL(string: stUrl),let data = try? Data(contentsOf: url),let image = UIImage(data: data)
                {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    popover.dismiss()
                    self.showMessage("Saved Successsfully..!", themeStyle: .success)
                }
            }
            else {
                DispatchQueue.global(qos: .background).async {
                    if let stUrl = self.itemData?.thumbStoryVideoThumbImage,let url = URL(string: stUrl),let urlData = NSData(contentsOf: url) {
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                        let fileName = url.lastPathComponent
                        let filePath="\(documentsPath)/\(fileName)"
                        DispatchQueue.main.async {
                            urlData.write(toFile: filePath, atomically: true)
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                            }) { completed, error in
                                if completed {
                                    print("Video is saved!")
                                }
                            }
                            self.popover.dismiss()
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        if let onReload = ContentViewControllerVC.onReloadStory {
            onReload()
        }
        resetPlayer()
    }
    
    @IBAction func btnshareClick(_ sender: UIButton) {
        SPB.isPaused = true
        let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ViewStoryViewController") as! ViewStoryViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.storyID = self.storyID
        vc.isShareStory = true
        vc.onStartStory = { () in
            self.SPB.isPaused = false
        }
        vc.onShareStory = { () in
            self.dismiss(animated: true, completion: nil)
            if let onShareDismiss = ContentViewControllerVC.onShareStoryDismiss {
                
                onShareDismiss()
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnviewStoryClick(_ sender: UIButton) {
        
        SPB.isPaused = true
        let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ViewStoryViewController") as! ViewStoryViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.storyID = self.storyID
        vc.arrViewList = self.arrViews
        vc.onStartStory = { () in
            self.SPB.isPaused = false
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnsendMessageClick(_ sender: UIButton) {
        
        if !(self.txtMsg?.text ?? "").isValidString() {
            self.sendMessage(msg: self.txtMsg?.text ?? "")
        }
        self.dismiss(animated: true, completion: nil)
        if let onReload = ContentViewControllerVC.onReloadStory {
            onReload()
        }
        resetPlayer()
        
    }
    
    @IBAction func btnNavClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK:- webSocketChatDelegate
extension PreViewController : webSocketChatDelegate {
    
    
    func SendReceiveData(dict: [String : AnyObject]) {
        print(dict)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            print("Socket Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
        }
        
        
        if let hookmethod = dict[khookMethod] as? String {
            if hookmethod == AppConstant.WebSocketAPI.kDeleteUserStory {
                
                self.dismiss(animated: true, completion: nil)
                if let onReload = ContentViewControllerVC.onReloadStory {
                    onReload()
                }
                self.resetPlayer()
                
            }
        } else if let hookmethod = dict[khookMethod] as? String {
            if hookmethod == AppConstant.WebSocketAPI.kviewUserStory {
                
            }
        } else if let hookmethod = dict[khookMethod] as? String {
            if hookmethod == AppConstant.WebSocketAPI.kgetUserStoryViewList {
                
                
                if let dataarr = dict[kData] as? [[String:Any]] {
                    let arrViews = dataarr.compactMap({ModelViewStory.init(fromDictionary: $0)})
                    
                    if arrViews.count > 0 {
                        self.arrViews = arrViews
                    }
                }
                
                self.lblViewstry.text = "\(self.arrViews.count) Views"
            }
        }
    }
}

//MARK: - UITextViewDelegate
extension PreViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        SPB.isPaused = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        SPB.isPaused = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textField(_ textView: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textView.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            if updatedText.count > 0 {
                btnsend.isHidden = false
                
            }
            else {
                //                SPB.isPaused = true
                btnsend.isHidden = false
            }
            
        }
        return true
    }
}

////MARK: Socket Custom Metod
//extension PreViewController {
//    func shareStoryMessage() {
//        if kAppDelegate.Socket.isConnected {
//            if txtMessage.text?.trim().count > 0 {
//                showLoaderHUD(strMessage: "")
//                let dictionary = ["hookMethod": socketChat,
//                                  "message" : txtMessage.text?.trim(),"type" : "1","recipient_id" : "\(items[pageIndex].chatGroupId)"]
//                if let theJSONData = try? JSONSerialization.data(
//                    withJSONObject: dictionary,
//                    options: []) {
//                    let theJSONText = String(data: theJSONData,
//                                             encoding: .utf8)
//                    print("JSON string = \(theJSONText!)")
//                    kAppDelegate.Socket.write(string: "\(theJSONText!)")
//                    txtMessage.text = ""
//                    self.view.endEditing(true)
//                    hideLoaderHUD()
//                }
//            }
//        }
//        else {
//            kAppDelegate.connectSocket()
//        }
//    }
//}


//MARK: API Calling Story
extension PreViewController {
    private func DeleteUserStory(_ storyID:String? = ""){
        
        
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kDeleteUserStory,
                                           kstoryId : "\(storyID ?? "")",
        ]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
    
    private func viewUserStory(_ storyID:String? = ""){
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kviewUserStory,
                                           kstoryId : "\(storyID ?? "")",
        ]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
    
    private func sendMessage(msg : String,fileRealName : String = ""){
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kmessage,
                                      krecipient_id : "\(items[pageIndex].chatGroupId)",
                                           kmessage : msg.encodindEmoji(),
                                              ktype : "1"]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
    
    private func getUserStoryViewList(_ storyID:String? = ""){
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kgetUserStoryViewList,
                                           kstoryId : "\(storyID ?? "")",
        ]
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    }
}

// MARK: - UITextViewDelegate
extension PreViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        SPB.isPaused = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        SPB.isPaused = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // print(textView.contentSize.height)
        if textView.contentSize.height <= 130 && textView.contentSize.height > 35{
            self.setTxtMsgHeight(value: textView.contentSize.height)
        } else if textView.contentSize.height < 35 {
            self.setTxtMsgHeight(value: 35.0)
        }
        self.SPB.isPaused = (textView.text?.count ?? 0) > 0 ? false : true
        self.btnMessageSend?.isHidden = (textView.text?.count ?? 0) > 0 ? false : true
        
        
    }
    
    private func setTxtMsgHeight(value : CGFloat){
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.constraintTxtMsgHeight?.constant = -value
            //            self.setScrollBottom()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension PreViewController {
    
    func addKeyboardObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeKeyboardObserver () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if #available(iOS 11, *) {
                if keyboardHeight > 0 {
                    keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                }
            }
            self.constraintVWMainBottom?.constant = keyboardHeight + (DeviceType.IS_PAD ? 18 : 9)
            view.layoutIfNeeded()
        }
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
    
}


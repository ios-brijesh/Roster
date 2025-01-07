//
//  AlbumNameViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 18/08/22.
//

import UIKit

protocol addAlbumDelegate {
    func reloadalbum()
}

protocol addHighlightsNameDelegate {
    func AddName(obj : String, id : String)
}

class AlbumNameViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblheader: UILabel?
    @IBOutlet weak var vwsub: UIView?
    @IBOutlet weak var btnsubmit: AppButton?
    @IBOutlet weak var btnclose: UIButton?
    @IBOutlet weak var btncloseTouch: UIButton?
    
    @IBOutlet weak var vwreportText: ReusableTextview?
    @IBOutlet weak var constarintbottoView: NSLayoutConstraint?
    
    var delegate : addAlbumDelegate?
    var Delegate : addHighlightsNameDelegate?
    var isfromProfile : Bool = false
    var isFromHighlights : Bool = false
    var isfromAlbum : Bool = false
    var selectedHighlightsData : AddPhotoVideoModel?
    var abumId : ProfileAlbumModel?
    var isFromEdit : Bool = false
    var highlights : String = ""
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.InitConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
//        self.addKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.removeKeyboardObserver()
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.vwsub?.clipsToBounds = true
        self.vwsub?.shadow(UIColor.CustomColor.shadowColorBlack, radius: 5.0, offset: CGSize(width: -4, height: -5), opacity: 1)
        self.vwsub?.maskToBounds = false
    }
}
// MARK: - Init Configure
extension AlbumNameViewController {
    private func InitConfig(){
        self.btnclose?.backgroundColor = UIColor.CustomColor.appColor
        self.lblheader?.textColor = UIColor.CustomColor.TextColor
        self.lblheader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        if self.isFromHighlights == true {
            self.vwreportText?.placeholderText = "Add Highlights Name here .."
            self.lblheader?.text = "Highlights Name"
        }
        if self.isfromAlbum == true {
            self.vwreportText?.placeholderText = "Album name here"
        }
       self.vwsub?.roundCornersTest(corners: [.topLeft,.topRight], radius: 40.0)
        
        if self.isFromEdit,let obj = self.selectedHighlightsData {
            self.vwreportText?.txtInput?.text = obj.name.decodingEmoji()
         
        }
    }
}
// MARK: - IBAction
extension AlbumNameViewController {
    @IBAction func btncrateClicked(_ sender: AppButton) {
        self.view.endEditing(true)
        
        if self.isFromHighlights == true {
            self.Delegate?.AddName(obj: (self.vwreportText?.txtInput?.text ?? "").encodindEmoji(), id: self.selectedHighlightsData?.id ?? "")
            self.dismiss(animated: true, completion: nil)
        }
        else {
            if self.vwreportText?.txtInput?.isEmpty ?? false {
                self.showMessage("Please enter report text", themeStyle: .warning, presentationStyle: .top)
                return
            }
            self.SetUserAlbum()
        }
    }
    @IBAction func btncloseClicked(_ sender: UIButton) {
        
        if self.isFromHighlights == true {
            self.Delegate?.AddName(obj: (self.vwreportText?.txtInput?.text ?? "").encodindEmoji(), id: self.selectedHighlightsData?.id ?? "")
            self.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func btnCloseDownCliked(_ sender : UIButton) {
        if self.isFromHighlights == true {
            self.Delegate?.AddName(obj: (self.vwreportText?.txtInput?.text ?? "").encodindEmoji(), id: self.selectedHighlightsData?.id ?? "")
            self.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
//MARK: - NotificateionValueDelegate methods
extension AlbumNameViewController {
    //MARK:- Notification observer for keyboard
    func addKeyboardObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGestureHandler() {
        self.view.endEditing(true)
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
            self.constarintbottoView?.constant = keyboardHeight + 20.0
            view.layoutIfNeeded()
        }
    }
}
//MARK:- API Call
extension AlbumNameViewController{
    
    private func SetUserAlbum(){
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kname : (self.vwreportText?.txtInput?.text ?? "").encodindEmoji()
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.SetUserAlbum(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.delegate?.reloadalbum()
                
                if self.isfromProfile {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    delay(seconds: 0.2) {
                         self.dismiss(animated: true, completion: nil)
                   }
                }
            }, failure: { (statuscode,error, errorType) in
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension AlbumNameViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}
// MARK: - AppNavigationControllerInteractable
extension AlbumNameViewController: AppNavigationControllerInteractable { }

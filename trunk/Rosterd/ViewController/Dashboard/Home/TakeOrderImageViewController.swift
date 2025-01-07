//
//  TakeOrderImageViewController.swift
//  BeautySuppliedDriver
//
//  Created by WM-KP on 22/10/21.
//

import UIKit
import AVFoundation

protocol BoomrangDelegate {
    func getBoomrangImages(_ url:URL)
}

protocol StorySetDelegate {
    func StorySet(_ image: UIImage)
    func setBoomRangStory(_ url: URL)
    func SetGallery()
    func CollageStory(_ Image: UIImage)
}

class TakeOrderImageViewController: UIViewController,AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnBoomerang: UIButton!
    @IBOutlet weak var btnGallary: UIButton!
    @IBOutlet weak var btnRetake: UIButton!
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var btnStoryNext: UIButton?
    @IBOutlet weak var lblBoomrend: UILabel?
    
    @IBOutlet weak var imgpickup: UIImageView!
    
    @IBOutlet weak var vwCamera: UIView!
    var delegate : StorySetDelegate?
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    var arrStoryMedia = [typeAliasDictionary]()
    var captureSession = AVCaptureSession();
    var sessionOutput = AVCapturePhotoOutput();
    var sessionOutputSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg]);
    var previewLayer = AVCaptureVideoPreviewLayer();
    
    var pickupImage = ""
    var onConfirmPickupImage: ((_ stImage:String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblBoomrend?.textColor = UIColor.CustomColor.whitecolor
        self.lblBoomrend?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 9.0))
        Rosterd.sharedInstance.multipleImageDelegate = self
        self.openCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
    
    @IBAction func btnAtoryNextClick() {
        if let img = self.imgpickup.image {
            self.navigationController?.popViewController(animated: true)
            self.delegate?.StorySet(img)
        }
    }
    @IBAction func btnConfirmAction() {
        self.dismiss(animated: true) {
            if self.pickupImage != "" {
                guard let onConfirm = self.onConfirmPickupImage else { return }
                onConfirm(self.pickupImage)
            }
        }
    }
    
    
    private func setCaptureButton(isCapture : Bool = false){
        self.imgpickup.isHidden = !isCapture
        self.vwCamera.isHidden = isCapture
        self.btnCapture.isHidden = isCapture
        self.btnStoryNext?.isHidden = !isCapture
    }
    
    @IBAction func btnCloseACtion() {
        self.dismiss(animated: true) {
        }
    }
    private func openCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // the user has already authorized to access the camera.
            self.setupCaptureSession()
            
        case .notDetermined: // the user has not yet asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted { // if user has granted to access the camera.
                    print("the user has granted to access the camera")
                    DispatchQueue.main.async {
                        self.setupCaptureSession()
                        self.setCaptureButton()
                    }
                } else {
                    print("the user has not granted to access the camera")
                    //self.handleDismiss()
                }
            }
            
        case .denied:
            print("the user has denied previously to access the camera.")
            //self.handleDismiss()
            
        case .restricted:
            print("the user can't give camera access due to some restriction.")
            //self.handleDismiss()
            
        default:
            print("something has wrong due to we can't access the camera.")
            // self.handleDismiss()
        }
    }
    
    private func setupCaptureSession() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera,AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.back)
        for device in (deviceDiscoverySession.devices) {
            if(device.position == AVCaptureDevice.Position.back){
                do{
                    let input = try AVCaptureDeviceInput(device: device)
                    if(captureSession.canAddInput(input)){
                        captureSession.addInput(input);
                        
                        if(captureSession.canAddOutput(sessionOutput)){
                            captureSession.addOutput(sessionOutput);
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
                            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
                            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait;
                            previewLayer.frame = vwCamera.bounds
                            self.vwCamera.layer.addSublayer(previewLayer);
                            print(previewLayer.frame)
                            captureSession.startRunning()
                        }
                    }
                }
                catch{
                    print("exception!");
                }
            }
        }
    }
    
    
    /*func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
     guard let imageData = photo.fileDataRepresentation() else { return }
     let previewImage = UIImage(data: imageData)
     self.imgpickup.isHidden = false
     self.imgPickup.image = previewImage
     }
     
     @objc private func handleDismiss() {
     DispatchQueue.main.async {
     self.dismiss(animated: true, completion: nil)
     }
     }*/
    
    func setUpRootScene() {
        let cc = IGCameraController()
        let navController = UINavigationController(rootViewController: cc)
        navController.isNavigationBarHidden = true
        present(navController, animated: true, completion: nil)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            print("image: \(UIImage(data: dataImage)?.size ?? .zero)") // Your Image
            if let img = UIImage(data: dataImage) {
                self.captureSession.stopRunning()
                self.setCaptureButton(isCapture: true)
                var dict = typeAliasDictionary()
                dict["media"] = img
                dict["isVideo"] = "0"
                self.imgpickup.isHidden = false
                self.imgpickup.image = img
            }
        }
    }
    //}
    @IBAction func btnCaptureCLicked(_ sender: UIButton) {
        
        if let videoConnection = sessionOutput.connection(with: AVMediaType.video) {
            
            let settings = AVCapturePhotoSettings()
            let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
            let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                                 kCVPixelBufferWidthKey as String: 160,
                                 kCVPixelBufferHeightKey as String: 160]
            settings.previewPhotoFormat = previewFormat
            self.sessionOutput.capturePhoto(with: settings, delegate: self)
        }
    }
    
    @IBAction func btnBoomreangClicked(_ sender: UIButton) {
    
        self.appNavigationController?.push(VideoCaptureViewController.self,configuration: { vc in
            vc.delegate = self
            
        })
                                           
//        setUpRootScene()
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        
        self.appNavigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnGalleryClicked(_ sender: UIButton) {
        self.appNavigationController?.popViewController(animated: true)
        self.delegate?.SetGallery()
    }
    
    @IBAction func btnRetakeClicked(_ sender: UIButton) {
        self.captureSession.startRunning()
        self.setCaptureButton()
    }
    
    @IBAction func btnCollageClicked(_ sender: UIButton) {
        
        if let viewController = UIStoryboard(name: "Collage", bundle: nil).instantiateViewController(withIdentifier: "CollageViewController") as? CollageViewController {
            viewController.delegate = self
            self.appNavigationController?.pushViewController(viewController, animated: true)
            
            }
    }
    
 }



extension TakeOrderImageViewController : CollageStorySetDelegate {

    func imagesData(_ image:UIImage) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.CollageStory(image)
    }
   

}
//MARK: - BoomrangDelegate
extension TakeOrderImageViewController : BoomrangDelegate {
    func getBoomrangImages(_ url: URL) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.setBoomRangStory(url)
    }
    
//    func getBoomrangImages(_ url: URL) {
//        print("URL:\(url)")
//        var dict = typeAliasDictionary()
//        dict["media"] = url
//        dict["isVideo"] = "1"
//        self.arrStoryMedia.append(dict)
//        print("Story Media:\(self.arrStoryMedia)")
//        if self.arrStoryMedia.count > 0 {
//           self.mediaAPIImagesAndVideoCall(self.arrStoryMedia)
//        }
//    }
}


extension TakeOrderImageViewController : BoomrangPopDelegate {
    func storyPop() {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: API Calling
extension TakeOrderImageViewController {
    private func mediaAPICall(img : UIImage) {
        let dict : [String:Any] = [
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        UserModel.uploadMedia(with: dict, image: img, success: {[unowned self] (msg) in
            self.pickupImage = msg
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
    }
    
    
    
}


// MARK: - ViewControllerDescribable
extension TakeOrderImageViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}

// MARK: - AppNavigationControllerInteractable
extension TakeOrderImageViewController: AppNavigationControllerInteractable { }

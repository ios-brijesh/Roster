//
//  IGCameraPreviewController.swift
//  Instagram_Boomerang
//
//  Created by Boominadha Prakash on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import UIKit
import AVKit




class IGCameraPreviewController: UIViewController, ActivityViewPresenter {
    
    @IBOutlet weak var backBiew: UIView?
   
    var arrayOfImages: [UIImage] = []
    var arrStoryMedia = [typeAliasDictionary]()
  
    private var arrPhotoVideo : [AddPhotoVideoModel] = []
    let outputSize = CGSize(width: 1920, height: 1280)
        let imagesPerSecond: TimeInterval = 3 //each image will be stay for 3 secs
        var selectedPhotosArray = [UIImage]()
        var imageArrayToVideoURL = NSURL()
        let audioIsEnabled: Bool = false //if your video has no sound
        var asset: AVAsset!
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: self.view.frame)
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        showAnimatedImages()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        let navItem = UINavigationItem(title: "Done")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(selectorName(sender:)))
        self.navigationItem.rightBarButtonItem = doneItem
        
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageView.stopAnimating()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.backBiew?.backgroundColor = UIColor.systemPink
        
    }
    func showAnimatedImages() {
        let totalImages = arrayOfImages + arrayOfImages.reversed()
        let animatedImages = UIImage.animatedImage(with: totalImages, duration: 1.5)
        imageView.image = animatedImages
        imageView.startAnimating()
    }
}


extension IGCameraPreviewController {
    
    @objc func selectorName(sender: UIBarButtonItem) {
//        self.dismiss(animated: true) { [self] in
////            Rosterd.sharedInstance.multipleImageDelegate?.getBoomrangImages(self.arrayOfImages + self.arrayOfImages.reversed())
//        }
          LoadingView.lockView()
          
          VideoGenerator.fileName = "newVideo"
          VideoGenerator.shouldOptimiseImageForVideo = true
        VideoGenerator.videoDurationInSeconds = 10.0
        
          VideoGenerator.current.generate(withImages: arrayOfImages, andAudios: [], andType: .multiple, { (progress) in
            print(progress)
          }) { (result) in
            LoadingView.unlockView()
            switch result {
            case .success(let url):
              print(url)
                self.dismiss(animated: true) { [self] in
                Rosterd.sharedInstance.multipleImageDelegate?.getBoomrangImages(url)
                }
            case .failure(let error):
              print(error)

            }
          }
        
        
       
    }
}

// MARK: - ViewControllerDescribable
extension IGCameraPreviewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.main
    }
}

// MARK: - AppNavigationControllerInteractable
extension IGCameraPreviewController: AppNavigationControllerInteractable { }

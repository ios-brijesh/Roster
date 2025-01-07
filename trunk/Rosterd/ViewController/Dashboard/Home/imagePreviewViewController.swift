//
//  imagePreviewViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 10/03/22.
//

import UIKit

class imagePreviewViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var btnClose: UIButton?
    
    @IBOutlet weak var imgPost: UIImageView?
    
    //UIScrollView
    @IBOutlet weak var postImgScrollview: UIScrollView?
    
    // MARK: - Variables
    var imageUrl : String = ""

    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imgPost?.setImage(withUrl: self.imageUrl, placeholderImage: UIImage(named: DefaultPlaceholderImage.AppPlaceholder) ?? UIImage(), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.btnClose?.roundedCornerRadius()
    }
}

// MARK: - Init Configure Methods
extension imagePreviewViewController {
    private func InitConfig() {
        self.postImgScrollview?.delegate = self
        self.postImgScrollview?.minimumZoomScale = 1.0
        self.postImgScrollview?.maximumZoomScale = 10.0
        
        self.btnClose?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 17.0))
        self.btnClose?.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
    }
}

// MARK: - UIScrollView Delegates
extension imagePreviewViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView == self.postImgScrollview {
            return self.imgPost
        }
        return nil
    }
}

//MARK: IBAction Mthonthd
extension imagePreviewViewController {
   
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ViewControllerDescribable
extension imagePreviewViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}

// MARK: - AppNavigationControllerInteractable
extension imagePreviewViewController: AppNavigationControllerInteractable{}


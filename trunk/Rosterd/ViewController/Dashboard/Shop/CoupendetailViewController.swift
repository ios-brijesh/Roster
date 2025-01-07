//
//  CoupendetailViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/08/22.
//

import UIKit

class CoupendetailViewController: UIViewController {

    
    
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblHowitWork: UILabel?
    @IBOutlet weak var lblDetail: UILabel?
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}



// MARK: - Init Configure
extension CoupendetailViewController {
    private func InitConfig() {
        
        
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        self.lblHeader?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 25.0))
        
        self.lblHowitWork?.textColor = UIColor.CustomColor.whitecolor
        self.lblHowitWork?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 18.0))
        
        self.lblDetail?.textColor = UIColor.CustomColor.whitecolor
        self.lblDetail?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
    }
}



//MARK: - IBAction Method
extension CoupendetailViewController {
    
    
    @IBAction func btnDownClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
    
// MARK: - ViewControllerDescribable
extension CoupendetailViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
           return UIStoryboard.Name.Shop
    }
}

// MARK: - AppNavigationControllerInteractable
extension CoupendetailViewController: AppNavigationControllerInteractable{}

//
//  SelectProfileTypeViewController.swift
//  Rosterd
//
//  Created by WM-KP on 05/01/22.
//

import UIKit

class SelectProfileTypeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    @IBOutlet weak var cvProfileType: UICollectionView?
    @IBOutlet weak var btnBack: UIButton!
    // MARK: - Variables
    var selectedIndex = 0
    var isFromLogin : Bool = false
    private var arrRole : [userRole] = [.fan,.athlete,.schoolclub,.coachrecruiter]
    private var selectedRole : userRole = .fan
   
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

// MARK: - Init Configure
extension SelectProfileTypeViewController {
    private func InitConfig(){
        
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 27.0))
        self.lblHeader?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.subHeaderTextColor
        
        if let cvProfileType = self.cvProfileType {
            cvProfileType.register(ProfileTypeCell.self)
            cvProfileType.dataSource = self
            cvProfileType.delegate = self
        }
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
        //appNavigationControllersetUpTabbarTitle(title: "", TitleColor: UIColor.green, navigationItem: self.navigationItem, isHideMsgButton: true)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
    
}

//MARK: - UICollectionView Delegate and Datasource Method
extension SelectProfileTypeViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.arrRole.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProfileTypeCell.self)
        if self.arrRole.count > 0 {
            let obj = self.arrRole[indexPath.row]
            
            cell.lblProfileTitle?.setSelectProfileTextLabel(firstText: "I am an", SecondText: " \(obj.name)")
            cell.imgProfileType?.image = obj.img
        }
        
        if selectedIndex == indexPath.item {
            cell.vwMainBG?.setCornerRadius(withBorder: 3, borderColor: UIColor.CustomColor.verifyCodeSeperatorColor, cornerRadius: 15)
        }
        else {
            cell.vwMainBG?.setCornerRadius(withBorder: 3, borderColor: UIColor.CustomColor.reusableSeperatorColor, cornerRadius: 15)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = (collectionView.frame.width - ((2 - 1) * 15)) / 2
        return CGSize(width: width , height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRole = self.arrRole[indexPath.row]
        selectedIndex = indexPath.item
        print(indexPath.row)
        collectionView.reloadData()

        
    }
}


//MARK:- API Call
extension SelectProfileTypeViewController {
    

    private func completeProfile(){
      
         
            if let user = UserModel.getCurrentUserFromDefault() {

                let dict : [String:Any] = [
                          ktoken : user.token,
                          klangType : Rosterd.sharedInstance.languageType,
                          krole : self.selectedRole.apiValue,
                          kprofileStatus : "1",
                      ]
                    let param : [String:Any] = [
                        kData : dict
                    ]
            UserModel.completeProfile(with: param, success: { (model, msg) in
                self.appNavigationController?.push(CompleteProfileViewController.self,configuration: { vc in
                  vc.selectedRole = self.selectedRole
                })
            }, failure: {[unowned self] (statuscode,error, errorType) in
//                print(error)
                if !error.isEmpty {
//                    self.showMessage(error,themeStyle : .error)
                }
            })
        //}
     }
    }
}
    

//MARK: - IBAction Method
extension SelectProfileTypeViewController {
    @IBAction func btnNextClick() {
        self.completeProfile()
//        self.appNavigationController?.push(CompleteProfileViewController.self,configuration: { vc in
//          vc.selectedRole = self.selectedRole
//        })
       
    }
    
    @IBAction func btnbackClick() {
        self.appNavigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - ViewControllerDescribable
extension SelectProfileTypeViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension SelectProfileTypeViewController: AppNavigationControllerInteractable { }

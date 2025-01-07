//
//  SportsSelectListViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/05/22.
//

import UIKit



protocol jobCategoryDelegate {
    func selectedCategories(arr : [SportsModel])
}

class SportsSelectListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tblCategory: UITableView?
    
    @IBOutlet weak var vwBottomBtn: UIView?
    // MARK: - Variables
    private var arrCategory : [SportsModel] = []
    var arrSelectedCategory : [String] = []
    var delegate : jobCategoryDelegate?
    
    var isFromHomeScreen : Bool = false
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
}

// MARK: - Init Configure
extension SportsSelectListViewController {
    private func InitConfig(){
        
    
       
        self.tblCategory?.register(SignupCategoryCell.self)
        self.tblCategory?.estimatedRowHeight = 100.0
        self.tblCategory?.rowHeight = UITableView.automaticDimension
        self.tblCategory?.delegate = self
        self.tblCategory?.dataSource = self
        
        self.tblCategory?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        self.vwBottomBtn?.isHidden = self.isFromHomeScreen
        
        self.getJobCategoryListAPICall()
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

//MARK:- UITableView Delegate
extension SportsSelectListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: SignupCategoryCell.self)
        if self.arrCategory.count > 0 {
            cell.setCategoryData(obj: self.arrCategory[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.isFromHomeScreen {
            if self.arrCategory.count > 0 {
                let obj = self.arrCategory[indexPath.row]
                obj.isSelect = !obj.isSelect
                self.tblCategory?.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

// MARK: - IBAction
extension SportsSelectListViewController {
    
    @IBAction func btnContinueClicked(_ sender: UIButton) {
        let filter = self.arrCategory.filter({$0.isSelect})
        if filter.isEmpty {
            self.showMessage(AppConstant.ValidationMessages.kEmptySportsSelect,themeStyle: .warning)
        } else {
            self.delegate?.selectedCategories(arr: filter)
            self.appNavigationController?.popViewController(animated: true)
        }
    }
}
// MARK: - API Call
extension SportsSelectListViewController {
    private func getJobCategoryListAPICall() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                ksearch : ""
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            SportsModel.getSportsList(with: param, success: { (arr,msg) in
                self.arrCategory = arr
                
                for i in stride(from: 0, to: self.arrCategory.count, by: 1) {
                    let obj = self.arrCategory[i]
                    if self.arrSelectedCategory.contains(obj.id) {
                        obj.isSelect = true
                    }
                    if i == self.arrCategory.count - 1 {
                        self.tblCategory?.reloadData()
                    }
                }
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error,themeStyle : .error)
                }
            })
        }
    }
}

// MARK: - ViewControllerDescribable
extension SportsSelectListViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension SportsSelectListViewController: AppNavigationControllerInteractable { }


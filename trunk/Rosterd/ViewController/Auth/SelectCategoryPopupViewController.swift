//
//  SelectCategoryPopupViewController.swift
//  Rosterd
//
//  Created by WM-KP on 20/05/22.
//

import UIKit

protocol DelegateEventCategory {
    func selectedCategory(Category:EventCategoryModel)
}

class SelectCategoryPopupViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tblCategory: UITableView?
    @IBOutlet weak var vwSub: UIView?
    @IBOutlet weak var btnClose: UIButton?
    @IBOutlet weak var btnSubmit: AppButton?
    
    @IBOutlet weak var lblselectcategory: UILabel!
    // MARK: - Variables
    private var arrCategoryData : [EventCategoryModel] = []
    var delegateCategory: DelegateEventCategory?
    var selectedEventCategoryData : EventCategoryModel?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwSub?.clipsToBounds = true
        self.vwSub?.shadow(UIColor.CustomColor.shadowColorBlack, radius: 5.0, offset: CGSize(width: 0, height: 0), opacity: 1)
        self.vwSub?.roundCornersTest(corners: [.topLeft,.topRight], radius: 40.0)
        self.vwSub?.maskToBounds = false
        if let btn = self.btnClose {
            btn.cornerRadius = btn.frame.height / 2.0
        }
    }
}

// MARK: - IBAction
extension SelectCategoryPopupViewController {
    @IBAction func btnOnClickClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Init Configure
extension SelectCategoryPopupViewController {
    private func InitConfig() {
        
        self.lblselectcategory?.textColor = UIColor.CustomColor.TextColor
        self.lblselectcategory?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
                
        self.tblCategory?.register(CommonListCell.self)
        self.tblCategory?.estimatedRowHeight = 100.0
        self.tblCategory?.rowHeight = UITableView.automaticDimension
        self.tblCategory?.delegate = self
        self.tblCategory?.dataSource = self
        self.tblCategory?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.getEventCategoryListAPICall()
    }
}
// MARK: - API Call
extension SelectCategoryPopupViewController {
    private func getEventCategoryListAPICall() {
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            EventCategoryModel.getcatergoryData(with: param, success: { (arr,msg) in
                self.arrCategoryData = arr
                self.tblCategory?.reloadData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error,themeStyle : .error)
                }
            })
        }
    }
}

// MARK: - UITABLEVIEW DELEGATE & DATASOURCE

extension SelectCategoryPopupViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCategoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: CommonListCell.self)
        if self.arrCategoryData.count > 0 {
            let obj = self.arrCategoryData[indexPath.row]
            cell.lblName?.text = obj.name
            if obj.name == "All" {
                cell.btnSelect?.isHidden = true
                cell.lblName?.textColor = UIColor.CustomColor.TextColor
                cell.lblName?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 14.0))
            }
            else {
                cell.btnSelect?.isHidden = false
                cell.lblName?.textColor = UIColor.CustomColor.TextColor
                cell.lblName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
                
                cell.btnSelectMain?.tag = indexPath.row
                cell.btnSelectMain?.addTarget(self, action: #selector(self.btnSelectSportsClicked(_:)), for: .touchUpInside)
            }
            if let data = self.selectedEventCategoryData {
                cell.btnSelect?.isSelected = (data.id == obj.id)
            } else {
                cell.btnSelect?.isSelected = false
            }
            
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    @objc func btnSelectSportsClicked(_ btn : UIButton){
        if self.arrCategoryData.count > 0 {
            let obj = self.arrCategoryData[btn.tag]
            self.selectedEventCategoryData = obj
            self.tblCategory?.reloadData()
        }
    }

}
// MARK: - IBAction
extension SelectCategoryPopupViewController {
    
    @IBAction func btnSubmitClicked(_ sender : UIButton) {
        if let data = self.selectedEventCategoryData{
            self.dismiss(animated: true) {
                self.delegateCategory?.selectedCategory(Category: data)
            }
        }
    }
}
// MARK: - ViewControllerDescribable
extension SelectCategoryPopupViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}
// MARK: - AppNavigationControllerInteractable
extension SelectCategoryPopupViewController: AppNavigationControllerInteractable { }

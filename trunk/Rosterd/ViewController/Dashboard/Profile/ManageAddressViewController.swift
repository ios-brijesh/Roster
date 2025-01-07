//
//  ManageAddressViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/05/22.
//

import UIKit

protocol AddadressDelegate {
    func reloadadress(_ address:AdresssModel?)
    
}

class ManageAddressViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var lblSavedAdresss: UILabel?
    @IBOutlet weak var lblManageAdd: UILabel?
    
    @IBOutlet weak var tblAdress: UITableView?
    
    @IBOutlet weak var btnAddadress: UIButton?
    @IBOutlet weak var btnnav: UIButton!
    
    @IBOutlet weak var constrainttblAdressHeight: NSLayoutConstraint?
    
    // MARK: - Variables
    var delegate : AddadressDelegate?
    var selectAdressDeta : AdresssModel?
    private var arrAdress : [AdresssModel] = []
    var selectedindex = 0
    var isFromMenu : Bool = false
    private var totalPages : Int = 0
    private var pageNo : Int = 1
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.addTableviewOberver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
       
    }
} 
// MARK: - Init Configure
extension ManageAddressViewController {
    private func InitConfig(){
                 
        self.lblSavedAdresss?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblSavedAdresss?.textColor = UIColor.CustomColor.textfieldTextColor
        
        self.lblManageAdd?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblManageAdd?.textColor = UIColor.CustomColor.blackColor
        
        self.btnAddadress?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnAddadress?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        self.tblAdress?.register(AdressCell.self)
        self.tblAdress?.rowHeight = UITableView.automaticDimension
        self.tblAdress?.delegate = self
        self.tblAdress?.dataSource = self
        self.getUserShippingAddressApi()
    }
}
//MARK: Pagination tableview Mthonthd
extension ManageAddressViewController {
    
    private func reloadAdressData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrAdress.removeAll()
        self.tblAdress?.reloadData()
        self.getUserShippingAddressApi()
    }
}
//MARK: - Tableview Observer
extension ManageAddressViewController {
    
    private func addTableviewOberver() {
        self.tblAdress?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
       
    }
    
    func removeTableviewObserver() {
        if self.tblAdress?.observationInfo != nil {
            self.tblAdress?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblAdress && keyPath == ObserverName.kcontentSize {
                self.constrainttblAdressHeight?.constant = self.tblAdress?.contentSize.height ?? 0.0
            }
            
        }
    }
}

//MARK:- UITableView Delegate
extension ManageAddressViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAdress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(for: indexPath, with: AdressCell.self)
        if self.arrAdress.count > 0 {
        let obj = self.arrAdress[indexPath.row]
        let houseNumber = "House No \(obj.houseNumber)"
        let address = obj.address
        let landMark = obj.landMark
        let city = obj.city
           
        
        let FullAdress = houseNumber + ", " + address + ", " + landMark + "," + city
            cell.lblphonenumber?.text = "Phone No.\(obj.phonenumber)"
        cell.lblDetailadd?.text = FullAdress
//            if let data = self.selectAdressDeta {
//                cell.btnSelect?.isSelected = (data.id == obj.id)
//
//
//            } else {
//                cell.btnSelect?.isSelected = false
//
//
//            }
        if obj.isDefault == "1"{
            cell.vwdefaultadd?.isHidden = false
        } else {
            cell.vwdefaultadd?.isHidden = true
        }
            if selectedindex == indexPath.item {
                cell.vwMainview?.setCornerRadius(withBorder: 1, borderColor: UIColor.CustomColor.appColor, cornerRadius: 25)
                
            }
            else {
                cell.vwMainview?.setCornerRadius(withBorder: 2, borderColor: UIColor.CustomColor.MinusBtnColor, cornerRadius: 25)
            }
        }
        
        cell.btnEdit?.tag = indexPath.row
        cell.btnEdit?.addTarget(self, action: #selector(self.btnEditRequest(_:)), for: .touchUpInside)
//        cell.btnSelect?.tag = indexPath.row
//        cell.btnSelect?.addTarget(self, action: #selector(self.btnSelectRequest(_:)), for: .touchUpInside)
       
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isFromMenu == true {
            
        } else {
            selectedindex = indexPath.item
            print(indexPath.row)
            let obj = self.arrAdress[selectedindex]
            self.selectAdressDeta = obj
            self.tblAdress?.reloadData()
            self.delegate?.reloadadress(self.selectAdressDeta)
            self.appNavigationController?.popViewController(animated: true)
        }
    }
    
    @objc func btnEditRequest(_ sender : UIButton){
        if self.arrAdress.count > 0 {
            let obj = self.arrAdress[sender.tag]
            self.appNavigationController?.present(AddadressViewController.self,configuration: { vc in
                vc.modalPresentationStyle = .overFullScreen
                vc.selectedAdressData = obj
                vc.isFromEditAdress = true
                vc.delegate = self
            })
        }
    }
}

// MARK: - API
extension ManageAddressViewController {
    private func getUserShippingAddressApi(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)"
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            AdresssModel.getUserShippingAddress(with: param, success: { (arrlist,msg) in
                self.arrAdress = arrlist
                self.tblAdress?.reloadData()
                self.tblAdress?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                 
                    self.tblAdress?.reloadData()
                    self.tblAdress?.EmptyMessage(message: error)
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                      
                    }
                }
            })
        }
    }
}

//MARK:- UITableView Delegate
extension ManageAddressViewController : addAdresssDelegate {
    func reloadadress() {
        self.reloadAdressData()
    }
}

// MARK: - IBAction
extension ManageAddressViewController {
    
    
    @IBAction func btnAddAdressClicked(_ sender : UIButton){
        self.appNavigationController?.present(AddadressViewController.self,configuration: { vc in
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            vc.btndelete = true
           
        })
    }
    
    @IBAction func btnNavClicked(_ sender : UIButton) {
        if self.arrAdress.count > 0 {
            let firstcard = self.arrAdress[selectedindex]
            self.delegate?.reloadadress(firstcard)
            self.appNavigationController?.popViewController(animated: true)
        } else {
            self.appNavigationController?.popViewController(animated: true)
        }
          
        
    }
}
// MARK: - ViewControllerDescribable
extension ManageAddressViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ManageAddressViewController: AppNavigationControllerInteractable { }

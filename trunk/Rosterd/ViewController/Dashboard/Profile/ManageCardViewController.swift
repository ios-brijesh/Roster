//
//  ManageCardViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/05/22.
//

import UIKit

protocol NewAddCardDelegate {
    func reloadCard(_ address:CardModel?)
    
}
class ManageCardViewController: UIViewController {
    @IBOutlet weak var lblSavedCard : UILabel?
    @IBOutlet weak var lblTransction : UILabel?
    @IBOutlet weak var lblManagecard : UILabel?
    
    @IBOutlet weak var vwNolabelView: UIView!
    @IBOutlet weak var btnaddcard : UIButton?
    @IBOutlet weak var btnnav : UIButton?
    
    @IBOutlet weak var tblCard : UITableView?
    @IBOutlet weak var tbltransction : UITableView?
    
    @IBOutlet weak var constrainttblCardHeight: NSLayoutConstraint?
    @IBOutlet weak var constrainttbltransctionHeight: NSLayoutConstraint?
    
    // MARK: - Variables
    private var arrCard : [CardModel] = []
    private var arrTransction : [TransctionModel] = []
    var delegate : NewAddCardDelegate?
    var selectCardData : CardModel?
    var selectedIndex = 0
    private var pageNo : Int = 1
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadCardData()
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
extension ManageCardViewController {
    private func InitConfig(){
        self.lblManagecard?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblManagecard?.textColor = UIColor.CustomColor.blackColor
        
        self.lblTransction?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblTransction?.textColor = UIColor.CustomColor.textfieldTextColor
        
        self.lblSavedCard?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblSavedCard?.textColor = UIColor.CustomColor.textfieldTextColor
        
        self.btnaddcard?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnaddcard?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
        
        self.tbltransction?.register(TransactionListCell.self)
        self.tbltransction?.estimatedRowHeight = 100.0
        self.tbltransction?.rowHeight = UITableView.automaticDimension
        self.tbltransction?.delegate = self
        self.tbltransction?.dataSource = self
        
        self.tblCard?.register(MastercardCell.self)
        self.tblCard?.estimatedRowHeight = 100.0
        self.tblCard?.rowHeight = UITableView.automaticDimension
        self.tblCard?.delegate = self
        self.tblCard?.dataSource = self
        self.tblCard?.reloadData()
    }
}
//MARK: Pagination tableview Mthonthd
extension ManageCardViewController {
    
    private func reloadCardData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrCard.removeAll()
        self.tblCard?.reloadData()
        self.getCardAPI()
        self.getProductTransaction()
    }
}
//MARK: - Tableview Observer
extension ManageCardViewController {
    
    private func addTableviewOberver() {
        self.tblCard?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        self.tbltransction?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        
    }
    
    func removeTableviewObserver() {
        if self.tblCard?.observationInfo != nil {
            self.tblCard?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        if self.tbltransction?.observationInfo != nil {
            self.tbltransction?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UITableView {
            if obj == self.tblCard && keyPath == ObserverName.kcontentSize {
                self.constrainttblCardHeight?.constant = self.tblCard?.contentSize.height ?? 0.0
            }
            
        }
        
        if let obj = object as? UITableView {
            if obj == self.tbltransction && keyPath == ObserverName.kcontentSize {
                self.constrainttbltransctionHeight?.constant = self.tbltransction?.contentSize.height ?? 0.0
            }
            
        }
        
        
    }
}
//MARK:- UITableView Delegate
extension ManageCardViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tblCard {
            return self.arrCard.count
        }
        else if tableView == self.tbltransction {
            return self.arrTransction.count
        }
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tblCard {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: MastercardCell.self)
            if self.arrCard.count > 0 {
                let obj = self.arrCard[indexPath.row]
                cell.setupCardData(obj: obj)
                if selectedIndex == indexPath.item {
                    cell.vwMainView?.setCornerRadius(withBorder: 1, borderColor: UIColor.CustomColor.appColor, cornerRadius: 25)
                }
                else {
                    cell.vwMainView?.setCornerRadius(withBorder: 2, borderColor: UIColor.CustomColor.MinusBtnColor, cornerRadius: 25)
                }
                
                cell.btnREmove?.tag = indexPath.row
                cell.btnREmove.addTarget(self, action: #selector(self.btnREmoveClicked(_:)), for: .touchUpInside)
            }
            return cell
        }
        else if tableView == self.tbltransction {
            let cell = tableView.dequeueReusableCell(for: indexPath, with: TransactionListCell.self)
            cell.setTransction(obj: self.arrTransction[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedIndex = indexPath.row
        let obj = self.arrCard[selectedIndex]
        self.selectCardData = obj
        self.tblCard?.reloadData()
        self.delegate?.reloadCard(self.selectCardData)
        self.appNavigationController?.popViewController(animated: true)
        
    }
    
    @objc func btnREmoveClicked(_ sender : UIButton){
        self.showAlert(withTitle: "", with: AlertTitles.kDeleteCard, firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            if self.arrCard.count > 0 {
                self.deleteCardAPI(cardId: self.arrCard[sender.tag].id)
            }
        }, secondButton: ButtonTitle.No, secondHandler: nil)
    }
}

// MARK: - API
extension ManageCardViewController {
    private func getCardAPI(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            CardModel.getCardList(with: param, success: { (arrlist,msg) in
                self.arrCard = arrlist
                self.tblCard?.reloadData()
                self.delegate?.reloadCard(self.selectCardData)
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    private func getProductTransaction(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kpage : self.pageNo,
                klimit : ""
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            TransctionModel.getProductTransaction(with: param, success: { (arr,msg) in
                self.arrTransction = arr
                self.tbltransction?.reloadData()
                self.vwNolabelView?.isHidden = self.arrTransction.count == 0 ? false : true
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    self.vwNolabelView?.isHidden = self.arrTransction.count == 0 ? false : true
                }
                else {
                    if !error.isEmpty {
                    }
                }
            })
        }
    }
    private func deleteCardAPI(cardId : String){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kid : cardId
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            CardModel.deleteCard(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.reloadCardData()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
}

//MARK:- UITableView Delegate
extension ManageCardViewController : addCardDelegate {
    func reloadCard() {
        self.getCardAPI()
    }
}

// MARK: - IBAction
extension ManageCardViewController {
    
    
    @IBAction func btnAddCardClicked(_ sender : UIButton){
        self.appNavigationController?.present(AddCardViewController.self,configuration: { vc in
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            
        })
    }
    
    @IBAction func btnNavClicked(_ sender : UIButton) {
        //        self.appNavigationController?.popViewController(animated: true)
        if self.arrCard.count > 0 {
            let firstcard = self.arrCard[selectedIndex]
            self.delegate?.reloadCard(firstcard)
            self.appNavigationController?.popViewController(animated: true)
        } else {
            self.appNavigationController?.popViewController(animated: true)
        }
        
    }
}
// MARK: - ViewControllerDescribable
extension ManageCardViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}
// MARK: - AppNavigationControllerInteractable
extension ManageCardViewController: AppNavigationControllerInteractable { }

//
//  EventMyCartViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 18/02/22.
//

import UIKit

class EventMyCartViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tblProduct: UITableView?
    @IBOutlet weak var vwcenterview: UIView?
    @IBOutlet weak var vwDotView: UIView?
    @IBOutlet var lblInformationHeader: [UILabel]?
    @IBOutlet weak var lblFee: UILabel?
    @IBOutlet weak var lblSubtotal: UILabel?
    @IBOutlet weak var lblheader: UILabel?
    @IBOutlet weak var lblSubheader: UILabel?
    
    @IBOutlet weak var lblTotalshow: UILabel?
    @IBOutlet weak var lblTotal: UILabel?
    
    @IBOutlet weak var constrainttblProductHeight: NSLayoutConstraint?
    @IBOutlet weak var vwtermsView: UIView?
    @IBOutlet weak var btnCheckOut: AppButton?
    @IBOutlet weak var btntermfirst: UIButton?
    @IBOutlet weak var btntermSecond: UIButton?
    @IBOutlet weak var velabelview: UIView!
    
    // MARK: - Variables
    private var arrcart : [TicketdataModel] = []
    private var EventData : TicketdataModel?
    var bagTotal = Float()
    private var totalShippingCost : Float = 0.0
    
    let maxQty = 1000
    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.vwcenterview?.backgroundColor = UIColor.CustomColor.otpColor
        self.vwcenterview?.cornerRadius = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
    }
}
// MARK: - Init Configure
extension EventMyCartViewController {
    
    private func InitConfig(){
        self.btnCheckOut?.isHidden = true
        self.vwcenterview?.isHidden = true
        self.vwtermsView?.isHidden = true
        
        self.lblTotal?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblTotal?.textColor = UIColor.CustomColor.appColor
        
        self.lblTotalshow?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblTotalshow?.textColor = UIColor.CustomColor.ProductListColor
        
        self.lblFee?.text = "service charge"
        [self.lblFee,self.lblSubtotal ].forEach({
            $0?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
            $0?.textColor = UIColor.CustomColor.ProductPrizeColor
            
        })
        
        [self.lblheader,self.lblSubheader ].forEach({
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 11.0))
            $0?.textColor = UIColor.CustomColor.blackColor
            
        })
        self.lblInformationHeader?.forEach({
            $0.textColor = UIColor.CustomColor.ProductListColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.vwDotView?.createDashedLine(width: 1, color: UIColor.CustomColor.borderColor.cgColor)
        self.tblProduct?.register(ProductCartCell.self)
        self.tblProduct?.estimatedRowHeight = 90
        self.tblProduct?.rowHeight = UITableView.automaticDimension
        self.tblProduct?.cornerRadius = 20
        self.tblProduct?.separatorStyle = .none
        self.tblProduct?.delegate = self
        self.tblProduct?.dataSource = self
        self.getCartView()
        
    }
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        appNavigationController?.setNavigationBackTitleRightBackBtnNavigationBar(title: "My Cart", TitleColor: UIColor.CustomColor.textfieldTextColor, rightBtntitle: "Clear Cart", rightBtnColor: UIColor.CustomColor.appColor, navigationItem: self.navigationItem)
        appNavigationController?.btnNextClickBlock = {
            self.showAlert(withTitle: "", with: AlertTitles.kRemoveCart, firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
                self.RemoveEventCart(cartId: "",clearAll: "1")
            }, secondButton: ButtonTitle.No, secondHandler: nil)
        }
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}
//MARK: - Tableview Observer
extension EventMyCartViewController {
    private func addTableviewOberver() {
        self.tblProduct?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    func removeTableviewObserver() {
        if self.tblProduct?.observationInfo != nil {
            self.tblProduct?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblProduct && keyPath == ObserverName.kcontentSize {
                self.constrainttblProductHeight?.constant = self.tblProduct?.contentSize.height ?? 0.0
            }
            
        }
    }
}
//MARK:- UITableView Delegate
extension EventMyCartViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrcart.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ProductCartCell.self)
        if self.arrcart.count > 0 {
            cell.setEventcartData(obj: self.arrcart[indexPath.row])
            
            cell.btnRemove?.tag = indexPath.row
            cell.btnRemove?.addTarget(self, action: #selector(self.btnRemoveClicked(_:)), for: .touchUpInside)
            
            cell.btnPlus?.tag = indexPath.row
            cell.btnPlus?.addTarget(self, action: #selector(self.btnPlusClicked(_:)), for: .touchUpInside)
            
            cell.btnMinus?.tag = indexPath.row
            cell.btnMinus?.addTarget(self, action: #selector(self.btnMinusClicked(_:)), for: .touchUpInside)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == self.tblProduct {
            let item = UIContextualAction(style: .normal, title: "") {  (contextualAction, view, boolValue) in
                //Write your code in here
                self.showAlert(withTitle: "", with: AlertTitles.kRemoveCart, firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
                    if self.arrcart.count > 0 {
                        self.RemoveEventCart(cartId: self.arrcart[indexPath.row].id,clearAll: "")
                    }
                }, secondButton: ButtonTitle.No, secondHandler: nil)
            }
            item.image = UIImage(named: "Ic_delete")
            item.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
            let swipeActions = UISwipeActionsConfiguration(actions: [item])
            swipeActions.performsFirstActionWithFullSwipe = false
            return swipeActions
        }
        return nil
    }
    @objc func btnRemoveClicked(_ sender : UIButton){
        self.showAlert(withTitle: "", with: AlertTitles.kRemoveCart, firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            if self.arrcart.count > 0 {
                self.RemoveEventCart(cartId: self.arrcart[sender.tag].id,clearAll: "")
            }
        }, secondButton: ButtonTitle.No, secondHandler: nil)
    }
    @objc func btnPlusClicked(_ sender: UIButton) {
        let index = sender.tag
        if arrcart.indices ~= index {
            let c_Info = arrcart[index]
            var qty = Int(c_Info.qty)!
            let cell:ProductCartCell = tblProduct?.cellForRow(at: IndexPath.init(row: index, section: 0)) as! ProductCartCell
            if qty < maxQty {
                qty += 1
                self.addEventCart("\(qty)", cart: c_Info)
            }
            else {
                return
            }
        }
    }
    @objc func btnMinusClicked(_ sender: UIButton) {
        let index = sender.tag
        if arrcart.indices ~= index {
            let c_Info = arrcart[index]
            var qty = Int(c_Info.qty)!
            let cell:ProductCartCell = tblProduct?.cellForRow(at: IndexPath.init(row: index, section: 0)) as! ProductCartCell
            
            if qty >= 1 {
                qty -= 1
                self.addEventCart("\(qty)", cart: c_Info)
            }
            else {
                
                return
            }
        }
    }
    //    func amountCalculation() {
    //        var tempTotal : Float = 0.0
    //        for item in 0..<arrcart.count {
    //            let qty = Float(self.arrcart[item].qty) ?? 1
    //            let price = Float(self.arrcart[item].price) ?? 0.0
    //            tempTotal += (qty * price)
    //        }
    //
    //        self.lblSubtotal?.text = "$\(String(format:"%.2f", tempTotal))"
    //        self.lblTotal?.text = "$\(String(format:"%.2f", (tempTotal + self.totalShippingCost)))"
    //        self.bagTotal = tempTotal + self.totalShippingCost
    //    }
}
//MARK: - Validation
extension EventMyCartViewController {
    private func validateFields() -> String? {
        
        if !(self.btntermfirst?.isSelected ?? true) {
            return AppConstant.ValidationMessages.kacceptTerms
            
        } else if !(self.btntermSecond?.isSelected ?? true) {
            return AppConstant.ValidationMessages.kacceptTerms
        } else {
            return nil
        }
    }
}
//MARK: - IBAction Method
extension EventMyCartViewController {
    
    @IBAction func btnCheckOutClick() {
        self.view.endEditing(true)
        self.appNavigationController?.push(CheckOutViewController.self, configuration: { vc in
            vc.isFromEventcart = true
            Rosterd.sharedInstance.TicketId = self.EventData?.ticketId ?? ""
            vc.isFromEventCartOrder = true
        })
        
    }
    @IBAction func btntermacceptfirstClick() {
        self.btntermfirst?.isSelected = !(self.btntermfirst?.isSelected ?? false)
        
    }
    @IBAction func btntermAcceptSecondClick() {
        self.btntermSecond?.isSelected = !(self.btntermSecond?.isSelected ?? false)
        
    }
}
extension EventMyCartViewController {
        private func getCartView(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault(){
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            TicketdataModel.EventcartView(with: param, isShowLoader: isshowloader,  success: { (fee,subTotal,total_amount,arr,totalpage,msg) in
                self.arrcart = arr
                self.tblProduct?.reloadData()
                self.totalShippingCost = Float(fee) ?? 0.0
                print(self.totalShippingCost)
                self.lblFee?.text = "$\(fee)"
                self.lblSubtotal?.text = "$\(subTotal)"
                self.lblTotal?.text = "$\(total_amount)"
                self.velabelview?.isHidden = true
                self.btnCheckOut?.isHidden = false
                self.vwcenterview?.isHidden = false
                self.vwtermsView?.isHidden = false
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.velabelview?.isHidden = false
                    self.btnCheckOut?.isHidden = true
                    self.vwcenterview?.isHidden = true
                    self.vwtermsView?.isHidden = true
                    appNavigationController?.setNavigationBackTitleRightBackBtnNavigationBar(title: "My Cart", TitleColor: UIColor.CustomColor.textfieldTextColor, rightBtntitle: "", rightBtnColor: UIColor.CustomColor.appColor, navigationItem: self.navigationItem)
                    self.lblTotal?.text = "$00.00"
                    self.lblFee?.text = "$00.00"
                    self.lblSubtotal?.text = "$00.00"
                    
                }
            })
        }
    }
    
    private func RemoveEventCart(cartId : String,clearAll : String){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kid : cartId,
                kclearAll : clearAll
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            TicketdataModel.EventremoveCart(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.arrcart.removeAll()
                self.tblProduct?.reloadData()
                self.getCartView()
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    private func addEventCart(_ cartQty:String,cart:TicketdataModel) {
        
        if let user = UserModel.getCurrentUserFromDefault(){
            var arr : [[String:Any]] = []
            for i in stride(from: 0, to: 1, by: 1){
                let obj = self.arrcart[i]
                
                let dicTicket : [String:Any] = [
                    kid :  "",
                    kqty : "",
                    kprice : ""
                ]
                arr.append(dicTicket)
            }
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                keventId : cart.eventId,
                kqty : cartQty,
                kticketData : arr,
                kid : cart.id
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            EventModel.addEventCart(with: param, success: { (totalAmount,msg) in
                self.lblTotal?.text = "$\(totalAmount)"
                self.getCartView()
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension EventMyCartViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}
// MARK: - AppNavigationControllerInteractable
extension EventMyCartViewController: AppNavigationControllerInteractable { }

//
//  MyCartViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 28/01/22.
//

import UIKit

protocol MyCartDelegate {
    func updateCartData()
}

class MyCartViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tblProduct: UITableView?
    
    @IBOutlet weak var vwcenterview: UIView?
    @IBOutlet weak var vwDotView: UIView!
    
    @IBOutlet var lblInformationHeader: [UILabel]?
    @IBOutlet weak var lblShipingCost: UILabel?
    @IBOutlet weak var lblSubtotal: UILabel?
    
    @IBOutlet weak var lblShowTotal: UILabel!
    @IBOutlet weak var lblTotal: UILabel?
    
    @IBOutlet weak var constrainttblProductHeight: NSLayoutConstraint?
    
    
    @IBOutlet weak var btnCheckOut: AppButton?
    
    @IBOutlet weak var vwlabelview: UIView!
    
    // MARK: - Variables
    private var arrcart : [CartModel] = []
    private var prizedata : CartModel?
    
    private var totalShippingCost : Float = 0.0
    var delegate : MyCartDelegate?
    var bagTotal = Float()
    let maxQty = 1000
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.vwcenterview?.backgroundColor = UIColor.CustomColor.otpColor
        self.vwcenterview?.cornerRadius = 25
        
    
    }
}


// MARK: - Init Configure
extension MyCartViewController {
    private func InitConfig() {
        
        self.vwcenterview?.isHidden = true
        self.btnCheckOut?.isHidden = true
        
        
        self.lblTotal?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblTotal?.textColor = UIColor.CustomColor.appColor
        
        self.lblShowTotal?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblShowTotal?.textColor = UIColor.CustomColor.ProductListColor
        
        [self.lblShipingCost,self.lblSubtotal ].forEach({
            $0?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
            $0?.textColor = UIColor.CustomColor.ProductPrizeColor
            
        })
        
        self.lblInformationHeader?.forEach({
            $0.textColor = UIColor.CustomColor.ProductListColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.vwDotView?.createDashedLine(width: 1
                                         , color: UIColor.CustomColor.borderColor.cgColor)
        
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
            self.RemoveProductCart(cartId: "",clearAll: "1")
        }, secondButton: ButtonTitle.No, secondHandler: nil)
    
        }
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

//MARK: - Tableview Observer
extension MyCartViewController {
    
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
extension MyCartViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrcart.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ProductCartCell.self)
        if self.arrcart.count > 0 {
            cell.setcartData(obj: self.arrcart[indexPath.row])
            
         
            
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
                        self.RemoveProductCart(cartId: self.arrcart[indexPath.row].id,clearAll: "")
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
  
    
    @objc func btnPlusClicked(_ sender: UIButton) {
        let index = sender.tag
        if arrcart.indices ~= index {
            let c_Info = arrcart[index]
            var qty = Int(c_Info.qty)!
            let cell:ProductCartCell = tblProduct?.cellForRow(at: IndexPath.init(row: index, section: 0)) as! ProductCartCell
          
            if qty < maxQty {
                qty += 1
                self.addProductCart("\(qty)", cart: c_Info)
            }
            else {
                
                return
            }
           
        }


    }
    @objc func btnMinusClicked(_ sender: UIButton) {
        let obj = self.arrcart[sender.tag]
        let index = sender.tag
        if arrcart.indices ~= index {
            let c_Info = arrcart[index]
            var qty = Int(c_Info.qty)!
            let cell:ProductCartCell = tblProduct?.cellForRow(at: IndexPath.init(row: index, section: 0)) as! ProductCartCell
           
            if qty >= 1 {
                qty -= 1
                self.addProductCart("\(qty)", cart: c_Info)
            }
            else {
                self.showAlert(withTitle: "", with: AlertTitles.kRemoveCart, firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
                                   self.RemoveProductCart(cartId: obj.id,clearAll: "")
               
                               }, secondButton: ButtonTitle.No, secondHandler: nil)
               
            }
        }

       
    }
    
}

extension MyCartViewController {
    
    
    private func getCartView(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault(){
      
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
          
          
   
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       CartModel.GetcartView(with: param, isShowLoader: isshowloader,  success: { (subTotal,shipingCost,total_amount,shippingAddress,arr,totalpage,msg) in
           self.arrcart = arr
           self.tblProduct?.reloadData()
           self.vwcenterview?.isHidden = false
           self.btnCheckOut?.isHidden = false
           self.lblTotal?.text = "$\(total_amount)"
           self.lblShipingCost?.text = "$\(shipingCost)"
           self.lblSubtotal?.text = "$\(subTotal)"
           self.vwlabelview?.isHidden = true
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               if !error.isEmpty {
                   self.vwcenterview?.isHidden = true
                   self.vwlabelview?.isHidden = false
                   self.btnCheckOut?.isHidden = true
                   appNavigationController?.setNavigationBackTitleRightBackBtnNavigationBar(title: "My Cart", TitleColor: UIColor.CustomColor.textfieldTextColor, rightBtntitle: "", rightBtnColor: UIColor.CustomColor.appColor, navigationItem: self.navigationItem)
                   self.lblTotal?.text = "$00.00"
                   self.lblShipingCost?.text = "$00.00"
                   self.lblSubtotal?.text = "$00.00"

               }
           })
       }
   }
    
    private func RemoveProductCart(cartId : String,clearAll : String){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kcartEntryid : cartId,
                kclearAll : clearAll
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            CartModel.RemoveProductCart(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.arrcart.removeAll()
                self.getCartView()
                self.tblProduct?.reloadData()
              
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                   
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func addProductCart(_ cartQty:String,cart:CartModel){
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kid : cart.id,
                kvariationId : cart.variationId,
                kqty : cartQty

            ]

            let param : [String:Any] = [
                kData : dict
            ]

            productModel.addProductCart(with: param, success: { (total_amount,subTotal,shipingCost,msg) in
                self.lblTotal?.text = "$\(total_amount)"
                self.lblShipingCost?.text = "$\(shipingCost)"
                self.lblSubtotal?.text = "$\(subTotal)"
                self.getCartView()
                

            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
    private func setproductPrize() {
        if let obj = self.prizedata {
            
            
            self.lblSubtotal?.text = obj.cartProductAmount
       
    
        }
    }
}
//MARK: - IBAction Method
extension MyCartViewController {
    
    @IBAction func btnCheckOutClick() {
        self.appNavigationController?.push(CheckOutViewController.self, configuration: { vc in
            vc.isFromEventcart = false
        })
    }

}


// MARK: - ViewControllerDescribable
extension MyCartViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
return UIStoryboard.Name.Shop
}
}

// MARK: - AppNavigationControllerInteractable
extension MyCartViewController: AppNavigationControllerInteractable { }



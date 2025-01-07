//
//  OrderDetailViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 26/07/22.
//

import UIKit

class OrderDetailViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblordersummary: UILabel!
    @IBOutlet weak var lblorderdeatil: UILabel!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lbldiscount: UILabel!
    @IBOutlet weak var lblservicecharge: UILabel!
    @IBOutlet weak var lbltotal: UILabel!
    @IBOutlet weak var lblordernumber: UILabel!
    @IBOutlet weak var lblpaymentmethod: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblphonenumber: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    
    @IBOutlet weak var lblsubtotalprize: UILabel!
    @IBOutlet weak var lbldiscountprize: UILabel!
    @IBOutlet weak var lblseviceprize: UILabel!
    @IBOutlet weak var lbltotalprize: UILabel!
    @IBOutlet weak var lblshowordernumber: UILabel!
    @IBOutlet weak var lblpaymenttype: UILabel!
    @IBOutlet weak var lblShowdat: UILabel!
    @IBOutlet weak var lblShowphonenu: UILabel!
    @IBOutlet weak var lblShowAdress: UILabel!
    
    @IBOutlet weak var vwamountview: UIView!
    @IBOutlet weak var vwseprateviewse: UIView!
    @IBOutlet weak var vwseprateview: UIView!
    @IBOutlet weak var tblorderdetail: UITableView!
    
    @IBOutlet weak var btnCancelorder: UIButton!
    
    
    @IBOutlet weak var constrainttblorderdetailHeight: NSLayoutConstraint?
    // MARK: - Variables
    var ProductData : String = ""
//    var ProductData : ProductOrderModel?
    private var arrOrderDeta : [CartModel] = []
    private var orderData : OrderDetailModel?
    var isFromCancel : Bool = false
    private var pageNo : Int = 1
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.reloadProductData()
        self.addTableviewOberver()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
      
      
        
       
        
    
    }
}


// MARK: - Init Configure
extension OrderDetailViewController {
    private func InitConfig() {
        
        self.vwseprateview?.backgroundColor = UIColor.CustomColor.borderColor7
        self.vwseprateviewse?.backgroundColor = UIColor.CustomColor.borderColor7
        
        
        [self.lblorderdeatil,self.lblordersummary].forEach({
            $0?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 11.0))
            $0?.textColor = UIColor.CustomColor.labelordercolor
            
        })
        
        [self.lblsubtotal,self.lbldiscount,self.lblservicecharge,self.lblordernumber,self.lblpaymentmethod,self.lblDate,self.lblphonenumber,self.lbladdress,self.lblsubtotalprize,self.lbldiscountprize,self.lblseviceprize,self.lblshowordernumber,self.lblpaymenttype,self.lblShowdat,self.lblShowphonenu,self.lblShowAdress].forEach({
            $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 11.0))
            $0?.textColor = UIColor.CustomColor.labelordercolor
            
        })
        
        self.lbltotal?.textColor = UIColor.CustomColor.blackColor
        self.lbltotal?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 11.0))
        
        
        self.lbltotalprize?.textColor = UIColor.CustomColor.blackColor
        self.lbltotalprize?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 17.0))
     
        
        self.btnCancelorder?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
        self.btnCancelorder?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        
        self.vwamountview?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        self.vwamountview?.cornerRadius = 15.0
        
        self.tblorderdetail?.register(OrderDetailCell.self)
        self.tblorderdetail?.estimatedRowHeight = 90
        self.tblorderdetail?.rowHeight = UITableView.automaticDimension
        self.tblorderdetail?.cornerRadius = 20
        self.tblorderdetail?.separatorStyle = .none
        self.tblorderdetail?.delegate = self
        self.tblorderdetail?.dataSource = self
        
       
        
        
    }
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "   RD231238231", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}

//MARK: Pagination tableview Mthonthd
extension OrderDetailViewController {
    
    private func reloadProductData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrOrderDeta.removeAll()
        self.tblorderdetail?.reloadData()
        self.getOrderDetail()
    }


}
//MARK: - Tableview Observer
extension OrderDetailViewController {
    
    private func addTableviewOberver() {
        self.tblorderdetail?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableviewObserver() {
        if self.tblorderdetail?.observationInfo != nil {
            self.tblorderdetail?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
   
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            
            if let obj = object as? UITableView {
                if obj == self.tblorderdetail && keyPath == ObserverName.kcontentSize {
                    self.constrainttblorderdetailHeight?.constant = self.tblorderdetail?.contentSize.height ?? 0.0
                }
                
            }
        }
    
    
}

//MARK:- UITableView Delegate
extension OrderDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOrderDeta.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: OrderDetailCell.self)
        cell.SetOrderData(obj: self.arrOrderDeta[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}




// MARK: - API Call
extension OrderDetailViewController {
    
    
    private func getOrderDetail(isshowloader :Bool = true) {
        
        
     
        if let user = UserModel.getCurrentUserFromDefault(){
          
           let dict : [String:Any] = [
               klangType : Rosterd.sharedInstance.languageType,
               ktoken : user.token,
               kid : self.ProductData
             
              
       
           ]
           
           let param : [String:Any] = [
               kData : dict
           ]

            OrderDetailModel.getOrderDetail(with: param, isShowLoader: isshowloader,  success: { (orderdetail,subTotal,searviceCharge,total,totalRecords,arr,totalPages,msg) in
                   self.arrOrderDeta.append(contentsOf: orderdetail)
                   self.tblorderdetail?.reloadData()
                   self.orderData = arr
                   self.setproductdeailData()
                self.lblsubtotalprize?.text = "$\(subTotal)"
                self.lblseviceprize?.text = "$\(searviceCharge)"
                self.lbltotalprize?.text = "$\(total)"
                
                if self.orderData?.order_status == "4" {
                    self.btnCancelorder?.isHidden = true
                } else if self.orderData?.order_status == "3" {
                    self.btnCancelorder?.isHidden = true
                } else {
                    self.btnCancelorder?.isHidden = false
                }
                 
               }, failure: {[unowned self] (statuscode,error, errorType) in
                   print(error)
                   if statuscode == APIStatusCode.NoRecord.rawValue {
                   
                   } else {
                       if !error.isEmpty {
                           self.showMessage(error, themeStyle: .error)
                           
                       }
                   }
               })
           }
   
      
        
    
    }
    
    private func setproductdeailData() {
        if let obj = self.orderData {
            
            self.lblshowordernumber?.text = "RD\(obj.id)"
            self.lblShowdat?.text = obj.createdDate
            self.lblShowphonenu?.text = obj.shippingPhone
            self.lbldiscountprize?.text = "$\(obj.offerDiscountAmount)"
            let shippingHouseNumber = obj.shippingHouseNumber
            let shippingAddress = obj.shippingAddress
            let shippingLandMark = obj.shippingLandMark
            let shippingZipcode = obj.shippingZipcode
            let shippingCity = obj.shippingCity
            
            let address = shippingHouseNumber + "," + shippingAddress + "," + shippingLandMark + " " + shippingZipcode + "," + shippingCity
            self.lblShowAdress?.text = address

        }
    }
//
}


//MARK: - IBAction Method
extension OrderDetailViewController {
    
    @IBAction func btnCancelOrderClick(_ sender : UIButton){
       
                self.appNavigationController?.detachRightSideMenu()
                self.appNavigationController?.present(FeedReportPopupViewController.self,configuration: { (vc) in
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.selecdtedOrder = self.orderData
                    vc.isFromOrder = true
                })
        
        
    
     }
}

// MARK: - ViewControllerDescribable
extension OrderDetailViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
           return UIStoryboard.Name.Shop
    }
}

// MARK: - AppNavigationControllerInteractable
extension OrderDetailViewController: AppNavigationControllerInteractable{}

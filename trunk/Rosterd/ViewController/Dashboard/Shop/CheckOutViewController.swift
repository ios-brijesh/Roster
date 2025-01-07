//
//  CheckOutViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 29/01/22.
//

import UIKit

class CheckOutViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tblCard: UITableView?
    @IBOutlet weak var constrainttblCardHeight: NSLayoutConstraint?
    @IBOutlet var lblHeader: [UILabel]?
   
    @IBOutlet weak var lblMyhome: UILabel?
    @IBOutlet weak var lblAdress: UILabel?
    @IBOutlet var lblInformationHeader: [UILabel]?
    @IBOutlet weak var lblShipingCost: UILabel?
    @IBOutlet weak var lblSubtotal: UILabel?
    @IBOutlet weak var lblphonenumber: UILabel?
    
    
    @IBOutlet weak var vwentercode: UIView?
    @IBOutlet weak var vwDashedview: UIView?
    @IBOutlet weak var vwPriceview: UIView?
    @IBOutlet weak var vwAdressView: UIView!
    
    @IBOutlet weak var lblTotalPrice: UILabel?
    @IBOutlet weak var lblTotal: UILabel?
    
    
    @IBOutlet weak var btnEnterCode: UIButton?
    @IBOutlet weak var btnPlaceOrder: AppButton?
    @IBOutlet weak var btnChange:UIButton?
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var MapView: GMSMapView!
    @IBOutlet weak var btnapply: UIButton?
    
    @IBOutlet weak var CodeText: UITextField?
    @IBOutlet weak var vwEnterCodeView: UIView!
    @IBOutlet weak var vwMainView: UIView?
    @IBOutlet weak var lblMasterCard: UILabel?
    @IBOutlet weak var lblCardNumber:UILabel?
    @IBOutlet weak var imgCard: UIImageView?
    @IBOutlet weak var btnREmove: UIButton?
    @IBOutlet weak var vwREmoveview: UIView?
    @IBOutlet weak var vecardview: UIView?
    @IBOutlet weak var vwAddpayment: UIView?
    // MARK: - Variables
    private var arrCard : [CardModel] = []
    private var AdressData : AdresssModel?
    private var cardData : CardModel?
    var isFromEventcart : Bool = false
    var isFromEventCartOrder : Bool = false
    private var selectedLatitude : Double = 0.0
    private var selectedLongitude : Double = 0.0
    var selectedCard:CardModel?
    var coupencode = ""
    
//MARK: - Life Cycle Methods
override func viewDidLoad() {
    super.viewDidLoad()
    self.InitConfig()
    if self.isFromEventcart {
        self.getEventcartApi()
    } else {
        self.getProductCheckoutDetails()
    }
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
    
    self.vwPriceview?.backgroundColor = UIColor.CustomColor.otpColor
    self.vwPriceview?.cornerRadius = 25
    
    if let MapView = self.MapView {
        MapView.cornerRadius = MapView.frame.height / 2
    }

}
}


    // MARK: - Init Configure
    extension CheckOutViewController {
      private func InitConfig() {
          
          self.CodeText?.delegate = self
          self.CodeText?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
          
          self.btnCancel?.isHidden = true
          self.vwMainView?.borderColor = UIColor.CustomColor.MinusBtnColor
          self.vwMainView?.borderWidth = 2
          self.vwMainView?.cornerRadius = 25
          
          
          self.lblMasterCard?.textColor = UIColor.CustomColor.ProductPrizeColor
          self.lblMasterCard?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 16.0))
          
          
          self.lblCardNumber?.textColor = UIColor.CustomColor.ProductListColor
          self.lblCardNumber?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
          
          
          self.btnapply?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
          self.btnapply?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
          
          self.btnCancel?.setTitleColor(UIColor.CustomColor.blackColor, for: .normal)
          self.btnCancel?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
          
          self.btnREmove?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
          self.btnREmove?.titleLabel?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
          self.btnREmove?.setTitle("Remove", for: .normal)
          
          self.btnChange?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
          self.btnChange?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
          
          self.lblTotalPrice?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 20.0))
          self.lblTotalPrice?.textColor = UIColor.CustomColor.appColor
          
          self.lblMyhome?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 18.0))
          self.lblMyhome?.textColor = UIColor.CustomColor.ProductPrizeColor
          
          self.lblAdress?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
          self.lblAdress?.textColor = UIColor.CustomColor.ProductListColor
          
          self.lblTotal?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
          self.lblTotal?.textColor = UIColor.CustomColor.ProductListColor
          
          self.lblphonenumber?.textColor = UIColor.CustomColor.addressLabelTextColor
          self.lblphonenumber?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
          
          
         
          
          self.lblInformationHeader?.forEach({
              $0.textColor = UIColor.CustomColor.ProductListColor
              $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
          })
          
          self.lblHeader?.forEach({
              $0.textColor = UIColor.CustomColor.TextColor
              $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
          })
         
         
          
          [self.lblShipingCost,self.lblSubtotal ].forEach({
              $0?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
              $0?.textColor = UIColor.CustomColor.labelTextColor
              
          })
          
          self.vwEnterCodeView?.isHidden = true
          self.vecardview?.isHidden = true
          self.vwAdressView?.isHidden = true 
          
          self.vwDashedview?.createDashedLine(width: 1
                                           , color: UIColor.CustomColor.borderColor.cgColor)
          
          self.tblCard?.register(MastercardCell.self)
          self.tblCard?.estimatedRowHeight = 120
          self.tblCard?.rowHeight = UITableView.automaticDimension
          self.tblCard?.cornerRadius = 20
          self.tblCard?.separatorStyle = .none
          self.tblCard?.delegate = self
          self.tblCard?.dataSource = self

    
     }

      private func configureNavigationBar() {
    
          appNavigationController?.setNavigationBarHidden(true, animated: true)
          appNavigationController?.navigationBar.backgroundColor = UIColor.clear
          self.navigationController?.setNavigationBarHidden(false, animated: false)
          
          appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Checkout", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
          
          navigationController?.navigationBar
              .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
          navigationController?.navigationBar.removeShadowLine()
     }
   }



//MARK: - Tableview Observer
extension CheckOutViewController {
    
    private func addTableviewOberver() {
        self.tblCard?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableviewObserver() {
        if self.tblCard?.observationInfo != nil {
            self.tblCard?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
   
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            
            if let obj = object as? UITableView {
                if obj == self.tblCard && keyPath == ObserverName.kcontentSize {
                    self.constrainttblCardHeight?.constant = self.tblCard?.contentSize.height ?? 0.0
                }
                
            }
        }
    
    
}

//MARK:- UITableView Delegate
extension CheckOutViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCard.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: MastercardCell.self)
        if self.arrCard.count > 0 {
            cell.setupCardData(obj: self.arrCard[indexPath.row])
            
            cell.btnREmove?.tag = indexPath.row
            cell.btnREmove.addTarget(self, action: #selector(self.btnREmoveClicked(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    @objc func btnREmoveClicked(_ sender : UIButton){
        self.showAlert(withTitle: "", with: AlertTitles.kDeleteCard, firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
            if self.arrCard.count > 0 {
                self.deleteCardAPI()
            }
        }, secondButton: ButtonTitle.No, secondHandler: nil)
    }
//
//
   
 
}


//MARK:- UITableView Delegate
extension CheckOutViewController : AddadressDelegate {
    func reloadadress(_ address:AdresssModel?) {
        AdressData = address
        if let cardData = AdressData,cardData.id != "" {
            self.vwAdressView?.isHidden = false
            self.AdressData = address
            self.setadressdata()
        } else {
            self.vwAdressView?.isHidden = true
        }
//        self.setadressdata()
        
    }
}

//MARK:- UITableView Delegate
extension CheckOutViewController : NewAddCardDelegate {
    func reloadCard(_ card:CardModel?) {
        cardData = card
//        self.setCardData()
//        self.vecardview?.isHidden = false
        
        if let cardData = cardData,cardData.id != "" {
            self.vecardview?.isHidden = false
            self.vwAddpayment?.isHidden = true
            self.cardData = card
            self.setCardData()
        } else {
            self.vecardview?.isHidden = true
            self.vwAddpayment?.isHidden = false
        }
    }
}
// MARK: - API
extension CheckOutViewController {
  
    
    private func deleteCardAPI(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kid : cardData?.id ?? ""
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            CardModel.deleteCard(with: param, success: { (msg) in
                self.showMessage(msg, themeStyle: .success)
                self.vecardview?.isHidden = true
                self.vwAddpayment?.isHidden = false
                if self.isFromEventcart {
                    self.getEventcartApi()
                } else {
                    self.getProductCheckoutDetails()
                }
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    
    private func ChechOutOrder(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kcardId : cardData?.id ?? "",
                kisFlag  : (self.isFromEventCartOrder) ?  "1" : "0",
                kaddressId : AdressData?.id ?? "",
                kofferId : self.coupencode
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            CardModel.CheckoutOrder(with: param, success: { (ticketId,eventId,msg) in
              
                self.appNavigationController?.push(OrderSuccessfullyViewController.self,configuration: { vc in
                     vc.isFromEvent = self.isFromEventcart
                     vc.Ticketid = eventId
                 })
            
            
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func ApplyOfferCoupon(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            var myString = self.lblTotalPrice?.text ?? ""
            myString.remove(at: myString.startIndex)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kcouponCode : self.CodeText?.text ?? "",
                ktotalAmount : myString
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            CardModel.applyOfferCoupon(with: param, success: { (offerId,discountAmount,total_amount) in
                self.coupencode = offerId
    
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                }
            })
        }
    }
    
    private func getEventcartApi() {
        
        if let user = UserModel.getCurrentUserFromDefault() {
        let dict : [String:Any] = [
            ktoken : user.token,
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        CartModel.getEventCheckoutDetails(with: param, success: { (subTotal,fee,totalAmount,arraddress,cardModel,totalPages,message) in
            self.lblTotalPrice?.text = "$\(totalAmount)"
            self.lblShipingCost?.text = "$\(fee)"
            self.lblSubtotal?.text = "$\(subTotal)"
            if let adressData = arraddress,adressData.id != "" {
                self.vwAdressView?.isHidden = false
                self.AdressData = arraddress
                self.setadressdata()
            }
            else {
                self.vwAdressView?.isHidden = true
            }
        
            if let cardData = cardModel,cardData.id != "" {
                self.vecardview?.isHidden = false
                self.vwAddpayment?.isHidden = true
                self.cardData = cardData
                self.setCardData()
            }
            else {
                self.vecardview?.isHidden = true
                self.vwAddpayment?.isHidden = false
            }
        }, failure: {[unowned self] (statuscode,error, errorType) in
            if !error.isEmpty {
            }
        })
     }
    
        
    }
  
    private func getProductCheckoutDetails() {
        
        if let user = UserModel.getCurrentUserFromDefault() {
        let dict : [String:Any] = [
            ktoken : user.token,
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        CartModel.getProductCheckoutDetails(with: param, success: { (subTotal,shipingCost,total_amount,arraddress,cardModel,totalPages,message) in
            
            self.lblTotalPrice?.text = "$\(total_amount)"
            self.lblShipingCost?.text = "$\(shipingCost)"
            self.lblSubtotal?.text = "$\(subTotal)"
            
            if let adressData = arraddress,adressData.id != "" {
                self.vwAdressView?.isHidden = false
                self.AdressData = arraddress
                self.setadressdata()
            }
            else {
                self.vwAdressView?.isHidden = true
            }
            
            if let cardData = cardModel,cardData.id != "" {
                self.vecardview?.isHidden = false
                self.vwAddpayment?.isHidden = true
                self.cardData = cardData
                self.setCardData()
            }
            else {
                self.vecardview?.isHidden = true
                self.vwAddpayment?.isHidden = false
            }
        }, failure: {[unowned self] (statuscode,error, errorType) in
            if !error.isEmpty {
//                self.showMessage(error, themeStyle: .error)
            }
        })
     }
    }
    
    private func setadressdata() {
        if let obj = self.AdressData {
            
            let houseNumber = "House No :\(obj.houseNumber)"
            let address = obj.address
            let landMark = obj.landMark
            let city = obj.city
           
            
            let FullAdress = houseNumber + ", " + address + ", " + landMark + ", " + city
            
            
            self.lblAdress?.text = FullAdress
            self.lblphonenumber?.text = "Phone No.\(obj.phonenumber)"
            
            let selecetdLatitude : Double = Double(obj.latitude) ?? 0
            let selecetdLongitude : Double = Double(obj.longitude) ?? 0
            if obj.latitude != "" && obj.longitude != "" {
                self.MapView?.isHidden = false
                delay(seconds: 0.2) {
                    
                    let coordinate = CLLocationCoordinate2D(latitude: selecetdLatitude, longitude: selecetdLongitude)
                    self.MapView.camera = GMSCameraPosition.camera(withLatitude:coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
                    let marker: GMSMarker = GMSMarker()
                    marker.icon = #imageLiteral(resourceName: "ic_Location")
                    marker.position = coordinate
                    marker.map = self.MapView
                }
            } else {
                self.MapView?.isHidden = true
            }
          
        }
    }
    
    private func setCardData() {
        if let obj = self.cardData {
             
            self.lblMasterCard?.text = obj.cardHolder
            self.lblCardNumber?.text = "**** **** **** \(obj.cardNumber)"
            let cardtye = CardAPIType.init(rawValue: obj.type) ?? .None
            self.imgCard?.image = cardtye.image
            
        }
    }
    
    
}


//MARK :- UITextFieldDelegate
extension CheckOutViewController : UITextFieldDelegate {
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        self.btnCancel?.isHidden = (textField.text?.count ?? 0) > 0 ? false : true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.btnCancel?.isHidden = (textField.text?.count ?? 0) > 0 ? false : true
        return true
    }
}
//MARK: - IBAction Method
extension CheckOutViewController {
    
    @IBAction func btnPlaceOrderClick(_ sender: AppButton) {
        self.ChechOutOrder()

       
    }
    
    @IBAction func btnApplyClick(_ sender: UIButton) {
        self.ApplyOfferCoupon()
        
    }
    
    @IBAction func btnCamcelClick() {
        
        self.vwEnterCodeView?.isHidden = true
        self.vwentercode?.isHidden = false
    }
    
    @IBAction func btnEnterCodeCLick() {
        
        self.vwentercode?.isHidden = true
        self.vwEnterCodeView?.isHidden = false
    }
    
 
    @IBAction func btnAddCartClick() {
        self.appNavigationController?.push(ManageCardViewController.self,configuration: { vc in
            vc.delegate = self
        })
        
    }
    
    @IBAction func btnChangeAddClick() {
        self.appNavigationController?.push(ManageAddressViewController.self,configuration: { vc in
            vc.delegate = self
        })
    }
    
    
    
    @IBAction func btnRemoveClick(_ sender : UIButton) {
        
        self.vecardview?.isHidden = true
        self.vwAddpayment?.isHidden = false
//        self.showAlert(withTitle: "", with: AlertTitles.kDeleteCard, firstButton: ButtonTitle.Yes, firstHandler: { (alert) in
//
//                self.deleteCardAPI()
//
//        }, secondButton: ButtonTitle.No, secondHandler: nil)
    }

}


 // MARK: - ViewControllerDescribable
 extension CheckOutViewController: ViewControllerDescribable {
   static var storyboardName: StoryboardNameDescribable {
      return UIStoryboard.Name.Shop
   }
 }

// MARK: - AppNavigationControllerInteractable
extension CheckOutViewController: AppNavigationControllerInteractable { }

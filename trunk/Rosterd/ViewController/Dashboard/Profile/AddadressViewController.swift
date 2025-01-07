//
//  AddadressViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 16/05/22.
//

import UIKit


protocol addAdresssDelegate {
    func reloadadress()
}

class AddadressViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var lblAddAdress: UILabel!
    
    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet weak var btnsaveadress: AppButton!
    @IBOutlet weak var btnSlide: UIButton!
    @IBOutlet weak var btndefault: UIButton!
    @IBOutlet weak var btnDeleteadd: UIButton!
    
    @IBOutlet weak var vwhousenumber: TextReusableView!
    @IBOutlet weak var vwstreetadress: TextReusableView!
    @IBOutlet weak var vwlandmark: TextReusableView!
    @IBOutlet weak var vwcity: TextReusableView!
    @IBOutlet weak var vwpostalcode: TextReusableView!
    @IBOutlet weak var vwPhonenumber: TextReusableView!
    @IBOutlet weak var vwdeleteadress: UIView!
    
    // MARK: - Variables
    var delegate : addAdresssDelegate?
    var isFromEditAdress : Bool = false
    var selectedAdressData : AdresssModel?
    private var selectedLatitude : Double = 0.0
    private var selectedLongitude : Double = 0.0
    var btndelete : Bool = false
    
    var countryname : String = ""
       var cityname : String = ""
       var statename : String = ""
       var streetname : String = ""
       var zipcode : String = ""
   
    
 
    var isSelectDefaultAdress: Bool = false {
        didSet{
            self.btndefault?.setTitleColor(isSelectDefaultAdress ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.appColor, for: .normal)
            self.btndefault?.borderColor = isSelectDefaultAdress ? UIColor.CustomColor.appColor : UIColor.CustomColor.ResumebgColor
            self.btndefault?.backgroundColor = isSelectDefaultAdress ? UIColor.CustomColor.appColor : .clear
            self.btndefault?.borderWidth = isSelectDefaultAdress ? 0.0 : 2.0
            self.btndefault?.titleLabel?.font = isSelectDefaultAdress ? UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0)) : UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
            self.btndefault?.cornerRadius = isSelectDefaultAdress ? 22.5 : 22.5
        }
    }
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.vwMainView?.roundCornersTest(corners: [.topLeft,.topRight], radius: 40.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
// MARK: - Init Configure
extension AddadressViewController {
    private func InitConfig(){
        self.vwstreetadress?.textreusableViewDelegate = self
        self.vwstreetadress?.btnSelect.isHidden = false
        self.vwdeleteadress?.isHidden = self.btndelete
        
        self.lblAddAdress?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 18.0))
        self.lblAddAdress?.textColor = UIColor.CustomColor.textfieldTextColor
        
        self.btndefault?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btndefault?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        self.btndefault?.cornerRadius = 22.5
        self.btndefault?.borderColor = UIColor.CustomColor.ResumebgColor
        self.btndefault?.borderWidth = 2.0
        self.isSelectDefaultAdress = false
        
        
        self.btnDeleteadd?.setTitleColor(UIColor.CustomColor.Logoutcolor, for: .normal)
        self.btnDeleteadd?.titleLabel?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 16.0))
        
        self.vwpostalcode?.isFromZipCode = true
        self.vwhousenumber?.txtInput.keyboardType = .default
        self.vwstreetadress?.txtInput.keyboardType = .default
        self.vwlandmark?.txtInput.keyboardType = .default
        self.vwcity?.txtInput.keyboardType = .default
        self.vwpostalcode?.txtInput.keyboardType = .numberPad
        self.vwlandmark?.txtInput.autocapitalizationType = .sentences
        
        
        if self.isFromEditAdress,let obj = self.selectedAdressData {
            self.vwhousenumber?.txtInput.text = obj.houseNumber
            self.vwstreetadress?.txtInput.text = obj.address
            self.vwlandmark?.txtInput.text = obj.landMark
            self.vwcity?.txtInput.text = obj.city
            self.vwpostalcode?.txtInput.text = obj.zipcode
            self.vwPhonenumber?.txtInput.text = obj.phonenumber

            
            if obj.isDefault == "1"{
                self.isSelectDefaultAdress = true
            } else {
                self.isSelectDefaultAdress = false
            }
        }
    }
}

//MARK: - IBAction Method
extension AddadressViewController {
    
    @IBAction func btnSaveAdressClick() {
        self.view.endEditing(true)
        if let errMessage = self.validateFields() {
            self.showMessage(errMessage.localized(), themeStyle: .warning,presentationStyle: .top)
            return
        }
        self.dismiss(animated: true, completion: nil)
        self.addNewAdressAPI()
    }
    
    @IBAction func btnDefualtAddClick() {
        self.btndefault?.isSelected = !(self.btndefault?.isSelected ?? false)
        self.isSelectDefaultAdress = true

    }
    
    @IBAction func btnDownClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCloseClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btndeleteAdd() {
        self.dismiss(animated: true, completion: nil)
        self.DeleteShippingAddress()
    }

}

// MARK: - API
extension AddadressViewController {
    func validateFields() -> String? {
        if self.vwhousenumber?.txtInput.isEmpty ?? false{
            self.vwhousenumber?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyHousenumber
        } else if self.vwstreetadress?.txtInput.isEmpty ?? false {
            self.vwstreetadress?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptystressadd
        } else if self.vwcity?.txtInput.isEmpty ?? false {
            self.vwcity?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptycity
        } else if self.vwpostalcode?.txtInput.isEmpty ?? false {
            self.vwpostalcode?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kemptyPostalCode
        } else if self.vwpostalcode?.txtInput.isEmpty ?? false {
            self.vwpostalcode?.txtInput.becomeFirstResponder()
            return AppConstant.ValidationMessages.kInvalidcode
        }  else if self.vwPhonenumber?.txtInput?.isEmpty ?? true {
            self.vwPhonenumber?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kEmptyPhoneNumber
        } else if !(self.vwPhonenumber?.txtInput.isValidContactPhoneno() ?? false) {
            self.vwPhonenumber?.txtInput?.becomeFirstResponder()
            return AppConstant.ValidationMessages.kInValidPhoneNo
        }
        return nil
    }
}

// MARK: - ReusableView Delegate
extension AddadressViewController : TextReusableViewDelegate {
    func buttonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.MapselectClicked(sender)
    }
    
    func rightButtonClicked(_ sender: UIButton) {
        return
    }
    @objc func MapselectClicked(_ sender : UIButton) {
    
            let filter = GMSAutocompleteFilter()
            //filter.type = .address
            let placePickerController = GMSAutocompleteViewController()
            placePickerController.delegate = self
            placePickerController.autocompleteFilter = filter
            present(placePickerController, animated: true, completion: nil)
        }
}
// MARK: - API
extension AddadressViewController {
    private func addNewAdressAPI(){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
        
            var dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                khouseNumber : self.vwhousenumber?.txtInput.text ?? "",
                kaddress : self.vwstreetadress?.txtInput.text ?? "",
                klandMark : self.vwlandmark?.txtInput.text ?? "",
                kcity : self.vwcity?.txtInput.text ?? "",
                kzipcode : self.vwpostalcode?.txtInput.text ?? "",
                kphone : self.vwPhonenumber?.txtInput.text ?? "",
                kisDefault : (self.btndefault?.isSelected ?? false) ? "1" : "0",
                klatitude : "\(selectedLatitude)",
                klongitude : "\(selectedLongitude)",
//                kisDefault : self.btndefault?.isSelected ? "b1" : "0"

            ]
            if self.isFromEditAdress,let obj = self.selectedAdressData {
                dict[kaddressId] = obj.id
            } else {
                dict[kid] = ""
            }
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            AdresssModel.SetUserShippingAddress(with: param, success: { (msg) in
                            
                self.dismiss(animated: true) {
                    self.delegate?.reloadadress()
                }
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                if !error.isEmpty {
                    self.showMessage(error, themeStyle: .error)
                  
                }
            })
        }
    }
    
    private func DeleteShippingAddress(){
      if let user = UserModel.getCurrentUserFromDefault() {
          self.view.endEditing(true)
          
          let dict : [String:Any] = [
              klangType : Rosterd.sharedInstance.languageType,
              ktoken : user.token,
              kaddressId : self.selectedAdressData?.id ?? ""
          ]
          
          let param : [String:Any] = [
              kData : dict
          ]
          
          AdresssModel.DeleteShippingAddress(with: param, success: { (msg) in
              self.dismiss(animated: true) {
                  self.delegate?.reloadadress()
              }
          }, failure: {[unowned self] (statuscode,error, errorType) in
              print(error)
              if !error.isEmpty {
                  self.showMessage(error, themeStyle: .error)
              }
          })
      }
    
    }
}

// MARK: - ViewControllerDescribable
extension AddadressViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension AddadressViewController: AppNavigationControllerInteractable { }


// MARK: - GMSAutocompleteViewControllerDelegate
extension AddadressViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //print("Place name: \(place.name)")
        //print("Place ID: \(place.placeID)")
        //print("Place attributions: \(place.attributions)")
        //dismiss(animated: true, completion: nil)

        dismiss(animated: true) {
            DispatchQueue.main.async { [self] in
                self.selectedLatitude = place.coordinate.latitude
                self.selectedLongitude = place.coordinate.longitude
                //self.lblLocation.text = place.formattedAddress ?? ""
                self.zipcode = ""
                self.streetname = ""
                var addressShort : String = ""
                for addressComponent in (place.addressComponents)! {
                    for type in (addressComponent.types){
                        print("Type : \(type) = \(addressComponent.name)")
                        switch(type){
                            case "street_number":
                                self.streetname = addressComponent.name
                                print("Street : \(self.streetname)")
                                addressShort = addressComponent.name
                            case "route":
                                addressShort = addressShort + "\(addressShort.isEmpty ? "\(addressComponent.name)" : ",\(addressComponent.name)")"
                            case "premise":
                                addressShort = addressShort + "\(addressShort.isEmpty ? "\(addressComponent.name)" : ",\(addressComponent.name)")"
                            case "neighborhood":
                                addressShort = addressShort + ",\(addressComponent.name)"
                            case "country":
                                self.countryname = addressComponent.name
                                print("Contry : \(self.countryname)")
                            case "postal_code":
                                 self.zipcode = addressComponent.name
                            case "administrative_area_level_2":
                                self.cityname = addressComponent.name
                                print("City : \(self.cityname)")
                            case "administrative_area_level_1":
                                self.statename = addressComponent.name
                                print("State : \(self.statename)")
                        default:
                            break
                        }
                    }
                }
                print(addressShort)
                self.vwstreetadress?.txtInput.text = addressShort.isEmpty ? (place.formattedAddress ?? "") : addressShort
                self.vwpostalcode?.txtInput.text = zipcode.isEmpty ? (place.formattedAddress ?? "") : zipcode
                self.vwcity?.txtInput.text = cityname.isEmpty ? (place.formattedAddress ?? "") : cityname
            }
        }

    }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
//

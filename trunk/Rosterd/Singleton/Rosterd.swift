//
//  FiveDollarBill.swift
//  FiveDollarBill
//
//  Created by wm-devIOShp on 20/12/21.
//

import UIKit

class Rosterd: NSObject {

    static let sharedInstance = Rosterd()
    var multipleImageDelegate:BoomrangDelegate?
    var currentUser: UserModel?
    var deviceToken = ""
    var DeviceType = "1"
    var navigationBackgroundImage: UIImage?
    var ReferalCode = ""
    var selectedUserType : userRole = .fan
    var languageType : String = "1"
    var TicketId : String = ""
    
    var tabbarHeight : CGFloat = 0.0
    
    var systemOSVersion : String = UIDevice.current.systemVersion
    
    var version : String = Bundle.main.releaseVersionNumber ?? ""
    var build : String = Bundle.main.buildVersionNumber ?? ""
    var deviceID : String = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    var userRole : String = "2"

    var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
    
    var AppVersion : String = "\(Bundle.main.releaseVersionNumber ?? "") \(Bundle.main.buildVersionNumber ?? "")"
//
    var currentAddressString : String = ""
    
    
    
    
    func getAddressFromLatLong(lat: Double,long: Double,complation : @escaping (_ address : String,_ country : String,_ state : String,_ city : String,_ street : String,_ zipcode : String) -> Void )  {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat , longitude: long)
        var address : String = ""
        var countryname : String = ""
        var statename : String = ""
        var cityname : String = ""
        var streetname : String = ""
        var zipcode : String = ""
        var locstreet : String = ""
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            //print("Response GeoLocation : \(placemarks)")
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if placeMark != nil {
                // Country
                if let country = placeMark.country {
                    //print("Country :- \(country)")
                    countryname = country
                    // City
                    
                }
                
                if let city = placeMark.subAdministrativeArea {
                    //print("City :- \(city)")
                    cityname = city
                    
                }
                
                // State
                if let state = placeMark.administrativeArea{
                    //print("State :- \(state)")
                    statename = state
                }
                // Street
                if let street = placeMark.thoroughfare{
                    //print("Street :- \(street)")
                    streetname = placeMark.subLocality ?? ""
                    
                }
                
                // ZIP
                if let zip = placeMark.postalCode{
                    //print("ZIP :- \(zip)")
                    zipcode = zip
                    
                }
                
                // Location name
                if let locationName = placeMark?.name {
                    //print("Location Name :- \(locationName)")
                    locstreet = locationName
                }
                
                if locstreet != "" {
                    address = locstreet
                }
                if streetname != "" {
                    address = "\(address == "" ? "" : "\(address),")\(streetname)"
                }
                
                if cityname != "" {
                    address = "\(address == "" ? "" : "\(address),")\(cityname)"
                }
                
                if countryname != "" {
                    address = "\(address == "" ? "" : "\(address),")\(countryname)"
                }
            }
            
            complation(address,countryname,statename,cityname,streetname,zipcode)
        })
    }
  
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
  
    func getMonthBetween(from start: Date, to end: Date) -> [String] {
            var allDates: [String] = []
            guard start < end else { return allDates }
            
            let calendar = Calendar.current
            let month = calendar.dateComponents([.month], from: start, to: end).month ?? 0
            
            for i in 0...month {
                if let date = calendar.date(byAdding: .month, value: i, to: start) {
                    allDates.append(date.getTimeString(inFormate: AppConstant.DateFormat.k_MMMM))
                }
            }
            return allDates
        }
    
    func getYearBetween(from start: Date, to end: Date) -> [String] {
        var allDates: [String] = []
        guard start < end else { return allDates }
        
        let calendar = Calendar.current
        let month = calendar.dateComponents([.year], from: start, to: end).year ?? 0
        
        for i in 0...month {
            if let date = calendar.date(byAdding: .year, value: i, to: start) {
                allDates.append(date.getTimeString(inFormate: AppConstant.DateFormat.k_yyyy))
            }
        }
        return allDates
    }
    
    func getArrayOfYear() -> [String] {
        let startingYear : Int = 1900
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        let currentYear = Int(yearString) ?? startingYear
        
        var arrYear = [String]()
        for i in stride(from: startingYear, to: currentYear, by: 1) {
            arrYear.append(String(i))
        }
        print(arrYear)
        arrYear.append(yearString)
        return arrYear
    }
}

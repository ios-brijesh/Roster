//
//  UIStoryboard+Name.swift
//  Momentor
//
//  Created by mac on 16/01/2020.
//  Copyright © 2019 Differenzsystem Pvt. LTD. All rights reserved.
//

import UIKit
import ViewControllerDescribable

extension UIStoryboard {
    enum Name: String, StoryboardNameDescribable {
        case main = "Main",
        auth = "Auth",
        DashBoard = "DashBoard",
        Home = "Home",
        Events = "Events",
        Shop = "Shop",
        Message = "Message",
        CMS = "CMS",
        Payment = "Payment",
        Profile = "Profile",
        Communication = "Communication",
        Sessions = "Sessions",
        MyNotes = "MyNotes",
        FeedTab = "FeedTab",
        MyCalender = "MyCalender",
        Chat = "Chat",
        Collage = "Collage"
        
    }
    func getViewController(with identifier: String) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier)
    }
    class func getStoryboard(for name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
}

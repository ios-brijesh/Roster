//
//  CustomNotificationDescribable.swift
//  Momentor
//
//  Created by mac on 16/01/2020.
//  Copyright © 2019 Differenzsystem Pvt. LTD. All rights reserved.
//

import Foundation

protocol Notifiable {
    static var representationName: String { get }
    static var notificationName: Notification.Name { get }
    
    var userInfo: Dictionary<AnyHashable, Any> { get set }
    
    init(userInfo: Dictionary<AnyHashable, Any>?)
    
    static func observe<Observer: Any>(observer: Observer,
                                       selector: Selector)
    
    func post(sender: Any?)
}

// MARK: - Default implementation & NSObject
extension Notifiable where Self: NSObject {
    static var representationName: String {
        return String(describing: self)
    }
    
    static var notificationName: Notification.Name {
        return Notification.Name(representationName)
    }
    
    static func observe<Observer: Any>(observer: Observer,
                                       selector: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: notificationName,
            object: nil
        )
    }
    
    func post(sender: Any? = nil) {
        NotificationCenter.default.post(
            name: type(of: self).notificationName,
            object: sender,
            userInfo: userInfo
        )
    }
}

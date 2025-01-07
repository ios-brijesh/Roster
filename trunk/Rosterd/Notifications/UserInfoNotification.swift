//
//  UserInfoNotification.swift
//  Momentor
//
//  Created by mac on 16/01/2020.
//  Copyright © 2019 Differenzsystem Pvt. LTD. All rights reserved.
//

import Foundation

final class UserInfoNotification: NSObject, Notifiable {
    var userInfo: Dictionary<AnyHashable, Any>
    
    var user: UserModel {
        let key = \UserInfoNotification.user
        
        return (userInfo[key] as? UserModel ?? nil)!
    }
    
    required init(userInfo: Dictionary<AnyHashable, Any>?) {
        self.userInfo = userInfo ?? Dictionary<AnyHashable, Any>()
    }
    
    init(user: UserModel) {
        userInfo = [\UserInfoNotification.user : user]
    }
}

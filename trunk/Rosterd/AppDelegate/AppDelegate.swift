//
//  AppDelegate.swift
//  Rosterd
//
//  Created by WM-KP on 04/01/22.
//

import UIKit
import CoreData
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Variables
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2.0)
        // Override point for customization after application launch.
        FirebaseApp.configure()
        //GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: "463815093978-dfdqqdc94trs8i5b5ki3pfa9lt20cq6d.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.configuration = config
        self.configureLocalNotifications()
        self.setSVProgressHUDconfiguration()
        self.setIQKeyboardManager()
        //LocationManager.shared.startLocationTracking()
        self.configureGoogle()
        //self.pushKitRegistration()
        WebSocketChat.shared.connectSocket()
        window?.rootViewController = AppSideMenuMainViewController.instantiated { vc in
            vc.rootNavigationController?.menuDelegate = vc
        }
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break
                }
            }
        }
       
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(
            _ app: UIApplication,
            open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            var handled: Bool
            
            handled = GIDSignIn.sharedInstance.handle(url)
            if handled {
                return true
            }
            
            ApplicationDelegate.shared.application(
                        app,
                        open: url,
                        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                        annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                    )
            
            // Handle other custom URL types.
            
            // If not handled by this app, return false.
            return false
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Rosterd")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: - Local Notifications
fileprivate extension AppDelegate {
    func configureLocalNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
                if !accepted {
                    print("Notification access denied.")
                }
            }
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            // Fallback on earlier versions
        }
        
        Messaging.messaging().delegate = self
    }
}

extension AppDelegate : MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
        if let str = fcmToken {
            let dataDict:[String: String] = ["token": str ]
            //UserDefaults.standard.set(String(describing: fcmToken), forKey: UD_Device_Token)
            UserDefaults.setDeviceToken = str
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        }
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    
    /*Messaging.messaging().token { token, error in
      if let error = error {
        print("Error fetching FCM registration token: \(error)")
      } else if let token = token {
        print("FCM registration token: \(token)")
        self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
      }
    }*/
    
}

// MARK: - Appearance
extension AppDelegate {
 
    // MARK: - Instance methods
    /**
     This method is used to set rootViewController
     */
    func clearUserDataForLogout() {
        //OnixNetwork.sharedInstance.currentUser = nil
        UserDefaults.isUserLogin = false
        UserDefaults.isShowShopInfo = false
        UserModel.removeUserFromDefault()
    }
    
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token " + token)
        //Momentor.sharedInstance.deviceToken = token
        //UserDefaults.setDeviceToken = token
        
        Messaging.messaging().apnsToken = deviceToken
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let notificationData = notification.request.content.userInfo
        //print(userInfo)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: notificationData, options: .prettyPrinted) {
            print("Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
        }
        completionHandler([.alert, .sound])
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        // send info from response somewhere before delete notification!!!
        let notificationData = response.notification.request.content.userInfo
        //print(userInfo)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: notificationData, options: .prettyPrinted) {
            print("Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
        }
        let userInfostr = notificationData["payload"] as? String ?? ""
        if let userInfo : [String:Any] = userInfostr.convertStringToDictionary() {
            //let dictData = userInfo["data"] as? [String :Any] ?? [:]
            if(UserDefaults.isUserLogin){
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    NotificationCenter.default.post(name:NSNotification.Name(rawValue: NotificationPostname.kPushNotification), object: userInfo, userInfo: userInfo)
                }
            }
        }
        completionHandler()
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        print(data)
    }
}

//MARK: - Private Methods
extension AppDelegate {
    // MARK: - SVProgressHUD configuration Method
    func setSVProgressHUDconfiguration() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        //        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
        SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.2))
        SVProgressHUD.setForegroundColor(UIColor.CustomColor.appColor)
        SVProgressHUD.setBackgroundColor(UIColor.white.withAlphaComponent(0.8))
        let size = DeviceType.IS_PAD ? CGSize(width: 150, height: 150) : CGSize(width: 75, height: 75)
        SVProgressHUD.setMinimumSize(size)
    }
    
    func setIQKeyboardManager() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().toolbarTintColor = UIColor.CustomColor.appColor
        IQKeyboardManager.shared().previousNextDisplayMode = .alwaysShow
        //IQKeyboardManager.shared().shouldShowTextFieldPlaceholder = false
        //IQKeyboardManager.shared().toolbarPreviousNextAllowedClasses.add(UIStackView.self)
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = false
    }
    
    func setupLocationManager() {
        let _ = LocationManager.init()
        //LocationManager.shared.startLocationTracking()
    }
    
    private func configureGoogle() {
        GMSPlacesClient.provideAPIKey(APIKeys.GooglePlaceAPIKey)
        GMSServices.provideAPIKey(APIKeys.GooglePlaceAPIKey)
        //GoogleApi.shared.initialiseWithKey(APIKeys.GooglePlaceAPIKey)
    }
}


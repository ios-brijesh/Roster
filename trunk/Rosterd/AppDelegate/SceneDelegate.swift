//
//  SceneDelegate.swift
//  Rosterd
//
//  Created by WM-KP on 04/01/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        (UIApplication.shared.delegate as? AppDelegate)?.self.window = window
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let url = connectionOptions.urlContexts.first?.url {
            if url.absoluteString.contains("/product") {
                delay(seconds: 5) {
                    if let user = UserModel.getCurrentUserFromDefault(),user.token != ""  {
                        print("product")
                        print(url.lastPathComponent)
                        let id : String = "\(url.lastPathComponent)"
                        let data : [String:Any] = ["linkid" : id,"linktype":"product"]
                        NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kOpenRosterdDetail), object: nil,userInfo: data)
                    }
                }
            }
            else if url.absoluteString.contains("/post") {
                delay(seconds: 5) {
                    if let user = UserModel.getCurrentUserFromDefault(),user.token != ""  {
                        print("post")
                        print(url.lastPathComponent)
                        let id : String = "\(url.lastPathComponent)"
                        let data : [String:Any] = ["linkid" : id,"linktype":"post"]
                        NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kOpenRosterdDetail), object: nil,userInfo: data)
                    }
                }
            }
            else if url.absoluteString.contains("/event") {
                delay(seconds: 5) {
                    if let user = UserModel.getCurrentUserFromDefault(),user.token != ""  {
                        print("event")
                        print(url.lastPathComponent)
                        let id : String = "\(url.lastPathComponent)"
                        let data : [String:Any] = ["linkid" : id,"linktype":"event"]
                        NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kOpenRosterdDetail), object: nil,userInfo: data)
                    }
                }
            }
            else if url.absoluteString.contains("//blog") {
                if let user = UserModel.getCurrentUserFromDefault()  {
                    print("Referal Coin")
                    print(url.lastPathComponent)
                    let id : String = "\(url.lastPathComponent)"
                    let data : [String:Any] = ["linkid" : id]
                    NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kReferalCoin), object: nil,userInfo: data)
                    Rosterd.sharedInstance.ReferalCode = id
//                    appDelegate.openURLType = .Blog
//                    appDelegate.openFromURL = true
//                    appDelegate.openURLDataID = id
                }
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        if url.absoluteString.contains("/product") {
            delay(seconds: 5) {
                if let user = UserModel.getCurrentUserFromDefault(),user.token != ""  {
                    print("product")
                    print(url.lastPathComponent)
                    let id : String = "\(url.lastPathComponent)"
                    let data : [String:Any] = ["linkid" : id,"linktype":"product"]
                    NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kOpenRosterdDetail), object: nil,userInfo: data)
                }
            }
        }
        else if url.absoluteString.contains("/post") {
            delay(seconds: 5) {
                if let user = UserModel.getCurrentUserFromDefault(),user.token != ""  {
                    print("post")
                    print(url.lastPathComponent)
                    let id : String = "\(url.lastPathComponent)"
                    let data : [String:Any] = ["linkid" : id,"linktype":"post"]
                    NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kOpenRosterdDetail), object: nil,userInfo: data)
                }
            }
        }
        else if url.absoluteString.contains("/event") {
            delay(seconds: 5) {
                if let user = UserModel.getCurrentUserFromDefault(),user.token != ""  {
                    print("event")
                    print(url.lastPathComponent)
                    let id : String = "\(url.lastPathComponent)"
                    let data : [String:Any] = ["linkid" : id,"linktype":"event"]
                    NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kOpenRosterdDetail), object: nil,userInfo: data)
                }
            }
        }

        else if url.absoluteString.contains("//blog") {
            if let user = UserModel.getCurrentUserFromDefault()  {
                print("Referal Blog")
                print(url.lastPathComponent)
                let id : String = "\(url.lastPathComponent)"
                let data : [String:Any] = ["linkid" : id]
                NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kOpenRosterdDetail), object: nil,userInfo: data)
               
            }
        }
        
        if let openURLContext = URLContexts.first {
            ApplicationDelegate.shared.application(UIApplication.shared,
                                                   open: openURLContext.url,
                                                   sourceApplication: openURLContext.options.sourceApplication,
                                                   annotation: openURLContext.options.annotation)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}


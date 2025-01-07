//
//  SocialLoginManager.swift
//  iTemp
//
//  Created by Wdev3 on 09/12/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class SocialLoginManager: NSObject {
    
    static let shared = SocialLoginManager()
    
    var viewController : UIViewController = UIViewController()
    var appnavigationcontroller : AppNavigationController?
    
    var locationname : String = ""
    var selectLat : Double = 0.0
    var selectLong : Double = 0.0
    
    let signInConfig = GIDConfiguration(clientID: "463815093978-dfdqqdc94trs8i5b5ki3pfa9lt20cq6d.apps.googleusercontent.com")
    
    //private let readPermissions: [ReadPermission] = [ .publicProfile, .email, .userFriends, .custom("user_posts") ]
    
    var onGetSuccessData: ((_ data : [String:Any])-> (Void))?
    
    func getLocation(){
        LocationManager.shared.getLocationUpdates { (manager, location) -> (Bool) in
            self.selectLat = location.coordinate.latitude
            self.selectLong = location.coordinate.longitude
            
//            Rosterd.sharedInstance.getAddressFromLatLong(lat: self.selectLat, long: self.selectLong) { (str,country,state,city,street,zipcode) in
//                Rosterd.sharedInstance.currentAddressString = str
//                self.locationname = str
//            }
            return true
        }
        
    }
    
    func loginWithGoogle(){
        
        GIDSignIn.sharedInstance.signOut()
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self.viewController) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            
            let userId = user.userID ?? ""                  // For client-side use only!
            //let idToken = user.authentication.idToken // Safe to send to the server
            let name = user.profile?.name ?? ""
            let email = user.profile?.email ?? ""
            let givenName = user.profile?.givenName ?? ""
            let familyName = user.profile?.familyName ?? ""
            
            print(" userId: ", userId)
            print(" name: ", name)
            print(" email: ", email)
            print(" givenName: ", givenName)
            print(" familyName: ", familyName)
            
            let profilePicUrl = user.profile?.imageURL(withDimension: 400)
            
            self.socialLoginAPICall(firstname: givenName, lastname: familyName, email: email, authProvider: "google", socialuserid: userId)
        }
        
      /*  GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self.viewController) { user, error in
            guard error == nil else { return }

            if (error == nil) {
                // Perform any operations on signed in user here.
                let userId = user?.userID ?? ""                  // For client-side use only!
                //let idToken = user.authentication.idToken // Safe to send to the server
                let name = user?.profile?.name ?? ""
                let email = user?.profile?.email ?? ""
                let givenName = user?.profile?.givenName ?? ""
                let familyName = user?.profile?.familyName ?? ""
                
                print(" userId: ", userId)
                print(" name: ", name)
                print(" email: ", email)
                print(" givenName: ", givenName)
                print(" familyName: ", familyName)
                
                if let image = user?.profile?.hasImage,image == true {
                    let imageUrl = user?.profile?.imageURL(withDimension: 400)
                    print(" image url: ", imageUrl?.absoluteString ?? "")
                    if let url = imageUrl {
                        let data = try? Data(contentsOf: url)
                        if let imageData = data,let image = UIImage(data: imageData){

                            let dict : [String:Any] = [
                                klangType : Rosterd.sharedInstance.languageType,
                            ]

                            UserModel.uploadMedia(with: dict, image: image, success: { (msg) in
                                //self.mediaName = msg
                                self.socialLoginAPICall(firstname: user?.profile?.givenName ?? "", lastname: user?.profile?.familyName ?? "", email: user?.profile?.email ?? "", authProvider: "google", socialuserid: user?.userID ?? "",imageName: msg)
                            }, failure: {[unowned self] (statuscode,error, errorType) in
                                print(error)
                                if !error.isEmpty {
                                    //self.showAlert(withTitle: errorType.rawValue, with: error)
                                    self.appnavigationcontroller?.showMessage(error, themeStyle: .error)
                                }
                            })
                        }
                        else {
                            self.socialLoginAPICall(firstname: user?.profile?.givenName ?? "", lastname: user?.profile?.familyName ?? "", email: user?.profile?.email ?? "", authProvider: "google", socialuserid: user?.userID ?? "")
                        }
                    }
                }
                else {
                    self.socialLoginAPICall(firstname: user?.profile?.givenName ?? "", lastname: user?.profile?.familyName ?? "", email: user?.profile?.email ?? "", authProvider: "google", socialuserid: user?.userID ?? "")
                }
            } else {
                print("\(error?.localizedDescription ?? "")")
                }
          } */
    }
    
    func loginWithApple(){
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self.viewController as? ASAuthorizationControllerPresentationContextProviding
            authorizationController.performRequests()
            SVProgressHUD.show()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func loginWithFacebook() {
        
        LoginManager().logOut()
        
        LoginManager().logIn(permissions: ["public_profile","email"], from: viewController) {[unowned self] (result, error) in
            guard error == nil else {
                //self.viewController.showAlert(with: error?.localizedDescription ?? "")
                self.viewController.showMessage(error?.localizedDescription ?? "", themeStyle: .warning)
                LoginManager().logOut()
                return
            }
            guard let loginResult = result, !loginResult.isCancelled, loginResult.grantedPermissions.contains("email") else {
                LoginManager().logOut()
                return
            }
            GraphRequest(graphPath:"me", parameters: ["fields":"id, email, first_name, last_name, picture.width(400)"]).start(completionHandler: {[unowned self] (connection, result, error) in
                guard let dic = result as? [String:Any], error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print(dic)
                self.loginFacebookUser(with: dic)
            })
        }
    }
    
    func loginWithInstagram(_ userID:String,userName:String) {
        self.socialLoginAPICall(firstname: userName, lastname: "", email: "", authProvider: "instagram", socialuserid: userID)
    }
    
    func loginFacebookUser(with responseDic: [String:Any]){
        let firstName = responseDic["first_name"] as? String ?? ""
        let lastName = responseDic["last_name"] as? String ?? ""
        let email = responseDic["email"] as? String ?? ""
        let pictureDic = responseDic["picture"] as? [String:Any] ?? [:]
        let dataDic = pictureDic["data"] as? [String:Any] ?? [:]
        let profileURL = dataDic["url"] as? String ?? ""
        guard let facebookId = responseDic["id"] as? String else {
            self.viewController.showAlert(with: AppConstant.FailureMessage.kFbIdNotFound)
            return
        }
        self.socialLoginAPICall(firstname: firstName, lastname: lastName, email: email, authProvider: "facebook", socialuserid: facebookId)
 
    }
    
    private func socialLoginAPICall(firstname : String,lastname : String,email : String,authProvider : String,socialuserid : String,imageName:String = ""){
        
        let dict : [String:Any] = [
            kauth_id : socialuserid,
            kauth_provider : authProvider,
            kdeviceToken : UserDefaults.setDeviceToken,
            klangType : Rosterd.sharedInstance.languageType,
            kdeviceType : Rosterd.sharedInstance.DeviceType,
            kdeviceId : Rosterd.sharedInstance.deviceID,
            ktimeZone : Rosterd.sharedInstance.localTimeZoneIdentifier,
            kisManualEmail : email == "" ? "1" : "0",
            kname : "\(firstname) \(lastname)",
            kEmail : email,
         
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        UserModel.userSocialLogin(with: param, success: { (user, msg) in
            UserDefaults.isUserLogin = true
            WebSocketChat.shared.connectSocket()
            
            if user.profileStatus == "5" {
                self.appnavigationcontroller?.showDashBoardViewController()
            }
            else {
                self.appnavigationcontroller?.push(SelectProfileTypeViewController.self) { vc in
                        vc.isFromLogin = true
                    }
            }
//            self.appnavigationcontroller?.showDashBoardViewController()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            print(error)
            if statuscode == APIStatusCode.verifyAcccout.rawValue {
                self.appnavigationcontroller?.detachRightSideMenu()
                self.appnavigationcontroller?.push(VerificationViewController.self,configuration: { (vc) in
                    vc.userEmail = email
                    vc.isFromSignup = true
                })
            } else {
                if !error.isEmpty {
                    self.viewController.showMessage(error, themeStyle: .error)//showAlert(withTitle: errorType.rawValue, with: error)
                }
            }
        })
    }
}

@available(iOS 13.0, *)
extension SocialLoginManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        //}
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            
            var name = String()
            if let givenName = fullName?.givenName {
                name = givenName
            }
            if let familyName = fullName?.familyName {
                name  = name + " " +  familyName
            }
            
            let appleUserFirstName = appleIDCredential.fullName?.givenName

            let appleUserLastName = appleIDCredential.fullName?.familyName

            let appleUserEmail = appleIDCredential.email
            
            
            print("First Name : \(appleUserFirstName ?? "")")
            print("Last Name : \(appleUserLastName ?? "")")
            print("Email : \(appleUserEmail ?? "")")
            
            if appleUserFirstName != nil && appleUserLastName != nil && appleUserEmail != nil && userIdentifier != "" {
                let dictionaryExample : [String:Any] = [kAppleSigninEmail : appleUserEmail ?? "",
                                                              kAppleSigninFirstName : appleUserFirstName ?? "",
                                                              kAppleSigninLastName : appleUserLastName ?? "",
                                                              kAppleSigninAppUserID : userIdentifier]
                do {
                    let dataExample : Data = try NSKeyedArchiver.archivedData(withRootObject: dictionaryExample, requiringSecureCoding: false)
                    let status = KeyChain.save(key: kAppleSigninUserData, data: dataExample as Data)
                    print("Sigin Status : \(status)")
                    
                    self.socialLoginAPICall(firstname: appleUserFirstName ?? "", lastname: appleUserLastName ?? "", email: appleUserEmail ?? "", authProvider: "apple", socialuserid: userIdentifier)
                    
                    
                } catch {
                    
                }
                
            } else {
                if let receivedData = KeyChain.load(key: kAppleSigninUserData) {
                    do{
                        let fetchValue = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(receivedData) as? NSDictionary ?? [:]
                        print(fetchValue)
                        let appuserID : String = fetchValue[kAppleSigninAppUserID] as? String ?? ""
                        let userFirstName : String = fetchValue[kAppleSigninFirstName] as? String ?? ""
                        let userLastName : String = fetchValue[kAppleSigninLastName] as? String ?? ""
                        let userEmail : String = fetchValue[kAppleSigninEmail] as? String ?? ""
                        
                        self.socialLoginAPICall(firstname: userFirstName, lastname: userLastName, email: userEmail, authProvider: "apple", socialuserid: appuserID)
                    }catch{
                        print("Unable to successfully convert NSData to NSDictionary")
                    }
                }
            }
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //print("AppleID Credential failed with error: \(error.localizedDescription)”)
        print("AppleID Credential failed with error: \(error.localizedDescription)")
        self.viewController.showMessage("AppleID Credential failed with error: \(error.localizedDescription)", themeStyle: .error)
        SVProgressHUD.dismiss()
    }
}

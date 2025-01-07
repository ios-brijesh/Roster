//
//  instaViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 10/08/22.
//

import UIKit

class instaViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var webContentView: WKWebView!
    var onCompleteUserInfo:((_ userId:String,_ userName:String) -> ())?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}

// MARK: - Init Configure
extension instaViewController {
    private func InitConfig(){
        self.view.backgroundColor = UIColor.CustomColor.appColor
        
        webContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.webContentView.isOpaque = false
        webContentView.uiDelegate = self
        webContentView.navigationDelegate = self
        webContentView.allowsBackForwardNavigationGestures = true
        self.webContentView.cleanAllCookies()
        
        self.loadInstaRequest()
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

// MARK: - UIButton Action
extension instaViewController {
    @IBAction func btnBackClick() {
        self.dismiss(animated: true) {
            
        }
    }
}
// MARK: - Instagram Config
extension instaViewController {
    func loadInstaRequest() {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&scope=%@&response_type=code", arguments: [INSTAGRAM_CONSTANT.INSTAGRAM_AUTHURL,INSTAGRAM_CONSTANT.INSTAGRAM_CLIENT_ID,INSTAGRAM_CONSTANT.INSTAGRAM_REDIRECT_URI, INSTAGRAM_CONSTANT.INSTAGRAM_SCOPE])
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webContentView.load(urlRequest)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        print("RequestURL :\(requestURLString)")
        if requestURLString.hasPrefix(INSTAGRAM_CONSTANT.INSTAGRAM_REDIRECT_URI) {
            //               let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            //               handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            
            if let params = request.url?.queryParameters,let codeString = params["code"] {
                print("CODE :\(codeString)")
                self.getAccessToken(codeString)
            }
            return false;
        }
        return true
    }
    
    func handleAuth(authToken: String) {
        INSTAGRAM_CONSTANT.INSTAGRAM_ACCESS_TOKEN = authToken
        print("Instagram authentication token ==", authToken)
        getUserInfo(){(userInfo,data) in
            if let user = userInfo,data {
                if let userID = user["id"] as? String ,let username = user["username"] as? String {
                    delay(seconds: 0.1) {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true) {
                                guard let onGetUser = self.onCompleteUserInfo else { return }
                                onGetUser(userID,username)
                            }
                        }
                        
                    }
                       
                }
            }
        }
    }
    func getUserInfo(completion: @escaping ((_ userInfo: [String:Any]?,_ dataAvailable:Bool) -> Void)){
        let url = String(format: "%@%@", arguments: [INSTAGRAM_CONSTANT.INSTAGRAM_USER_INFO,INSTAGRAM_CONSTANT.INSTAGRAM_ACCESS_TOKEN])
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {  (data, response, error) in
            guard error == nil else {
                self.showMessage("\(error?.localizedDescription ?? "")", themeStyle: .error)
                completion(nil,false)
                //failure
                return
            }
            // make sure we got data
            guard let responseData = data else {
                completion(nil,false)
                //Error: did not receive data
                self.showMessage("\(error?.localizedDescription ?? "")", themeStyle: .error)
                return
            }
            do {
                if let responseJson = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any]{
                    print(responseJson)
                    
                    completion(responseJson,true)
                }
                
            }catch let error {
                self.showMessage("\(error.localizedDescription)", themeStyle: .error)
                completion(nil,false)
            }
        })
        task.resume()
    }
    
    
    func getAccessToken(_ code:String) {
        let appendedURI = "client_id=\(INSTAGRAM_CONSTANT.INSTAGRAM_CLIENT_ID)&client_secret=\(INSTAGRAM_CONSTANT.INSTAGRAM_CLIENTSERCRET)&grant_type=authorization_code&redirect_uri=\(INSTAGRAM_CONSTANT.INSTAGRAM_REDIRECT_URI)&code=\(code)"
        
        let url = URL(string: INSTAGRAM_CONSTANT.INSTAGRAM_GET_TOKEN)!
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpBody = appendedURI.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("result=",dataString!)
                do {
                    
                    if let accDetail = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any],let accessToken = accDetail["access_token"] as? String,let userID = accDetail["user_id"] as? Int64  {
                        print("User Id:\(userID)")
                        print("Access Token:\(accessToken)")
                        self.handleAuth(authToken: accessToken)
                    }
                    
                }catch let error {
                    print("Token Generete Error:\(error.localizedDescription)")
                    self.showMessage("\(error.localizedDescription)", themeStyle: .error)
                }
            }
            else {
                self.showMessage("\(error?.localizedDescription ?? "")", themeStyle: .error)
            }
            
        }
        task.resume()
    }
}

//MARK: - WKNavigationDelegate,WKUIDelegate
extension instaViewController : WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
            
            if checkRequestForCallbackURL(request: navigationAction.request){
                decisionHandler(.allow)
            }else{
                decisionHandler(.cancel)
            }
        }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showMessage("\(error.localizedDescription)", themeStyle: .error)
    }

}

// MARK: - API Call
extension instaViewController {
}

// MARK: - ViewControllerDescribable
extension instaViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.auth
    }
}

// MARK: - AppNavigationControllerInteractable
extension instaViewController: AppNavigationControllerInteractable { }

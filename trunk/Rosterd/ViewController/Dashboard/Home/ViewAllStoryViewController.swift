//
//  ViewAllStoryViewController.swift
//  Rosterd
//
//  Created by wm-devIOShp on 22/01/22.
//

import UIKit

class ViewAllStoryViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var cvStory: UICollectionView?
    
    // MARK: - Variables
    var arrStoriesList = [StoryModel]()
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    //MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        self.REloadStory()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        WebSocketChat.shared.delegate = self
        
    }
}

// MARK: - Init Configure
extension ViewAllStoryViewController {
    private func InitConfig(){
        
        if let cv = self.cvStory {
            cv.register(HomeStoryCell.self)
            cv.dataSource = self
            cv.delegate = self
            cv.reloadData()
        }
//        self.getUserStory()
      
       
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetWhiteTitleWithBack(title: "  Stories", TitleColor: UIColor.CustomColor.textfieldTextColor, isShowRightButton: true,navigationItem: self.navigationItem)
       
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}

////MARK: Pagination tableview Mthonthd
extension ViewAllStoryViewController {
    
    private func REloadStory() {
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrStoriesList.removeAll()
        self.cvStory?.reloadData()
        self.getUserStory()
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension ViewAllStoryViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return arrStoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeStoryCell.self)
        cell.isFromViewAllStory = true
        cell.btnusername?.isHidden = true
        cell.setViewAllStoryData(obj:self.arrStoriesList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2.0) - 10.0, height: ((collectionView.frame.size.width / 1.5) - 10.0))
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.arrStoriesList[indexPath.row]
        if collectionView == cvStory {
            
            if UserModel.getCurrentUserFromDefault()?.id == obj.user_id {
                if arrStoriesList.count > 0 {
                    let storyInfo = arrStoriesList[indexPath.row]
                    let userStory = StoryModel.init(id: UserModel.getCurrentUserFromDefault()?.id ?? "", user_id: UserModel.getCurrentUserFromDefault()?.id ?? "", mediaName: UserModel.getCurrentUserFromDefault()?.profileimage ?? "", isVideo: false, status: "", mediaUrl: UserModel.getCurrentUserFromDefault()?.thumbprofileimage ?? "", userName: UserModel.getCurrentUserFromDefault()?.userName ?? "", userProfileImage: UserModel.getCurrentUserFromDefault()?.thumbprofileimage ?? "", userProfileThumbImage: UserModel.getCurrentUserFromDefault()?.thumbprofileimage ?? "", isUnread: "", chatGroupId: "", storyList: storyInfo.storyList, thumbStoryVideoThumbImage: "", videoThumbImage: "")
                    let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.pages = [userStory]
                    vc.currentIndex = 0
                    vc.storyType = .MyStory
                    vc.onReloadStory = { () in
                        self.arrStoriesList.removeAll()
                        self.pageNo = 1
                        self.REloadStory()
                    }
                   
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }
            }
            
            else {
                if arrStoriesList.indices ~= indexPath.row {
//                    let userStory = arrStoriesList[indexPath.row - 1]
                    let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.pages = arrStoriesList
                    vc.currentIndex = indexPath.row
                    vc.storyType = .OtherStory
                    vc.onReloadStory = { () in
                        self.arrStoriesList.removeAll()
                        self.pageNo = 1
                        self.REloadStory()
                    }
                    vc.onShareStoryDismiss = { () in
                       print("Story Dismiss")
                    }
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }
                
            }
        }
    }
}

//MARK:- API Call
extension ViewAllStoryViewController {
    
    private func getUserStory(){
        
       
        let dictionary : [String:Any] = [khookMethod: AppConstant.WebSocketAPI.kgetUserStory,
                                        kpage : "\(self.pageNo)",
                                        klimit : "10",
                                       
                        ]
//        "\(self.pageNo)",
        WebSocketChat.shared.writeSocketData(dict: dictionary)
    
      
    }

}


//MARK:- webSocketChatDelegate
extension ViewAllStoryViewController : webSocketChatDelegate{
    
    
    func SendReceiveData(dict: [String : AnyObject]) {
        print(dict)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            print("Socket Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
        }
        
        
          if let hookmethod = dict[khookMethod] as? String {
              if hookmethod == AppConstant.WebSocketAPI.kgetUserStory {
                  
                  
                  if let dataarr = dict[kData] as? [[String:Any]] {
                      let arrStories = dataarr.compactMap({StoryModel.init(fromDictionary: $0)})
                      
                      if arrStories.count > 0 {
                          self.arrStoriesList.append(contentsOf: arrStories)
                      }
                  }
                  
                  self.cvStory?.reloadData()
                  
                  
                  let totalpages : Int =  Int (dict["total_page"] as? String ?? "") ?? 0
                  print(totalpages)
                  self.totalPages = totalpages
                  
              }
          }
    
    }
}
// MARK: - ViewControllerDescribable
extension ViewAllStoryViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Home
    }
}

// MARK: - AppNavigationControllerInteractable
extension ViewAllStoryViewController: AppNavigationControllerInteractable { }

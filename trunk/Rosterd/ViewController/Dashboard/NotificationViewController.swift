//
//  NotificationViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 19/02/22.
//

import UIKit

class NotificationViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var vwAll: SegmentTabView?
    @IBOutlet weak var vwSocial: SegmentTabView?
    @IBOutlet weak var vwEvents: SegmentTabView?
    @IBOutlet weak var vwShop: SegmentTabView?
    @IBOutlet weak var tblData: UITableView?
    @IBOutlet weak var lblNoData: NoDataFoundLabel?
    // MARK: - Variables
    private var selecetdTab : segementNotificationEnum = .All
    private var arrNotification : [NotificationModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Init Configure
extension NotificationViewController {
    private func InitConfig(){
        self.view.backgroundColor = UIColor.CustomColor.whitecolor
        self.tblData?.register(NotificationCell.self)
        self.tblData?.estimatedRowHeight = 100.0
        self.tblData?.register(headerFooterViewType: NotificationHeaderCell.self)
        self.tblData?.estimatedSectionHeaderHeight = 100.0
        self.tblData?.rowHeight = UITableView.automaticDimension
        self.tblData?.sectionHeaderHeight = UITableView.automaticDimension
        self.tblData?.delegate = self
        self.tblData?.dataSource = self
        
        delay(seconds: 0.2) {
            self.tblData?.reloadData()
        }
        [self.vwAll,self.vwSocial,self.vwEvents,self.vwShop].forEach({
            $0?.segmentDelegate = self
            
        })
        self.vwShop?.isHidden = true 
        
        self.vwAll?.btnSelectTab?.tag = segementNotificationEnum.All.rawValue
        self.vwSocial?.btnSelectTab?.tag = segementNotificationEnum.Social.rawValue
        self.vwEvents?.btnSelectTab?.tag = segementNotificationEnum.Events.rawValue
        self.vwShop?.btnSelectTab?.tag = segementNotificationEnum.Shop.rawValue
        
        self.setSelectedTab(obj: .All, isUpdateVC: false)
        
        self.setupESInfiniteScrollinWithTableView()
        //        self.getNotificationsListList()
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appsetUpNotificationWithTitle(title: "Notifications", TitleColor: UIColor.CustomColor.blackColor,navigationItem: self.navigationItem)
        
        appNavigationController?.btnNextClickBlock = {
            self.appNavigationController?.push(HelpViewController.self)
        }
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}


//MARK: Pagination tableview Mthonthd
extension NotificationViewController {
    
    private func reloadTableData(){
        self.pageNo = 1
        self.arrNotification.removeAll()
        self.tblData?.reloadData()
        self.getNotificationsListList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblData?.es.addPullToRefresh {
            [unowned self] in
            self.view.endEditing(true)
            self.reloadTableData()
        }
        
        self.tblData?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getNotificationsListList()
                } else if self.pageNo <= self.totalPages {
                    self.getNotificationsListList(isshowloader: false)
                } else {
                    self.tblData?.es.noticeNoMoreData()
                }
            } else {
                self.tblData?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblData?.footer?.animator as? ESRefreshFooterAnimator {
            animator.noMoreDataDescription = ""
        }
    }
    
    /**
     This function is used to hide the footer infinte loading.
     - Parameter success: Used to know API reponse is succeed or fail.
     */
    //Harshad
    func hideFooterLoading(success: Bool) {
        if success {
            if self.pageNo == self.totalPages {
                self.tblData?.es.noticeNoMoreData()
            }
            else {
                self.tblData?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblData?.es.stopLoadingMore()
            self.tblData?.es.noticeNoMoreData()
            self.isLoading = true
        }
        
    }
}

//MARK:- UITableView Delegate
extension NotificationViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotification.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: NotificationCell.self)
        /* if indexPath.row == 0 {
         cell.lblNotificationDesc?.setNotificationTextLable(firstText: "Arnold Berry", SecondText: " loved your photos")
         cell.vwPhotoMain?.isHidden = true
         cell.vwNotificationImgMain?.isHidden = false
         } else if indexPath.row == 1 {
         cell.lblNotificationDesc?.setNotificationTextLable(firstText: "Arnold Berry", SecondText: " has follow you back")
         cell.vwPhotoMain?.isHidden = true
         cell.vwNotificationImgMain?.isHidden = true
         } else if indexPath.row == 2 {
         cell.lblNotificationDesc?.setNotificationTextLable(firstText: "Arnold Berry", SecondText: " is now following you")
         cell.vwPhotoMain?.isHidden = true
         cell.vwNotificationImgMain?.isHidden = true
         } else if indexPath.row == 3 {
         cell.lblNotificationDesc?.setNotificationTextLable(firstText: "Kevin Leonard ", SecondText: " has updated photo gallery")
         cell.vwPhotoMain?.isHidden = false
         cell.vwNotificationImgMain?.isHidden = true
         } else {
         cell.vwPhotoMain?.isHidden = true
         cell.lblNotificationDesc?.text = "Arnold Berry and 1 other posted on your talk page."
         cell.vwNotificationImgMain?.isHidden = true
         }*/
        
        if self.arrNotification.count > 0 {
            let obj = self.arrNotification[indexPath.row]
            cell.setNotificationData(obj: obj)
        }
        
        
        //cell.lblNotification?.addInterlineSpacing(spacingValue: 5.0)
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = tableView.dequeueReusableHeaderFooterView(NotificationHeaderCell.self)
        /*if self.arrFaq.count > 0 {
         let obj = self.arrFaq[section]
         //self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView" ) as! MapTableHeaderView
         hView?.lblHeader.text = obj.caregoryName
         }*/
        if self.arrNotification.count > 0 {
            hView?.lblHeader?.text = section == 0 ? "Recent" : "Older Notifications"
        } else {
            hView?.lblHeader?.text = ""
        }
        return hView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.arrNotification.count > 0 {
            let obj = self.arrNotification[indexPath.row]
            self.appNavigationController?.detachRightSideMenu()
            if obj.model == "userFollow" {
                self.appNavigationController?.push(ProfileViewController.self, configuration: { (vc) in
                    vc.selectedUserID = "\(obj.model_id)"
                    vc.isbtnsettinf = true
                    vc.isfromOther = true
                    vc.isbtnRefer = true
                    vc.isfromUpdateResume = true
                })
            } else if obj.model == "chatMessage" {
                self.appNavigationController?.push(MessageChatViewController.self, configuration: { (vc) in
                    vc.chatUserID = "\(obj.model_id)"
                })
            } else if obj.model == "orderPlaced" {
                self.appNavigationController?.push(OrderDetailViewController.self, configuration: { (vc) in
                    vc.ProductData = "\(obj.model_id)"
                })
            } else if obj.model == "orderCancelled" {
                self.appNavigationController?.push(OrderDetailViewController.self, configuration: { (vc) in
                    vc.ProductData = "\(obj.model_id)"
                })
            } else if obj.model == "userLike" {
                self.appNavigationController?.push(FeedLikeViewController.self, configuration: { (vc) in
                    vc.LikeId = "\(obj.model_id)"
                })
            } else if obj.model == "userComment" {
                self.appNavigationController?.push(FeedCommentViewController.self, configuration: { (vc) in
                    vc.CommentId = "\(obj.model_id)"
                })
            } else if obj.model == "eventBooked" {
                self.appNavigationController?.push(EventDetailsViewController.self, configuration: { (vc) in
                    vc.SelectedEventData = "\(obj.model_id)"
                    vc.isPublish = true
                })
            } else if obj.model == "userGalleryUpdate" {
                self.appNavigationController?.push(InsideAlbumViewController.self, configuration: { (vc) in
                    vc.selectedAlbumdata = "\(obj.model_id)"
                    
                })
            } else if obj.model == "userNewPost" {
                self.appNavigationController?.showDashBoardViewController()
            }
        }
        
    }
}



//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(for: indexPath, with: NotificationTVCell.self)
//    cell.selectionStyle = .none
//    let objNoti = self.arrNotificationList[indexPath.row]
//    if objNoti.model == "rsvpEventInvite" {
//        cell.stackBottom?.isHidden = false
//        cell.imgHeight?.constant = 120
//        cell.imgWidth?.constant = 100
//        cell.imgEvent?.layer.cornerRadius = 20.0
//        cell.imgEvent?.layer.masksToBounds = true
//    } else {
//        cell.stackBottom?.isHidden = true
//        cell.imgHeight?.constant = 80
//        cell.imgWidth?.constant = 80
//        cell.imgEvent?.layer.cornerRadius = 40.0
//        cell.imgEvent?.layer.masksToBounds = true
//    }
//    var first = ""
//    var second = ""
//    var third = ""
//    var four = ""
//    
//    var firstColor = ""
//    var secondColor = ""
//    var thirdColor = ""
//    var fourColor = ""
//    
//    let arrDesList = objNoti.descList
//    if arrDesList?.count != 0 {
//        for obj in arrDesList ?? [] {
//            if obj.color == "#000000" && obj.weight == "bold" {
//                let firstTemp = obj.text + " "
//                if (first == "") {
//                    first = firstTemp
//                    firstColor = obj.color
//                }
//            } else if obj.color == "#000000" && obj.weight == "normal" {
//                let secondTemp = obj.text + " "
//                if (second == "") {
//                    second = secondTemp
//                    secondColor = obj.color
//                }
//            } else if obj.color == "#FF5C33" && obj.weight == "bold" {
//                let thirdTemp = obj.text + " "
//                if (third == "") {
//                    third = thirdTemp
//                    thirdColor = obj.color
//                }
//            } else if obj.color == "#000000" && obj.weight == "normal" {
//                let fourTemp = obj.text + " "
//                if (four == "") {
//                    four = fourTemp
//                    fourColor = obj.color
//                }
//            }
//        }
//    }
//    if objNoti.status == "0" {
//        cell.vwBG?.backgroundColor = UIColor.white
//        
//    } else {
//        cell.vwBG?.backgroundColor = UIColor.CustomColor.selectGrayColor
//    }
//    cell.lblEventName?.setHomeHeaderAttributedText4(firstText: "\(first)", fc: "\(firstColor)", SecondText: "\(second)", sc: "\(secondColor)", ThirdText: "\(third)", tc: "\(thirdColor)", forthText: "\(four)", foc: "\(fourColor)")
//    cell.imgEvent?.setImage(withUrl: objNoti.image , placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.AppPlaceholder), indicatorStyle: UIActivityIndicatorView.Style.medium, isProgressive: true, imageindicator: .white)
//    cell.lblEventDateAndTime?.text = objNoti.time
//    cell.btnYes?.tag = indexPath.row
//    cell.btnYes?.addTarget(self, action: #selector(self.btnYesEventOnClick(_:)), for: .touchUpInside)
//    cell.btnNo?.tag = indexPath.row
//    cell.btnNo?.addTarget(self, action: #selector(self.btnNoEventOnClick(_:)), for: .touchUpInside)
//    cell.btnMaybe?.tag = indexPath.row
//    cell.btnMaybe?.addTarget(self, action: #selector(self.btnMaybeEventOnClick(_:)), for: .touchUpInside)
//    return cell
//}
//MARK: - SegmentTabDelegate
extension NotificationViewController : SegmentTabDelegate {
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: segementNotificationEnum(rawValue: sender.tag) ?? .All)
    }
    
    private func setSelectedTab(obj : segementNotificationEnum, isUpdateVC : Bool = true){
        switch obj {
        case .All:
            self.selecetdTab = .All
            self.vwAll?.isSelectTab = true
            self.vwSocial?.isSelectTab = false
            self.vwEvents?.isSelectTab = false
            self.vwShop?.isSelectTab = false
            break
            
        case .Social:
            self.selecetdTab = .Social
            self.vwAll?.isSelectTab = false
            self.vwSocial?.isSelectTab = true
            self.vwEvents?.isSelectTab = false
            self.vwShop?.isSelectTab = false
            
            
            break
        case .Events:
            self.selecetdTab = .Events
            self.vwAll?.isSelectTab = false
            self.vwSocial?.isSelectTab = false
            self.vwEvents?.isSelectTab = true
            self.vwShop?.isSelectTab = false
            
            
            break
        case .Shop:
            self.selecetdTab = .Shop
            self.vwAll?.isSelectTab = false
            self.vwSocial?.isSelectTab = false
            self.vwEvents?.isSelectTab = false
            self.vwShop?.isSelectTab = true
        }
        self.reloadTableData()
    }
}

extension NotificationViewController {
    
    private func getNotificationsListList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                klimit : "15",
                ktype : self.selecetdTab.apivalue
                
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            NotificationModel.getNotificationsListAPICall(with: param, isShowLoader: isshowloader, success: { (arr, totalpage,msg) in
                self.tblData?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                
                self.arrNotification.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
                self.tblData?.reloadData()
                self.tblData?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblData?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                    self.tblData?.reloadData()
                    self.tblData?.EmptyMessage(message: error)
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                        
                    }
                }
            })
        }
    }
}

// MARK: - IBAction
extension NotificationViewController {
    
}

// MARK: - ViewControllerDescribable
extension NotificationViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.DashBoard
    }
}

// MARK: - AppNavigationControllerInteractable
extension NotificationViewController: AppNavigationControllerInteractable { }

//
//  MyEventViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 15/02/22.
//

import UIKit

class MyEventViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var VWCreateEventMAinView: UIView?
 
    @IBOutlet weak var vwCreateEvent: SegmentTabView?
    @IBOutlet weak var vwFavourite: SegmentTabView?
    @IBOutlet weak var vwCreateEventMain: UIView?
    @IBOutlet weak var vwCreateEventSub: UIView?
    @IBOutlet weak var vwCreateEventBG: UIView?
    @IBOutlet weak var constrainttblEventHeight: NSLayoutConstraint?
   
    @IBOutlet weak var btnCreateEvent: UIButton?
    @IBOutlet weak var btnCreateEventNext: UIButton?
    
    @IBOutlet weak var lblCreateEvent: UILabel?
    @IBOutlet weak var tblEvent: UITableView?
   
    @IBOutlet weak var imgCreateEvent: UIImageView?
   
    @IBOutlet weak var vwnodatafound: UIView?
    @IBOutlet weak var LblNoEventFound: NoDataFoundLabel?
  
    // MARK: - Variables
  
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    
    private var arrEvent : [EventModel] = []
    private var arrCreateEvent : [EventModel] = []
    private var selecetdTab : SegemnentMyeventEnum = .CreatedEvents
    // MARK: - LIfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        
        if let vw = self.btnCreateEventNext {
            vw.cornerRadius = vw.frame.height / 2.0
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableviewOberver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
       
    }
}

// MARK: - Init Configure
extension MyEventViewController {
  private func InitConfig(){
      
      self.btnCreateEventNext?.backgroundColor = UIColor.CustomColor.whitecolor
      self.vwCreateEventBG?.backgroundColor = UIColor.CustomColor.black39Per
      self.lblCreateEvent?.setHomeQuotesAttributedText(firstText: "Create an event", SecondText: "\nBuild an event according to your preferences.")
      
      [self.vwCreateEventSub,self.vwCreateEventBG,self.imgCreateEvent].forEach({
          $0?.cornerRadius = 25.0
      })
      
      [self.vwCreateEvent,self.vwFavourite].forEach({
          $0?.segmentDelegate = self
      })
      
      self.vwCreateEvent?.btnSelectTab?.tag = SegemnentMyeventEnum.CreatedEvents.rawValue
      self.vwFavourite?.btnSelectTab?.tag = SegemnentMyeventEnum.Favorites.rawValue
      
     
      
    self.setSelectedTab(obj: .CreatedEvents, isUpdateVC: false)

  
      if self.selecetdTab == .CreatedEvents {
          self.LblNoEventFound?.text = "No Event Found!"
      }
      else if  self.selecetdTab == .Favorites {
          self.LblNoEventFound?.text = "No Favorite Event Found!"
      }
      
      
      self.tblEvent?.register(EventCell.self)
    
      self.tblEvent?.estimatedRowHeight = 100.0
      self.tblEvent?.rowHeight = UITableView.automaticDimension
      self.tblEvent?.delegate = self
      self.tblEvent?.dataSource = self
      
      self.tblEvent?.reloadData()
      self.setupESInfiniteScrollinWithTableView()

  }
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "My Events", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }

}

////MARK: Pagination tableview Mthonthd
extension MyEventViewController {

    private func reloadEventData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrEvent.removeAll()
        self.tblEvent?.reloadData()
        self.getMyEventList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblEvent?.es.addPullToRefresh {
            [unowned self] in
            self.reloadEventData()
        }

        self.tblEvent?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getMyEventList()
                } else if self.pageNo <= self.totalPages {
                    self.getMyEventList(isshowloader: false)
                } else {
                    self.tblEvent?.es.noticeNoMoreData()
                }
            } else {
                self.tblEvent?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblEvent?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblEvent?.es.noticeNoMoreData()
            }
            else {
                self.tblEvent?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblEvent?.es.stopLoadingMore()
            self.tblEvent?.es.noticeNoMoreData()
            self.isLoading = true
        }

    }
}
//MARK: - Tableview Observer
extension MyEventViewController {

    private func addTableviewOberver() {
        self.tblEvent?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
      
    }

    func removeTableviewObserver() {
        if self.tblEvent?.observationInfo != nil {
            self.tblEvent?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
       
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if let obj = object as? UITableView {
            if obj == self.tblEvent && keyPath == ObserverName.kcontentSize {
                self.constrainttblEventHeight?.constant = self.tblEvent?.contentSize.height ?? 0.0
            }
        }
        
        
    }
    
}


//MARK:- UITableView Delegate
extension MyEventViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selecetdTab {
        case .CreatedEvents:
            return self.arrEvent.count
        case .Favorites:
            return self.arrEvent.count
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
            let cell = tableView.dequeueReusableCell(for: indexPath, with: EventCell.self)
            switch selecetdTab {
            case .CreatedEvents:
                cell.SetCreateEventData(obj: self.arrEvent[indexPath.row])
            case .Favorites:
                cell.SetFavoritesData(obj: self.arrEvent[indexPath.row])
                cell.Delegate = self
        
            }
          
        return cell
            
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selecetdTab {
        case .CreatedEvents:
            if self.arrEvent.count > 0 {
                self.appNavigationController?.push(EventDetailsViewController.self,configuration: { vc in
                    vc.isFromCreateEvent = true
                    vc.isBookview = true
                    vc.isDateview = true
                    vc.isMyBookview = true
                    vc.SelectedEventData = self.arrEvent[indexPath.row].id
                })
            }
        case .Favorites:
            return
        }
    }
   
}
//MARK: - SegmentTabDelegate
extension MyEventViewController : SegmentTabDelegate {
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: SegemnentMyeventEnum(rawValue: sender.tag) ?? .CreatedEvents)
    }
    
    private func setSelectedTab(obj : SegemnentMyeventEnum, isUpdateVC : Bool = true){
        switch obj {
        case .CreatedEvents:
            self.selecetdTab = .CreatedEvents
            self.vwCreateEvent?.isSelectTab = true
            self.vwFavourite?.isSelectTab = false
            self.vwCreateEventMain?.isHidden = false
            break
            
        case .Favorites:
            self.selecetdTab = .Favorites
            self.vwCreateEvent?.isSelectTab = false
            self.vwFavourite?.isSelectTab = true
            self.vwCreateEventMain?.isHidden = true
            break
        
        }
        self.reloadEventData()
    }
}


//MARK: - API Call
extension MyEventViewController {
    
    private func getMyEventList(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault() {
       
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kPageNo : "\(self.pageNo)",
           klimit : "10",
           kisType : self.selecetdTab.apivalue
          
           
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

           EventModel.MyEvent(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
               self.tblEvent?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrCreateEvent.append(contentsOf: arr)
               self.arrEvent.append(contentsOf: arr)
               self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
               self.pageNo = self.pageNo + 1
               self.LblNoEventFound?.isHidden = self.arrEvent.count == 0 ? false : true
               self.tblEvent?.reloadData()
              
               self.tblEvent?.EmptyMessage(message: "")
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.tblEvent?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.hideFooterLoading(success: false)
               if statuscode == APIStatusCode.NoRecord.rawValue {
                
                   self.tblEvent?.reloadData()
                   self.tblEvent?.EmptyMessage(message: error)
               } else {
                   if !error.isEmpty {
                       self.showMessage(error, themeStyle: .error)
                     
                   }
               }
           })
       }
   }
    
    
    private func setEventlike(isFavourite : String,eventId : String){
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                keventId : eventId,
                kfavorite : isFavourite
            ]

            let param : [String:Any] = [
                kData : dict
            ]

            EventModel.setEventlike(with: param, success: { (msg) in
                self.reloadEventData()
                self.tblEvent?.reloadData()
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
}


// MARK: - FeedCellDelegate
extension MyEventViewController : EventCellDelegate {
    func btnLikeSelect(btn: UIButton, cell: EventCell) {
        self.view.endEditing(true)
        if let indexpath = self.tblEvent?.indexPath(for: cell) {
            if self.arrEvent.count > 0 {
                let obj =   self.arrEvent[indexpath.row]
                obj.isFavourite = btn.isSelected ? "1" : "0"
                self.setEventlike(isFavourite: btn.isSelected ? "1" : "0", eventId: self.arrEvent[indexpath.row].eventId)
                self.tblEvent?.reloadData()
            }
           
        }
    }
}

//MARK: - IBAction Method
extension MyEventViewController {
    
    @IBAction func btncreateEventClick() {
        self.appNavigationController?.push(CreateEventViewController.self)
       
    }

}
// MARK: - ViewControllerDescribable
extension MyEventViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension MyEventViewController: AppNavigationControllerInteractable { }

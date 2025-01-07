//
//  EventsViewController.swift
//  Rosterd
//
//  Created by WM-KP on 08/01/22.
//

import UIKit

class EventsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwCreateEventMain: UIView?
    @IBOutlet weak var vwCreateEventSub: UIView?
    @IBOutlet weak var vwCreateEventBG: UIView?
    @IBOutlet weak var lblCreateEvent: UILabel?
    @IBOutlet weak var btnCreateEventNext: UIButton?
    @IBOutlet weak var btnCreateEvent: UIButton?
    @IBOutlet weak var imgCreateEvent: UIImageView?
    
    @IBOutlet weak var vwMyEventMain: UIView?
    @IBOutlet weak var vwMyEventBG: UIView?
    @IBOutlet weak var imgMyEvent: UIImageView?
    @IBOutlet weak var lblMyEvent: UILabel?
    @IBOutlet weak var btnMyEvent: UIButton?
    
    @IBOutlet weak var vwMyBookingMain: UIView?
    @IBOutlet weak var vwMyBookingBG: UIView?
    @IBOutlet weak var imgMyBooking: UIImageView?
    @IBOutlet weak var lblMyBooking: UILabel?
    @IBOutlet weak var btnMyBooking: UIButton?
    
    @IBOutlet weak var vwSearch: SearchView?
    
    @IBOutlet weak var vwCategoryMain: UIView?
    @IBOutlet weak var cvCategory: UICollectionView?
    
    @IBOutlet weak var vwCalenderMain: UIView?
    @IBOutlet weak var cvCalender: UICollectionView?
    
    @IBOutlet weak var vwnodata: UIView?
    @IBOutlet weak var lblNoData: NoDataFoundLabel?
    
    @IBOutlet weak var tblEvent: UITableView?
    @IBOutlet weak var constrainttblEventHeight: NSLayoutConstraint?
    
    @IBOutlet weak var vweventCart: UIView?
    @IBOutlet weak var vwnotification: UIView?
    @IBOutlet weak var lblshowcount: UILabel?
    @IBOutlet weak var btnCart: UIButton?
    
  
    // MARK: - Variables
    private var arrCategory : [EventCategoryModel] = []
    private var selectedEventCatergory : EventCategoryModel?
    private var selectedEventDate : EventModel?
    private var selectedCategoryIndex : Int = 0
    private var arrDates : [Date] = []
     var selectedDate : Date = Date()
   
    private var arrEvent : [EventModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstant.DateFormat.k_YYYY_MM_dd
        return formatter
    }()
    var isFromTodayDate: Bool = true
    
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
        self.reloadEventData()
        self.addTableviewOberver()
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.scrollToDate(date: self.selectedDate)
    }
}
// MARK: - Init Configure
extension EventsViewController {
    private func InitConfig(){
        self.vwnotification?.isHidden = true
        
//        self.vweventCart?.isHidden = true
        
        if let vweventCart = self.vweventCart {
            vweventCart.cornerRadius = vweventCart.frame.height/2
            vweventCart.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vweventCart.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if let  vwnotification = self.vwnotification {
            vwnotification.cornerRadius = vwnotification.frame.height/2
            vwnotification.backgroundColor = UIColor.CustomColor.profilebgColor
        }
        
        
        self.lblshowcount?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 11.0))
        self.lblshowcount?.textColor = UIColor.CustomColor.whitecolor
        
        self.vwSearch?.btnClearClickBlock = {
            self.view.endEditing(true)
            self.reloadEventData()
        }
        
        self.vwSearch?.txtSearch?.returnKeyType = .search
        self.vwSearch?.txtSearch?.delegate = self
        self.vwSearch?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
      
        self.cvCategory?.register(EventCatagoryCell.self)
        self.cvCategory?.delegate = self
        self.cvCategory?.dataSource = self
        self.getEventCategoryListAPICall()
        self.cvCalender?.register(DateCollectionViewCell.self)
        self.cvCalender?.delegate = self
        self.cvCalender?.dataSource = self
        
        self.tblEvent?.register(EventCell.self)
        self.tblEvent?.estimatedRowHeight = 100.0
        self.tblEvent?.rowHeight = UITableView.automaticDimension
        self.tblEvent?.delegate = self
        self.tblEvent?.dataSource = self
        
        self.tblEvent?.reloadData()
        
        self.btnCreateEventNext?.backgroundColor = UIColor.CustomColor.whitecolor
        self.vwCreateEventBG?.backgroundColor = UIColor.CustomColor.black39Per
        self.vwMyEventBG?.backgroundColor = UIColor.CustomColor.black39Per
        self.vwMyBookingBG?.backgroundColor = UIColor.CustomColor.black39Per
        self.lblCreateEvent?.setHomeQuotesAttributedText(firstText: "Create an event", SecondText: "\nBuild an event according to your preferences.")
        
        [self.vwCreateEventSub,self.vwCreateEventBG,self.imgCreateEvent,self.vwMyEventMain,self.imgMyEvent,self.vwMyEventBG,self.vwMyBookingMain,self.imgMyBooking,self.vwMyBookingBG].forEach({
            $0?.cornerRadius = 25.0
        })
        
        [self.lblMyEvent,self.lblMyBooking].forEach({
            $0?.textColor = UIColor.CustomColor.whitecolor
            $0?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 18.0))
        })
        
        self.displayDate(date: self.selectedDate)
        
        self.setupESInfiniteScrollinWithTableView()
      
        
        self.tblEvent?.reloadData()
    }
    
    func scrollToDate(date: Date)
    {
        print("will scroll to today")
        let startDate = UsedDates.shared.startDate
        let cal = Calendar.current
        if let numberOfDays = cal.dateComponents([.day], from: startDate, to: date).day {
            let extraDays: Int = numberOfDays % 7 // will = 0 for Mondays, 1 for Tuesday, etc ..
            let scrolledNumberOfDays = numberOfDays - extraDays
            let firstMondayIndexPath = IndexPath(row: scrolledNumberOfDays, section: 0)
            self.cvCalender?.scrollToItem(at: firstMondayIndexPath, at: .left , animated: false)
           
        }
        displayDate(date: date)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        displayWeek()
    }
    
    func displayWeek() {
        if let cv = self.cvCalender {
            var visibleCells = cv.visibleCells
            visibleCells.sort { (cell1: UICollectionViewCell, cell2: UICollectionViewCell) -> Bool in
                guard let cell1 = cell1 as? DateCollectionViewCell else {
                    return false
                }
                guard let cell2 = cell2 as? DateCollectionViewCell else {
                    return false
                }
                let result = (cell1.selecteDate ?? Date()).compare(cell2.selecteDate ?? Date())
                return result == ComparisonResult.orderedAscending
                
            }
            let middleIndex = visibleCells.count / 2
            if let middleCell = visibleCells[middleIndex] as? DateCollectionViewCell {
                
                let displayedDate = UsedDates.shared.getDateOfAnotherDayOfTheSameWeek(selectedDate: middleCell.selecteDate ?? Date(), requiredDayOfWeek: UsedDates.shared.selectdDayOfWeek)
                displayDate(date: displayedDate)
            }
        }
    }
    
    func selectCell(cell: DateCollectionViewCell) {
        //if let selectedCellDate = cell.selecteDate {
        displayDate(date: self.selectedDate)
        //}
    }
    
    func displayDate(date: Date) {
        UsedDates.shared.displayedDate = date
        UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: date)
        
    }
}
//
////MARK: Pagination tableview Mthonthd
extension EventsViewController {

    private func reloadEventData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrEvent.removeAll()
        self.tblEvent?.reloadData()
        self.getEventDashboardList(date: "", EventCategory: "")
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
                    self.getEventDashboardList(date: "", EventCategory: "")
                } else if self.pageNo <= self.totalPages {
                    self.getEventDashboardList(isshowloader: false, date: "", EventCategory: "")
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
extension EventsViewController {
    
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
extension EventsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrEvent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: EventCell.self)
        if self.arrEvent.count > 0 {
            cell.SetEventData(obj: self.arrEvent[indexPath.row])
         
            cell.Delegate = self
            cell.btnLike?.tag = indexPath.row
            cell.btnLike?.addTarget(self, action: #selector(self.btnLikeClicked(_:)), for: .touchUpInside)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if self.arrEvent.count > 0 {
            let obj = self.arrEvent[indexPath.row]
            self.appNavigationController?.push(EventDetailsViewController.self,configuration: { vc in
                vc.SelectedEventData = self.arrEvent[indexPath.row].id
                vc.EventUrl = self.arrEvent[indexPath.row].shareLink
                vc.isPublish = true
                vc.ispaid = obj.isPaid
            })
        }
    }
    
    @objc func btnLikeClicked(_ sender : UIButton){
        if self.arrEvent.count > 0 {
            self.appNavigationController?.detachRightSideMenu()
        }
    }
}
//MARK: - UICollectionView Delegate and Datasource Method
extension EventsViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvCalender {
            return 9999
        } else {
            return self.arrCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvCalender {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DateCollectionViewCell.self)
            let addedDays = indexPath.row
            var addedDaysDateComp = DateComponents()
            addedDaysDateComp.day = addedDays//calculating the date of the given cell
            let currentCellDate = Calendar.current.date(byAdding: addedDaysDateComp , to: UsedDates.shared.startDate)
        
            if self.isFromTodayDate == true {
                let date = Date()
                let format = date.getFormattedDate(format: "yyyy-MM-dd")
                let format1 = currentCellDate?.getFormattedDate(format: "yyyy-MM-dd")
                delay(seconds: 0.5) {
                    if format == format1 {
                        cell.isSelectCell = true
                        cell.lblDate?.textColor = UIColor.white
                    } else {
                        cell.isSelectCell = false
                        cell.lblDate?.textColor = UIColor.black
                    }
                }
                if let cellDate = currentCellDate {
                    cell.selecteDate = cellDate
                    let dayOfMonth = Calendar.current.component(.day, from: cellDate)
                    let dayOfWeek = Calendar.current.component(.weekday, from: cellDate)
                    cell.isSelectCell = self.selectedDate == cellDate
                    cell.lblDate?.setSelectDateAttributedText(firstText: String(describing: UsedDates.shared.getDayOfWeekLetterFromDayOfWeekNumber(dayOfWeekNumber: dayOfWeek)), SecondText: "\n\(String(describing: dayOfMonth))", isSelectCell: self.selectedDate == cellDate)
                } else {
                    cell.isSelectCell = false
                }
            } else {
                if let cellDate = currentCellDate {
                    cell.selecteDate = cellDate
                    let dayOfMonth = Calendar.current.component(.day, from: cellDate)
                    let dayOfWeek = Calendar.current.component(.weekday, from: cellDate)
                    cell.isSelectCell = self.selectedDate == cellDate
                    cell.lblDate?.setSelectDateAttributedText(firstText: String(describing: UsedDates.shared.getDayOfWeekLetterFromDayOfWeekNumber(dayOfWeekNumber: dayOfWeek)), SecondText: "\n\(String(describing: dayOfMonth))", isSelectCell: self.selectedDate == cellDate)
                } else {
                    cell.isSelectCell = false
                }
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: EventCatagoryCell.self)
            if self.arrCategory.count > 0 {
                cell.SetEventCategoryData(obj: self.arrCategory[indexPath.row])
                cell.isSelectCell = (self.selectedCategoryIndex == indexPath.row)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.cvCalender {
            return 10.0
        } else {
            return 10.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.cvCalender {
            return CGSize(width: collectionView.bounds.width/5, height: collectionView.bounds.height)
        } else {
            var fontsize: CGFloat = 0.0
            if self.arrCategory.count > 0 {
                let obj = self.arrCategory[indexPath.row]
                fontsize = obj.name.widthOfString(usingFont: (self.selectedCategoryIndex == indexPath.row) ? UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)) : UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0)))
            }
            return CGSize(width: fontsize + 20.0, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.cvCategory {
            if self.arrCategory.count > 0 {
                let objCategory = self.arrCategory[indexPath.row]
                self.getEventDashboardList(date: "", EventCategory: objCategory.id )
                self.pageNo = 1
                self.arrEvent.removeAll()
                self.tblEvent?.reloadData()
                self.selectedCategoryIndex = indexPath.row
                self.cvCategory?.reloadData()
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
                self.isFromTodayDate = false
                UsedDates.shared.displayedDate = cell.selecteDate
                UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: cell.selecteDate)
                self.selectedDate = cell.selecteDate
                let date = formatter.string(from: cell.selecteDate)
                let yourDate = formatter.date(from: date)
                let myStringDate = formatter.string(from: yourDate!)
                self.pageNo = 1
                self.arrEvent.removeAll()
                self.tblEvent?.reloadData()
                self.getEventDashboardList(date: myStringDate, EventCategory: "")
                self.cvCalender?.reloadData()
            }
        }
    }
}

extension Date {

 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: Date())

    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
// MARK: - UITextFieldDelegate
extension EventsViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if !(textField.isEmpty) {
            self.reloadEventData()
           
        }
        return true
    }
    
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        if textField.isEmpty {
            self.reloadEventData()
        }
    }
}
//MARK: - API Call
extension EventsViewController {
    
    private func getEventDashboardList(isshowloader :Bool = true, date : String, EventCategory : String){
   if let user = UserModel.getCurrentUserFromDefault() {
       
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kPageNo : "\(self.pageNo)",
           klimit : "10000",
           kcategoryId : EventCategory,
           ksearch : self.vwSearch?.txtSearch?.text ?? "",
           keventDate : date

       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

           EventModel.EventDashbaord(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
               self.tblEvent?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage

               self.arrEvent.append(contentsOf: arr)
               self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
               self.pageNo = self.pageNo + 1
               self.lblNoData?.isHidden = self.arrEvent.count == 0 ? false : true
               self.tblEvent?.reloadData()
               self.tblEvent?.EmptyMessage(message: "")
               self.vwnodata?.isHidden = true
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.tblEvent?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.hideFooterLoading(success: false)
               if statuscode == APIStatusCode.NoRecord.rawValue {
                  
                   self.tblEvent?.EmptyMessage(message: error)
                   self.lblNoData?.text = error
                   self.vwnodata?.isHidden = false
                   self.lblNoData?.isHidden = self.arrEvent.count == 0 ? false : true
                   self.tblEvent?.reloadData()
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
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
    private func getEventCategoryListAPICall() {
            if let user = UserModel.getCurrentUserFromDefault() {
                let dict : [String:Any] = [
                    klangType : Rosterd.sharedInstance.languageType,
                    ktoken : user.token
                ]
                let param : [String:Any] = [
                    kData : dict
                ]
                EventCategoryModel.getcatergoryData(with: param, success: { (arr,msg) in
                    self.arrCategory = arr
                    self.cvCategory?.reloadData()
                }, failure: {[unowned self] (statuscode,error, errorType) in
                    print(error)
                    if !error.isEmpty {
                        self.showMessage(error,themeStyle : .error)
                    }
                })
        }
    }
}
// MARK: - FeedCellDelegate
extension EventsViewController : EventCellDelegate {
    func btnLikeSelect(btn: UIButton, cell: EventCell) {
        self.view.endEditing(true)
        if let indexpath = self.tblEvent?.indexPath(for: cell) {
            if self.arrEvent.count > 0 {
                let obj = self.arrEvent[indexpath.row]
                obj.isFavourite = btn.isSelected ? "1" : "0"
                self.setEventlike(isFavourite: btn.isSelected ? "1" : "0", eventId: self.arrEvent[indexpath.row].id)
                self.tblEvent?.reloadData()
            }
           
        }
    }
}

//MARK: - IBAction Method
extension EventsViewController {
    
    @IBAction func btnEventcreateClick() {
        self.appNavigationController?.push(CreateEventViewController.self)
       
    }
    
    @IBAction func btnMyBooklingClick() {
        self.appNavigationController?.push(MyBookingViewController.self)
    }
    
    
    @IBAction func btnMyEventClick() {
        self.appNavigationController?.push(MyEventViewController.self)
    }
        
    @IBAction func btnEventCartClick() {
//        self.appNavigationController?.push(EventTicketListViewController.self)
        self.appNavigationController?.push(EventMyCartViewController.self, configuration: { vc in
        })
    }
}

// MARK: - ViewControllerDescribable
extension EventsViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension EventsViewController: AppNavigationControllerInteractable { }





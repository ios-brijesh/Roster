//
//  MyBookingViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 09/02/22.
//

import UIKit

class MyBookingViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var vwCalenderMain: UIView?
    @IBOutlet weak var vwAll: SegmentTabView?
    @IBOutlet weak var vwBooked: SegmentTabView?
    @IBOutlet weak var vwRSCPd: SegmentTabView?
    
    @IBOutlet weak var LblNodata: NoDataFoundLabel?
    @IBOutlet weak var vwNodata: UIView?
    @IBOutlet weak var tblEvent: UITableView?
    @IBOutlet weak var constrainttblEventHeight: NSLayoutConstraint?
    @IBOutlet weak var CvCalender: UICollectionView?
    
    
    // MARK: - Variables
    private var selectedDate : Date = Date()
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    private var arrBookEvent : [EventModel] = []
    private var selecetdTab : SegemnetMyBookingEnum = .All
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
        self.scrollToDate(date: self.selectedDate)
    }
}


// MARK: - Init Configure
extension MyBookingViewController {
  private func InitConfig(){
      
      self.vwAll?.btnSelectTab?.tag = SegemnetMyBookingEnum.All.rawValue
      self.vwBooked?.btnSelectTab?.tag = SegemnetMyBookingEnum.Booked.rawValue
      self.vwRSCPd?.btnSelectTab?.tag = SegemnetMyBookingEnum.RSVPd.rawValue
      
      
      [self.vwAll,self.vwBooked,self.vwRSCPd].forEach({
          $0?.segmentDelegate = self
      })
      
    self.setSelectedTab(obj: .All, isUpdateVC: false)

        self.CvCalender?.register(DateCollectionViewCell.self)
        self.CvCalender?.delegate = self
        self.CvCalender?.dataSource = self
      
      
      
      self.tblEvent?.register(EventCell.self)
      self.tblEvent?.estimatedRowHeight = 100.0
      self.tblEvent?.rowHeight = UITableView.automaticDimension
      self.tblEvent?.delegate = self
      self.tblEvent?.dataSource = self
    
      
        self.displayDate(date: self.selectedDate)

       
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            displayWeek()
        }

        func displayWeek() {
            if let cv = self.CvCalender {
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
      
      self.tblEvent?.reloadData()
      self.setupESInfiniteScrollinWithTableView()
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
            self.CvCalender?.scrollToItem(at: firstMondayIndexPath, at: .left , animated: false)
        }
        displayDate(date: date)
    }

    
    
    
        func selectCell(cell: DateCollectionViewCell) {
            //if let selectedCellDate = cell.selecteDate {
            displayDate(date: self.selectedDate)
            //}
        }

        func displayDate(date: Date) {
            UsedDates.shared.displayedDate = date
            UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: date) //so that if the selected date is Wednesday, it keeps selecting Wednesday next week
            //self.selectedDate.text = UsedDates.shared.displayedDateString
        }

  
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "My Bookings", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
    
   }

////MARK: Pagination tableview Mthonthd
extension MyBookingViewController {

    private func reloadMyBookEventData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrBookEvent.removeAll()
        self.tblEvent?.reloadData()
        self.MyBookEventList(date: "")
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {

        self.tblEvent?.es.addPullToRefresh {
            [unowned self] in
            self.reloadMyBookEventData()
        }

        self.tblEvent?.es.addInfiniteScrolling {

            if !self.isLoading {
                if self.pageNo == 1 {
                    self.MyBookEventList(date: "")
                } else if self.pageNo <= self.totalPages {
                    self.MyBookEventList(isshowloader: false, date: "")
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
extension MyBookingViewController {

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
extension MyBookingViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBookEvent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: EventCell.self)
        if self.arrBookEvent.count > 0 {
            cell.setMyBookEventData(obj: self.arrBookEvent[indexPath.row])
            cell.Delegate = self
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.arrBookEvent.count > 0 {
            let obj = self.arrBookEvent[indexPath.row].eventId
            self.appNavigationController?.push(EventTicketListViewController.self,configuration: { vc in
                vc.Ticketid = obj
            })
//            self.appNavigationController?.push(EventTicketListViewController.self)
        }
    }
}
//MARK: - UICollectionView Delegate and Datasource Method
extension MyBookingViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.CvCalender {
            return 9999
        }
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.CvCalender {
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
        }
       return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.CvCalender {
            return 10.0
        }
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.CvCalender {
            return CGSize(width: collectionView.bounds.width/5, height: collectionView.bounds.height)
        }
        
        return CGSize.zero
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.CvCalender {
            if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
                self.isFromTodayDate = false
                UsedDates.shared.displayedDate = cell.selecteDate
                UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: cell.selecteDate)
                //selectedDate.text = UsedDates.shared.displayedDateString
                self.selectedDate = cell.selecteDate
                let date = formatter.string(from: cell.selecteDate)
                let yourDate = formatter.date(from: date)
                let myStringDate = formatter.string(from: yourDate!)
                self.pageNo = 1
                self.arrBookEvent.removeAll()
                self.tblEvent?.reloadData()
                self.MyBookEventList(date: myStringDate)
                print("Selected Date: \(UsedDates.shared.displayedDateString)")
                self.CvCalender?.reloadData()
            }
        }
       
    }
}
//MARK: - SegmentTabDelegate
extension MyBookingViewController : SegmentTabDelegate {
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: SegemnetMyBookingEnum(rawValue: sender.tag) ?? .All)
    }
    
    private func setSelectedTab(obj : SegemnetMyBookingEnum, isUpdateVC : Bool = true){
        switch obj {
        case .All:
            self.selecetdTab = .All
            self.vwAll?.isSelectTab = true
            self.vwBooked?.isSelectTab = false
            self.vwRSCPd?.isSelectTab = false
            break
        case .Booked:
            self.selecetdTab = .Booked
            self.vwAll?.isSelectTab = false
            self.vwBooked?.isSelectTab = true
            self.vwRSCPd?.isSelectTab = false
      
    
            break
        case .RSVPd:
            self.selecetdTab = .RSVPd
            self.vwAll?.isSelectTab = false
            self.vwBooked?.isSelectTab = false
            self.vwRSCPd?.isSelectTab = true
     
            break
        }
        self.reloadMyBookEventData()
    }
}


// MARK: - EventCellDelegate
extension MyBookingViewController : EventCellDelegate {
    func btnLikeSelect(btn: UIButton, cell: EventCell) {
        self.view.endEditing(true)
        if let indexpath = self.tblEvent?.indexPath(for: cell) {
            if self.arrBookEvent.count > 0 {
                let obj = self.arrBookEvent[indexpath.row]
                obj.isFavourite = btn.isSelected ? "1" : "0"
                self.setEventlike(isFavourite: btn.isSelected ? "1" : "0", eventId: self.arrBookEvent[indexpath.row].id)
                self.tblEvent?.reloadData()
            }
           

        }
    }
    
    
}

//MARK: - API Call
extension MyBookingViewController {
    
    private func MyBookEventList(isshowloader :Bool = true, date : String){
   if let user = UserModel.getCurrentUserFromDefault() {
       
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kPageNo : "\(self.pageNo)",
           klimit : "10",
           keventpaidType : self.selecetdTab.apivalue,
           keventDate : date
        
          
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

           EventModel.MyBookEvent(with: param, isShowLoader: isshowloader,  success: { (arr,totalpage,msg) in
               //self.arrFeed.append(contentsOf: arr)
               self.tblEvent?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrBookEvent.append(contentsOf: arr)
            
//               self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
               self.pageNo = self.pageNo + 1
               self.LblNodata?.isHidden = self.arrBookEvent.count == 0 ? false : true
               self.tblEvent?.reloadData()
               self.vwNodata?.isHidden = true
               self.tblEvent?.EmptyMessage(message: "")
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.tblEvent?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
//               self.hideFooterLoading(success: false)
               if statuscode == APIStatusCode.NoRecord.rawValue {
                   self.vwNodata?.isHidden = false
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
                keventId : eventId
            ]

            let param : [String:Any] = [
                kData : dict
            ]

            EventModel.setEventlike(with: param, success: { (msg) in
                self.reloadMyBookEventData()
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }

}
// MARK: - ViewControllerDescribable
extension MyBookingViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Events
    }
}

// MARK: - AppNavigationControllerInteractable
extension MyBookingViewController: AppNavigationControllerInteractable { }

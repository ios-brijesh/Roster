//
//  MessageViewController.swift
//  Rosterd
//
//  Created by WM-KP on 08/01/22.
//

import UIKit


enum SegmentMessageTabEnum : Int{
    case Message
    case Request
    case Archieve
    
    var apiValue : String{
        switch self {
        case .Message:
            return "1"
        case .Request:
            return "2"
        case .Archieve:
            return "3"
        }
    }
}

class MessageViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwContainerMain: UIView?
    @IBOutlet weak var vwContentMain: UIView?
    @IBOutlet weak var vwSearchview: SearchView?
    @IBOutlet weak var vwMessage: SegmentTabView?
    @IBOutlet weak var vwRequest: SegmentTabView?
    @IBOutlet weak var vwArchieve: SegmentTabView?
    
    // MARK: - Variables
    private var selecetdTab : SegmentMessageTabEnum = .Message
    
    let tabs = [
        ViewPagerTab(title: "Message", image: nil),
        ViewPagerTab(title: "Request", image: nil),
        ViewPagerTab(title: "Archieve", image: nil)
    ]
    private var options = ViewPagerOptions()
    private var pager:ViewPager?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.configureNavigationBar()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
    
    }
}


// MARK: - Init Configure
extension MessageViewController {
    private func InitConfig(){
        
        self.vwMessage?.btnSelectTab?.tag = SegmentMessageTabEnum.Message.rawValue
        self.vwRequest?.btnSelectTab?.tag = SegmentMessageTabEnum.Request.rawValue
        self.vwArchieve?.btnSelectTab?.tag = SegmentMessageTabEnum.Archieve.rawValue
        
        [self.vwMessage,self.vwRequest,self.vwArchieve].forEach({
            $0?.segmentDelegate = self
        })
        
        self.vwSearchview?.txtSearch?.returnKeyType = .search
        self.vwSearchview?.txtSearch?.delegate = self
        self.vwSearchview?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
        
        self.setSelectedTab(obj: .Message)
        
        self.vwSearchview?.btnClearClickBlock = {
            self.vwSearchview?.txtSearch?.resignFirstResponder()
            //if self.vwSearch?.txtSearch?.text != "" {
                NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kSearchChatClick), object: "", userInfo: nil)
            //}
        }
        
        
        self.options.tabType = .basic
        self.options.distribution = .normal
        
        
        self.pager = ViewPager(viewController: self, containerView: self.vwContainerMain)//ViewPager(viewController: self)
        self.options.tabViewHeight = 0.0
        self.options.isTabIndicatorAvailable = false
        self.pager?.setOptions(options: self.options)
        self.pager?.setDataSource(dataSource: self)
        self.pager?.setDelegate(delegate: self)
        self.pager?.build()
        
      
       
    }
}


//MARK:- UITableView Delegate
extension MessageViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: MessageCell.self)
        cell.isSelectedTab = self.selecetdTab
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.appNavigationController?.detachLeftSideMenu()
//        self.appNavigationController?.push(SessionDetailViewController.self)
//    }
}

//MARK:- SegmentTabDelegate
extension MessageViewController : SegmentTabDelegate {
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: SegmentMessageTabEnum(rawValue: sender.tag) ?? .Message)
        
    }  
    private func setSelectedTab(obj : SegmentMessageTabEnum, isUpdateVC : Bool = true){
        switch obj {
        case .Message:
            self.selecetdTab = .Message
            self.vwMessage?.isSelectTab = true
            self.vwRequest?.isSelectTab = false
            self.vwArchieve?.isSelectTab = false
            //self.tblSession?.reloadData()
            break
        case .Request:
            self.selecetdTab = .Request
            self.vwMessage?.isSelectTab = false
            self.vwRequest?.isSelectTab = true
            self.vwArchieve?.isSelectTab = false
            //self.tblSession?.reloadData()
            break
        case .Archieve:
            self.selecetdTab = .Archieve
            self.vwMessage?.isSelectTab = false
            self.vwRequest?.isSelectTab = false
            self.vwArchieve?.isSelectTab = true
            //self.tblSession?.reloadData()
            break
        }
        if isUpdateVC {
            self.pager?.displayViewController(atIndex: obj.rawValue)
        }
    }
}


// MARK: - UITextFieldDelegate
extension MessageViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if !(textField.isEmpty) {
            //self.reloadCarGiverData()
            NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kSearchChatClick), object: textField.text ?? "", userInfo: nil)
        }
        return true
    }
    
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        if textField.isEmpty {
            //self.reloadCarGiverData()
            NotificationCenter.default.post(name: Notification.Name(NotificationPostname.kSearchChatClick), object: textField.text ?? "", userInfo: nil)
        }
    }
}

// MARK: - ViewPagerDataSource
extension MessageViewController: ViewPagerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        
        if let vc = self.storyboard?.getViewController(with: VCIdentifier.kMessageChildViewController) as? MessageChildViewController {
            vc.selecetdTab = SegmentMessageTabEnum(rawValue: position) ?? .Message
            
            return vc
        }
        return UIViewController()
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

// MARK: - ViewPagerDelegate
extension MessageViewController: ViewPagerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        self.setSelectedTab(obj: SegmentMessageTabEnum(rawValue: index) ?? .Message,isUpdateVC : false)
        print("Moved to page \(index)")
    }
}
// MARK: - ViewControllerDescribable
extension MessageViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Message
    }
}

// MARK: - AppNavigationControllerInteractable
extension MessageViewController: AppNavigationControllerInteractable { }

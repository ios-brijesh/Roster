//
//  HelpViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 07/02/22.
//

import UIKit

class HelpViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lblrecentticket: UILabel?
    @IBOutlet weak var lblFAQ: UILabel?
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblSubHeader: UILabel?
    
    @IBOutlet weak var tblsolved: UITableView?
    @IBOutlet weak var cvFAQs: UICollectionView?
    
    
    @IBOutlet weak var vwContactsupport: UIView?
    @IBOutlet weak var vwFAQS: UIView?
    
    @IBOutlet weak var btnContactSupport: UIButton?
    @IBOutlet weak var btnViewall: UIButton?
    @IBOutlet weak var btnNext: UIButton?
    
    @IBOutlet weak var constrainttblsolvedHeight: NSLayoutConstraint?
    @IBOutlet weak var constraintCVFAQsHeight: NSLayoutConstraint?
   
    
    // MARK: - Variables
    var arrFaqList : [TicketFaqModel] = []
    private var arrTicket : [SupportChatModel] = []
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    
    //    MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      self.configureNavigationBar()
        self.addTableviewOberver()
        self.addCollectionviewOberver()
        GetFaqCategory()
       
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
        self.removeCollectionviewObserver()
      
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.vwFAQS?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        self.vwFAQS?.cornerRadius = 15
        
        self.vwContactsupport?.backgroundColor = UIColor.CustomColor.appColor
        self.vwContactsupport?.cornerRadius = 20
        

    }
    }


// MARK: - Init Configure
extension HelpViewController {
    private func InitConfig() {
        
        self.btnViewall?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnViewall?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0))
       
        self.lblHeader?.textColor = UIColor.CustomColor.whitecolor
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        
        self.lblSubHeader?.textColor = UIColor.CustomColor.whitecolor
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        
        
        [self.lblrecentticket,self.lblFAQ].forEach({
            $0?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
            $0?.textColor = UIColor.CustomColor.blackColor
        })
        self.btnNext?.backgroundColor = UIColor.CustomColor.whitecolor
        
        if let btn = self.btnNext {
            btn.cornerRadius = btn.frame.height / 2
        }
        
        self.tblsolved?.register(ChatSupportCell.self)
        self.tblsolved?.dataSource = self
        self.tblsolved?.delegate = self
        
        if let cvFAQs = self.cvFAQs {
            cvFAQs.register(FAQsCell.self)
            cvFAQs.dataSource = self
            cvFAQs.delegate = self
        }
        
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "Help & Support", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}




//MARK: Pagination tableview Mthonthd
extension HelpViewController {
    func setupESInfiniteScrollinWithTableView() {
        self.tblsolved?.es.addPullToRefresh {
            [unowned self] in
            self.view.endEditing(true)
            self.pageNo = 1
            self.arrTicket.removeAll()
            self.tblsolved?.reloadData()
            self.GetFaqCategory()
        }
        
        tblsolved?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
                    self.GetFaqCategory()
                } else if self.pageNo <= self.totalPages {
                    self.GetFaqCategory()
                } else {
                    self.tblsolved?.es.noticeNoMoreData()
                }
            } else {
                self.tblsolved?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblsolved?.footer?.animator as? ESRefreshFooterAnimator {
            animator.noMoreDataDescription = ""
        }
    }
    
    func hideFooterLoading(success: Bool) {
        if success {
            if self.pageNo == self.totalPages {
                self.tblsolved?.es.noticeNoMoreData()
            }
            else {
                self.tblsolved?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblsolved?.es.stopLoadingMore()
            self.tblsolved?.es.noticeNoMoreData()
            self.isLoading = true
        }
    }
}

//MARK: - Tableview Observer
extension HelpViewController {
    
    private func addTableviewOberver() {
        self.tblsolved?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        
    }
    
    
    func removeTableviewObserver() {
        if self.tblsolved?.observationInfo != nil {
            self.tblsolved?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
       
        
    }
     private func addCollectionviewOberver() {
        self.cvFAQs?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
     func removeCollectionviewObserver() {
        if self.cvFAQs?.observationInfo != nil {
            self.cvFAQs?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblsolved && keyPath == ObserverName.kcontentSize {
                self.constrainttblsolvedHeight?.constant = self.tblsolved?.contentSize.height ?? 0.0
            }
            
        }
        if let obj = object as? UICollectionView {
            if obj == self.cvFAQs && keyPath == ObserverName.kcontentSize {
                self.constraintCVFAQsHeight?.constant = self.cvFAQs?.contentSize.height ?? 0.0
                self.cvFAQs?.layoutIfNeeded()
            }
            self.view.layoutIfNeeded()
        }
      
    }
}

//MARK:- UITableView Delegate
extension HelpViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTicket.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ChatSupportCell.self)
        if self.arrTicket.indices ~= indexPath.row {
            let obj = self.arrTicket[indexPath.row]
            cell.setupTicketData(obj: obj)
           cell.vwBottomview?.isHidden = true
        }
        return cell
    }
    
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let objTicketData = arrTicketData[indexPath.row]
        self.appNavigationController?.push(SupportchatdetailViewController.self,configuration: { vc in
            vc.ticketData = self.arrTicket[indexPath.row]
//            vc.strTicketId  = objTicketData.id
        })
    }
 
}


//MARK: - UICollectionView Delegate and Datasource Method
extension HelpViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrFaqList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FAQsCell.self)
        if self.arrFaqList.count > 0 {
            cell.SetFaqCategoryData(obj: self.arrFaqList[indexPath.row])
        }
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
        let width:CGFloat = (collectionView.frame.width - ((2 - 1) * 15)) / 2
        return CGSize(width: width , height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.arrFaqList.count > 0 {
            let obj = self.arrFaqList[indexPath.row]
        self.appNavigationController?.push(FAQsViewController.self,configuration: { vc in
            vc.faqCategoryId = obj.id

         })
        }
    }
    
}
//MARK:- API Call
extension HelpViewController {
    
    private func GetFaqCategory() {
        if let user = UserModel.getCurrentUserFromDefault() {
        let dict : [String:Any] = [
            ktoken : user.token,
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        TicketFaqModel.GetFaqCategory(with: param, success: { (arrTicket,arrFaq,totalPages,message) in
            
            self.arrTicket = arrTicket
            self.tblsolved?.reloadData()
            self.arrFaqList = arrFaq
            self.cvFAQs?.reloadData()
           
          
        }, failure: {[unowned self] (statuscode,error, errorType) in
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
     }
    
  }
    
  
}

// MARK: - IBAction
extension HelpViewController {
    
    @IBAction func btnViewAllClicked(_ sender : UIButton) {
        self.appNavigationController?.push(SupportViewController.self)
        
    }
    @IBAction func btnContactClicked(_ sender : UIButton) {
        self.appNavigationController?.push(SupportViewController.self)
        
    }
}

// MARK: - ViewControllerDescribable
extension HelpViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.CMS
    }
}

// MARK: - AppNavigationControllerInteractable
extension HelpViewController: AppNavigationControllerInteractable { }
//9725284318

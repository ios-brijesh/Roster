//
//  FAQsViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 07/02/22.
//

import UIKit

class FAQsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwSearch: SearchView?
    @IBOutlet weak var tblFAQs: UITableView?
    @IBOutlet weak var constrainttblFAQsHeight: NSLayoutConstraint?
    
    @IBOutlet weak var btnNav: UIButton?
    @IBOutlet weak var lblEventCtergoryName: UILabel?
    @IBOutlet weak var imgCategory: UIImageView?
    @IBOutlet weak var vwCatergoryimg: UIView?
    
    
    // MARK: - Variables
    private var arrFaqList : [FAQModel] = []
    
    private var pageNo : Int = 1
    private var totalPages : Int = 0
    private var isLoading = false
    var faqCategoryId : String = ""
    //    MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.addTableviewOberver()
        
       
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
       
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let vw = self.vwCatergoryimg {
            vw.cornerRadius = vw.frame.height / 2.0
        }

    }
    }

// MARK: - Init Configure
extension FAQsViewController {
    private func InitConfig() {
        
        self.vwSearch?.txtSearch?.returnKeyType = .search
        self.vwSearch?.txtSearch?.delegate = self
        self.vwSearch?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
        
        self.lblEventCtergoryName?.textColor = UIColor.CustomColor.blackColor
        self.lblEventCtergoryName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0))
        
        self.tblFAQs?.register(HelpCell.self)
        self.tblFAQs?.dataSource = self
        self.tblFAQs?.delegate = self
        
        self.getFaqList()
        self.tblFAQs?.reloadData()
       
    }
}

//MARK: Pagination tableview Mthonthd
extension FAQsViewController {
    
    func reloadFeedData(){
        self.pageNo = 1
        self.arrFaqList.removeAll()
        self.tblFAQs?.reloadData()
        self.getFaqList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblFAQs?.es.addPullToRefresh {
            [unowned self] in
            self.view.endEditing(true)
            self.reloadFeedData()
            
            //self.tblFeed.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        }
        
        tblFAQs?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
                    //if self.isLoadingLikeTbl {
                    self.getFaqList()
                    //}
                } else if self.pageNo <= self.totalPages {
                    //if self.isLoadingLikeTbl {
                    self.getFaqList(isshowloader: false)
                    //}
                } else {
                    self.tblFAQs?.es.noticeNoMoreData()
                }
            } else {
                self.tblFAQs?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblFAQs?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblFAQs?.es.noticeNoMoreData()
            }
            else {
                self.tblFAQs?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblFAQs?.es.stopLoadingMore()
            self.tblFAQs?.es.noticeNoMoreData()
            self.isLoading = true
        }
    }
}

//MARK: - Tableview Observer
extension FAQsViewController {
    
    private func addTableviewOberver() {
        self.tblFAQs?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
       
    }
    
    func removeTableviewObserver() {
        if self.tblFAQs?.observationInfo != nil {
            self.tblFAQs?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblFAQs && keyPath == ObserverName.kcontentSize {
                self.constrainttblFAQsHeight?.constant = self.tblFAQs?.contentSize.height ?? 0.0
            }
            
        }
    }
}

//MARK:- UITableView Delegate
extension FAQsViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFaqList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(for: indexPath, with: HelpCell.self)
          let objInfo = arrFaqList[indexPath.item]
        cell.setFaqData(objInfo)
        
        cell.btnKnowMore?.tag = indexPath.row
        cell.btnKnowMore?.addTarget(self, action: #selector(self.btnKnowMoreClicked), for: .touchUpInside)
        
        return cell
    }
    @objc func btnKnowMoreClicked(sender : UIButton) {
        let index = sender.tag
        let objInfo = arrFaqList[index]
        self.appNavigationController?.push(FaqDetailViewController.self,configuration: { vc in
            vc.faqInfo = objInfo
        })
    }
}

// MARK: - UITextFieldDelegate
extension FAQsViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if !(textField.isEmpty) {
            self.reloadFeedData()
           
        }
        return true
    }
    
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        if textField.isEmpty {
            self.reloadFeedData()
        }
    }
}

//MARK:- API Call
extension FAQsViewController {
    private func getFaqList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)",
                klimit : "20",
                ksearch : self.vwSearch?.txtSearch?.text ?? "",
                kfaqCategoryId : self.faqCategoryId
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            FAQModel.getFAQList(with: param,isShowLoader : isshowloader, success: { (arr,totalpage,msg,faqCategoryName,faqCategoryImage) in
                //self.arrResources = arr
                self.tblFAQs?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalpage
                self.lblEventCtergoryName?.text = faqCategoryName
                self.imgCategory?.setImage(withUrl: faqCategoryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                self.arrFaqList.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
                self.tblFAQs?.reloadData()
                
                self.tblFAQs?.EmptyMessage(message: "")
                //self.lblNoData.text = msg
                //self.lblNoData.isHidden = self.arrFaq.count > 0 ? true : false
            }, failure: {(statuscode,error, errorType) in
                print(error)
                self.tblFAQs?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
        
                    self.tblFAQs?.reloadData()
                    self.tblFAQs?.EmptyMessage(message: error)
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                       
                    }
                }
            })
        }
    }
}

//MARK: - Action
extension FAQsViewController {
    
    @IBAction func btnNavClick(_ sender : UIButton) {
        
        self.appNavigationController?.popViewController(animated: true)
    }
}

// MARK: - ViewControllerDescribable
extension FAQsViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.CMS
    }
}

// MARK: - AppNavigationControllerInteractable
extension FAQsViewController: AppNavigationControllerInteractable { }
//9725284318

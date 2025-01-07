//
//  MyOrdersViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 08/06/22.
//

import UIKit

class MyOrdersViewController: UIViewController {
    // MARK: - IBOutlet
    
    
    @IBOutlet weak var tblorder: UITableView?
    @IBOutlet weak var constrainttblorderHeight: NSLayoutConstraint?
    
    // MARK: - Variables
    
    private var ProductData : ProductOrderModel?
    private var arrProductOrder : [ProductOrderModel] = []
    private var totalPages : Int = 0
    private var pageNo : Int = 1
    private var isLoading = false
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.configureNavigationBar()
        self.reloadProductData()
        self.addTableviewOberver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      }
    }
// MARK: - Init Configure
extension MyOrdersViewController {
    
    private func InitConfig() {
        
        self.tblorder?.register(OrderCell.self)
        self.tblorder?.dataSource = self
        self.tblorder?.delegate = self
       
        setupESInfiniteScrollinWithTableView()
    }
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "My Orders", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}

//MARK: Pagination tableview Mthonthd
extension MyOrdersViewController {
    
    private func reloadProductData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrProductOrder.removeAll()
        self.tblorder?.reloadData()
        self.getOrderList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblorder?.es.addPullToRefresh {
            [unowned self] in
            self.reloadProductData()
           
        }
        tblorder?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
              
                    self.getOrderList()
                   
                } else if self.pageNo <= self.totalPages {
                 
                    self.getOrderList(isshowloader: false)
                 
                } else {
                    self.tblorder?.es.noticeNoMoreData()
                }
            } else {
                self.tblorder?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblorder?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblorder?.es.noticeNoMoreData()
            }
            else {
                self.tblorder?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblorder?.es.stopLoadingMore()
            self.tblorder?.es.noticeNoMoreData()
            self.isLoading = true
        }
        
    }
}

//MARK: - Tableview Observer
extension MyOrdersViewController {
    
    private func addTableviewOberver() {
        self.tblorder?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        
    }
        
    func removeTableviewObserver() {
        if self.tblorder?.observationInfo != nil {
            self.tblorder?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblorder && keyPath == ObserverName.kcontentSize {
                self.constrainttblorderHeight?.constant = self.tblorder?.contentSize.height ?? 0.0
            }
            
        }
    }
}

//MARK:- UITableView Delegate
extension MyOrdersViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProductOrder.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(for: indexPath, with: OrderCell.self)
        cell.setupOrderData(obj: self.arrProductOrder[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.appNavigationController?.push(OrderDetailViewController.self,configuration: { vc in
            vc.ProductData = self.arrProductOrder[indexPath.row].id
            
        })
                
    }

}
extension MyOrdersViewController {
    
    
    private func getOrderList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kPageNo : "\(self.pageNo)"

            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            ProductOrderModel.getOrderList(with: param, isShowLoader: isshowloader,  success: { (totalAmount,totalRecords,arr,totalPages,message) in

                //self.arrFeed.append(contentsOf: arr)
                self.tblorder?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.totalPages = totalPages

                self.arrProductOrder.append(contentsOf: arr)
                self.hideFooterLoading(success: self.pageNo <= self.totalPages ? true : false )
                self.pageNo = self.pageNo + 1
//                self.NoDataFound?.isHidden = self.arrTicketData.count == 0 ? false : true
                self.tblorder?.reloadData()
                self.tblorder?.EmptyMessage(message: "")
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                self.tblorder?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
                self.hideFooterLoading(success: false)
                if statuscode == APIStatusCode.NoRecord.rawValue {
        
                    self.tblorder?.reloadData()
                    self.tblorder?.EmptyMessage(message: error)
                } else {
                    if !error.isEmpty {
                        self.showMessage(error, themeStyle: .error)
                       
                    }
                }
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension MyOrdersViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Shop
    }
}

// MARK: - AppNavigationControllerInteractable
extension MyOrdersViewController: AppNavigationControllerInteractable{}

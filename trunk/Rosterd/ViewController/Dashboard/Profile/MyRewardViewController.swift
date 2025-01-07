//
//  MyRewardViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 22/11/22.
//

import UIKit

class MyRewardViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var lbltotalcoins: UILabel!
    @IBOutlet weak var lblShowCoin: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    @IBOutlet weak var lblAlltransuction: UILabel!
    
    @IBOutlet weak var VwCosmosView: CosmosView!
    @IBOutlet weak var vwMainView: UIView!
    
    @IBOutlet weak var tblReward: UITableView!
    @IBOutlet weak var constrainttblRewardHeight: NSLayoutConstraint?
    // MARK: - Variables
    private var arrReward : [RefercoinModel] = []
    private var pageNo : Int = 1
    private var isLoading = false
    private var totalPages : Int = 0
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableviewOberver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableviewObserver()
    }
}
// MARK: - Init Configure
extension MyRewardViewController {
    
    private func InitConfig(){
        
        if let vwMainView = self.vwMainView {
            vwMainView.cornerRadius = 15.0
            vwMainView.backgroundColor = UIColor.CustomColor.appColor
        }
        self.lblHeader?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblHeader?.textColor = UIColor.CustomColor.blackColor
        
        self.lblSubHeader?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblSubHeader?.textColor = UIColor.CustomColor.black50Per
        
        self.lblAlltransuction?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblAlltransuction?.textColor = UIColor.CustomColor.blackColor
        
        self.lbltotalcoins?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lbltotalcoins?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblShowCoin?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 17.0))
        self.lblShowCoin?.textColor = UIColor.CustomColor.CoinColor
        
        self.tblReward?.register(ReferCoinCell.self)
        self.tblReward?.rowHeight = UITableView.automaticDimension
        self.tblReward?.delegate = self
        self.tblReward?.dataSource = self
        
        self.REloadReward()
    }
    
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "My Reward Points", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
    }
}

////MARK: Pagination tableview Mthonthd
extension MyRewardViewController {
    private func REloadReward() {
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrReward.removeAll()
        self.tblReward?.reloadData()
        self.getUserRewardList()
    }
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    //Harshad
    func setupESInfiniteScrollinWithTableView() {
        
        self.tblReward?.es.addPullToRefresh {
            [unowned self] in
            self.REloadReward()
        }
        
        self.tblReward?.es.addInfiniteScrolling {
            
            if !self.isLoading {
                if self.pageNo == 1 {
                    self.getUserRewardList()
                } else if self.pageNo <= self.totalPages {
                    self.getUserRewardList(isshowloader: false)
                } else {
                    self.tblReward?.es.noticeNoMoreData()
                }
            } else {
                self.tblReward?.es.noticeNoMoreData()
            }
        }
        if let animator = self.tblReward?.footer?.animator as? ESRefreshFooterAnimator {
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
                self.tblReward?.es.noticeNoMoreData()
            }
            else {
                self.tblReward?.es.stopLoadingMore()
            }
            self.isLoading = false
        }
        else {
            self.tblReward?.es.stopLoadingMore()
            self.tblReward?.es.noticeNoMoreData()
            self.isLoading = true
        }
    }
}
//MARK: - Tableview Observer
extension MyRewardViewController {
    private func addTableviewOberver() {
        self.tblReward?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
        
    }
    func removeTableviewObserver() {
        if self.tblReward?.observationInfo != nil {
            self.tblReward?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
        
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblReward && keyPath == ObserverName.kcontentSize {
                self.constrainttblRewardHeight?.constant = self.tblReward?.contentSize.height ?? 0.0
            }
            
        }
    }
}
//MARK:- UITableView Delegate
extension MyRewardViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReward.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ReferCoinCell.self)
        cell.SetReferData(obj: self.arrReward[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
// MARK: - API
extension MyRewardViewController {
    private func getUserRewardList(isshowloader :Bool = true){
        if let user = UserModel.getCurrentUserFromDefault() {
            self.view.endEditing(true)
            
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kpage : self.pageNo,
                klimit : ""
            ]
            
            let param : [String:Any] = [
                kData : dict
            ]
            
            RefercoinModel.getUserRewardList(with: param, success: { (totalStar,totalReward,arr,msg) in
                self.arrReward = arr
                self.tblReward?.reloadData()
                self.lblShowCoin?.text = totalReward
                self.VwCosmosView.rating = Double(totalStar) ?? 0.0
            }, failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
            })
        }
    }
}
// MARK: - ViewControllerDescribable
extension MyRewardViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}
// MARK: - AppNavigationControllerInteractable
extension MyRewardViewController: AppNavigationControllerInteractable { }

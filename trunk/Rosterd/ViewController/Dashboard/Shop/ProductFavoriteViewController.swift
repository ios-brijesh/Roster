//
//  ProductFavoriteViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 21/12/22.
//

import UIKit

class ProductFavoriteViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var cvFvProduct: UICollectionView?
    @IBOutlet weak var Nolabel: UIView?
    @IBOutlet weak var lblempty: NoDataFoundLabel?
    
    // MARK: - Variables
    private var arrProductFv : [productModel] = []
    private var totalPages : Int = 0
    private var pageNo : Int = 1
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
extension ProductFavoriteViewController {
    private func InitConfig(){
        
        if let cv = self.cvFvProduct {
            cv.register(OtherCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        self.getMyProductFavoriteList()
    }
    
    private func configureNavigationBar() {
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appsetUpNotificationWithTitle(title: "My Wishlist", TitleColor: UIColor.CustomColor.blackColor,navigationItem: self.navigationItem)
        
        appNavigationController?.btnNextClickBlock = {
            self.appNavigationController?.push(HelpViewController.self)
        }
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()

    }
}
extension ProductFavoriteViewController {

    private func reloadproductData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrProductFv.removeAll()
        self.cvFvProduct?.reloadData()
        self.getMyProductFavoriteList()
    }
}
//MARK: - UICollectionView Delegate and Datasource Method
extension ProductFavoriteViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProductFv.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: OtherCell.self)
              if self.arrProductFv.count > 0 {
                cell.SetFavoriteData(obj: self.arrProductFv[indexPath.row])
                  cell.Delegate = self
            }
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2.0) - 10.0, height: ((collectionView.frame.size.width / 1.75) - 10.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.appNavigationController?.push(ProductDetailViewController.self,configuration: { vc in
//            vc.selectedproductdata = self.arrProduct[indexPath.row].id
//            vc.Url = self.arrProduct[indexPath.row].shareLink
        })
    }
    
}

// MARK: - FeedCellDelegate
extension ProductFavoriteViewController : ProductCellDelegate {
    func btnLikeSelect(btn: UIButton, cell: OtherCell) {
        self.view.endEditing(true)
        if let indexpath = self.cvFvProduct?.indexPath(for: cell) {
            if self.arrProductFv.count > 0 {
                let obj =   self.arrProductFv[indexpath.row]
                obj.isLike = btn.isSelected ? "1" : "0"
                self.setProductLikeDislike(isLike: btn.isSelected ? "1" : "0", productId: self.arrProductFv[indexpath.row].productId)
                self.cvFvProduct?.reloadData()
            }
           
        }
    }
}

extension ProductFavoriteViewController {
    
    private func getMyProductFavoriteList(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault(){
      
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token
   
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       productModel.getMyProductFavoriteList(with: param, isShowLoader: isshowloader,  success: { (arrProduct,totalpage,msg) in
          
               self.cvFvProduct?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrProductFv = arrProduct
               self.Nolabel?.isHidden = self.arrProductFv.count == 0 ? false : true
           self.cvFvProduct?.reloadData()
//                   self.cvBrand?.reloadData()
//               self.lblNotification?.text = totalCartProduct
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.cvFvProduct?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.Nolabel?.isHidden = self.arrProductFv.count == 0 ? false : true

               if statuscode == APIStatusCode.NoRecord.rawValue {
                   self.lblempty?.text = error
                   self.cvFvProduct?.reloadData()
               } else {
                   if !error.isEmpty {
//                       self.showMessage(error, themeStyle: .error)
                    
                   }
               }
           })
       }
   }
    
    private func setProductLikeDislike(isLike : String,productId : String){
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kproductId : productId
            ]

            let param : [String:Any] = [
                kData : dict
            ]

            productModel.setProductLikeDislike(with: param, success: { (msg) in
                self.reloadproductData()
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
 }


// MARK: - ViewControllerDescribable
extension ProductFavoriteViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
  return UIStoryboard.Name.Shop
 }
}

// MARK: - AppNavigationControllerInteractable
extension ProductFavoriteViewController: AppNavigationControllerInteractable { }

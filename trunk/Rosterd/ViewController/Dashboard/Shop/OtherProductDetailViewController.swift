//
//  OtherProductDetailViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 09/02/22.
//

import UIKit
import CloudKit

class OtherProductDetailViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var vwCartView: UIView?
    @IBOutlet weak var VwNotificationview: UIView?
    @IBOutlet weak var lblNotification: UILabel?
    @IBOutlet weak var imgBrand: UIImageView?
    @IBOutlet weak var cvBrand: UICollectionView?
    @IBOutlet weak var Nolabel: NoDataFoundLabel!
    
    
    // MARK: - Variables
    private var ProductData : productModel?
    private var arrProduct : [productModel] = []
    var selectedBranddata : CategoryModel?
    private var totalPages : Int = 0
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProductList()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: - Init Configure
extension OtherProductDetailViewController {
    private func InitConfig(){
      
        if let cv = self.cvBrand {
            cv.register(OtherCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
       
        self.lblNotification?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 11.0))
        self.lblNotification?.textColor = UIColor.CustomColor.whitecolor
        
        
        if let vwCartView = self.vwCartView {
            vwCartView.cornerRadius = vwCartView.frame.height/2
            vwCartView.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vwCartView.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if let VwNotificationview  = self.VwNotificationview {
            VwNotificationview.cornerRadius = VwNotificationview.frame.height/2
            VwNotificationview.backgroundColor = UIColor.CustomColor.profilebgColor
        }
    }
}
//MARK: - UICollectionView Delegate and Datasource Method
extension OtherProductDetailViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: OtherCell.self)
              if self.arrProduct.count > 0 {
                cell.SetOtherData(obj: self.arrProduct[indexPath.row])
                  cell.VwLikeView?.isHidden = true
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
            vc.selectedproductdata = self.arrProduct[indexPath.row].id
            vc.Url = self.arrProduct[indexPath.row].shareLink
        })
    }
    
}

extension OtherProductDetailViewController {
    
    
    private func getProductList(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault(),let Branddata = self.selectedBranddata {
      
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           kproduct_brand_id : Branddata.id
          
   
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       productModel.getProductList(with: param, isShowLoader: isshowloader,  success: { (product_brand_image,totalCartProduct,arrProduct,totalpage,msg) in
          
               self.cvBrand?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrProduct = arrProduct
               self.setProductimagedata()
           
          
               self.Nolabel?.isHidden = self.arrProduct.count == 0 ? false : true
                   self.cvBrand?.reloadData()
               self.lblNotification?.text = totalCartProduct
               self.imgBrand?.setImage(withUrl: product_brand_image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
          
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.cvBrand?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.Nolabel?.isHidden = self.arrProduct.count == 0 ? false : true
               self.VwNotificationview?.isHidden = true

               if statuscode == APIStatusCode.NoRecord.rawValue {
                   self.Nolabel?.text = error
                   self.cvBrand?.reloadData()
                   
                
               } else {
                   if !error.isEmpty {
                       self.showMessage(error, themeStyle: .error)
                    
                   }
               }
           })
       }
   }
    
    private func setProductimagedata() {
        
        if let obj = self.ProductData  {
            
            self.imgBrand?.setImage(withUrl: obj.product_brand_image, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
    }
    
}






//MARK: - IBAction Method
extension OtherProductDetailViewController {
    
    @IBAction func btnNavClick(){
        self.appNavigationController?.popToRootViewController(animated: true)
     
    }
    
    @IBAction func btnCartClick() {
        self.appNavigationController?.push(MyCartViewController.self)
       
    }

}


// MARK: - ViewControllerDescribable
extension OtherProductDetailViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
  return UIStoryboard.Name.Shop
 }
}

// MARK: - AppNavigationControllerInteractable
extension OtherProductDetailViewController: AppNavigationControllerInteractable { }

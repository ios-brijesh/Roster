//
//  ProductDetailViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 27/01/22.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - IBOutlet  
    @IBOutlet weak var cvColor: UICollectionView?
    @IBOutlet weak var cvsize: UICollectionView?
    @IBOutlet weak var cvAlbum: UICollectionView?
    @IBOutlet weak var cvdescription: UICollectionView?
    
    @IBOutlet weak var vwProductimageview: UIView?
    @IBOutlet weak var vwCard: UIView?
    @IBOutlet weak var vwCartview: UIView?
    @IBOutlet weak var VwNotificationview: UIView?
    
    @IBOutlet weak var lblCartPrize: UILabel?
    @IBOutlet weak var lblAddCart: UILabel?
    @IBOutlet weak var lblMaterial: UILabel?
    @IBOutlet weak var lblProductName: UILabel?
    @IBOutlet weak var lblShowNotification: UILabel?
    @IBOutlet weak var lblDesc: UILabel?
    
    @IBOutlet weak var lblbrand: UILabel?
    @IBOutlet var lblheader: [UILabel]?
    @IBOutlet var lblSubheader: [UILabel]?
    @IBOutlet var lblProductHeader: [UILabel]?
    @IBOutlet var constraintCVSpecificationHeight : NSLayoutConstraint?
  
    @IBOutlet weak var imgproduct: UIImageView?
    
    @IBOutlet weak var btnForward: UIButton?
    @IBOutlet weak var btnLikeUnlike: UIButton!
    
    // MARK: - Variables
    private var ProductData : productModel?
    private var arrcolor : [VariationModel] = []
    private var arrSize : [SizeModel] = []
    private var arrAlbum : [CategoryModel] = []
    private var arrProductspecification : [productSpecificationModel] = []
    var selectedproductdata : String = ""
    var Url : String = ""
    var selectedSize : SizeModel?
    var selectedIndex = 0
    var selectedindex = 0
    var selectedShopIndex = 0
    var SelectedIndex = UIImage()
    var isLike : [productModel] = []
    private var Variation : String = ""
    var isRealoadRestaurantData : Bool = false
    
        //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProductDetailAPICall()
        self.addCollectionviewOberver()
        self.navigationController?.navigationBar.isHidden = true
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeCollectionviewObserver()
              
    }
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let vwCard = self.vwCard {
            vwCard.cornerRadius = 20
            vwCard.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vwCard.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if let vwProductimageview = self.vwProductimageview {
            vwProductimageview.clipsToBounds = true
//            vwProductimageview.cornerRadius = 15.0
            vwProductimageview.shadow(UIColor.CustomColor.shadowColor18PerBlack, radius: 8.0, offset: CGSize(width: 0, height: 0), opacity: 1)
            vwProductimageview.maskToBounds = false
        }
    }
    
}

/// MARK: - Init Configure
extension ProductDetailViewController {
    private func InitConfig() {
        
        self.lblShowNotification?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 11.0))
        self.lblShowNotification?.textColor = UIColor.CustomColor.whitecolor
        
        if let vwCartview = self.vwCartview {
            vwCartview.cornerRadius = vwCartview.frame.height/2
            vwCartview.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vwCartview.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if let VwNotificationview  = self.VwNotificationview {
            VwNotificationview.cornerRadius = VwNotificationview.frame.height/2
            VwNotificationview.backgroundColor = UIColor.CustomColor.profilebgColor
        }
        
        self.lblMaterial?.setHelloUserAttributedTextLable(firstText: "Material:", SecondText: " 100% polyester")
        
        self.lblProductName?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 29.0))
        self.lblProductName?.textColor = UIColor.CustomColor.labelTextColor
        
        self.lblCartPrize?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 19.0))
        self.lblCartPrize?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblAddCart?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 9.0))
        self.lblAddCart?.textColor = UIColor.CustomColor.whitecolor
        
        
        self.lblDesc?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblDesc?.textColor = UIColor.CustomColor.blackColor
        
        
        self.lblbrand?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        self.lblbrand?.textColor = UIColor.CustomColor.blackColor
        
        self.lblheader?.forEach({
            $0.textColor = UIColor.CustomColor.textfieldTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        })
        
        self.lblSubheader?.forEach({
            $0.textColor = UIColor.CustomColor.textfieldTextColor
            $0.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.lblProductHeader?.forEach({
            $0.textColor = UIColor.CustomColor.textfieldTextColor
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        })
        
        if let cv = self.cvColor {
            cv.register(ColorCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        if let cv = self.cvsize {
            cv.register(SizeCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        if let cv = self.cvAlbum {          
            cv.register(AlbumCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        if let cv = self.cvdescription {
            cv.register(DescriptionCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
    }
}
////MARK: Pagination tableview Mthonthd
extension ProductDetailViewController {

    private func reloadProductData(){
        self.view.endEditing(true)
        self.arrAlbum.removeAll()
        self.cvAlbum?.reloadData()
        self.getProductDetailAPICall()
    }
}
//MARK: - Tableview Observer
extension ProductDetailViewController {
    
   
     private func addCollectionviewOberver() {
        self.cvdescription?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
     func removeCollectionviewObserver() {
        if self.cvdescription?.observationInfo != nil {
            self.cvdescription?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
       
        if let obj = object as? UICollectionView {
            if obj == self.cvdescription && keyPath == ObserverName.kcontentSize {
                self.constraintCVSpecificationHeight?.constant = self.cvdescription?.contentSize.height ?? 0.0
                self.cvdescription?.layoutIfNeeded()
            }
            self.view.layoutIfNeeded()
        }
      
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension ProductDetailViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvColor{
            return arrcolor.count
        } else if collectionView == self.cvsize {
            return arrSize.count
        }else if collectionView == self.cvAlbum {
            return arrAlbum.count
        }else if collectionView == self.cvdescription {
            return arrProductspecification.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvColor {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ColorCell.self)
            if self.arrcolor.count > 0 {
                cell.setcolordata(obj: self.arrcolor[indexPath.row])
            }
            if selectedIndex == indexPath.item {
                cell.vwMainview?.setCornerRadius(withBorder: 1, borderColor: UIColor.CustomColor.blackColor, cornerRadius: 13.0)
            }
            else {
                cell.vwMainview?.setCornerRadius(withBorder: 1, borderColor: .clear, cornerRadius: 12.0)
            }
             return cell

        } else if collectionView == self.cvsize {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SizeCell.self)
            
            if self.arrSize.count > 0 {
                cell.setSizedata(obj: self.arrSize[indexPath.row])
            
            }
            if selectedindex == indexPath.item {

                cell.lblSize?.textColor = UIColor.CustomColor.whitecolor
                cell.isselectCell = true
            }
            else {
             
                cell.lblSize?.textColor = UIColor.CustomColor.blackColor
                cell.isselectCell = false
            }
        
            return cell
        } else if collectionView == self.cvAlbum {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AlbumCell.self)
            cell.vwAddview?.isHidden = true 
            if self.arrAlbum.count > 0 {
                cell.setProductImageData(obj: self.arrAlbum[indexPath.row])
            }
            return cell
        } else if collectionView == self.cvdescription {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DescriptionCell.self)
            if self.arrProductspecification.count > 0 {
                cell.setProductspecification(obj: self.arrProductspecification[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.cvAlbum {
            return 0
        }
        else if collectionView == self.cvdescription {
            return 15
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.cvColor {
            return 0
        }
        else if collectionView == self.cvsize {
            return 5
        }
        else if collectionView == self.cvAlbum {
            return 12
        }
        else if collectionView == self.cvdescription {
            return 15
        }
        
        return 0
    }
      
//9825552825
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.cvColor {
            return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
        } else if collectionView == self.cvsize {
            return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
        } else if collectionView == self.cvAlbum {
            return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
        } else if collectionView == self.cvdescription {
//            return CGSize(width: (collectionView.frame.size.width / 2.0) - 10.0, height: ((collectionView.frame.size.width / 1.75) - 10.0))
            
            let width = ((ScreenSize.SCREEN_WIDTH - 30) - ((2 - 1) * 15)) / 2
            return CGSize(width:width , height: 50)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.cvColor {
            selectedIndex = indexPath.item
            print(indexPath.row)
            collectionView.reloadData()
            arrSize = arrcolor[selectedIndex].size
            self.cvsize?.reloadData()
        }
        else  if collectionView == self.cvsize {
            selectedindex = indexPath.item
            self.selectedSize = arrSize[selectedindex]
            print(indexPath.row)
            collectionView.reloadData()
            self.lblCartPrize?.text = "$\(arrSize[selectedindex].price)"
        }
        else if collectionView == self.cvAlbum {
            
            selectedShopIndex = indexPath.item
            print(indexPath.row)
            self.imgproduct?.setImage(withUrl: arrAlbum[indexPath.row].productfullimage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
        }
    }
}

//MARK: - IBAction Method/*
extension ProductDetailViewController {
    
    @IBAction func btnAddCartClick() {
       
        self.addProductCart()

        
    }
    
    @IBAction func SharelinkClick(_ sender : UIButton ) {
        
        let textToShare = [self.Url]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnNavClick() {
        self.appNavigationController?.popViewController(animated: true)
       
    }
    @IBAction func btnCartClick() {
        
        self.appNavigationController?.push(MyCartViewController.self)
       
    }
    
    @IBAction func btnforwardClick() {
   
        guard let indexPath = cvAlbum?.indexPathsForVisibleItems.last.flatMap({
               IndexPath(item: $0.row + 1, section: $0.section)
           }), cvAlbum?.cellForItem(at: indexPath) != nil else {
               return
           }

           cvAlbum?.scrollToItem(at: indexPath, at: .right, animated: true)
        
        
    }

    @IBAction func btnLikeUnlikeClick() {
        
//        self.isLike = btnLikeUnlike.isSelected ? "1" : "0"
        self.btnLikeUnlike?.isSelected = !(self.btnLikeUnlike?.isSelected ?? false)
        self.setProductLikeDislike(isLike: btnLikeUnlike.isSelected ? "1" : "0")
        
    }
    func moveCollectionToFrame(contentOffset : CGFloat) {

        let frame: CGRect = CGRect(x : contentOffset ,y : self.cvAlbum?.contentOffset.y ?? 0 ,width : self.cvAlbum?.frame.width ?? 0,height : self.cvAlbum?.frame.height ?? 00)
           self.cvAlbum?.scrollRectToVisible(frame, animated: true)
       }
}

// MARK: - API Call
extension ProductDetailViewController {
    
    
    private func getProductDetailAPICall(isshowloader :Bool = true) {
        
        
     
        if let user = UserModel.getCurrentUserFromDefault(){
          
           let dict : [String:Any] = [
               klangType : Rosterd.sharedInstance.languageType,
               ktoken : user.token,
               kproductId : self.selectedproductdata
             
           ]
           
           let param : [String:Any] = [
               kData : dict
           ]

               productModel.productDeatil(with: param, isShowLoader: isshowloader,  success: { (totalCartProduct,arr,arriamges,arrvariation,arrProductvariation,totalpage,msg) in
                   self.lblShowNotification?.text = totalCartProduct
                   self.arrAlbum.append(contentsOf: arriamges)
                   self.cvAlbum?.reloadData()
                   self.arrcolor = arrvariation
                   self.cvColor?.reloadData()
                   self.selectedIndex = 0
                   self.ProductData = arr
                   self.arrProductspecification = arrProductvariation
                   
                   if let productVariation =  self.arrcolor.first {
                       self.arrSize = productVariation.size
                       self.cvsize?.reloadData()
                       self.selectedindex = 0
                   }
                   
                   if let color = self.arrSize.first {
                       self.selectedSize = color
                       self.lblCartPrize?.text = "$\(color.price)"
                       self.selectedIndex = 0
//                       self.selectedSize = color.variationId
                   }
                   self.cvdescription?.reloadData()
                   self.cvsize?.reloadData()
                   self.setproductdeailData()
                
                 
               }, failure: {[unowned self] (statuscode,error, errorType) in
                   print(error)
                   if statuscode == APIStatusCode.NoRecord.rawValue {
                   
                   } else {
                       if !error.isEmpty {
                           self.showMessage(error, themeStyle: .error)
                           
                       }
                   }
               })
           }
    }
    
    
    private func setProductLikeDislike(isLike : String){
        if let user = UserModel.getCurrentUserFromDefault(){
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kproductId : self.selectedproductdata
            ]

            let param : [String:Any] = [
                kData : dict
            ]

            productModel.setProductLikeDislike(with: param, success: { (msg) in

            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    
    private func addProductCart(){
        if let user = UserModel.getCurrentUserFromDefault(),let sizedata = selectedSize {
            let dict : [String:Any] = [
                klangType : Rosterd.sharedInstance.languageType,
                ktoken : user.token,
                kproductId : self.selectedproductdata,
                kvariationId : sizedata.variationId,
                kqty : "1"

            ]

            let param : [String:Any] = [
                kData : dict
            ]

            productModel.addProductCart(with: param, success: { (total_amount,subTotal,shipingCost,msg) in
                self.reloadProductData()
            }, failure: { (statuscode,error, errorType) in
                print(error)
            })
        }
    }
    private func setproductdeailData() {
        if let obj = self.ProductData {
            self.lblProductName?.text = obj.name
            self.lblbrand?.text = obj.product_brand_name
            self.imgproduct?.setImage(withUrl: obj.primaryImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
            self.lblDesc?.text = obj.desc
            self.btnLikeUnlike?.isSelected = obj.isLike == "1"
            self.cvsize?.reloadData()
            self.cvColor?.reloadData()

        }
    }
}
// MARK: - ViewControllerDescribable
extension ProductDetailViewController: ViewControllerDescribable {
     static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Shop
  }
}

// MARK: - AppNavigationControllerInteractable
extension ProductDetailViewController: AppNavigationControllerInteractable { }

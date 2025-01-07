//
//  ShopViewController.swift
//  Rosterd
//
//  Created by WM-KP on 08/01/22.
//

import UIKit

class ShopViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var scrollViewShop: UIScrollView?
    @IBOutlet weak var lblShownotification: UILabel?
    @IBOutlet weak var lblCategory: UILabel?
    @IBOutlet weak var lblShooesname: UILabel?
    @IBOutlet weak var lblshoesprice: UILabel?
    @IBOutlet weak var vwBackBG: UIView!
    
    @IBOutlet var lblheader: [UILabel]?
    
    @IBOutlet weak var btnShop: UIButton?
    @IBOutlet weak var btnorder: UIButton?
    
    @IBOutlet weak var vwshopview: UIView?
    @IBOutlet weak var vwProductView: UIView?
    
    @IBOutlet weak var vwPageControl: UIView?
    @IBOutlet weak var vwCoupenView: iCarousel!
    @IBOutlet weak var vwdiscountview: iCarousel!
    @IBOutlet weak var vwshownotification: UIView?
    @IBOutlet weak var vwCategoryview: UIView?
    @IBOutlet weak var vwSearchview: TextReusableView?
    @IBOutlet weak var cvDiscount: UICollectionView?
    @IBOutlet weak var cvBrand: UICollectionView?
    @IBOutlet weak var cvCategory: UICollectionView?
    @IBOutlet weak var cvOther: UICollectionView?
    
    @IBOutlet weak var cvbrandheight: NSLayoutConstraint?
    
    @IBOutlet weak var btnserach: UIButton?
    @IBOutlet weak var vwsearchview: SearchView?
    
    @IBOutlet weak var DiscountFSview: FSPagerView!
    
    // MARK: - Variables
    private var arrcategory : [productModel] = []
    private var arrOther : [productModel] = []
    private var arrbrand : [CategoryModel] = []
    private var arrCoupen : [GiftCoupenModel] = []
    private var arrImageCoupon : [ModelGiftCoupon] = []
    private var cartdata : productModel?
    let pageControl = SCPageControlView()
    private var arrTutorial : [AdvertiseModel] = []
    private var currentIndex : Int = 0
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
        scrollViewShop?.delegate = self
        self.vwdiscountview.delegate = self
        self.vwdiscountview.dataSource = self
        self.vwdiscountview.type = .cylinder
        
        
        self.vwCoupenView.delegate = self
        self.vwCoupenView.dataSource = self
        self.vwCoupenView.type = .rotary
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.configureNavigationBar()
        self.productDashboardList()
        self.addCollectionViewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeCollectionViewObserver()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.vwCategoryview?.cornerRadius = 20
        
    
    }
}



// MARK: - Init Configure
extension ShopViewController {
    private func InitConfig(){
  
      
        self.vwSearchview?.textreusableViewDelegate = self
        self.vwSearchview?.btnSelect.isHidden = false
        
        if let cv = self.cvDiscount {
            cv.register(DiscountCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        if let cv = self.cvBrand {
            cv.register(BrandCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        if let cv = self.cvOther {
            cv.register(OtherCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        if let cv = self.cvCategory {
            cv.register(InformationCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        
        self.lblheader?.forEach({
            $0.textColor = UIColor.CustomColor.labelTextColor
            $0.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        })
        
        self.lblCategory?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 10.0))
        self.lblCategory?.textColor = UIColor.CustomColor.placeholderapp760
        
        
        self.lblShownotification?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 11.0))
        self.lblShownotification?.textColor = UIColor.CustomColor.whitecolor
        
        self.lblShooesname?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 14.0))
        self.lblShooesname?.textColor = UIColor.CustomColor.placeholderapp
        
        self.lblshoesprice?.font = UIFont.PoppinsBold(ofSize: GetAppFontSize(size: 20.0))
        self.lblshoesprice?.textColor = UIColor.CustomColor.placeholderapp
        
        self.vwCategoryview?.backgroundColor = UIColor.CustomColor.writeSomethingBGColor
        
        if let vwshopview = self.vwshopview {
            vwshopview.cornerRadius = vwshopview.frame.height/2
            vwshopview.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vwshopview.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        if let vwProductView = self.vwProductView {
            vwProductView.cornerRadius = vwProductView.frame.height/2
            vwProductView.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vwProductView.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
        }
        
        
        
        if let  vwshownotification = self.vwshownotification {
            vwshownotification.cornerRadius = vwshownotification.frame.height/2
            vwshownotification.backgroundColor = UIColor.CustomColor.profilebgColor
        }
        
        pageControl.frame = CGRect(x: 0, y: 0, width: vwPageControl?.frame.width ?? 0 , height: vwPageControl?.frame.height ?? 0)
        pageControl.scp_style = .SCNormal
        pageControl.set_view(arrTutorial.count, current: 0, current_color: UIColor.CustomColor.whitecolor)
        vwPageControl?.addSubview(pageControl)
        
        self.vwshownotification?.isHidden = true
        
        self.productDashboardList()
        self.getGiftCouponNew()
        
    }
}
//
////MARK: -  Scrollview Method
//extension ShopViewController {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        pageControl.currentOfPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        pageControl.scroll_did(scrollView)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        //self.collectionview.scrollToNearestVisibleCollectionViewCell()
//        //self.pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        print("scrollViewDidEndDecelerating : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
//        self.currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        //self.pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        self.currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        print("scrollViewDidEndScrollingAnimation : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
//        self.cvDiscount.scrollToNextItem()
//
//    }
//}

// MARK: - ReusableView Delegate
extension ShopViewController : TextReusableViewDelegate {
    
    func buttonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.appNavigationController?.push(ShopSearchViewController.self)
        
    }
    func rightButtonClicked(_ sender: UIButton) {
        return
    }
}


// MARK: - Init Configure
extension ShopViewController : iCarouselDelegate,iCarouselDataSource {

    
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        if carousel == self.vwdiscountview {
            return arrCoupen.count
        }
        else {
            return arrImageCoupon.count
        }
        
        
         
      }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        if carousel == self.vwdiscountview {
            let view:iCarousolView = UIView.fromNib()
        
        view.frame = CGRect.init(x: 0, y: 0, width: (ScreenSize.SCREEN_WIDTH - 30) - 100, height: 400)
        
        view.coupendata = arrCoupen[index]
        view.setCoupoenData()
//        view.btnvisitwebsite?.tag = index
//        view.btnvisitwebsite?.addTarget(self, action: #selector(self.btnvisitwebsiteClicked(_:)), for: .touchUpInside)
            
            return view
        }
        else {
            
            let otherview:iCarouselHomeView = UIView.fromNib()
            otherview.frame = CGRect.init(x: 0, y: 0, width: (ScreenSize.SCREEN_WIDTH - 30) - 100, height: 375)
            otherview.coupendata = arrImageCoupon[index]
            otherview.setImageData()
            otherview.onClickImageData = { (CoupenData) in
                otherview.lblDesc?.text = CoupenData.descriptionField
                otherview.lblpresentage?.text = "\(CoupenData.offerPercentage)%"
                otherview.lblcode?.text = CoupenData.couponCode
                otherview.lblexpiredate?.text = "Expires\(CoupenData.expiryDate)"
                
                otherview.btnvisitwebsite?.tag = index
                otherview.btnvisitwebsite?.addTarget(self, action: #selector(self.btnvisitwebsiteClicked(_:)), for: .touchUpInside)
                otherview.imgBrand?.setImage(withUrl: CoupenData.offerImage, placeholderImage: #imageLiteral(resourceName: DefaultPlaceholderImage.UserAppPlaceholder), indicatorStyle: .medium, isProgressive: true, imageindicator: .medium)
                
                
                if CoupenData.isFlipped == true {
                    CoupenData.isFlipped = false
                    UIView.transition(from: otherview.vwmainview ?? UIView(), to: otherview.vwImageView ?? UIView(),
                                      duration: 0.5, options: [.transitionFlipFromLeft,
                                                           .showHideTransitionViews]) { _ in
                        otherview.vwmainview?.isHidden = true
                        otherview.vwImageView?.isHidden = false
                        
                    }
                }
                else {
                    UIView.transition(from: otherview.vwmainview ?? UIView(), to: otherview.vwImageView ?? UIView(),
                                      duration: 0.5, options: [.transitionFlipFromRight,
                                                           .showHideTransitionViews]) { _ in
                        otherview.vwmainview?.isHidden = false
                        otherview.vwImageView?.isHidden = true
                    }
                    CoupenData.isFlipped = true
                }
            }
            return otherview
        }
//           return view
        }

      func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
          
          if carousel == self.vwdiscountview {
              
              if (option == .spacing) {
                  return value * 1.1
              }
          } else {
              
              if (option == .spacing) {
                  return value * 1.1
              }
          }
          
        
          return value
      }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        print("Coupon Index : \(index)")
        let carousalView = carousel.itemView(at: index)
        if carousel == self.vwdiscountview {
           
            if let view = carousalView as? iCarousolView,let mainView = view.vwmainview,let mainImgView = view.vwImageview {
               let couponData = arrCoupen[index]
                if couponData.isFlipped == true {
                    couponData.isFlipped = false
                    UIView.transition(from: mainView, to: mainImgView,
                                      duration: 0.5, options: [.transitionFlipFromLeft,
                                                           .showHideTransitionViews]) { _ in
                        mainView.isHidden = true
                        mainImgView.isHidden = false
                    }
                }
                else {
                    UIView.transition(from: mainView, to: mainImgView,
                                      duration: 0.5, options: [.transitionFlipFromRight,
                                                           .showHideTransitionViews]) { _ in
                        mainView.isHidden = false
                        mainImgView.isHidden = true
                    }
                    couponData.isFlipped = true
                }
            }
        }
        else {
            let couponData = arrImageCoupon[index]
            if let indexSub = couponData.subData.firstIndex(where: {$0.isFlipped == true}) {
                let subData = couponData.subData[indexSub]
                subData.isFlipped = false
                
                if let view = carousalView as? iCarouselHomeView,let mainView = view.vwmainview,let mainImgView = view.vwImageView {
                    UIView.transition(from: mainView, to: mainImgView,
                                      duration: 0.5, options: [.transitionFlipFromLeft,
                                                           .showHideTransitionViews]) { _ in
                        mainView.isHidden = true
                        mainImgView.isHidden = false
                    }
                }
                
            }
        }
      
       
    }
    
    @objc func btnvisitwebsiteClicked(_ sender : UIButton){
        if self.arrCoupen.count > 0 {
            self.appNavigationController?.detachRightSideMenu()
            self.appNavigationController?.push(ShopLinkViewController.self,configuration: { vc in
                vc.Url = self.arrCoupen[sender.tag].websiteLink
            })

        }
    }
}


//
//// MARK: - Init Configure
//extension ShopViewController : iCarouselDelegate,iCarouselDataSource {
//
//    func numberOfItems(in carousel: iCarousel) -> Int {
//           return 20
//       }
//
//       func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//           let view:iCarouselHomeView = UIView.fromNib()
//           view.frame = CGRect.init(x: 0, y: 0, width: (ScreenSize.SCREEN_WIDTH - 30) - 100, height: 400)
//           return view
//       }
//
//       func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
//           if (option == .spacing) {
//               return value * 1.2
//           }
//           return value
//       }
//
//}

////MARK: Pagination tableview Mthonthd
extension ShopViewController {

    private func reloadProductData(){
        self.view.endEditing(true)
     
        self.productDashboardList()
        self.getGiftCouponNew()
    }
}

//MARK: - Tableview Observer
extension ShopViewController {
    
    private func addCollectionViewOberver() {
        self.cvBrand?.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    private func removeCollectionViewObserver() {
        
            if self.cvBrand?.observationInfo != nil {
            self.cvBrand?.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in Collection View.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UICollectionView {
            if obj == self.cvBrand && keyPath == ObserverName.kcontentSize {
                self.cvbrandheight?.constant = self.cvBrand?.contentSize.height ?? 0.0
            }
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension ShopViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvDiscount{
            return self.arrTutorial.count
        } else if collectionView == self.cvBrand {         
            return arrbrand.count
        } else if collectionView == self.cvOther {
            return arrOther.count
        } else {
            return arrcategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvDiscount {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DiscountCell.self)
            if self.arrTutorial.count > 0 {
                cell.setupData(obj: self.arrTutorial[indexPath.row])
             
            }
            return cell
        } else if collectionView == self.cvBrand {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: BrandCell.self)
            if self.arrbrand.count > 0 {
                cell.setBrandiconData(obj: self.arrbrand[indexPath.row])
            }
            return cell
        } else if collectionView == self.cvOther {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: OtherCell.self)
            if self.arrOther.count > 0 {
                cell.SetOtherData(obj: self.arrOther[indexPath.row])
            }
            return cell
        } else if collectionView == self.cvCategory{
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: InformationCell.self)
            if self.arrcategory.count > 0 {
                cell.setBrandData(obj: self.arrcategory[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.cvBrand {
            return 10
        }
        if collectionView == self.cvOther {
            return 0
        }
        if collectionView == self.cvCategory {
            return 10
        }
        return 0
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.cvDiscount {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else if collectionView == self.cvBrand {
            return CGSize(width: collectionView.frame.size.height / 1.6, height: collectionView.frame.size.height)
        }else if collectionView == self.cvOther {
            return CGSize(width: collectionView.frame.size.height / 1.2, height: collectionView.frame.size.height)
        }else if collectionView == self.cvCategory {
            return CGSize(width: collectionView.frame.size.height / 0.65, height: collectionView.frame.size.height)

        }
        return CGSize(width: 0, height: 0)
    }
    @objc func btnCloseSliderClicked(_ sender : UIButton){
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == self.cvBrand {
            self.appNavigationController?.push(OtherProductDetailViewController.self,configuration: {vc in
                vc.selectedBranddata = self.arrbrand[indexPath.row]
                
            })
      }
       else  if collectionView == self.cvOther {
            self.appNavigationController?.push(ProductDetailViewController.self,configuration: { vc in
                vc.selectedproductdata = self.arrOther[indexPath.row].id
                vc.Url = self.arrOther[indexPath.row].shareLink
            })
        }
      else  if collectionView == self.cvCategory {
            self.appNavigationController?.push(ShopLinkViewController.self,configuration: { vc in
                vc.Url = self.arrcategory[indexPath.row].other_product_link
            })

      } else if collectionView == self.cvDiscount {
          
          if self.arrTutorial.count > 0 {
              let obj = self.arrTutorial[indexPath.row]
              guard let urldata = URL(string: "\(AppConstant.API.MAIN_URL)/assets/uploads/\(obj.redirectLink)") else { return }
              let safariVC = SFSafariViewController(url: urldata)
              safariVC.delegate = self
              safariVC.modalTransitionStyle = .crossDissolve
              safariVC.modalPresentationStyle = .overFullScreen
              self.present(safariVC, animated: true,completion: nil)
          }
      }
    }
}
// MARK: - SFSafariViewControllerDelegate
extension ShopViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
//MARK:- API Call
extension ShopViewController {
    
    private func productDashboardList() {
        if let user = UserModel.getCurrentUserFromDefault() {
        let dict : [String:Any] = [
            ktoken : user.token,
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
        productModel.productDashboardList(with: param, success: { (arrAd,totalCartProduct,arrlatest,arrBrand,arrbyOther,arrgiftCoupon,totalPages,message) in
            self.vwshownotification?.isHidden = false
            self.lblShownotification?.text = totalCartProduct
            self.arrcategory = arrlatest
            self.cvCategory?.reloadData()
            self.arrbrand = arrBrand
            self.cvBrand?.reloadData()
            self.arrOther = arrbyOther
            self.cvOther?.reloadData()
            self.arrCoupen = arrgiftCoupon
            self.arrTutorial = arrAd
            self.cvDiscount?.reloadData()
            delay(seconds: 0.2) {
                self.vwdiscountview?.reloadData()
            }
        }, failure: {[unowned self] (statuscode,error, errorType) in
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
     }
  }
    private func getGiftCouponNew() {
        if let user = UserModel.getCurrentUserFromDefault() {
        let dict : [String:Any] = [
            ktoken : user.token,
            klangType : Rosterd.sharedInstance.languageType
        ]
        
        let param : [String:Any] = [
            kData : dict
        ]
        
            ModelGiftCoupon.getGiftCouponNew(with: param, success: { (sub_data,message) in
           
            self.arrImageCoupon = sub_data
                self.vwCoupenView?.reloadData()
        }, failure: {[unowned self] (statuscode,error, errorType) in
            if !error.isEmpty {
                self.showMessage(error, themeStyle: .error)
            }
        })
     }
    
  }
    
  
}

// MARK: - IBAction


extension ShopViewController : MyCartDelegate{
    func updateCartData() {
        self.reloadProductData()
    }
    
    
}
    
//MARK: - IBAction Method
extension ShopViewController {
    
    @IBAction func btnAddCartClick() {
        self.appNavigationController?.push(MyCartViewController.self,configuration: { vc in
            vc.delegate = self
        })
    }
    
    
    @IBAction func btnOrderClick() {
        self.appNavigationController?.push(MyOrdersViewController.self)
       
    }
    
    @IBAction func btnSerachClick() {
        
        self.appNavigationController?.push(ShopSearchViewController.self)
    }
    
    
}

// MARK: - UIScrollViewDelegate
extension ShopViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    if scrollView == self.cvDiscount {
        pageControl.currentOfPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.scroll_did(scrollView)
        
    } else {
        let convertToWindow = self.vwCoupenView.globalFrame
        print("Content Offset:\(scrollView.contentOffset.y)")
        print("Content View:\(convertToWindow?.origin.y ?? 0)")
        print("View MaxY:\(self.vwBackBG.frame.maxY)")
        if scrollView == self.scrollViewShop {
            if  (convertToWindow?.minY ?? 0) <= self.vwBackBG.frame.maxY {
                if UserDefaults.isShowShopInfo == false {
                    UserDefaults.isShowShopInfo = true
                    self.appNavigationController?.present(CoupendetailViewController.self, configuration: { (vc) in
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .crossDissolve
                    })
                }
               
            }
        }
    }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.cvDiscount {
            print("scrollViewDidEndDecelerating : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
            self.currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        self.currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print("scrollViewDidEndScrollingAnimation : \(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))")
     
    }
}
        
// MARK: - ViewControllerDescribable
extension ShopViewController: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Shop
    }
}

// MARK: - AppNavigationControllerInteractable
extension ShopViewController: AppNavigationControllerInteractable { }
    

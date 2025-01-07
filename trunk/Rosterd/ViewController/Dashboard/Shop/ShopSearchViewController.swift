//
//  ShopSearchViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 25/07/22.
//

import UIKit

class ShopSearchViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var vwSearchView: SearchView!
    @IBOutlet weak var cvProductlist: UICollectionView!
    
    @IBOutlet weak var vwNoLabel: UIView!
    @IBOutlet weak var lblNolabel: NoDataFoundLabel!
    @IBOutlet weak var vwfilterview: UIView!
    @IBOutlet weak var btnFilter: UIButton!
    // MARK: - Variables
    private var arrProductlist : [productModel] = []
   var arrSizsData : [SizeModel] = []
     var arrColorData : [ColorModel] = []
    private var totalPages : Int = 0
    private var pageNo : Int = 1
    private var isLoading = false
    var selectedMinValue = Float()
    var SelectedMaxValue = Float()
    private var selecetdTab : filterEnum = .PriceHightoLow
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.reloadPrpductData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
      
        if let vwSubview = self.vwfilterview {
            vwSubview.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: vwSubview.frame, colors: [UIColor.CustomColor.gradiantColorTop,UIColor.CustomColor.gradiantColorBottom])
            vwSubview.cornerRadius = vwSubview.frame.height / 2.0
        }
        
       
        
    
    }
}


// MARK: - Init Configure
extension ShopSearchViewController {
    private func InitConfig() {
       
     
        if let cv = self.cvProductlist {
            cv.register(ProductFilterCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        self.vwSearchView?.txtSearch?.returnKeyType = .search
        self.vwSearchView?.txtSearch?.delegate = self
        self.vwSearchView?.txtSearch?.addTarget(self, action: #selector(self.textFieldSearchDidChange(_:)), for: .editingChanged)
        
        
        
    }
    private func configureNavigationBar() {
        
        appNavigationController?.setNavigationBarHidden(true, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        appNavigationController?.appNavigationControllersetUpBackWithTitle(title: "   Search", TitleColor: UIColor.CustomColor.blackColor, navigationItem: self.navigationItem)
        
        navigationController?.navigationBar
            .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
        navigationController?.navigationBar.removeShadowLine()
        
    }
}

//MARK: Pagination tableview Mthonthd
extension ShopSearchViewController {
    
    private func reloadPrpductData(){
        self.view.endEditing(true)
        self.pageNo = 1
        self.arrProductlist.removeAll()
        self.cvProductlist?.reloadData()
        self.getProductList()
    }
}

//MARK: - UICollectionView Delegate and Datasource Method
extension ShopSearchViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProductlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProductFilterCell.self)
        if self.arrProductlist.count > 0 {
          cell.SetOtherData(obj: self.arrProductlist[indexPath.row])
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
        return CGSize(width: (collectionView.frame.size.width / 2.0) - 10.0, height: ((collectionView.frame.size.width / 1.45) - 10.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.appNavigationController?.push(ProductDetailViewController.self,configuration: { vc in
            vc.selectedproductdata = self.arrProductlist[indexPath.row].id
            vc.Url = self.arrProductlist[indexPath.row].shareLink
            
        })
    }
    
}


//MARK: - IBAction Method
extension ShopSearchViewController {
    
    @IBAction func btnfilterClick(){
        self.appNavigationController?.present(ProductfilerViewController.self,configuration: { vc in
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            vc.arrSelectedSizeIndex = self.arrSizsData
            vc.arrSelectedColourIndex = self.arrColorData
            vc.selectedMinValue = self.selectedMinValue
            vc.selectedMaxValue = self.SelectedMaxValue
        })
     }
     
}

//MARK:- Filter Delegate
extension ShopSearchViewController : FilterDelegate {
    
    func applyFilter(arrSizs: [SizeModel], arrcolour: [ColorModel],selectedminPrice: Float,selectedmaxPrice: Float,selectedTab: filterEnum) {
        self.arrProductlist.removeAll()
        self.pageNo = 1
        self.totalPages = 0
        self.isLoading = false
        self.arrSizsData = arrSizs
        self.arrColorData = arrcolour
        self.selectedMinValue = selectedminPrice
        self.SelectedMaxValue = selectedmaxPrice
        self.selecetdTab = selectedTab
        self.cvProductlist.reloadData()
        self.reloadPrpductData()
    }
    
    func clearFilter() {
        self.arrProductlist.removeAll()
        self.pageNo = 1
        self.totalPages = 0
        self.isLoading = false
        self.arrSizsData.removeAll()
        self.arrColorData.removeAll()
        self.selectedMinValue = 0
        self.SelectedMaxValue = 0
        self.cvProductlist.reloadData()
        self.reloadPrpductData()
    }
    
    
}


extension ShopSearchViewController {
    
    private func getProductList(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault(){
      
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token,
           ksearch : self.vwSearchView?.txtSearch?.text ?? "",
           kminPrice : self.selectedMinValue == 0 ? "" : "\(self.selectedMinValue)",
           kmaxPrice : self.SelectedMaxValue == 0 ? "" : "\(self.SelectedMaxValue)",
           kproduct_size : self.arrSizsData.map({$0.id}),
           kproduct_color : self.arrColorData.map({$0.id}),
           ksort_by : self.selecetdTab.apiValue
           
       ]
       let param : [String:Any] = [
           kData : dict
       ]
       productModel.getProductList(with: param, isShowLoader: isshowloader, success: { (product_brand_image,totalCartProduct,arrProduct,totalpage,msg) in
          
               self.cvProductlist?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.totalPages = totalpage
               self.arrProductlist = arrProduct
               self.vwNoLabel?.isHidden = self.arrProductlist.count == 0 ? false : true
               self.cvProductlist?.reloadData()
               
           }, failure: {[unowned self] (statuscode,error, errorType) in
               print(error)
               self.cvProductlist?.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
               self.vwNoLabel?.isHidden = self.arrProductlist.count == 0 ? false : true

               if statuscode == APIStatusCode.NoRecord.rawValue {
                   self.lblNolabel?.text = error
                   self.cvProductlist?.reloadData()
                   
                
               } else {
                   if !error.isEmpty {
                       self.showMessage(error, themeStyle: .error)
                    
                   }
               }
           })
       }
   }
}

// MARK: - UITextFieldDelegate
extension ShopSearchViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if !(textField.isEmpty) {
            self.reloadPrpductData()
        }
        return true
    }
    
    @objc func textFieldSearchDidChange(_ textField: UITextField) {
        if textField.isEmpty {
            self.reloadPrpductData()
           
        }
    }
}


// MARK: - ViewControllerDescribable
extension ShopSearchViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
    return UIStoryboard.Name.Shop
}
}

// MARK: - AppNavigationControllerInteractable
extension ShopSearchViewController: AppNavigationControllerInteractable{}

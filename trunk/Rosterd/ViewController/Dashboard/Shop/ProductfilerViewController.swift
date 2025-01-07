//
//  ProductfilerViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 26/07/22.
//

import UIKit
import TTRangeSlider
import SwiftUI

protocol FilterDelegate {
    func applyFilter(arrSizs: [SizeModel], arrcolour: [ColorModel],selectedminPrice: Float,selectedmaxPrice: Float,selectedTab: filterEnum)
    func clearFilter()
}

class ProductfilerViewController: UIViewController{
    // MARK: - IBOutlet
    @IBOutlet weak var vwMainView: UIView?
    
    @IBOutlet weak var lblSortby: UILabel?
    @IBOutlet weak var lblsize: UILabel?
    @IBOutlet weak var lblColor: UILabel?
    @IBOutlet weak var lblpricerange: UILabel?
    @IBOutlet weak var lblShowpricerange: UILabel?
    
    @IBOutlet weak var vwhightolow: EventSegement?
    @IBOutlet weak var vwlowtohigh: EventSegement?
    @IBOutlet weak var vwsegementview: UIView!
    
    @IBOutlet weak var vwrangesilder: TTRangeSlider!
    
    @IBOutlet weak var cvSize: UICollectionView?
    @IBOutlet weak var cvColor: UICollectionView?
    
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnclose: UIButton?
    @IBOutlet weak var btnapplyfilter: AppButton?
    // MARK: - Variables
    var arrSelectedColourIndex = [ColorModel]()
    var arrSelectedSizeIndex = [SizeModel]()
     var arrSizsData : [SizeModel] = []
    var arrColorData : [ColorModel] = []
    private var selecetdTab : filterEnum = .PriceHightoLow
    private var arrColour : [ColorModel] = []
    var selectedcolour = [ColorModel]()
    private var arrSize : [SizeModel] = []
    var SelectedSizs = [SizeModel]()
    var selectedMinValue = Float()
    var selectedMaxValue = Float()
    var delegate : FilterDelegate?
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
              
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.vwsegementview?.backgroundColor = UIColor.CustomColor.SupportTopBGcolor
        self.vwsegementview?.cornerRadius = 15
        self.vwMainView?.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
    }
}

// MARK: - Init Configure
extension ProductfilerViewController {
    private func InitConfig() {
       
        self.lblSortby?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblSortby?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblsize?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblsize?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblColor?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblColor?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblpricerange?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 14.0))
        self.lblpricerange?.textColor = UIColor.CustomColor.headerTextColor
        
        self.lblShowpricerange?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        self.lblShowpricerange?.textColor = UIColor.CustomColor.ProductPrizeColor
        
        self.vwhightolow?.btnSelectTab?.tag = filterEnum.PriceHightoLow.rawValue
        self.vwlowtohigh?.btnSelectTab?.tag = filterEnum.PriceLowtoHigh.rawValue
        
        self.btnClear?.setTitleColor(UIColor.CustomColor.appColor, for: .normal)
        self.btnClear?.titleLabel?.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 15.0))
        
        let MAXVALUE = Float(self.selectedMaxValue)
        let MINVALUE = Float(self.selectedMinValue)

        self.lblShowpricerange?.text = "$\(String(format: "%.2f", MINVALUE)) - $\(String(format: "%.2f", MAXVALUE))"
        
        [self.vwhightolow,self.vwlowtohigh].forEach({
            $0?.EventsegementDelegate = self
        })
        
        self.setSelectedTab(obj: .PriceHightoLow, isUpdateVC: false)
        
        if let cv = self.cvColor {
            cv.register(ColorCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
        
        if let cv = self.cvSize {
            cv.register(SizeCell.self)
            cv.dataSource = self
            cv.delegate = self
        }
      
        self.vwrangesilder.delegate = self
        self.vwrangesilder.hideLabels = true
        self.vwrangesilder.handleImage = #imageLiteral(resourceName: "ic_Rangesilder")
        self.vwrangesilder.tintColorBetweenHandles = UIColor.CustomColor.appColor
        self.vwrangesilder.lineHeight = 6.0
        self.vwrangesilder.tintColor = UIColor.CustomColor.borderColorMsg
        self.vwrangesilder.handleColor = .clear
        self.vwrangesilder.minValue = 0
        self.vwrangesilder.maxValue = 10000
        self.vwrangesilder.selectedMinimum = self.selectedMinValue
        self.vwrangesilder.selectedMaximum = self.selectedMaxValue
        
        self.getProductList()
    }
  
}

extension ProductfilerViewController : TTRangeSliderDelegate {
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        
//        let selectedMinimumValue:Float = Float(selectedMinimum) ?? 0.00
//        self.selectedMinValue = "$\((Float(format:"%.2f", selectedMinimumValue)))"
//
        let MinValue = Float(selectedMinimum)
        let MaxValue = Float(selectedMaximum)
        
        self.lblShowpricerange?.text = "$\(String(format: "%.2f", MinValue)) - $\(String(format: "%.2f", MaxValue))"
        
        self.selectedMinValue = selectedMinimum
        self.selectedMaxValue = selectedMaximum
    }
}
//MARK: - SegmentTabDelegate
extension ProductfilerViewController : EventSegementDelegate {
    func tabSelect(_ sender: UIButton) {
        self.setSelectedTab(obj: filterEnum(rawValue: sender.tag) ?? .PriceHightoLow)
    }
    
    private func setSelectedTab(obj : filterEnum, isUpdateVC : Bool = true){
        switch obj {
        case .PriceHightoLow:
            self.selecetdTab = .PriceHightoLow
            self.vwhightolow?.isSelectTab = true
            self.vwlowtohigh?.isSelectTab = false
          
            break
        case .PriceLowtoHigh:
            self.selecetdTab = .PriceLowtoHigh
            self.vwhightolow?.isSelectTab = false
            self.vwlowtohigh?.isSelectTab = true
           
            break
      
        }
       
    }
}
//MARK: - UICollectionView Delegate and Datasource Method
extension ProductfilerViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvColor{
            return self.arrColour.count
        } else if collectionView == self.cvSize {
            return self.arrSize.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvColor {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ColorCell.self)
            let c_Info = arrColour[indexPath.row]
            cell.setFiltercolordata(obj: c_Info)
            if (arrSelectedColourIndex.firstIndex(where: {$0.id == c_Info.id}) != nil) {
                cell.vwMainview?.setCornerRadius(withBorder: 1, borderColor: UIColor.CustomColor.blackColor, cornerRadius: 18.0)
            }
            else {
                cell.vwMainview?.setCornerRadius(withBorder: 1, borderColor: .clear, cornerRadius: 25.0)
            }
             return cell

        } else if collectionView == self.cvSize {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SizeCell.self)
            let s_Info = arrSize[indexPath.row]
            cell.setSizedata(obj: s_Info)
            if (arrSelectedSizeIndex.firstIndex(where: {$0.id == s_Info.id}) != nil) {
                cell.lblSize?.textColor = UIColor.CustomColor.whitecolor
                cell.isselectCell = true
            }
            else {
                cell.lblSize?.textColor = UIColor.CustomColor.blackColor
                cell.isselectCell = false
            }

            return cell
     
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.cvColor {
            return 0
        }
        if collectionView == self.cvSize {
            return 15
        }
     
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.cvColor {
            return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
        } else if collectionView == self.cvSize {
            return CGSize(width: collectionView.frame.size.height / 1.0, height: collectionView.frame.size.height)
        }
        return CGSize(width: 0, height: 0)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.cvColor {
            let strData = arrColour[indexPath.item]
            
            if let index = arrSelectedColourIndex.firstIndex(where: {$0.id == strData.id}) {
                arrSelectedColourIndex.remove(at: index)
            }
            else {
                arrSelectedColourIndex.append(strData)
            }
            collectionView.reloadData()
            
        }
        else  if collectionView == self.cvSize {
            
            let strData = arrSize[indexPath.item]
            
            if let index = arrSelectedSizeIndex.firstIndex(where: {$0.id == strData.id}) {
                
                arrSelectedSizeIndex.remove(at: index)
            }
            else {
                arrSelectedSizeIndex.append(strData)
            }
            collectionView.reloadData()
            
        }
       
    }
}

//MARK: - IBAction Method
extension ProductfilerViewController {
    
    
    @IBAction func btncloseClick(){
    self.dismiss(animated: true, completion: nil)
     }
    
    @IBAction func btnapplyfilter(_ sender : AppButton) {
    
        self.delegate?.applyFilter(arrSizs: self.arrSelectedSizeIndex, arrcolour: self.arrSelectedColourIndex, selectedminPrice: self.selectedMinValue, selectedmaxPrice: self.selectedMaxValue, selectedTab: self.selecetdTab)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnClearFilterClick() {
        self.arrSelectedColourIndex.removeAll()
        self.arrSelectedColourIndex.removeAll()
        self.cvSize?.reloadData()
        self.cvColor?.reloadData()
        vwrangesilder.selectedMaximum = 0
        vwrangesilder.selectedMinimum = 0
        if let delegate = self.delegate {
            delegate.clearFilter()
        }
        self.dismiss(animated: true, completion: nil)
    }

}

extension ProductfilerViewController {
    
    
    private func getProductList(isshowloader :Bool = true){
   if let user = UserModel.getCurrentUserFromDefault(){
      
       let dict : [String:Any] = [
           klangType : Rosterd.sharedInstance.languageType,
           ktoken : user.token
           
       ]
       
       let param : [String:Any] = [
           kData : dict
       ]

       productModel.getShadeSizeData(with: param, isShowLoader: isshowloader, success: { (arr,shade,Sizearr,totalPages,message) in
           self.arrSize = Sizearr
           self.cvSize?.reloadData()
           self.arrColour = shade
           self.cvColor?.reloadData()
    
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
}

// MARK: - ViewControllerDescribable
extension ProductfilerViewController: ViewControllerDescribable {
static var storyboardName: StoryboardNameDescribable {
    return UIStoryboard.Name.Shop
}
}

// MARK: - AppNavigationControllerInteractable
extension ProductfilerViewController: AppNavigationControllerInteractable{}

//
//  HeightWeightViewController.swift
//  Rosterd
//
//  Created by WMiosdev01 on 23/05/22.
//


    import UIKit

    class HeightWeightViewController: UIViewController {

        // MARK: - IBOutlet
        @IBOutlet weak var vwMain: UIView!
        @IBOutlet weak var vwSubContent: UIView!
        @IBOutlet weak var vwInchPicker: UIView!
        @IBOutlet weak var vwInchContent: UIView!
        
        @IBOutlet weak var lblContentTitle: UILabel!
        @IBOutlet weak var lblFTHeader: UILabel!
        @IBOutlet weak var lblInchHeader: UILabel!
        
        @IBOutlet var FtPickerView: UIPickerView!
        @IBOutlet var InchPickerView: UIPickerView!
        
        // MARK: - Variables
        private var arrFit : [String] = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        private var arrInch : [String] = ["1","2","3","4","5","6","7","8","9","10"]
        private var arrWeight : [Int] = []
        
        var isFromWeight : Bool = false
        
        // MARK: - LIfe Cycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            self.InitConfigure()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
//            self.configureNavigationBar()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        }
    }

    // MARK: - UI helpers
    extension HeightWeightViewController  {
        func InitConfigure() {
            
            for i in stride(from: 1, to: 999, by: 1){
                self.arrWeight.append(i)
            }
            
//            self.vwMain.backgroundColor = UIColor.CustomColor.registerColor
            self.vwSubContent.backgroundColor = UIColor.CustomColor.whitecolor
            
//            self.lblContentTitle.font = UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 24.0))
//            self.lblContentTitle.textColor = UIColor.CustomColor.whitecolor
            
            [self.lblFTHeader,self.lblInchHeader].forEach({
                $0?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 16.0))
                $0?.textColor = UIColor.CustomColor.blackColor
            })
            
            [self.FtPickerView,self.InchPickerView].forEach({
                $0?.delegate = self
                $0?.dataSource = self
            })
            
            delay(seconds: 0.2) {
                self.vwSubContent.roundCorners(corners: [.topLeft,.topRight], radius: 20.0)
            }
            
            if self.isFromWeight {
                self.vwInchPicker.isHidden = true
                self.vwInchContent.isHidden = true
                self.lblFTHeader.text = "lbs"
                self.lblContentTitle.text = "What is your weight?"
            }
        }
        
//        private func configureNavigationBar() {
//            appNavigationController?.setNavigationBarHidden(true, animated: true)
//            appNavigationController?.navigationBar.backgroundColor = UIColor.clear
//            self.navigationController?.setNavigationBarHidden(false, animated: false)
//            appNavigationController?.appNavigationControllerTitle(title: "", TitleColor: .clear, navigationItem: self.navigationItem)
//            navigationController?.navigationBar
//                .configure(barTintColor: UIColor.clear, tintColor: UIColor.CustomColor.borderColor)
//            navigationController?.navigationBar.removeShadowLine()
//        }
    }
    //MARK:- UiPickerView Delegate
    extension HeightWeightViewController : UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if self.isFromWeight {
                return self.arrWeight.count
            }
            return (pickerView == self.FtPickerView) ? self.arrFit.count : self.arrInch.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if self.isFromWeight {
                return "\(self.arrWeight[row])"
            }
            return (pickerView == self.FtPickerView) ? self.arrFit[row] : self.arrInch[row]
        }
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 50
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
        {
            //if #available(iOS 14.0, *) {
            let height: CGFloat = 1
            for subview in pickerView.subviews {
                /* smaller than the row height plus 20 point, such as 40 + 20 = 60*/
                if subview.frame.size.height < 60 {
                    if subview.subviews.isEmpty {
                        let topLineView = UIView()
                        topLineView.frame = CGRect(x: 0.0, y: 0.0, width: subview.frame.size.width, height: height)
                        topLineView.backgroundColor = UIColor.CustomColor.sepratorcolor
                        subview.addSubview(topLineView)
                        let bottomLineView = UIView()
                        bottomLineView.frame = CGRect(x: 0.0, y: subview.frame.size.height - height, width: subview.frame.size.width, height: height)
                        bottomLineView.backgroundColor = UIColor.CustomColor.sepratorcolor
                        subview.addSubview(bottomLineView)
                    }
                }
                subview.backgroundColor = .clear
            }
            //}
            var font : UIFont = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 16.0))
            let pickerLabel = UILabel()
            if pickerView.selectedRow(inComponent: component) == row {
                pickerLabel.textColor = UIColor.CustomColor.labelTextColor
                font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 16.0))
                
            } else {
                pickerLabel.textColor = UIColor.CustomColor.labelTextColorAlpha
                font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 16.0))
            }
            if self.isFromWeight {
                pickerLabel.text = "\(self.arrWeight[row])"
            } else {
                pickerLabel.text = (pickerView == self.FtPickerView) ? self.arrFit[row] : self.arrInch[row]
            }
            
            pickerLabel.font =  font
            pickerLabel.textAlignment = NSTextAlignment.center
            return pickerLabel
            
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            pickerView.reloadAllComponents()
        }
        
    }

    // MARK: - ViewControllerDescribable
    extension HeightWeightViewController: ViewControllerDescribable {
        static var storyboardName: StoryboardNameDescribable {
            return UIStoryboard.Name.auth
        }
    }

    // MARK: - AppNavigationControllerInteractable
    extension HeightWeightViewController: AppNavigationControllerInteractable{}

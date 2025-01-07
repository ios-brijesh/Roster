//
//  SegmentTabView.swift
//  Tipper
//
//  Created by Wdev3 on 23/02/21.
//

import UIKit
protocol SegmentTabDelegate {
    func tabSelect(_ sender : UIButton)
}

class SegmentTabView: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var lblTabName: UILabel?
    
    @IBOutlet weak var vwRightDotMain: UIView?
    @IBOutlet weak var vwRightDot: UIView?
    
    @IBOutlet weak var btnSelectTab: UIButton?
    
    //MARK: Variables
    var contentView:UIView?
    let nibName = "SegmentTabView"
    var segmentDelegate : SegmentTabDelegate?
    
    //MARK: - Life Cycle Methods
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        self.InitConfig()
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBInspectable
    var setRightViewBackgroundColor : UIColor = UIColor.CustomColor.whitecolor {
        didSet{
            self.vwRightDot?.backgroundColor = setRightViewBackgroundColor
        }
    }
    
    @IBInspectable
    var setTabName : String = "" {
        didSet{
            self.lblTabName?.text = setTabName
        }
    }
    @IBInspectable
    var isHideRightDotView : Bool = false{
        didSet{
            self.vwRightDotMain?.isHidden = isHideRightDotView
        }
    }
    
    @IBInspectable
    var isSelectTab : Bool = false{
        didSet{
            //self.vwTabBottomBar.isHidden = isHideBottomBarView
            self.lblTabName?.textColor = isSelectTab ? UIColor.CustomColor.labelTextColor : UIColor.CustomColor.labelTextColor
            self.lblTabName?.backgroundColor = isSelectTab ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.whitecolor
            self.lblTabName?.font = isSelectTab ? UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 20.0)) : UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        }
    }
    
    @IBInspectable
    var isSelectReportTab : Bool = false{
        didSet{
            //self.vwTabBottomBar.isHidden = isHideBottomBarView
            self.lblTabName?.textColor = isSelectReportTab ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.labelTextColor
            self.lblTabName?.backgroundColor = isSelectReportTab ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.viewBGColor
            self.lblTabName?.font = isSelectReportTab ? UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0)) : UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 13.0))
            self.lblTabName?.cornerRadius = (self.lblTabName?.frame.height ?? 0.0) / 2
        }
    }
    
    @IBInspectable
    var isSelectMoneyTab : Bool = false{
        didSet{
            //self.vwTabBottomBar.isHidden = isHideBottomBarView
            self.lblTabName?.textColor = isSelectMoneyTab ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.reusableTextColor
            self.lblTabName?.backgroundColor = isSelectMoneyTab ? UIColor.CustomColor.statusTicketColor : UIColor.clear
            self.lblTabName?.font = isSelectMoneyTab ? UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0)) : UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 12.0))
        }
    }
    

    // MARK: - Init Configure
    private func InitConfig(){
        self.lblTabName?.textColor = UIColor.CustomColor.labelTextColor
        self.lblTabName?.font = UIFont.PoppinsMedium(ofSize: GetAppFontSize(size: 11.0))
        
        self.vwRightDot?.backgroundColor = UIColor.CustomColor.segmentDotColor
        
        self.lblTabName?.cornerRadius = 15.0
        
    }

    @IBAction func btnSelectTabClicked(_ sender: UIButton) {
        self.segmentDelegate?.tabSelect(sender)
    }
}

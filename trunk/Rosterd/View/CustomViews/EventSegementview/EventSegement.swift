//
//  EventSegement.swift
//  Rosterd
//
//  Created by WMiosdev01 on 26/01/22.
//

import UIKit


protocol EventSegementDelegate {
    func tabSelect(_ sender : UIButton)
}
class EventSegement: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var lblTabName: UILabel?
    
    @IBOutlet weak var vwRightDotMain: UIView?
    @IBOutlet weak var vwRightDot: UIView?
    
    @IBOutlet weak var btnSelectTab: UIButton?

    //MARK: Variables
    
    var contentView:UIView?
    let nibName = "EventSegement"
    var EventsegementDelegate : EventSegementDelegate?
    
    
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
            self.lblTabName?.textColor = isSelectTab ? UIColor.CustomColor.appColor : UIColor.CustomColor.ProductPrizeColor
            self.lblTabName?.backgroundColor = isSelectTab ? UIColor.CustomColor.whitecolor : UIColor.CustomColor.SupportTopBGcolor
            self.lblTabName?.font = isSelectTab ? UIFont.PoppinsSemiBold(ofSize: GetAppFontSize(size: 12.0)) : UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
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
        self.lblTabName?.font = UIFont.PoppinsRegular(ofSize: GetAppFontSize(size: 12.0))
        
        self.vwRightDot?.backgroundColor = UIColor.CustomColor.segmentDotColor
        
        self.lblTabName?.cornerRadius = 08.0
        
    }

    @IBAction func btnSelectTabClicked(_ sender: UIButton) {
        self.EventsegementDelegate?.tabSelect(sender)
    }
    

}

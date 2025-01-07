//
//  TabBarView.swift
//  Tipper
//
//  Created by Wdev3 on 19/02/21.
//

import UIKit

protocol TabbarItemDelegate {
    func selectTabButton(_ sender : UIButton)
}

class TabBarItemView: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var imgTab: UIImageView?
    @IBOutlet weak var btnSelect: UIButton?
    
    //MARK: Variables
    var contentView:UIView?
    let nibName = "TabBarItemView"
    var delegate : TabbarItemDelegate?
    
    //MARK: - Life Cycle Methods
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
        
        initialConfig()
        
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //self.vwImageActive?.maskToBounds = true
        
    }
    
    /*@IBInspectable var isSelectedTab: Bool = false {
        didSet {
            self.vwImageActive.isHidden = !isSelectedTab
            
            //transitionCrossDissolve
            UIView.transition(with: self.lblTabName, duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                                //self.lblTabName.isHidden = !self.isSelectedTab
                                //self.imgTab.isHidden = isSelectedTab
                                self.lblTabName.textColor = UIColor.CustomColor.whitecolor.withAlphaComponent(self.isSelectedTab ? 1.0 : 0.8)
                              })
            
            UIView.transition(with: self.imgTab, duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                                //self.lblTabName.isHidden = !isSelectedTab
                                //self.imgTab.isHidden = self.isSelectedTab
                              })
            
        }
    }*/
    
    func isSelectedTab(selecetdTab : Bool, tabType : TabbarItemType){
        if let view = self.imgTab {
            UIView.transition(with: view, duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                self.imgTab?.image = selecetdTab ? tabType.imgSelected : tabType.imgDeSelect
            })
        }
    }
    
    //MARK: - Helper Methods
    private func initialConfig() {
      
    }
    @IBAction func btnSelectClicked(_ sender: UIButton) {
        self.delegate?.selectTabButton(sender)
    }
}

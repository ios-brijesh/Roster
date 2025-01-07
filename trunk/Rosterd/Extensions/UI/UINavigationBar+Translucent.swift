//
//  UINavigationBar+Translucent.swift
//  Momentor
//
//  Created by mac on 16/01/2020.
//  Copyright © 2019 Differenzsystem Pvt. LTD. All rights reserved.
//

import UIKit
import AVFoundation

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func popToPerticularViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
          popToViewController(vc, animated: animated)
        }
      }
}

extension UINavigationBar {
    @discardableResult func makeTranslucent(isTranslucent: Bool = true) -> UINavigationBar {
        configure(barTintColor: .clear, tintColor: .white)
        
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
        self.isTranslucent = isTranslucent
        
        return self
    }
    
    @discardableResult func configure(barTintColor: UIColor,
                                      tintColor: UIColor) -> UINavigationBar {
        self.barTintColor = barTintColor
        self.tintColor = tintColor
        return self
    }
    
    func removeShadowLine() {
        self.shadowImage = UIImage()
    }
}

extension UINavigationItem {
    func removeBackButtontext() {
        self.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UINavigationBar {
    /// Applies a background gradient with the given colors
    func apply(gradient colors : [UIColor]) {
        let frameAndStatusBar: CGRect = self.bounds
//        frameAndStatusBar.size.height += 20
        let image = UIImage.gradient(size: frameAndStatusBar.size, colors: colors)
        setBackgroundImage(image, for: .default)
        Rosterd.sharedInstance.navigationBackgroundImage = image
    }
}

extension UITabBar {
    /// Applies a background gradient with the given colors
    func apply(gradient colors : [UIColor]) {
        let frameAndStatusBar: CGRect = self.bounds
        self.backgroundImage = UIImage.gradient(size: frameAndStatusBar.size, colors: colors)
    }
}

extension UIImage {
    /// Creates a gradient image with the given settings
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage? {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}

// MARK: - UIBarButtonItem's Extension

extension UIBarButtonItem {
    
    class func makBarButtonItem(with image: UIImage?, color: UIColor, target: Any?, action: Selector?) -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        buttonItem.tintColor = color
        return buttonItem
    }
    
    class func makBarButtonDisableItem(with title: String?, color: UIColor, font: UIFont?, target: Any?, action: Selector) -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        buttonItem.tintColor = color
        buttonItem.isEnabled = false
        if let font = font {
            buttonItem.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
            buttonItem.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .highlighted)
            let titleParagraphStyle = NSMutableParagraphStyle()
            titleParagraphStyle.alignment = .center
            buttonItem.setTitleTextAttributes([NSAttributedString.Key.font : font,NSAttributedString.Key.foregroundColor : color,NSAttributedString.Key.paragraphStyle : titleParagraphStyle], for: .disabled)
        }
        return buttonItem
    }
    
    class func makBarButtonItem(with title: String?, color: UIColor, font: UIFont?, target: Any?, action: Selector) -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        buttonItem.tintColor = color
        if let font = font {
            buttonItem.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
            buttonItem.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .highlighted)
        }
        return buttonItem
    }
    
    class func makBarButtonItemImageWithText(with title: String?,colorfulImage: UIImage?, color: UIColor, font: UIFont?, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        //button.frame = CGRect(x: 0.0, y: 0.0, width: 150.0, height: 44.0)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        //button.titleLabel?.textColor = UIColor.CustomColor.logoutTextColor
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = UIColor.clear
        button.maskToBounds = true
        
        let barButtonItem = UIBarButtonItem(customView: button)
        //let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 150.0)
        //currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        return barButtonItem
    }
    
    class func itemWithBackPic(colorfulImage: UIImage?, target: AnyObject, action: Selector,url : String = "") -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        //button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        //button.layer.cornerRadius = 10.0
        button.addTarget(target, action: action, for: .touchUpInside)
        /*if url != "" {
            //button.setImage(colorfulImage, for: .normal)//setImage(withUrl: url, placeholderImage: #imageLiteral(resourceName: "ImgPlaceholder"), indicatorStyle: .white, isProgressive: false, imageindicator: .white)
            button.imageView?.contentMode = .center
            //button.imageView?.contentMode = .scaleToFill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //button.imageView?.frame = button.frame
            //button.backgroundColor = UIColor.green
            button.adjustsImageWhenHighlighted = false
            
        }*/
        
       // button.backgroundColor = UIColor.CustomColor.whitecolor
       // button.maskToBounds = true
        //button.cornerRadius = button.frame.height / 3//13.0
        //button.shadow(UIColor.CustomColor.shadowColor, radius: 6.0, offset: CGSize(width: 5, height: 3), opacity: 1)
        //button.maskToBounds = false
        
        let barButtonItem = UIBarButtonItem(customView: button)
        let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 44.0)
        currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        return barButtonItem
    }
    
    class func itemWithBackOtherPic(colorfulImage: UIImage?, target: AnyObject, action: Selector,url : String = "") -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        //button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        //button.layer.cornerRadius = 10.0
        button.addTarget(target, action: action, for: .touchUpInside)
        /*if url != "" {
            //button.setImage(colorfulImage, for: .normal)//setImage(withUrl: url, placeholderImage: #imageLiteral(resourceName: "ImgPlaceholder"), indicatorStyle: .white, isProgressive: false, imageindicator: .white)
            button.imageView?.contentMode = .center
            //button.imageView?.contentMode = .scaleToFill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //button.imageView?.frame = button.frame
            //button.backgroundColor = UIColor.green
            button.adjustsImageWhenHighlighted = false
            
        }*/
        
        //button.backgroundColor = UIColor.CustomColor.BackBGColor
        button.maskToBounds = true
        //button.cornerRadius = button.frame.height / 3//13.0
        //button.shadow(UIColor.CustomColor.shadowColor, radius: 6.0, offset: CGSize(width: 5, height: 3), opacity: 1)
        //button.maskToBounds = false
        
        let barButtonItem = UIBarButtonItem(customView: button)
        let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 44.0)
        currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        return barButtonItem
    }
    
    class func btnWithPicDashboard(colorfulImage: UIImage?, target: AnyObject, action: Selector,url : String = "") -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        //button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        //button.layer.cornerRadius = 10.0
        button.addTarget(target, action: action, for: .touchUpInside)
        /*if url != "" {
            //button.setImage(colorfulImage, for: .normal)//setImage(withUrl: url, placeholderImage: #imageLiteral(resourceName: "ImgPlaceholder"), indicatorStyle: .white, isProgressive: false, imageindicator: .white)
            button.imageView?.contentMode = .center
            //button.imageView?.contentMode = .scaleToFill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //button.imageView?.frame = button.frame
            //button.backgroundColor = UIColor.green
            button.adjustsImageWhenHighlighted = false
            
        }*/
        /*button.backgroundColor = UIColor.CustomColor.whitecolor
        button.maskToBounds = true
        button.cornerRadius = 10.0
        button.shadow(UIColor.CustomColor.shadowColor, radius: 6.0, offset: CGSize(width: 5, height: 3), opacity: 1)
        button.maskToBounds = false*/
        //button.contentMode = .center
        //button.imageView?.contentMode = .scaleAspectFit
        
        button.backgroundColor = UIColor.CustomColor.whitecolor
        button.maskToBounds = true
        button.cornerRadius = button.frame.height / 3
        
        let barButtonItem = UIBarButtonItem(customView: button)
        let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 44.0)
        currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        return barButtonItem
    }
    
    class func itemWithBackVideoCall(colorfulImage: UIImage?, target: AnyObject, action: Selector,url : String = "") -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        //button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        //button.layer.cornerRadius = 10.0
        button.addTarget(target, action: action, for: .touchUpInside)
        /*if url != "" {
            //button.setImage(colorfulImage, for: .normal)//setImage(withUrl: url, placeholderImage: #imageLiteral(resourceName: "ImgPlaceholder"), indicatorStyle: .white, isProgressive: false, imageindicator: .white)
            button.imageView?.contentMode = .center
            //button.imageView?.contentMode = .scaleToFill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //button.imageView?.frame = button.frame
            //button.backgroundColor = UIColor.green
            button.adjustsImageWhenHighlighted = false
            
        }*/
        
        button.backgroundColor = UIColor.CustomColor.videoBackcolor25
        button.maskToBounds = true
        button.cornerRadius = button.frame.height / 3//13.0
        //button.shadow(UIColor.CustomColor.shadowColor, radius: 6.0, offset: CGSize(width: 5, height: 3), opacity: 1)
        //button.maskToBounds = false
        
        let barButtonItem = UIBarButtonItem(customView: button)
        let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 44.0)
        currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        return barButtonItem
    }
    
    class func btnWithPicNotesDashboard(colorfulImage: UIImage?, target: AnyObject, action: Selector,url : String = "") -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        //button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        //button.layer.cornerRadius = 10.0
        button.addTarget(target, action: action, for: .touchUpInside)
        //button.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        /*if url != "" {
            //button.setImage(colorfulImage, for: .normal)//setImage(withUrl: url, placeholderImage: #imageLiteral(resourceName: "ImgPlaceholder"), indicatorStyle: .white, isProgressive: false, imageindicator: .white)
            button.imageView?.contentMode = .center
            //button.imageView?.contentMode = .scaleToFill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //button.imageView?.frame = button.frame
            //button.backgroundColor = UIColor.green
            button.adjustsImageWhenHighlighted = false
            
        }*/
        //button.backgroundColor = UIColor.red
        /*button.backgroundColor = UIColor.CustomColor.whitecolor
        button.maskToBounds = true
        button.cornerRadius = 10.0
        button.shadow(UIColor.CustomColor.shadowColor, radius: 6.0, offset: CGSize(width: 5, height: 3), opacity: 1)
        button.maskToBounds = false*/
        //button.contentMode = .center
        //button.imageView?.contentMode = .scaleAspectFit
        
        button.backgroundColor = UIColor.CustomColor.whitecolor
        button.maskToBounds = true
        button.cornerRadius = button.frame.height / 3
        
        let barButtonItem = UIBarButtonItem(customView: button)
        let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 44.0)
        currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        //barButtonItem.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        return barButtonItem
    }
    
    class func itemWithBackRoundPic(colorfulImage: UIImage?, target: AnyObject, action: Selector,url : String = "") -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        //button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        button.maskToBounds = true
        button.layer.cornerRadius = button.frame.height / 2.0
        button.addTarget(target, action: action, for: .touchUpInside)
        /*if url != "" {
            //button.setImage(colorfulImage, for: .normal)//setImage(withUrl: url, placeholderImage: #imageLiteral(resourceName: "ImgPlaceholder"), indicatorStyle: .white, isProgressive: false, imageindicator: .white)
            button.imageView?.contentMode = .center
            //button.imageView?.contentMode = .scaleToFill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //button.imageView?.frame = button.frame
            //button.backgroundColor = UIColor.green
            button.adjustsImageWhenHighlighted = false
            
        }*/
        
        button.backgroundColor = UIColor.CustomColor.cardBackColor
       // button.maskToBounds = true
        //button.cornerRadius = button.frame.height / 3//13.0
        //button.shadow(UIColor.CustomColor.shadowColor, radius: 6.0, offset: CGSize(width: 5, height: 3), opacity: 1)
        //button.maskToBounds = false
        
        let barButtonItem = UIBarButtonItem(customView: button)
        let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 44.0)
        currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        return barButtonItem
    }
    
    class func btnWithLogoPic(colorfulImage: UIImage?, target: AnyObject, action: Selector,url : String = "") -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.isEnabled = false
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 44.0)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 80.0)
        currWidth?.isActive = true
        let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 44.0)
        currHeight?.isActive = true
        
        return barButtonItem
    }
}

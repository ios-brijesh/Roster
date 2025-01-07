//
//  UIView+Layer.swift
//  Momentor
//
//  Created by mac on 16/01/2020.
//  Copyright © 2019 Differenzsystem Pvt. LTD. All rights reserved.
//

import UIKit

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
}

extension UIView {
    
    @discardableResult func borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        layer.masksToBounds = true
        
        return self
    }
    
    @discardableResult func borderColor(_ color: UIColor = .black) -> Self {
        layer.borderColor = color.cgColor
        
        return self
    }
    
    @discardableResult func removeBorder() -> Self {
        return borderColor(.clear)
            .borderWidth(0)
    }
    
    @discardableResult func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
        return self
    }
    
    @discardableResult func roundSides() -> Self {
        return cornerRadius(bounds.height / 2.0)
    }
    
    @discardableResult func roundedCornerRadius() -> Self {
        return cornerRadius(min(bounds.height, bounds.width) / 2.0)
    }
   
    
    
    @discardableResult func shadowColor(_ color: UIColor) -> Self {
        layer.shadowColor = color.cgColor
        
        return self
    }
    
    @discardableResult func shadowOffset(_ offset: CGSize) -> Self {
        layer.shadowOffset = offset
        
        return self
    }
    
    @discardableResult func shadowOpacity(_ opacity: Float) -> Self {
        layer.shadowOpacity = opacity
        
        return self
    }
    
    @discardableResult func shadowRadius(_ radius: CGFloat) -> Self {
        layer.shadowRadius = radius
        
        return self
    }
    
    @discardableResult func roundCorners(_ corners: UIRectCorner,
                                         radius: CGFloat) -> Self {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
        
        return self
    }
    
    func roundCustomeCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
        
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
        self.layer.shadowPath = maskPath.cgPath//UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        /*self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.red.cgColor*/
    }
    
    @discardableResult func shadow(_ color: UIColor = .black,
                                   radius: CGFloat = 3,
                                   offset: CGSize = .zero,
                                   opacity: Float = 0.5) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        
        return self
    }
    
    /**
     This method is used to give size constraints custom view of navigation item.
     - Parameter size: Size of view.
     */
    func applyNavBarConstraints(with size: CGSize) {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
    }
    
   
    /**
     This method is used to show shadow.
     - Parameters:
     - color: Color of shadow
     - opacity: Opacity of shadow
     - offset: Shadow offset
     - radius: Shadow radius
     */
    func showShadow(with color: UIColor = .gray, opacity: Float = 1.0, offset: CGSize = CGSize(width: 0, height: 1), radius : CGFloat = 1.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /**
     This method is used to show shadow to all side of view.
     - Parameters:
     - color: Color of shadow
     - opacity: Opacity of shadow
     */
    func showShadowToAllSide(with color: UIColor = .black, opacity: Float = 1.0) {
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    /**
     This method is used to remove shadow.
     */
    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.masksToBounds = false
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func createDottedLine(width: CGFloat, color: CGColor) {
       let caShapeLayer = CAShapeLayer()
       caShapeLayer.strokeColor = color
       caShapeLayer.lineWidth = width
       caShapeLayer.lineDashPattern = [2,3]
       let cgPath = CGMutablePath()
       let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
       cgPath.addLines(between: cgPoint)
       caShapeLayer.path = cgPath
       layer.addSublayer(caShapeLayer)
    }
    
    func createDashedLine(width: CGFloat, color: CGColor) {
       let caShapeLayer = CAShapeLayer()
       caShapeLayer.strokeColor = color
       caShapeLayer.lineWidth = width
       caShapeLayer.lineDashPattern = [10,10]
       let cgPath = CGMutablePath()
       let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
       cgPath.addLines(between: cgPoint)
       caShapeLayer.path = cgPath
       layer.addSublayer(caShapeLayer)
    }
    
    func addDashedBorder() {
        let color = UIColor.CustomColor.borderColor.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor//UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [10,10]
        //shapeLayer.cornerRadius = 15.0
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 15).cgPath
        self.layer.masksToBounds = false
        self.layer.addSublayer(shapeLayer)
    }
    
    // Top Anchor
    var safeAreaTopAnchor: NSLayoutYAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.topAnchor
      } else {
        return self.topAnchor
      }
    }

    // Bottom Anchor
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.bottomAnchor
      } else {
        return self.bottomAnchor
      }
    }

    // Left Anchor
    var safeAreaLeftAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.leftAnchor
      } else {
        return self.leftAnchor
      }
    }

    // Right Anchor
    var safeAreaRightAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.rightAnchor
      } else {
        return self.rightAnchor
      }
    }
    
    /**
     This method is used to set Corner Radiuse.
     - Parameters:
     - borderWidth: set border Width
     - borderColor: set border Color
     - cornerRadius: set corner radius
     */
    func setCornerRadius(withBorder borderWidth: CGFloat, borderColor: UIColor , cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    /*Rotate a view by specified degrees
    
    - parameter angle: angle in degrees
    */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}


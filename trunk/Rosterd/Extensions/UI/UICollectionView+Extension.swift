//
//  UICollectionView+Extension.swift
//  Momentor
//
//  Created by wmdevios-h on 11/09/21.
//

import Foundation

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        print("X : \(self.contentOffset.x) Width : \(self.bounds.size.width)")
        if self.contentOffset.x <= self.bounds.size.width {
            self.moveToFrame(contentOffset: contentOffset)
        }
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}

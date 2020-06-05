//
//  HQTextFieldExtension.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/6.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import Foundation
import UIKit


// FIXME: - 给UITextField添加晃动效果
extension UITextField {
    
    func shakeField() {
        let animation = CABasicAnimation.init(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue.init(cgPoint: CGPoint.init(x: self.centerX - 10, y: self.centerY))
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: self.centerX + 10, y: self.centerY))
        self.layer.add(animation, forKey: "position")
    }
}

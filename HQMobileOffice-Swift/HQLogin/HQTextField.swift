//
//  HQTextField.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = UIColor.blue
    }
    
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        var originalRect = super.caretRect(for: position)
        originalRect.origin.y += 2
        originalRect.size.height = (self.font?.lineHeight)!-2
        originalRect.size.width = 2
        return originalRect
    }
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let inset = CGRect.init(x: bounds.origin.x+70, y: bounds.origin.y, width:bounds.size.width, height: bounds.size.height)
        return inset
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let inset = CGRect.init(x: bounds.origin.x+70, y: bounds.origin.y, width:bounds.size.width, height: bounds.size.height)
        return inset
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let inset = CGRect.init(x: bounds.origin.x+66, y: bounds.origin.y, width:bounds.size.width, height: bounds.size.height)
        return inset
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let inset = CGRect.init(x: bounds.origin.x+25, y: bounds.origin.y + 13, width:20, height: 20)
        return inset
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let inset = CGRect.init(x: bounds.size.width - 30, y: bounds.origin.y + 18, width: 20, height: 14)
        return inset
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

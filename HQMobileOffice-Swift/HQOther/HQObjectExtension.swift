//
//  HQObjectExtension.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/9.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import Foundation

extension NSObject {
    
    func showText(text:String,view:UIView, after:Double) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = text
        hud.label.textColor = RGBA(r: 50, g: 50, b: 50, a: 0.5)
        hud.hide(animated: true, afterDelay: after)
    }
}

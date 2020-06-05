//
//  HQMainTool.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQMainTool: NSObject {

   class func chooseRootController()  {
        let key = "CFBundleVersion"
        
        let userDefaluts = UserDefaults.standard
        
        // 取出沙盒中存储的上次使用软件的版本号
        let lastVersion = userDefaluts.string(forKey: key)
        
        // 获得当前软件的版本号
        let infoDictionary = Bundle.main.infoDictionary!

 
        let currentVersion = infoDictionary[key] as! String//版本号（内部标示）
        if currentVersion == lastVersion {
            // 显示状态栏
            
            let tokenId = userDefaluts.string(forKey:"tokenId")
            if tokenId != nil {
                UIApplication.shared.keyWindow?.rootViewController = HQTabBarViewController()

            } else {
                let loginVc = HQLoginViewController()
                UIApplication.shared.keyWindow?.rootViewController = loginVc
            }
           
        } else { // 新版本
            UIApplication.shared.keyWindow?.rootViewController = HQNewfeatureViewController()
            // 存储新版本
            userDefaluts.set(currentVersion, forKey: key)
            userDefaluts.synchronize()
        }
    }
}

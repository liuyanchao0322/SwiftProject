//
//  HQLoginViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let loginView = HQLoginView()
        loginView.frame = view.bounds
        loginView.didLoginBtnClick = {
            (name:String, pass:String) ->()
            in
            print(name,pass)
           self.loginAction(name: name, pass: pass)
        }
        view.addSubview(loginView)
    }
    func loginAction(name:String, pass:String) {
        HQUserDefaults.setDataObject(object: "5960f0e6ba354e1286db03466ff6f0c2", key: "tokenId")
        let tabBarVc = HQTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabBarVc
    }

}

// FIXME: - 扩展，可以为系统的类、结构体、自定义的类等对象添加扩展
// MARK: -  扩展，可以为系统的类、结构体、自定义的类等对象添加扩展，
extension CGRect {
    
    init(center:CGPoint, size:CGSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: CGPoint.init(x: originX, y: originY), size: size)
    }
}


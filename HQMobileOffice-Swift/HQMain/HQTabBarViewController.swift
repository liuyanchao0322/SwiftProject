//
//  HQTabBarViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/2.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let workVc = HQWorkViewController()
        self.setupChildViewController(childVc: workVc, title: "工作", image: "work", selectImage: "work")
        
        let notiVc = TestViewController()
        self.setupChildViewController(childVc: notiVc, title: "通知", image: "noti", selectImage: "noti")
        
        let mineVc = HQMineViewController()
        self.setupChildViewController(childVc: mineVc, title: "我", image: "mine", selectImage: "mine")
    }

    func setupChildViewController(childVc: UIViewController,title:String, image:String, selectImage:String) {
        
        childVc.title = title
        childVc.tabBarItem.title = title
        childVc.tabBarItem.image = UIImage.init(named: image)
        childVc.tabBarItem.selectedImage = UIImage.init(named: selectImage)
        
    childVc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.black], for: .normal)
    childVc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.blue], for: .selected)

//        childVc.tabBarItem.setTitleTextAttributes(textAttrs as? [NSAttributedStringKey : Any], for: UIControlState.normal)
//        childVc.tabBarItem.setTitleTextAttributes(selectTextAttrs as? [NSAttributedStringKey : Any], for: UIControlState.selected)
        
        
        let navi = HQNaviViewController.init(rootViewController: childVc)
        self.addChildViewController(navi)
    }
}

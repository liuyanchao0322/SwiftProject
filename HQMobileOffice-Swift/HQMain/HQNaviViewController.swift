//
//  HQNaviViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/2.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(self.createImageWithColor(color: RGBA(r: 56, g: 152, b: 246, a: 1)), for: UIBarMetrics.default)
        
        self.navigationBar.titleTextAttributes = [kCTForegroundColorAttributeName:UIColor.white] as [NSAttributedStringKey : Any]
        
        self.navigationBar.barTintColor = UIColor(red: 66/256.0, green: 176/256.0, blue: 216/256.0, alpha: 1)
        
//        self.navigationBar.isTranslucent = false

    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //如果不是栈底的控制器才需要隐藏，跟控制器不需要处理
        if childViewControllers.count > 0{
            //隐藏tabBar
            viewController.hidesBottomBarWhenPushed = true
            self.navigationBar.barTintColor = UIColor.white
            
            let backImage = UIImage.init(named: "backIcon")
            let backButton = UIButton.init(type: UIButtonType.custom)
            backButton.setImage(backImage, for: UIControlState.normal)
            backButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: (backImage?.size.height)!)
//            backButton.backgroundColor = UIColor.red
            backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            backButton.addTarget(self, action: #selector(backBtnAction), for: UIControlEvents.touchUpInside)
            let leftBarItem = UIBarButtonItem.init(customView: backButton)
            viewController.navigationItem.leftBarButtonItem = leftBarItem

        }
        super.pushViewController(viewController, animated: true)
    }

    
    
    @objc func backBtnAction()  {
        self.popViewController(animated: true)
    }
    
    func createImageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
}

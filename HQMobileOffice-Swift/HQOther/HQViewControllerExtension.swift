//
//  ViewControllerExtension.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setLeftBarItem(imageName:String, highLightImageName:String,target:Any, clickEvent:Selector)  {
        let leftImage = UIImage.init(named: imageName)
        let backButton = UIButton.init(type: UIButtonType.custom)
        backButton.frame = CGRect.init(x: 0, y: 0, width: (leftImage?.size.width)!, height: (leftImage?.size.height)!)
        backButton.setImage(leftImage, for: UIControlState.normal)
        backButton.setImage(UIImage.init(named: highLightImageName), for: UIControlState.highlighted)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        backButton.addTarget(target, action: clickEvent, for: UIControlEvents.touchUpInside)
        
        let leftBarItem = UIBarButtonItem.init(customView: backButton)
        //        [self setLeftBarButtonItem:leftBarItem];
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    
    func setLeftBarItem(title:String ,target:Any, clickEvent:Selector)  {
        
        let backButton = UIButton.init(type: UIButtonType.custom)
        backButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
        backButton.setTitle(title, for: UIControlState.normal)
        backButton.addTarget(target, action: clickEvent, for: UIControlEvents.touchUpInside)
        let leftBarItem = UIBarButtonItem.init(customView: backButton)
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    
    func setRightBarItem(imageName:String, highLightImageName:String,target:Any, clickEvent:Selector)  {
        let rightImage = UIImage.init(named: imageName)
        let rightButton = UIButton.init(type: UIButtonType.custom)
        rightButton.frame = CGRect.init(x: 0, y: 0, width: (rightImage?.size.width)!, height: (rightImage?.size.height)!)
        rightButton.setImage(rightImage, for: UIControlState.normal)
        rightButton.setImage(UIImage.init(named: highLightImageName), for: UIControlState.highlighted)
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        rightButton.addTarget(target, action: clickEvent, for: UIControlEvents.touchUpInside)
        let rightBarItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }

    
    func setRightBarItem(title:String ,target:Any, clickEvent:Selector)  {
        let rightButton = UIButton.init(type: UIButtonType.custom)
        let titleW = title.ga_widthForComment(fontSize: 16)
        rightButton.frame = CGRect.init(x: 0, y: 0, width: titleW, height: 30)
        rightButton.setTitle(title, for: UIControlState.normal)
        rightButton.addTarget(target, action: clickEvent, for: UIControlEvents.touchUpInside)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        let rightBarItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }

    
}

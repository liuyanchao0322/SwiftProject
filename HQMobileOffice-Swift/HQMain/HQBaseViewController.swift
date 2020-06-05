//
//  HQBaseViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQBaseViewController: UIViewController {

    // MARK:- 创建懒加载
    lazy var visitorView : HQVisitorView = HQVisitorView.visitorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupTitleView(title:String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.navigationItem.titleView = titleLabel
    }
    
    func loadVisitorView() {
        self.view.addSubview(self.visitorView)
    }
    
    
//    func setLeftBarItem(imageName:String, highLightImageName:String,target:Any, clickEvent:Selector)  {
//        let leftImage = UIImage.init(named: imageName)
//        let backButton = UIButton.init(type: UIButtonType.custom)
//        backButton.frame = CGRect.init(x: 0, y: 0, width: (leftImage?.size.width)!, height: (leftImage?.size.height)!)
//        backButton.setImage(leftImage, for: UIControlState.normal)
//        backButton.setImage(UIImage.init(named: highLightImageName), for: UIControlState.highlighted)
//        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        backButton.addTarget(target, action: clickEvent, for: UIControlEvents.touchUpInside)
//        
//        let leftBarItem = UIBarButtonItem.init(customView: backButton)
////        [self setLeftBarButtonItem:leftBarItem];
//        self.navigationItem.leftBarButtonItem = leftBarItem        
//    }
//    
//    
//    func setRightBarItem(imageName:String, highLightImageName:String,target:Any, clickEvent:Selector)  {
//        let rightImage = UIImage.init(named: imageName)
//        let rightButton = UIButton.init(type: UIButtonType.custom)
//        rightButton.frame = CGRect.init(x: 0, y: 0, width: (rightImage?.size.width)!, height: (rightImage?.size.height)!)
//        rightButton.setImage(rightImage, for: UIControlState.normal)
//        rightButton.setImage(UIImage.init(named: highLightImageName), for: UIControlState.highlighted)
//        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        rightButton.addTarget(target, action: clickEvent, for: UIControlEvents.touchUpInside)
//        
//        let rightBarItem = UIBarButtonItem.init(customView: rightButton)
//        //        [self setLeftBarButtonItem:leftBarItem];
//        self.navigationItem.rightBarButtonItem = rightBarItem
//    }
}

//
//  HQPersonModel.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

// MARK: 想要属性可以用KVO监听，必须用@objc dynamic修饰
class HQPersonModel: NSObject {
    @objc dynamic var name : String  = ""
    @objc dynamic var age : Int = 1
    
    init(name : String) {
        self.name = name
        super.init()
    }
}



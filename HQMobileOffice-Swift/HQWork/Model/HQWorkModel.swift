//
//  HQWorkModel.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON


class HQWorkModel: NSObject {

    var menuClass : String?
    var menuCode : String?
    var menuName : String?
    var menuUrlParam : String?
    
    init(jsonData:JSON) {
        menuClass = jsonData["menuClass"].stringValue
        menuCode = jsonData["menuCode"].stringValue
        menuName = jsonData["menuName"].stringValue
        menuUrlParam = jsonData["menuUrlParam"].stringValue
    }
}

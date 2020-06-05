//
//  HQEditMenuModel.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/9.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON

class HQEditMenuModel: NSObject {

    var numberId : String?
    var menuCode : String?
    var pId : String?
    var menuUrlParam : String?
    var isChecked : String?
    var menuName : String?
    var menuClass : String?
    var orderCode : String?
    var isShow : String?
    
    lazy var sectionDataArray: NSMutableArray = {
        let sectionArray = NSMutableArray.init()
        return sectionArray
    }()
    
    init(jsonData:JSON) {
        self.numberId = jsonData["id"].stringValue
        self.menuCode = jsonData["menuCode"].stringValue
        self.pId = jsonData["pId"].stringValue
        self.menuUrlParam = jsonData["menuUrlParam"].stringValue
        self.isChecked = jsonData["isChecked"].stringValue
        self.menuName = jsonData["menuName"].stringValue
        self.menuClass = jsonData["menuClass"].stringValue
        self.orderCode = jsonData["orderCode"].stringValue
    }
}

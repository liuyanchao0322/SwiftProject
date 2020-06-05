//
//  HQNotiModel.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON


// FIXME: 如果你没有为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）
class HQNotiModel: NSObject {
    /** 通知的busiId */
    var BUSIID : String?
    var CHANNELID : String?
    var TITLE : String?
    var PUBLISHTIME : String?
    var isAdd : Bool?
    
    
    
    
    init(jsonData:JSON) {
        TITLE = jsonData["TITLE"].stringValue
        CHANNELID = jsonData["CHANNELID"].stringValue
        PUBLISHTIME = jsonData["PUBLISHTIME"].stringValue
        isAdd = jsonData["isAdd"].boolValue
    }
    
    
    /**
     如果两个不同的地址而内容完全相等的对象采取containsObject默认比较返回结果是NO
     针对这种情况，一般我们需要在自定义的类中重载NSObject的-(BOOL)isEqual:(id)object方法
     */
    override func isEqual(_ object: Any?) -> Bool {
        //        if object is  ChannelModel {
        //            return true
        //        }
        
        // swift中直接使用 is 来实现oc中isKindOfClass: 的功能
        if !(object is HQNotiModel) {
            return false
        }
        
        // as!强制转换  as？转换成可选类型
        let channelModel = object as! HQNotiModel
        if (channelModel.CHANNELID == CHANNELID)  {
            return true
        } else {
            return false
        }
    }
    
}

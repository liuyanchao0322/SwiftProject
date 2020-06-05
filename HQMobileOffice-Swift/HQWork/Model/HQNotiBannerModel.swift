//
//  HQNotiBannerModel.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/5.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON

class HQNotiBannerModel: NSObject {

    var BUSIID : String?
    var CHANNELID : String?
    var TITLE : String?
    var PUBLISHTIME : String?
    var ISREAD : String?
    
    
    init(jsonData:JSON) {
        TITLE = jsonData["TITLE"].stringValue
        CHANNELID = jsonData["CHANNELID"].stringValue
        PUBLISHTIME = jsonData["PUBLISHTIME"].stringValue
        BUSIID = jsonData["BUSIID"].stringValue
        ISREAD = jsonData["ISREAD"].stringValue

    }
    

}

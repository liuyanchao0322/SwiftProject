//
//  SwiftShare.swift
//  SwiftJSON
//
//  Created by 太极华青协同办公 on 2018/6/28.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import Foundation

class SwiftShare: NSObject {
    
    var text = "liuyanchao"
    static let instance: SwiftShare = SwiftShare()
    class func sharedDanli() -> SwiftShare {
        return instance
    }
}

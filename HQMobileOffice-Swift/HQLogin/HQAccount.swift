//
//  HQAccount.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit


class HQAccount: NSObject,NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tokenId, forKey: "tokenid")
    }
    
    required init?(coder aDecoder: NSCoder) {
        tokenId = aDecoder.decodeObject(forKey: "tokenid") as! String?
    }
    var tokenId :String?
    var userId :String?
}

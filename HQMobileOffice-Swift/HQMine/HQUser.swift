//
//  HQUser.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/23.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import ObjectMapper

class HQUser: Mappable {

    var userName: String?
    var age: Int?
    var weight: Double!
    var array: [AnyObject]?
    var dictionary: [String : AnyObject] = [:]
    var bestFriend: HQUser?                       // Nested User object
    var friends: [HQUser]?                        // Array of Users
    var birthday: NSDate?
    var imageURLs: Array<NSURL>?
    
    
    /**
     ObjectMapper 通过 Mappable 协议中的 init?(map: Map) 方法来初始化创建对象。我们可以利用这个方法，在对象序列化之前验证 JSON 合法性。在不符合的条件时，返回 nil 阻止映射发生。 
     */
    required init?(map: Map) {
        // 检查JSON中是否有"username"属性
        if map.JSON["userName"] == nil {
            return nil
        }
    }
    
    init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mappable
    func mapping(map: Map) {
        userName    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        array       <- map["arr"]
        dictionary  <- map["dict"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
//        birthday    <- (map["birthday"], DateTransform())
//        posterURL   <- (map["image"], URLTransform())
    }
}

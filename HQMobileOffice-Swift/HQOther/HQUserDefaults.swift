//
//  HQUserDefaults.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQUserDefaults: UserDefaults {

   class func setDataObject(object:Any,key:String)  {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(object, forKey: key)
        userDefaults.synchronize()
    }
    
   class func getDataObject(key:String) -> Any {
        var object: Any?
        let userDefaults = UserDefaults.standard
        object = userDefaults.object(forKey: key)
        return object ?? ""
    }
    
   class func removeDataObject(key:String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
    
//    func objectIsValid(object:Any) -> Bool {
//        if object != nil  {
//            return true
//        } else if object as Array
//
//
//    }
}

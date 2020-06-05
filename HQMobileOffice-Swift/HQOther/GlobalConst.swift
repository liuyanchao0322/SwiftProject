//
//  GlobalConst.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import Foundation
import UIKit


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}


let kMainUrl = "http://192.168.0.50:7004/hqoa/"

let kMainColor = RGBA(r:56, g: 152, b: 246, a: 1)

let kLineColor = RGBA(r: 212, g: 212, b: 212, a: 1)

let kTokenId = "5960f0e6ba354e1286db03466ff6f0c2"

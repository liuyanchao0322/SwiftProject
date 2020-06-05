//
//  HQTitleBtn.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/26.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQTitleBtn: UIButton {

    // MARK: - 重写init函数
    //override重写系统方法时
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
}

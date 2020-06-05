//
//  HQWorkHeaderView.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQWorkHeaderView: UICollectionReusableView {
    
    
    var moreMenuBtnActionHandle:(() ->())?
    
    
    lazy var leftLabel : UILabel = {
        
        let lineLabel = UILabel()
        lineLabel.backgroundColor = kMainColor
        return lineLabel
    }()
    
    lazy var titleLabel :UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var moreBtn : UIButton = {
        
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setTitle("更多", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(HQWorkHeaderView.moreMenuAction), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.leftLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.moreBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.leftLabel.frame = CGRect.init(x: 15, y: 13, width: 3, height: 24)
        self.titleLabel.frame = CGRect.init(x: self.leftLabel.right + 12, y: 12, width: 80, height: 25)
        self.moreBtn.frame = CGRect.init(x: self.width - 15 - 50, y: self.titleLabel.mj_y, width: 50, height: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func moreMenuAction()  {
        self.moreMenuBtnActionHandle!()
    }
}

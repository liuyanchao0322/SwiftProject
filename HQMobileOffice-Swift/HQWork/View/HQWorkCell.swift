//
//  HQWorkCell.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit


class HQWorkCell: UICollectionViewCell {
 
    var newModel : HQWorkModel!

    
    lazy var iconView : UIImageView = {
        let topView = UIImageView()
        return topView
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = RGBA(r: 50, g: 50, b: 50, a: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    // 给控件赋值
    var model : HQWorkModel{
        set{
            self.newModel = newValue
            self.nameLabel.text = model.menuName
            let nameW = model.menuName?.ga_widthForComment(fontSize: 15)
            self.iconView.image = UIImage.init(named: model.menuClass!)
        }
        get{
            return self.newModel
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.contentView.backgroundColor = UIColor.orange
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.nameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconView.frame = CGRect.init(x: (self.width - 40) / 2, y: 7, width: 40, height: 40)
        self.nameLabel.frame = CGRect.init(x: self.iconView.left - 20, y: self.iconView.bottom + 15, width: 80, height: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

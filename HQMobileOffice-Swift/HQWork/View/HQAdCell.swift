//
//  HQAdCell.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit



class HQAdCell: UICollectionViewCell {
    
    var notiModel : HQNotiBannerModel!
    var cellLableClickClosure : ((_ notiModel:HQNotiBannerModel) ->())?

    // 给控件赋值
    var model : HQNotiBannerModel{
        set{
            self.notiModel = newValue
            self.adTitleBtn.setTitle(newValue.TITLE, for: UIControlState.normal)
        }
        get{
            return self.notiModel
        }
    }


    
    lazy var adTitleBtn : UIButton = {
        let adBtn = UIButton.init(type: UIButtonType.custom)
        adBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        adBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        adBtn.addTarget(self, action: #selector(adBtnAction), for: UIControlEvents.touchUpInside)
        adBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        return adBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.adTitleBtn)
    }
    
    @objc func adBtnAction()  {
        cellLableClickClosure!(self.model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.adTitleBtn.frame = CGRect.init(x: 15, y: 0, width: self.width, height: self.height)
    }
}

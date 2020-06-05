//
//  HQEditView.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/9.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit


protocol HQEditViewDelegate:NSObjectProtocol {
    func didSelectOpenAndClose(editModel:HQEditMenuModel, button:UIButton)
}


class HQEditView: UIView {

    var editModel: HQEditMenuModel!
    
    weak var delegate : HQEditViewDelegate?
    
    var openAndCloseBlock:((_ editModel:HQEditMenuModel, _ isOpen:Bool) ->())?
    
    // 给控件赋值
    var model : HQEditMenuModel{
        set{
            self.editModel = newValue
            self.nameLabel.text = newValue.menuName
        }
        get{
            return self.editModel
        }
    }
    
    lazy var leftLayer: CALayer = {
        
        let lineLayer = CALayer.init()
        lineLayer.backgroundColor = kMainColor.cgColor
        return lineLayer
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = RGBA(r: 50, g: 50, b: 50, a: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var openAndCloseBtn : UIButton = {

        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setTitle("展开", for: UIControlState.normal)
        btn.setTitle("收起", for: UIControlState.selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(openAndCloseAction), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(self.leftLayer)
        self.addSubview(self.nameLabel)
        self.addSubview(self.openAndCloseBtn)
    }
    

    @objc func openAndCloseAction(button:UIButton){
        button.isSelected = !button.isSelected
  
//        self.openAndCloseBlock!(self.editModel,button.isSelected)
        self.delegate?.didSelectOpenAndClose(editModel: self.editModel, button: button)
    }


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.leftLayer.frame = CGRect.init(x: 10, y: 15, width: 3, height: 15)
        self.nameLabel.frame = CGRect.init(x: 20, y: 15, width: 100, height: 15)
        self.openAndCloseBtn.frame = CGRect.init(x: kScreenWidth - 15 - 40, y: 10, width: 40, height: 30)
    }

}

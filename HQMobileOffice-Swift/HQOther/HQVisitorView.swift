//
//  HQVisitorView.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/26.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQVisitorView: UIView {

    
    var registerBlock:(() ->())?
    var loginBlock:(() ->())?
    
    class func visitorView() -> HQVisitorView {
        // MARK:-
        let visitor = HQVisitorView()
        visitor.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        return visitor
    }
    
    lazy var rotationView : UIImageView = {
        
        let rotation = UIImageView.init()
        rotation.image = UIImage.init(named: "visitordiscover_feed_image_smallicon")
        return rotation
    }()
    
    lazy var iconView  : UIImageView = {
        
        let icon = UIImageView.init()
        icon.image = UIImage.init(named: "visitordiscover_feed_image_house")
        return icon
    }()
    
    
    lazy var tipLabel : UILabel = {
        
        let tipView = UILabel.init()
        tipView.font = UIFont.systemFont(ofSize: 18)
        tipView.text = "关注一些人，会这里看看"
        tipView.textAlignment = NSTextAlignment.center
        tipView.textColor = UIColor.gray
        return tipView
    }()

    lazy var registerBtn : UIButton = {
        
        let registerView = UIButton.init(type: UIButtonType.custom)
        registerView.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registerView.backgroundColor = UIColor.white
        registerView.setTitle("注册", for: UIControlState.normal)
        registerView.setTitleColor(UIColor.orange, for: UIControlState.normal)
        registerView.addTarget(self, action: #selector(registerAction), for: UIControlEvents.touchUpInside)
        return registerView
    }()

    lazy var loginBtn : UIButton = {
        
        let loginView = UIButton.init(type: UIButtonType.custom)
        loginView.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loginView.backgroundColor = UIColor.white
        loginView.setTitle("登录", for: UIControlState.normal)
        loginView.setTitleColor(UIColor.gray, for: UIControlState.normal)
        loginView.addTarget(self, action: #selector(loginAction), for: UIControlEvents.touchUpInside)

        return loginView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = RGBA(r: 240, g: 240, b: 240, a: 1)
        self.addSubview(self.rotationView)
        self.addSubview(self.iconView)
        self.addSubview(self.tipLabel)
        self.addSubview(self.registerBtn)
        self.addSubview(self.loginBtn)
    }
    
    @objc func registerAction(){
        self.registerBlock!()
    }
    
    @objc func loginAction(){
        self.loginBlock!()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- 自定义函数
    func setUpVisitorViewInfo(iconName: String, title: String ) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }

    
    //设置动画
    func addRotationAnimation() {
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT //无限旋转
        rotationAnim.duration = 5 //时间
        rotationAnim.isRemovedOnCompletion = false //
        rotationView.layer.add(rotationAnim, forKey: nil)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let rotationImage = UIImage.init(named: "visitordiscover_feed_image_smallicon")
        let iconImage = UIImage.init(named: "visitordiscover_feed_image_house")
        
        
        self.rotationView.frame = CGRect.init(x: (CGFloat(kScreenWidth) - (rotationImage?.size.width)!) / 2, y: 100, width: (rotationImage?.size.width)!, height: (rotationImage?.size.height)!)
        
        self.iconView.frame = CGRect.init(x: self.rotationView.left + 37, y: self.rotationView.top + 32, width: (iconImage?.size.width)!, height: (iconImage?.size.height)!)

        self.tipLabel.frame = CGRect.init(x: self.rotationView.left - 25, y: self.rotationView.bottom + 50, width: self.rotationView.width + CGFloat(50), height: 20)
        
        
        self.registerBtn.frame = CGRect.init(x: self.tipLabel.left, y: self.tipLabel.bottom + 60, width: 100, height: 40)
        
        self.loginBtn.frame = CGRect.init(x: self.tipLabel.right - 100, y: self.tipLabel.bottom + 60, width: 100, height: 40)

    }
    
}

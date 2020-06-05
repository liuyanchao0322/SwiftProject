//
//  HQLoginView.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit



class HQLoginView: UIView {

    var didLoginBtnClick:((_ name:String, _ pass:String) ->())?

    lazy var topImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "logo")
        return imageView
    }()
    
    lazy var userAccountView : UIView = {
        
        let userView = UIView()
        userView.layer.cornerRadius = 6
        userView.layer.borderWidth = 0.5
        userView.layer.borderColor = kMainColor.cgColor
        userView.layer.masksToBounds = true
       return userView
    }()
    

    lazy var passTextField : HQTextField = {
        
       let passText = HQTextField()
        let leftImage = UIImageView.init(image: UIImage.init(named: "pass"))
//        userText.text = [UserDefaults objectForKey:@"password"];
        passText.textColor = UIColor.gray
        passText.backgroundColor = UIColor.clear
        passText.borderStyle = UITextBorderStyle.none
        passText.leftViewMode = UITextFieldViewMode.always
        passText.leftView = leftImage
        passText.rightViewMode = UITextFieldViewMode.always
        passText.keyboardType = UIKeyboardType.twitter
        passText.clearsOnBeginEditing = false
        passText.layer.borderColor = kMainColor.cgColor
        //UIColor.blue.cgColor
        passText.layer.borderWidth = 0.5
        passText.isSecureTextEntry = true;
        passText.placeholder = "请输入密码";
        let font = UIFont.systemFont(ofSize: 15)
        let attributedPlaceholder = NSMutableAttributedString.init(string: "请输入用户名", attributes: [NSAttributedStringKey.foregroundColor: kMainColor])
        passText.attributedPlaceholder = attributedPlaceholder;
        return passText
    }()
    
    lazy var userTextField : HQTextField = {
        
       let userText = HQTextField()
        let leftImage = UIImageView.init(image: UIImage.init(named: "user"))
        userText.backgroundColor = UIColor.clear
        userText.textColor = UIColor.gray
        userText.leftView = leftImage
        userText.borderStyle = UITextBorderStyle.none
        userText.leftViewMode = UITextFieldViewMode.always
        userText.clearButtonMode = UITextFieldViewMode.whileEditing;
        userText.keyboardType = UIKeyboardType.default
        userText.placeholder = "请输入用户名";
        userText.layer.borderColor = kMainColor.cgColor
        userText.layer.borderWidth = 0.5
        let font = UIFont.systemFont(ofSize: 15)
        let attributedPlaceholder = NSMutableAttributedString.init(string: "请输入用户名", attributes: [NSAttributedStringKey.foregroundColor: kMainColor])
        userText.attributedPlaceholder = attributedPlaceholder;
        userText.clearsOnBeginEditing = false
        return userText
    }()
    
    
    lazy var loginBtn : UIButton = {
        let loginBtn = UIButton.init(type: UIButtonType.custom)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4
        loginBtn.setTitle("登 录", for: UIControlState.normal)
        loginBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginBtn.backgroundColor = kMainColor
        loginBtn.addTarget(self, action: #selector(loginAction), for: UIControlEvents.touchUpInside)
        return loginBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.topImageView)
        self.addSubview(self.userAccountView)
        self.userAccountView.addSubview(self.userTextField)
        self.userAccountView.addSubview(self.passTextField)
        self.addSubview(self.loginBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let topImage = UIImage.init(named: "logo")
        self.topImageView.frame = CGRect.init(x: (self.width - (topImage?.size.width)!) / 2, y: 100, width: (topImage?.size.width)!, height: (topImage?.size.height)!)
        self.userAccountView.frame = CGRect.init(x: 20, y: self.topImageView.bottom + 100, width: self.width - 40, height: 100)
        self.userTextField.frame = CGRect.init(x: 0, y: 0, width: self.userAccountView.width, height: 50)
        self.passTextField.frame = CGRect.init(x: 0, y: self.userTextField.bottom, width: self.userTextField.width, height: 50)
        self.loginBtn.frame = CGRect.init(x: 20, y: self.userAccountView.bottom + 60, width: self.userTextField.width, height: 50)
    }
    
    @objc func loginAction()  {
        if (self.userTextField.text?.isEmpty)! {
//            self.textShow(text: "用户名为空")
            self.userTextField.shakeField()
            return
        }
        if (self.passTextField.text?.isEmpty)! {
//            self.textShow(text: "密码为空")
            self.passTextField.shakeField()
            return
        }        
        didLoginBtnClick!(self.userTextField.text!, self.passTextField.text!)
    }
}

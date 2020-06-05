//
//  ChannelHeaderView.swift
//  SwiftDemo
//
//  Created by 太极华青协同办公 on 2018/6/28.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

// MARK: Swift中的枚举
public enum HeaderViewType : Int {
    case aaa
    case bbb
    case ccc
}

protocol changeName{
    func changeNameTo(name:String)
}
protocol changeSex{
    func changeSexTo(sex:String)
}

// MARK: - typealias设置别名
typealias changeProtocol = changeName & changeSex

typealias Location = CGPoint


// MARK: - 代理加上calss
@objc protocol HQNotiHeaderViewDelagate :class {
    
    func didSearchAction(text:String)
    /** 可选的代理方法 */ 
    @objc optional func optionalDelegateFunc()

}

class HQNotiHeaderView: UIView, UISearchBarDelegate {
    
    weak var delegate : HQNotiHeaderViewDelagate?
    var headreType : HeaderViewType?
    open var headerName : String?
    // MARK 懒加载控件
    lazy var typeBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("类型", for: UIControlState.normal)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        return btn
    } ()
    
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "关键字"
        searchBar.delegate = self
        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 16
        searchBar.barTintColor = RGBA(r: 240, g: 240, b: 240, a: 1)
        let imageSize = CGSize.init(width: kScreenWidth-150, height: 44)
        UIGraphicsBeginImageContextWithOptions(imageSize, false,UIScreen.main.scale)
        RGBA(r: 240, g: 240, b: 240, a: 1).set()
        UIRectFill(CGRect.init(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let pressedColorImg =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        searchBar.returnKeyType = UIReturnKeyType.search
        searchBar.setSearchFieldBackgroundImage(pressedColorImg, for: UIControlState.normal)
        return searchBar
    } ()
    
    // MARK: override:重写方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.typeBtn)
        self.addSubview(self.searchBar)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.typeBtn.frame = CGRect.init(x: 0, y: 10, width: 60, height: 30)
        self.searchBar.frame = CGRect.init(x: self.typeBtn.right, y: 10, width: self.width - 60, height: 30)
        //        self.headreType = HeaderViewType.aaa
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.delegate?.didSearchAction(text:searchBar.text!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

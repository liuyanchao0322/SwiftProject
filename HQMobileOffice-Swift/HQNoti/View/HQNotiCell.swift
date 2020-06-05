//
//  HQNotiCell.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/4.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import Kingfisher


class HQNotiCell: UITableViewCell {

    var newModel : HQNotiModel!
    
    // MARK 懒加载控件
    lazy var buildNameLabel : UILabel = {
        let namelable = UILabel()
        namelable.font = UIFont.systemFont(ofSize: 14)
        return namelable
    } ()
    
    lazy var buildAddressLabel : UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        return addressLabel
    }()
    
    lazy var buildNumLabel : UILabel = {
        let numLabel = UILabel()
        numLabel.font = UIFont.systemFont(ofSize: 14)
        return numLabel
    }()
    
    lazy var iconImageVIew : UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()
    
    
    
    // 给控件赋值
    var model : HQNotiModel{
        set{
            self.newModel = newValue
            self.buildNameLabel.text = model.TITLE
            self.buildAddressLabel.text = model.PUBLISHTIME
            self.buildNumLabel.text = "测试字断"
            let url = URL(string: "https://www.baidu.com/img/bd_logo1.png?qua=high&where=super")
            //            let image = UIImage.init(named: "icon")
            self.iconImageVIew.kf.setImage(with: url)
            //            self.iconImageVIew.kf.setImage(with: url, placeholder: image, options: KingfisherOptionsInfoItem.cacheOriginalImage, progressBlock: nil, completionHandler: nil)
            if model.isAdd! {
                self.buildNameLabel.textColor = UIColor.red
                self.buildAddressLabel.textColor = self.buildNameLabel.textColor
                self.buildNumLabel.textColor = self.buildNameLabel.textColor
            }
        }
        get{
            return self.newModel
        }
    }
    
    
    // 自定义cell的类方法 -> 返回cell
    class func cellWithTable(_ tableView:UITableView) -> (HQNotiCell){
        
        let Id = "HQNotiCellId"
        var homeCell = tableView.dequeueReusableCell(withIdentifier: Id)
        if homeCell == nil {
            homeCell = HQNotiCell.init(style: UITableViewCellStyle.default, reuseIdentifier: Id)
        }
        return homeCell as! (HQNotiCell)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.buildNameLabel)
        self.contentView.addSubview(self.buildAddressLabel)
        self.contentView.addSubview(self.buildNumLabel)
        self.contentView.addSubview(self.iconImageVIew)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 控件位置还是在layoutSubviews中计算
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconImageVIew.frame = CGRect.init(x: 15, y: 10, width: 60, height: 60);
        
        let titleW = self.model.TITLE?.ga_widthForComment(fontSize: 14)
        
        self.buildNameLabel.frame = CGRect.init(x: self.iconImageVIew.right + 15, y: 10, width: titleW!, height: 20)
        
        let contenW = self.model.PUBLISHTIME?.ga_widthForComment(fontSize: 14)
        
        self.buildAddressLabel.frame = CGRect.init(x: self.iconImageVIew.right + 15, y: self.buildNameLabel.bottom + 10, width: contenW!, height: 20)
        self.buildNumLabel.frame = CGRect.init(x: self.buildAddressLabel.right + 10, y: self.buildAddressLabel.top, width: 60, height: 20)
    }

}

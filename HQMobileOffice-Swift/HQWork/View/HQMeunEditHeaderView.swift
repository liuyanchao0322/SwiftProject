//
//  HQMeunEditHeaderView.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/24.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQMeunEditHeaderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var isHiddleEditBtn : Bool = Bool() {
        didSet {
            // MARK: -> cell中添加tableView，tableView的headerView显示第一层数据，cell显示下层数据
            self.editCollView.reloadData()
        }
    }
    
   

    // 操作数据后刷新HeaderViewHeight
    var resetHeaderViewHeightBlock:((_ editArray:Array<Any>) ->())?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.editArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HQEditCellId", for: indexPath) as! editCollectCell
        let editModel = self.editArray[indexPath.item]
        cell.editModel = editModel
        cell.tag = indexPath.item
        cell.isHiddleEditBtn = self.isHiddleEditBtn
        cell.deleteEditModelBlock = {
            
            (indexItem:Int) ->()
            in
            self.editArray.remove(at: indexItem)
//            let row = (self.editArray.count + 4 - 1) / 4
//            self.editCollView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(row) * 100.0)
            self.resetHeaderViewHeightBlock!(self.editArray)
            self.editCollView.reloadData()
        }
        return cell
    }
    
    
    
    var editArray : [HQEditMenuModel] = [HQEditMenuModel]() {
        didSet {
            
            let maxCol = 4
            
            // row = (总数 + 最大列数 - 1) / 最大列数
            let row = (self.editArray.count + maxCol - 1) / maxCol
            self.editCollView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(row) * 100.0)
            self.addSubview(self.editCollView)
            self.editCollView.reloadData()
        }
    }


    lazy var editCollView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
//        let row = (self.editArray.count + 4 - 1) / 4
        
        layout.itemSize = CGSize(width: (kScreenWidth - 5) / 4, height: 90)
        let meunView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        meunView.showsVerticalScrollIndicator = false
        
        meunView.register(editCollectCell.self, forCellWithReuseIdentifier: "HQEditCellId")
        meunView.dataSource = self
        meunView.delegate = self
        meunView.frame = self.bounds
        meunView.backgroundColor = UIColor.white
        return meunView
        
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let row = (self.editArray.count + 4 - 1) / 4
//        self.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(row) * 100.0)
        self.isHiddleEditBtn = true
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class editCollectCell: UICollectionViewCell {
    
    var newModel : HQEditMenuModel?
    
    var deleteEditModelBlock:((_ indexItem:Int) ->())?
    
    
    lazy var iconView : UIImageView = {
        let imageView = UIImageView.init()
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
//    var isHiddleEditBtn : Bool = true
    var isHiddleEditBtn : Bool = Bool() {
        didSet {
            // MARK: -> cell中添加tableView，tableView的headerView显示第一层数据，cell显示下层数据
            self.deleteBtn.isHidden = isHiddleEditBtn
        }
    }

    // 给控件赋值
    var editModel : HQEditMenuModel{
        set{
            self.newModel = newValue
            self.titleView.text = editModel.menuName
        }
        get{
            return self.newModel!
        }
    }

    
    lazy var titleView : UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.gray
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    
    lazy var deleteBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named: ""), for: UIControlState.normal)
        btn.backgroundColor = UIColor.red
        btn.isHidden = true
        btn.addTarget(self, action: #selector(deleteAction), for: UIControlEvents.touchUpInside)
        return btn
    }()

    @objc func deleteAction(){
        self.deleteEditModelBlock!(self.tag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.titleView)
        self.contentView.addSubview(self.deleteBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconView.frame = CGRect.init(x: 15, y: 10, width: self.width - 30, height: 60)
        self.titleView.frame = CGRect.init(x: 0, y: self.iconView.bottom + 10, width: self.width, height: 20)
        self.deleteBtn.frame = CGRect.init(x: self.iconView.right, y: self.iconView.top, width: 10, height: 5)
    }
}

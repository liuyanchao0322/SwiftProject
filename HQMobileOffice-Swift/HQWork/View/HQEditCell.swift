//
//  HQEditCell.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/9.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

class HQEditCell: UITableViewCell {
    
    var didSectionHeaderViewBlock:(() -> ())?
    
    // FIXME: -> 数组的set方法
     var sectionDatas : [HQEditMenuModel] = [HQEditMenuModel]() {
        didSet {
            // MARK: -> cell中添加tableView，tableView的headerView显示第一层数据，cell显示下层数据
            self.sectionTable.reloadData()
        }
    }

    lazy var sectionTable : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedRowHeight = 0
        tableView.isScrollEnabled = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    class func cellWithTableView(tableView:UITableView) -> HQEditCell {
        
        let Id = "HQEditCellId"
        var homeCell = tableView.dequeueReusableCell(withIdentifier: Id)
        if homeCell == nil {
            homeCell = HQEditCell.init(style: UITableViewCellStyle.default, reuseIdentifier: Id)
        }
        return homeCell as! (HQEditCell)
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.sectionTable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sectionTable.frame = self.contentView.bounds
    }
}



// FIXME: -> HQEditCell的扩展，使代码更易读
extension HQEditCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subEditModel = sectionDatas[section]
        if subEditModel.isShow == "0" {
            return 0
        } else {
            return subEditModel.sectionDataArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Id = "HQEditSectionCellId"
        var sectionCell = tableView.dequeueReusableCell(withIdentifier: Id)
        if sectionCell == nil {
            sectionCell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: Id)
        }
        let editModel = sectionDatas[indexPath.section]
        sectionCell?.textLabel?.text = editModel.menuName
        return (sectionCell )!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionModel = self.sectionDatas[section]
        let headerBtn = UIButton.init(type: UIButtonType.custom)
        headerBtn.setTitle(sectionModel.menuName, for: UIControlState.normal)
        headerBtn.setTitle("选中", for: UIControlState.selected)
        headerBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        headerBtn.setTitleColor(UIColor.red, for: UIControlState.selected)
        headerBtn.backgroundColor = UIColor.yellow
        headerBtn.tag = section
        // FIXME: -> 刷新后需要重新设置选中状态,否则状态刷新不回来
        if sectionModel.isShow == "1"{
            headerBtn.isSelected = true
        } else {
            headerBtn.isSelected = false
        }
        headerBtn.addTarget(self, action: #selector(sectionHeaderViewAction), for: UIControlEvents.touchUpInside)
        return headerBtn
    }

    
    @objc func sectionHeaderViewAction(button:UIButton) {
        
        button.isSelected = !button.isSelected;
        let editModel = self.sectionDatas[button.tag]
        if button.isSelected {
            editModel.isShow = "1";
            let set = NSIndexSet.init(index: button.tag)
            self.sectionTable.reloadSections(set as IndexSet, with: UITableViewRowAnimation.fade)
            self.didSectionHeaderViewBlock!()
        } else {
            editModel.isShow = "0";
            let set = NSIndexSet.init(index: button.tag)
            self.sectionTable.reloadSections(set as IndexSet, with: UITableViewRowAnimation.fade)
            self.didSectionHeaderViewBlock!()
        }
    }
    
}


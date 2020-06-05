//
//  HQEditMenuViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/9.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON

class HQEditMenuViewController: HQBaseViewController,HQEditViewDelegate {
    func didSelectOpenAndClose(editModel: HQEditMenuModel, button: UIButton) {
        
        if (button.isSelected) {
            editModel.isShow = "1"
//            self.countArray.replaceObject(at: button.tag, with: "1")
            let set = NSIndexSet.init(index: button.tag)
            self.editTableView.reloadSections(set as IndexSet, with: UITableViewRowAnimation.fade)

        } else {
//            self.countArray.replaceObject(at: button.tag, with: "0")
            editModel.isShow = "0"
            let set = NSIndexSet.init(index: button.tag)
            self.editTableView.reloadSections(set as IndexSet, with: UITableViewRowAnimation.fade)
        }
    }

    lazy var editMenuArray : NSMutableArray = {
        let menuArray = NSMutableArray.init()
        return menuArray
    }()
    
    lazy var sectionDataArray : NSMutableArray = {
        let sectionArray = NSMutableArray.init()
        return sectionArray
    }()
    
    lazy var totalArray : NSMutableArray = {
        let array = NSMutableArray.init()
        return array
    }()
    
    lazy var countArray : NSMutableArray = {
        
        let counts = NSMutableArray.init()
        return counts
    }()
    
    lazy var editTableView : UITableView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        let editTable = UITableView.init(frame: frame, style: UITableViewStyle.grouped)
        editTable.delegate = self
        editTable.dataSource = self
        editTable.backgroundColor = RGBA(r: 240, g: 240, b: 240, a: 1)
        editTable.estimatedSectionFooterHeight = 0.0
        editTable.estimatedSectionHeaderHeight = 0.0
        editTable.estimatedRowHeight = 0.0
        return editTable
    }()
    
    lazy var editHeaderView : HQMeunEditHeaderView = {
        
        let headerView = HQMeunEditHeaderView()
        return headerView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMenuData()
        view.backgroundColor = UIColor.white
        self.title = "编辑菜单"
        setupRightBtn()
        self.editHeaderView.resetHeaderViewHeightBlock = { [weak self]
            
            (editArray:Array) ->()
            in
            let row = (editArray.count + 4 - 1) / 4
            self!.editHeaderView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(row) * 100.0)
            self!.editHeaderView.backgroundColor = UIColor.red
            self!.editTableView.tableHeaderView = self!.editHeaderView
        }
    }
    
    
    func setupRightBtn()  {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("编辑", for: UIControlState.normal)
        button.setTitle("完成", for: UIControlState.selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.frame = CGRect.init(x: 0, y: 0, width: 64, height: 40)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.addTarget(self, action: #selector(editAction), for: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func editAction(button:UIButton)  {
        button.isSelected = !button.isSelected
        self.editHeaderView.isHiddleEditBtn = !button.isSelected
    }
    
    func loadMenuData()  {
        let userId = "96c190dfabd94725a78c398a5f2b1f0e"
        let params = ["userId":userId, "tokenid":kTokenId]
        HQNetworkTools.requestData(.post, URLString: "app/system/applogin/getUserMenuAndChecked.do?", parameters: params, finishedCallback: { (result)
            in
            let jsonData = JSON(result)

            let dataArray = jsonData["data"].arrayValue
            let dataCount = dataArray.count
            
            for index in 0..<dataCount {

                let menuModel = HQEditMenuModel.init(jsonData: dataArray[index])
                menuModel.isShow = "0"
                self.totalArray.add(menuModel)
                // 顶部快捷菜单数据
                if menuModel.isChecked == "1" {
                   self.editMenuArray.add(menuModel)
                }
                
//                // 列表分组数据
//                if menuModel.pId == "63a9f0ea7bb98050796b649e85481845" {
//                    self.sectionDataArray.add(menuModel)
//                }
            }
            // 把数据还原成树形结构 --> 代替注释的代码
            self.sectionDataArray = self.sortNode(sourceNodes: self.totalArray)
            
//            for sectionIndex in 0..<self.sectionDataArray.count {
//                let sectionModel = self.sectionDataArray.object(at: sectionIndex) as! HQEditMenuModel
//                self.countArray.add("0")
//                for i  in 0..<dataCount {
//                    let model = HQEditMenuModel.init(jsonData: dataArray[i])
//                    if model.pId == sectionModel.numberId {
//                        model.isShow = "0"
//                        if !sectionModel.sectionDataArray.contains(model) {
//                            sectionModel.sectionDataArray.add(model)
//                        }
//                    }
//                }
//
//
//                for j in 0..<sectionModel.sectionDataArray.count {
//                    let modelTwo = sectionModel.sectionDataArray[j] as! HQEditMenuModel
//                    for h in 0..<self.totalArray.count {
//                        let modelTheer = self.totalArray[h] as! HQEditMenuModel
//                        if modelTheer.pId == modelTwo.numberId {
//                            modelTheer.isShow = "0"
//                            modelTwo.sectionDataArray.add(modelTheer)
//                        }
//                    }
//                }
//            }

            let row = (self.editMenuArray.count + 4 - 1) / 4
            self.editHeaderView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(row) * 100.0)
            self.view.addSubview(self.editTableView)
            self.editTableView.tableHeaderView = self.editHeaderView
            self.editHeaderView.editArray = self.editMenuArray as! [HQEditMenuModel]

            self.editTableView.reloadData()

        }) { (error) in
            print(error)
        }
    }
}


extension HQEditMenuViewController {
    
    func sortNode(sourceNodes:NSArray) -> NSMutableArray {
        
        var rootNodes : NSMutableArray?
        let resultNodes = NSMutableArray.init()
        
        for indexItem in 0..<sourceNodes.count {
            let nodeLoop1 = sourceNodes[indexItem] as! HQEditMenuModel
//            self.countArray.add("0")
            nodeLoop1.isShow = "0"
            let nodeId = nodeLoop1.numberId
            
            for nextIndex in 0..<sourceNodes.count {
               let nodeLoop2 = sourceNodes[nextIndex] as! HQEditMenuModel
                if nodeId == nodeLoop2.pId {
                    nodeLoop2.isShow = "0"
                    if !nodeLoop1.sectionDataArray.contains(nodeLoop2) {
                        nodeLoop1.sectionDataArray.add(nodeLoop2)
                    }
                }
            }
            if !resultNodes.contains(nodeLoop1) {
                resultNodes.add(nodeLoop1)
            }
        }
    
        rootNodes = NSMutableArray.init()
        for index in 0..<resultNodes.count {
            let node = resultNodes[index] as! HQEditMenuModel
            if node.pId == "63a9f0ea7bb98050796b649e85481845" {
                rootNodes?.add(node)
            }
        }
        return rootNodes!
    }
}

extension HQEditMenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let editCell = HQEditCell.cellWithTableView(tableView: tableView)
        let editModel = self.sectionDataArray[indexPath.section] as! HQEditMenuModel
        editCell.sectionDatas = editModel.sectionDataArray as! [HQEditMenuModel]

        editCell.didSectionHeaderViewBlock = {
            () -> ()
            in
            let setIndex = NSIndexSet.init(index: 0)
            self.editTableView.reloadSections(setIndex as IndexSet, with: UITableViewRowAnimation.fade)
        }
        return editCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let editModel = self.sectionDataArray[section] as! HQEditMenuModel
        if editModel.isShow == "1" {
            return 1
        } else {
            return 0
        }
        
//        let numStr = self.countArray.object(at: section) as! String
//        if numStr == "0" {
//            return 0
//        } else {
//            return 1
//        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var cellHeight : CGFloat = 0.0

        let editModel = self.sectionDataArray[indexPath.section] as! HQEditMenuModel

        for i in 0..<editModel.sectionDataArray.count {
            let sectionModel = editModel.sectionDataArray[i] as! HQEditMenuModel
            if sectionModel.sectionDataArray.count > 0 && sectionModel.isShow == "1" {
                cellHeight = cellHeight + CGFloat(sectionModel.sectionDataArray.count * 44)
            }
        }
        return CGFloat(editModel.sectionDataArray.count * 44) + cellHeight
    }

    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = HQEditView()
        sectionView.backgroundColor = UIColor.orange
        sectionView.openAndCloseBtn.tag = section
        sectionView.delegate = self
        let model = self.sectionDataArray[section] as! HQEditMenuModel
        sectionView.model = model
//        let numStr = self.countArray.object(at: section) as! String
        // FIXME: -> 刷新后需要重新设置选中状态,否则状态刷新不回来
        if model.isShow == "1" {
            sectionView.openAndCloseBtn.isSelected = true
        } else {
            sectionView.openAndCloseBtn.isSelected = false
        }
        return sectionView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionDataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}

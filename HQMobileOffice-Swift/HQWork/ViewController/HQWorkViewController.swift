//
//  HQWorkViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/2.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON


class HQWorkViewController: HQBaseViewController {
    
    // MRAK: - 懒加载
    lazy var workCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (kScreenWidth - 3) / 4, height: 100)
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: 55)
        let workView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        workView.showsVerticalScrollIndicator = false
        workView.backgroundColor = UIColor.white
        workView.register(HQWorkCell.self, forCellWithReuseIdentifier: "HQWorkCellId")
        workView.register(HQWorkHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId");
        workView.dataSource = self
        workView.delegate = self
        return workView
    }()
    
    lazy var dataArray : NSMutableArray = {
        let array = NSMutableArray.init()
        return array
    }()
    
    lazy var notiBannerArray : NSMutableArray = {
        let notiArray = NSMutableArray.init()
        return notiArray
    }()
    
    lazy var topView : HQWorkTopView = {
        let view = HQWorkTopView()
        // [weak self]:避免循环引用
        view.didSelectNotiBlock = { [weak self]
            (notiModel:HQNotiBannerModel) ->()
            in
            self!.view.textShow(text: notiModel.TITLE!, view: self!.view, after: 0.8)
        }
        return view
    }()

    // MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitleView(title: "工 作")
        self.view.addSubview(self.workCollectionView)
        self.loadWorkData()
        self.loadNotiData()
        self.workCollectionView.contentInset = UIEdgeInsetsMake(215, 0, 0, 0)
        self.topView.frame = CGRect.init(x: 0, y: -215, width: kScreenWidth, height: 215)
        self.workCollectionView.addSubview(self.topView)
    }
    
    // MARK: 请求通知banner数据
    @objc func loadNotiData() {
        
        let params = ["tokenid":kTokenId, "rowNum":"10", "channelId":"","title":"","pageCurrentPage":"1","pageShowCount":"10"]
        HQNetworkTools.requestData(.post, URLString: "app/system/applogin/getChannelInfoContent.do?", parameters: params, finishedCallback: { (result) in
            print(result)
            let jsonData = JSON(result)


            let notiArray = jsonData["data"]["datalist"].arrayValue
            let count = notiArray.count
            for index in 0..<count {
                let notiModel = HQNotiBannerModel.init(jsonData: notiArray[index])
                self.notiBannerArray.add(notiModel)
            }

            self.topView.loadNotiData(notiArray: self.notiBannerArray)
            
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: 请求工作菜单数据
    @objc func loadWorkData() {
        let tokenid = kTokenId
        let url = String.init(format: "app/system/applogin/getUserFastMenu.do?tokenid=%@",tokenid)
        
        HQNetworkTools.requestData(.get, URLString: url, finishedCallback: { (result) in
            print(result)
            let jsonData = JSON(result)
            let dataArray = jsonData["data"].arrayValue
            let count = dataArray.count
            
            for index in 0..<count {
                let model = HQWorkModel.init(jsonData: dataArray[index])
                self.dataArray.add(model)
            }
            self.workCollectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    @objc func getTestFunc()  {
        print("获取到的方法")
    }
}


// FIXME: - 扩展
extension HQWorkViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.dataArray.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let itemSize = CGSize(width: (kScreenWidth - 3) / 4, height: 100)
    //        return itemSize
    //    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HQWorkCellId", for: indexPath) as! HQWorkCell
        if indexPath.section == 0 {
            let dataModel = HQWorkModel(jsonData: nil)
            dataModel.menuName = "待办公文"
            dataModel.menuClass = "待办公文"
            cell.model = dataModel
            return cell
        } else {
            let dataModel = self.dataArray[indexPath.item]
            cell.model = dataModel as! HQWorkModel
            return cell
        }
    }
    
    // 返回View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! HQWorkHeaderView

        if kind == UICollectionElementKindSectionHeader{
            if indexPath.section == 0 {
                headview.titleLabel.text = "待办待阅"
                headview.moreBtn.isHidden = true
            } else {
                headview.titleLabel.text = "快捷菜单"
                headview.moreBtn.isHidden = false
                headview.moreMenuBtnActionHandle = {
                    () ->()
                    in
                    let editMenuVc = HQEditMenuViewController()
                    self.navigationController?.pushViewController(editMenuVc, animated: true)
                }
            }
        }
        return headview
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            self.showText(text: "待办公文", view: self.view, after: 0.8)
        } else {
            let dataModel = self.dataArray[indexPath.item] as! HQWorkModel
            self.showText(text: dataModel.menuName!, view: self.view, after: 0.8)
        }
    }
}



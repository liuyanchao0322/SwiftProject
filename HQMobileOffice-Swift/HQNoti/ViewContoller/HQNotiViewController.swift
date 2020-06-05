//
//  ViewController.swift
//  SwiftJSON
//
//  Created by 太极华青协同办公 on 2018/6/27.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON
import NVActivityIndicatorView
import GTMRefresh


/**
 
 override -> 重写方法、属性
 final  -> 防止方法、属性被重写。如果在class前加上final关键字，这样的类是不可以被继承的
 
 你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。
 */

class HQNotiViewController: HQBaseViewController,backValueDelegate,HQNotiHeaderViewDelagate {
    
    // MARK: <HQNotiHeaderViewDelagate>
    func didSearchAction(text: String) {
        loadHomeData(searchTitle: text)
    }
    // MARK: - <backValueDelegate>
    func backVlaue(value: HQNotiModel) {
        print(value)
        self.dataArr.add(value)
        self.homeTableView.reloadData()
    }
    
    func optionalDelegateFunc(enumType: HQEnumType) {
        switch enumType {
        case .oneType:
            self.showText(text: "第1个按钮", view: self.view, after: 0.25)
        case .twoType:
            self.showText(text: "第2个按钮", view: self.view, after: 0.25)
        case .threeType:
            self.showText(text: "第3个按钮", view: self.view, after: 0.25)
        case .fourType:
            self.showText(text: "第4个按钮", view: self.view, after: 0.25)
        default:
            print("")
        }
    }
    
    // MARK: - 懒加载
    /** 列表 */
    lazy var homeTableView: UITableView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64)
        let homeTableView = UITableView (frame: frame, style: UITableViewStyle.plain)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.tableHeaderView = self.channelHeaderView
        return homeTableView
    }()
    
    /** 数据源 */
    lazy var dataArr : NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    } ()
    
    /** 表头 */
    lazy var channelHeaderView : HQNotiHeaderView = {

        let headerView = HQNotiHeaderView()
        headerView.frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: 50)
        headerView.delegate = self
        return headerView
    } ()
    

    var pageIndex = 0
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置prompt属性,主要是用来做一些提醒，比如网络请求，数据加载等等
        self.navigationItem.prompt = "正在加载数据";
        self.view.addSubview(self.homeTableView)
        self.setupTitleView(title:"通 知")
        
        self.homeTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.pageIndex = 1
            self.loadHomeData(searchTitle: "")
        })
        self.homeTableView.mj_header.beginRefreshing()
        
        // MJRefresh上拉刷新的方法 1
//        self.homeTableView.mj_header = MJRefreshStateHeader.init(refreshingTarget: self, refreshingAction: #selector(loadMoreHomeData))
        
        self.homeTableView.mj_footer = MJRefreshAutoStateFooter.init(refreshingBlock: {
            [weak self] in
            self?.pageIndex += 1
            self?.loadMoreHomeData(searchTitle: "")
        })
        
        self.setRightBarItem(title: "添加", target: self, clickEvent: #selector(addAddress))
        
        NotificationCenter.default.addObserver(self, selector: #selector(notiValue)
            , name: NSNotification.Name(rawValue: "testNotiValue"), object: nibName)
        
//        self.homeTableView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    
    @objc func notiValue(noti:Notification) {
        print(noti.userInfo ?? 0)
        let notiModel = HQNotiModel(jsonData: nil)
        notiModel.TITLE = noti.userInfo?["TITLE"] as? String
        notiModel.PUBLISHTIME = noti.userInfo?["PUBLISHTIME"] as? String
        notiModel.isAdd = true
        self.dataArr.add(notiModel)
        self.homeTableView.reloadData()
    }

    // MARK: - 网络请求
    func loadHomeData(searchTitle:String){
        let channelId = "e2fff386b9d34e0eaf69146cde368a1b"
        let parameter = ["tokenid":kTokenId,"rowNum":"10","channelId":channelId,"title":searchTitle,"pageCurrentPage":self.pageIndex ,"pageShowCount":"10","endTime":"","startTime":""] as [String : Any]
        let frame = CGRect.init(x: self.view.centerX - 25, y: self.view.centerY, width: 50, height: 50)
        let actView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.pacman, color: UIColor.blue, padding: 10)
        self.view.addSubview(actView)
        actView.startAnimating()
        
        HQNetworkTools.requestData(.post, URLString:"app/system/applogin/getChannelInfoContent.do", parameters: parameter, finishedCallback: { (result) in
            actView.stopAnimating()
            
            self.navigationItem.prompt = nil;


            self.dataArr.removeAllObjects()
            let jsonData = JSON(result)
            let listData = jsonData["data"]["datalist"].arrayValue

            let count = listData.count
            for i in 0..<count {
                let data = listData[i]
                let model = HQNotiModel.init(jsonData: data)
                self.dataArr.add(model as Any)
            }

            self.homeTableView.mj_header.endRefreshing()
            self.homeTableView.mj_footer.endRefreshing()
            self.homeTableView.reloadData()

            if count < 10 {
                //                self.homeTableView.endLoadMore(isNoMoreData: true)
                //                self.homeTableView.noMoreDataText("没有更多数据")
                self.homeTableView.mj_footer.endRefreshingWithNoMoreData()
            }
        }) { (error) in
            self.homeTableView.mj_header.endRefreshing()
            self.homeTableView.mj_footer.endRefreshing()
        }
    }
    
    @objc func loadMoreHomeData(searchTitle:String) {
        let tokenId = "e8bb93dda1a34e17826c9f2d719e20a5"
        let channelId = "e2fff386b9d34e0eaf69146cde368a1b"
        let parameter = ["tokenid":tokenId,"rowNum":"10","channelId":channelId,"title":searchTitle,"pageCurrentPage":self.pageIndex ,"pageShowCount":"10","endTime":"","startTime":""] as [String : Any]
        let frame = CGRect.init(x: self.view.centerX - 25, y: self.view.centerY, width: 50, height: 50)
        let actView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.pacman, color: UIColor.blue, padding: 10)
        self.view.addSubview(actView)
        actView.startAnimating()
        
        HQNetworkTools.requestData(.post, URLString: "app/system/applogin/getChannelInfoContent.do", parameters: parameter, finishedCallback: { (result) in
            
            actView.stopAnimating()

            let jsonData = JSON(result)
            let dataDict = jsonData["data"]
            let listData = dataDict["datalist"].arrayValue
            let dataArray = NSMutableArray()
            let count = listData.count
            for i in 0..<count {
                let data = listData[i]
                let model = HQNotiModel.init(jsonData: data)
                if !self.dataArr.contains(model) {
                    dataArray.add(model as Any)
                }
            }

            let tempArray = NSMutableArray()
            tempArray.addObjects(from: self.dataArr as! [Any])
            tempArray.addObjects(from: dataArray as! [Any])
            self.dataArr = tempArray
            self.homeTableView.mj_footer.endRefreshing()
            self.homeTableView.mj_header.endRefreshing()
            self.homeTableView .reloadData()

            if count < 10 {
                //                self.homeTableView.noMoreDataText("没有更多数据")
                //                self.homeTableView.endLoadMore(isNoMoreData: true)
                self.homeTableView.mj_footer.endRefreshingWithNoMoreData()
            }
        }) { (error) in
            
        }
    }
    
    // MARK: - 点击添加
    @objc private func addAddress(){
        let testVc = TestViewController()
//        testVc.hidesBottomBarWhenPushed = true
        testVc.delegate = self
        weak var weakSelf = self
        testVc.addAddress = {
            // 没有返回值 ->() 可以不写
            (address:HQNotiModel) ->()
            in
            weakSelf?.dataArr .add(address)
            weakSelf?.homeTableView .reloadData()
        }
        let navi = self.navigationController as! HQNaviViewController
        navi.pushViewController(testVc, animated: true)
        
    }
}


// MARK: -> 扩展
extension HQNotiViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - <UITableViewDataSource>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = HQNotiCell.cellWithTable(tableView)
        homeCell.model = self.dataArr.object(at: indexPath.row) as! HQNotiModel
        return homeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = self.dataArr[indexPath.row]
        if self.dataArr.contains(channel) {
            print("数组包含\(channel)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let notiModel = self.dataArr[indexPath.row] as! HQNotiModel
        if notiModel.isAdd! {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let notiModel = self.dataArr[indexPath.row] as! HQNotiModel
        notiModel.isAdd = notiModel.isAdd!
        let editAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.destructive, title: "编辑") { (action:UITableViewRowAction, indexPath:IndexPath) in
            print("编辑")
        }
        editAction.backgroundColor = kMainColor
        
        
        let deleteAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.destructive, title: "删除") { (action:UITableViewRowAction, indexPath:IndexPath) in
            
            self.dataArr.remove(notiModel)
            self.homeTableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor.blue
        return [editAction,deleteAction]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    
}

//        //这是模拟的json数据
//        let baseInfo: [String : Any] = ["build_name":"置信·原墅",
//                                        "build_address":"学院中路与金桥路交汇处东北侧",
//                                        "build_num": 12,
//                                        "room_num": 588,
//                                        "detail_address":["province":"浙江省",
//                                                          "city":"温州市",
//                                                          "district":"鹿城区",
//                                                          "street":"五马街道"],
//                                        "area_address":"浙江省温州市鹿城区五马街道"]
//        // 1.先转换成json数据
//        let jsonData = JSON(baseInfo)
//        // 2.在转换成模型
//        let homeModel = HomeInfo.init(jsonData: jsonData)
//        for _ in 0..<5 {
//            self.dataArr .add(homeModel as Any)
//        }

//struct InfoModel {
//    var build_name : String?
//    var build_address : String?
//    var build_num : String?
//    var room_num : String?
//    var detail_address : Detail_address
//
//
//    init(jsonData:JSON) {
//        build_name = jsonData["build_address"].stringValue
//        build_address = jsonData["build_address"].stringValue
//        build_num = jsonData["build_num"].stringValue
//        room_num = jsonData["room_num"].stringValue
//        detail_address = Detail_address.init(subJsonData: jsonData["detail_address"])
//    }
//}
//
//struct Detail_address {
//    var province: String?
//    var city: String?
//    var district: String?
//    var street: String?
//    init(subJsonData:JSON) {
//        province = subJsonData["province"].stringValue
//        city = subJsonData["city"].stringValue
//        district = subJsonData["district"].stringValue
//        street = subJsonData["street"].stringValue
//    }
//}



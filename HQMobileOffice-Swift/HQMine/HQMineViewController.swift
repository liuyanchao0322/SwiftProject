//
//  HQMineViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/2.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper

class HQMineViewController: HQBaseViewController {

    private lazy var titleBtn: UIButton = HQTitleBtn()
    private lazy var dataArray: NSMutableArray = NSMutableArray.init()

    var testName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 设置九宫格视图
        self.view.backgroundColor = UIColor.white
        let nameArray = ["hjj","wj","lzy","ljj","xw","zjl","gdg","yq"]
        setupSubViews(names: nameArray)
        
        
        for index in 0..<10 {
            let user = HQUser.init()
            user.userName = String.init(format: "%@-%d", "lyc",index)
            dataArray.add(user)
        }
        
        for item in dataArray {
            print(item)
        }

        
        
        // 2.设置titleView
        titleBtn.setTitle("ZoroNie", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnAction), for: UIControlEvents.touchUpInside)
        navigationItem.titleView = titleBtn;

        
        
        let row = totalCountAndRow(total: 10, maxCol: 4)
        
        // 3. 没有登录时的视图
        self.loadVisitorView()
        self.visitorView.addRotationAnimation()
        self.visitorView.registerBlock = {
            () -> ()
            in
            self.showText(text: "点击注册", view: self.view, after: 0.8)
        }
        
        self.visitorView.loginBlock = {
            
            () -> ()
            in
            self.showText(text: "点击登录", view: self.view, after: 0.8)
        }

        
        
//        let label = HQAnimatedLabel(frame: CGRect(x: 20, y: 344, width: UIScreen.main.bounds.size.width, height: 100))
//        label.text = "LOADING"
//        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
//        label.animationType = .wave
//        label.placeHolderColor = .gray
//        label.backgroundColor = .black
//        label.textColor = . white
//
//        view.addSubview(label)
//        view.backgroundColor = .white
//        label.startAnimation(duration: 8.0) {
//            label.startAnimation(duration: 8.0, nil)
//        }
    }
    
    @objc func titleBtnAction(button:UIButton){
        button.isSelected = !button.isSelected
    }

    
    func setupSubViews(names:Array<Any>) {
        
        for index in 0..<names.count {
            
//            let buttonW = 80.0 // 固定宽度，间距自适应
//            let maxCol = 4
//            let row = index / maxCol
//            let col = index % maxCol
//            let margin = (Double(kScreenWidth) - (buttonW * Double(maxCol))) / Double(maxCol + 1)
            
            
            let margin = 20 // 间距固定，宽度自适应
            let maxCol = 4
            let buttonW = (Int(kScreenWidth) - (margin * (maxCol + 1))) / maxCol
            let row = index / maxCol
            let col = index % maxCol
            let name = names[index] as! String
            
            let button = UIButton.init(type: UIButtonType.custom)
            button.backgroundColor = UIColor.red
            button.setTitle(name, for: UIControlState.normal)
            let buttonX = margin + (buttonW + margin) * Int(col)
            let buttonY = margin + (buttonW + margin) * Int(row)
            button.frame = CGRect.init(x: buttonX, y: buttonY, width: buttonW, height: buttonW)
            self.view.addSubview(button)
        }
    }
    
    
    // ObjectMapper数据解析
    func objectMapperDataParsing()  {
        let lilei = HQUser()
        lilei.userName = "李雷"
        lilei.age = 18
        
        let meimei = HQUser()
        meimei.userName = "梅梅"
        meimei.age = 17
        meimei.bestFriend = lilei
        
        // 将模型转字典
        let meimeiDict:[String: Any] = meimei.toJSON()
        print(meimeiDict)
        
        
        
        // 模型数组转字典数组
        let liuchao = HQUser()
        liuchao.userName = "刘超"
        liuchao.age = 32
        
        let liuming = HQUser()
        liuming.userName = "刘明"
        liuming.age = 30
        
        let users = [liuchao,liuming]
        let userArray:[[String:Any]] = users.toJSON()
        print(userArray)
        
        
        // 将字典转为模型
        let meimeiDict2 = ["age": 17, "userName": "梅梅",
                           "best_friend": ["age": 18, "username": "李雷"]] as [String : Any]
        let meimei2 = HQUser(JSON: meimeiDict2)
        print(meimei2 ?? 0)
        
        // 将字典数字转成模型数组
        let usersArray2 = [["age": 17, "username": "梅梅"],
                           ["age": 18, "username": "李雷"]]
        let users2:[HQUser] = Mapper<HQUser>().mapArray(JSONArray: usersArray2)
        print(users2)
        
        
        // 将模型数组转为JSON字符串
        let lilei1 = HQUser()
        lilei1.userName = "李雷"
        lilei1.age = 18
        
        let meimei1 = HQUser()
        meimei1.userName = "梅梅"
        meimei1.age = 17
        
        let users3 = [lilei1, meimei1]
        let json:String  = users3.toJSONString()!
        print(json)
        
        // 将JSON字符串转为模型
        let meimeiJSON:String = "{\"age\":17,\"username\":\"梅梅\",\"best_friend\":{\"age\":18,\"username\":\"李雷\"}}"
        let meimei3 = HQUser(JSONString: meimeiJSON)
        print(meimei3 ?? 0)
        
        
        
        
        // 将JSON字符串转为模型数组
        let json1 = "[{\"age\":18,\"username\":\"李雷\"},{\"age\":17,\"username\":\"梅梅\"}]"
        let users4:[HQUser] = Mapper<HQUser>().mapArray(JSONString: json1)!
        print(users4)
        
        
        
        // $0和$1表示闭包中第一个和第二个String类型的参数。
        let names = ["AT", "AE", "D", "S", "BE"]
        let reversed = names.sorted( by: { $0 > $1 } )
        print(reversed)
        
        
        let nums = [1, 13, 165, 2, 345]
        let result = nums.sorted(by: {$0 > $1})
        print(result)

    }
    
    
    // 根据总数和最大列数计算行数
    func totalCountAndRow(total:Int, maxCol:Int) -> Int {
        
        let row = (total + maxCol - 1) / maxCol
        return row
    }
    
}

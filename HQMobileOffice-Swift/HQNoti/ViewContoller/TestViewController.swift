
//  TestViewController.swift
//  SwiftJSON
//
//  Created by 太极华青协同办公 on 2018/6/27.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import SwiftyJSON

@objc enum HQEnumType : Int {
    case oneType
    case twoType
    case threeType
    case fourType
}

// MARK: 协议使用weak避免循环引用时需要加上 NSObjectProtocol 或 class
@objc protocol backValueDelegate : NSObjectProtocol {
    // 默认是必须实现的
    func backVlaue(value:HQNotiModel)
    // 可选的代理方法
    @objc optional func optionalDelegateFunc(enumType:HQEnumType)
}

class TestViewController: HQBaseViewController {

    // 相当于OC的block
    var addAddress:((_ channel:HQNotiModel)->())?
    
    var p : HQPersonModel?

    typealias hideShowView = (Int) -> Void
    var muFunc:hideShowView?
    
    // 声明block
    typealias addAddressBlock = (_ chanel: HQNotiModel)->()
    // block属性
    var myBlock:addAddressBlock?
    
    
    // 加上weak避免循环引用
    weak var delegate : backValueDelegate?
    
    lazy var ageLabel :UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 15)
        label.frame = CGRect.init(x: 100, y: 80, width: 100, height: 20)
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.blue
        return label
    } ()
    
    
    lazy var kvoBtn : UIButton = {
        
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect.init(x: 100, y: 300, width: 100, height: 30)
        btn.setTitle("KVO按钮", for: UIControlState.normal)
        btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(kvoAction), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    lazy var addBtn : UIButton = {
        let addBtn = UIButton.init(type: UIButtonType.custom)
        addBtn.frame = CGRect.init(x: 100, y: 164, width: 200, height: 30)
        addBtn.backgroundColor = UIColor.orange
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addBtn.setTitle("代理、闭包、通知传值", for: UIControlState.normal)
        addBtn.addTarget(self, action: #selector(backAddress), for: UIControlEvents.touchUpInside)
       return addBtn
    }()
    
    lazy var kvoView : TestKVOView = {
        
        let view = TestKVOView()
        view.frame = CGRect.init(x: 100, y: self.kvoBtn.bottom + 40, width: 100, height: 100)
        view.backgroundColor = UIColor.purple
        
        return view
    }()
    
    
    func loadEnumType(type:HQEnumType) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        // 10进制String转Int
        let string10 = "222"
        let int10 = Int(string10)
        
        let intValue = 56
        // Int转10进制String
        let str10 = String(intValue, radix: 10)
        print("数据转换%ld,%@",int10 ?? 0,str10)
        
        
        view.addSubview(self.ageLabel)
        view.addSubview(self.addBtn)
        view.addSubview(self.kvoBtn)
        view.addSubview(self.kvoView)

        let indexValue = 12345678[2]
        print("Int类型的扩展方法获得下标的数据\(indexValue)")
        
        // MARK: 单例方法
        HQNetworkTools.shareNetwork().networkLoadData()
        
        let person = HQPersonModel(name: "lyc")
        p = person
        p?.addObserver(self, forKeyPath: "age", options: [.new,.old], context: nil)
        self.ageLabel.text = String(format: "%ld", (p?.age)!)
        
        
        let s = Status()
        s.run()

        self.setupTitleView(title: "ceshi")
        self.setRightBarItem(imageName: "时间", highLightImageName: "时间", target: self, clickEvent: #selector(TestViewController.rightBtnAction))
        
        
        // 元组
        let product = (year : 2015, name : "iphone6s plus", price : 6088)
        print(product.year)
        
        self.createButton()
    }
    
    
    func createButton()  {
        let buttonW = kScreenWidth / 4
        for index in 0..<4 {
            let button = UIButton.init(type: UIButtonType.custom)
            let buttonX =  buttonW * CGFloat(index)
            
            button.frame = CGRect.init(x:buttonX, y: self.kvoView.bottom + 10, width: buttonW, height: buttonW)
            button.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
            if index == 0 {
                button.tag = HQEnumType.oneType.rawValue
                button.backgroundColor = UIColor.red

            } else if index == 1 {
                
                button.tag = HQEnumType.twoType.rawValue
                button.backgroundColor = kMainColor

            } else if index == 2 {
                button.tag = HQEnumType.threeType.rawValue
                button.backgroundColor = UIColor.red

            } else {
                button.tag = HQEnumType.fourType.rawValue
                button.backgroundColor = kMainColor

            }
            
            self.view.addSubview(button)
        }
    }
    
    
    @objc func buttonAction(button: UIButton)  {
        self.delegate?.optionalDelegateFunc!(enumType: HQEnumType(rawValue: button.tag)!)
    }
    
    
    @objc func rightBtnAction() {
        self.view.textShow(text: "点击右边按钮", view: self.view, after: 0.25)
    }
    
    @objc func backAddress() {
        
        // 通知传值
        let dic :[String : NSObject]  = [
            "TITLE":"通知传递数据" as NSObject,
            "PUBLISHTIME" : "2016-12-04" as NSObject
        ]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "testNotiValue"), object: nibName, userInfo: dic)

        
        // 闭包传值
        let baseInfo: [String : Any] = ["TITLE":"闭包传过来数据传值",
                                        "PUBLISHTIME":"2017-13-14",
                                        "isAdd":true]
        let jsonData = JSON(baseInfo)
        let channelModel = HQNotiModel.init(jsonData: jsonData)
        addAddress!(channelModel)
        
        
        // 代理传值
        let baseInfo1: [String : Any] = ["TITLE":"代理传过来数据传值",
                                        "PUBLISHTIME":"2017-11-14",
                                        "isAdd":true]
        let jsonData1 = JSON(baseInfo1)
        let delegateModel = HQNotiModel.init(jsonData: jsonData1)
        delegate?.backVlaue(value:delegateModel)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func kvoAction(){
        p?.age += 1
        self.kvoView.p?.age = (p?.age)!
    }
    
    // MARK: - KVO:监听的属性要用@objc dynamic修饰
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "age" {
            let oldValue = change![NSKeyValueChangeKey.oldKey] as? Int
            let newValue = change![NSKeyValueChangeKey.newKey] as? Int
            self.ageLabel.text = String.init(format: "%ld", (newValue)!)
            print("oldValue = \(String(describing: oldValue)),newValue = \(String(describing: newValue))")
            print("keyPath = \(String(describing: keyPath))")
            print("object = \(String(describing: object))")
            print("change = \(String(describing: change))")
            print("context = \(String(describing: context))")
        }
    }

    func chengfa()  {
        for i in 1...9 {
            for j in 1...i {
                print("\(i) * \(j) = \(i * j)  ", terminator: "")
            }
            print()
        }
    }

    
    deinit {
        p?.removeObserver(self, forKeyPath: "age", context: nil)
        NotificationCenter.default.removeObserver(self)
        print("释放了")
    }
}

// MARK: - 扩展可以为已有类型添加新下标。这个例子为 Swift 内建类型 Int 添加了一个整型下标。该下标 [n] 返回十进制数字从右向左数的第 n 个数字：
extension Int {
    subscript(digitIndex:Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}



protocol runProtocol {
    func run()
}

// FIXME: - HQPersonModel遵守runProtocol协议
class Status: runProtocol {
    func run() {
        print("协议方法")
    }
}

/**
 Open 和 Public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 Open 或 Public 级别来指定框架的外部接口。Open 和 Public 的区别在后面会提到。
 Internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
 File-private 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
 Private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。
 
 Open 为最高访问级别（限制最少），Private 为最低访问级别（限制最多）。
 
 Open 只能作用于类和类的成员，它和 Public 的区别如下：
 
 Public 或者其它更严访问级别的类，只能在其定义的模块内部被继承。
 Public 或者其它更严访问级别的类成员，只能在其定义的模块内部的子类中重写。
 Open 的类，可以在其定义的模块中被继承，也可以在引用它的模块中被继承。
 Open 的类成员，可以在其定义的模块中子类中重写，也可以在引用它的模块中的子类重写。
 把一个类标记为 open，明确的表示你已经充分考虑过外部模块使用此类作为父类的影响，并且设计好了你的类的代码了。
 
 如果你没有为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）
 
 */



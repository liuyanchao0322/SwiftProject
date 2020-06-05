//
//  AppDelegate.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/2.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        HQMainTool.chooseRootController()
        
        let dataArray = ["111","222","333"]
        
        for string in dataArray {
            print(string)
        }
        
        return true
    }
    
    

    // FIXME: swift代码规范
    /**
     1. 如果一个函数有多个返回值，推荐使用 元组 而不是 inout 参数， 如果你见到一个元组多次，建议使用typealias ，而如果返回的元组有三个或多于三个以上的元素，建议使用结构体或类。
     2. 断言流程控制的时候不要使用小括号。
     3. Switch 模块中不用显式使用break。
     4. 尽可能的多使用let，少使用var。
     5. 不要使用 unowned，unowned 和 weak 变量基本上等价，并且都是隐式拆包( unowned 在引用计数上有少许性能优化)，由于不推荐使用隐式拆包，也不推荐使用unowned 变量。
     6. 使用 // MARK: 注释来分割协议实现和其他代码。
        使用 extension 在 类/结构体已有代码外，但在同一个文件内。
        请注意 extension 内的代码不能被子类重写，这也意味着测试很难进行。 如果这是经常发生的情况，为了代码一致性最好统一使用第一种办法。否则使用第二种办法，其可以代码分割更清晰。
        使用而第二种方法的时候，使用  // MARK:  依然可以让代码在 Xcode 可读性更强。
     7. 推荐尽可能使用 for item in items 而不是 for i in 0..10
     8. 协议一致性：当对象要实现协议一致性时，推荐使用 extension 隔离协议中的方法集，这样让相关方法和协议集中在一起，方便归类和查找
     9. 尽量不要使用 as! 或 try!
    10. 判断是否为空的调用对象的 isEmpty 方法
    11. Swift中使用OC类的方法：创建文件把oc类import进去，把文件路径拖拽到Object-C Bridging Header
    12. 不能对为空的optional进行解包 ( ! 解包 ), 否则会报运行时错误.
    13. [weak self] 避免block循环引用
     */
    
    
    
    // MARK: -  swift中的关键字
    /**
         let : 声明一个常量. 类似于const
         protocol : 协议.也可以叫接口.这个往往在很多高级语言中不能多重继承的情况下使用协议是一个比较好的多态方式。
         static : 声明静态变量或者函数
         struct : 声明定义一个结构体
         subscript : 下标索引修饰.可以让class、struct、以及enum使用下标访问内部的值
         typealias : 为此类型声明一个别名.和 typedef类似.
         break : 跳出循环.一般在控制流中使用,比如 for . while switch等语句
         case : switch的选择分支.
         continue : 跳过本次循环,继续执行后面的循环.
         in : 范围或集合操作,多用于遍历.
         fallthrough : swift语言特性switch语句的break可以忽略不写,满足条件时直接跳出循环.fallthrough的作用就是执行完当前case,继续执行下面的case.类似于其它语言中省去break里，会继续往后一个case跑，直到碰到break或default才完成的效果.
     */
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


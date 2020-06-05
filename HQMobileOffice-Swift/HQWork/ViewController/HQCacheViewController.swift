//
//  HQCacheViewController.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/10.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit
import Alamofire


class HQCacheViewController: UIViewController {

    
    lazy var textView: UITextView = {
        
        let textView = UITextView()
        textView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (kScreenHeight - 10) / 2)
        textView.backgroundColor = UIColor.red
        return textView
    }()
    
    
    lazy var cacheView: UITextView = {
        let cacheView = UITextView()
        cacheView.frame = CGRect.init(x: 0, y: self.textView.bottom + 10, width: kScreenWidth, height: self.textView.height)
        return cacheView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataAndCache()
        view.addSubview(self.textView)
        view.addSubview(self.cacheView)
        
        
        let loop = RunLoop.current
        loop.add(Port.init(), forMode: RunLoopMode.commonModes)
        loop.run()
        
        
        let timer = Timer.init(timeInterval: 0.25, repeats: true) { (timer) in
        }
        loop.add(timer, forMode: RunLoopMode.commonModes)
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadDataAndCache()  {
//        DaisyNet.openResultLog = false
//        DaisyNet.timeoutIntervalForRequest(4)
        let url = "http://api.travels.app887.com/api/Articles.action"
        let params = ["keyword" : "", "npc" : "0", "opc" : "20", "type" : "热门视频", "uid" : "2321"]
        
//        DaisyNet.request(url, params: params).cache(true).responseCacheAndString { value in
//            switch value.result {
//            case .success(let json):
//                if value.isCacheData {
//                    self.cacheView.text = json
//                } else {
//                    self.textView.text = json
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    
    // global Queue + 异步任务
    func globalAsyn(_ sender: Any) {
        // 创建一个全局队列。
        let globalQueue = DispatchQueue.global()
        for i in 0...10 {
            // 使用全局队列，开启异步任务。
            globalQueue.async {
                print("I am No.\(i), current thread name is:\(Thread.current)")
            }
        }
    }

}

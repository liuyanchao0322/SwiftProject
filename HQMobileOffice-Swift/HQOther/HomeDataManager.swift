//
//  HomeDataManager.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/5.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//

import UIKit

//HomeDataManager.swift
@objc enum HomeDataRequestStatus:Int {//网络请求状态
    case Normal
    case NoNetWork
    case TimeOut
}

@objc protocol HomeDataManagerDelegate:NSObjectProtocol {
    func responseforHomeDynamicDataRequest(response:NSArray?,status:HomeDataRequestStatus)
    @objc optional func pageNoforRequestDynamicData() -> Int
    @objc optional func pageSizeforRequestDynamicData() -> Int
}

class HomeDataManager: NSObject {
    enum HomeDynamicDataType {//数据类型
        case HomeAuthoritativeInformation//首页数据
        case AuthoritativeInformation//权威发布
        case PartyConstitution//党章
        case PartyrulesAndDisciplines//党规党纪
        case PartyHistory//党史
        case SecretarySpeech//系列讲话
    }
    
    var delegate:HomeDataManagerDelegate?
    
 
    
    private override init() { }
    
    func dataRequestforHomeDynamic(type:HomeDynamicDataType) {
        let parms = self.requestParmsforHomeDynamicDataSource(type: type)
        
        if let pageNo = self.delegate?.pageNoforRequestDynamicData?() {
            parms["pageNo"] = pageNo
        }
        
        if let pageSize = self.delegate?.pageSizeforRequestDynamicData?()  {
            parms["pageSize"] = pageSize
        }
        
        
        HQNetworkTools.requestData(.post, URLString: "", parameters: parms as? [String : Any], finishedCallback: { (result) in
//                self.delegate?.responseforHomeDynamicDataRequest(rows, status: .Normal)

        }) { (error) in
//            self.delegate?.responseforHomeDynamicDataRequest(nil, status: .TimeOut)
        }
    }    
}

extension HomeDataManager {
    func requestParmsforHomeDynamicDataSource(type:HomeDynamicDataType) -> NSMutableDictionary {
        let dict =  ["token": "FD65C7F1-10AA-4A3F-BF41-F3F285883FCD",
                     "keyword":"" ,
                     "pageSize": 7,
                     "pageNo": 1,
                     "type": 4,
                     "childType": 1
            ] as [String : Any]
        let parms = NSMutableDictionary(dictionary: dict)
        
        switch type {
        case .HomeAuthoritativeInformation:
            parms["pageSize"] = 4
            parms["type"] = 1
            return parms
        case .AuthoritativeInformation:
            parms["type"] = 1
            return parms
        case .PartyConstitution:
            return parms
        case .PartyHistory:
            parms["childType"] = 2
            return parms
        case .PartyrulesAndDisciplines:
            parms["childType"] = 3
            return parms
        case .SecretarySpeech:
            parms["childType"] = 4
            return parms
        }
        
    }
}


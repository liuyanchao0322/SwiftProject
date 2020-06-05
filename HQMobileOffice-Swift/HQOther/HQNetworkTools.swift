//
//  HQNetworkTools.swift
//  HQMobileOffice-Swift
//
//  Created by 太极华青协同办公 on 2018/7/3.
//  Copyright © 2018年 太极华青协同办公. All rights reserved.
//


import Foundation
import Alamofire
import Reachability
import UIKit
import SwiftyJSON

enum MethodType {
    case get
    case post
}


class HQNetworkTools {
    
    static let instance: HQNetworkTools = HQNetworkTools()
    class func shareNetwork() -> HQNetworkTools {
        return instance
    }
    
    func networkLoadData()  {
        print("单例对象方法")
    }
    
    /**
     SwiftyJSON给我们提供的获取数据包含了Optional 与 Non-Optional两种方式，从源码可以看出各个数据类型各自对应的非可选类型返回的默认值：
     fileprivate var rawArray: [Any] = []
     fileprivate var rawDictionary: [String : Any] = [:]
     fileprivate var rawString: String = ""
     fileprivate var rawNumber: NSNumber = 0
     fileprivate var rawNull: NSNull = NSNull()
     fileprivate var rawBool: Bool = false
     
     作者：一根聪
     链接：https://www.jianshu.com/p/06376ca5a935
     來源：简书
     */
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> (), failureCallback:   @escaping (_ result : Error) -> ()) {
        
        HQNetworkTools.checkConnenct()
        
        let mainUrl = String.init(format: "%@%@", kMainUrl,URLString)
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(mainUrl, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                //                return
                return failureCallback(response.result.error!)
            }
             
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
    
    
   class func checkConnenct() {
        
        let reachability = Reachability.init()
        //判断连接状态
        if reachability!.connection != .none{
            print("网络连接：可用")
        }else{
            print("网络连接：不可用")
        }
        let objc = NSObject.init()

        //判断连接类型
        if reachability!.connection == .wifi {
            print("网络类型：WiFi")
            objc.showText(text: "网络类型：WiFi", view: UIApplication.shared.keyWindow!, after: 2.0)

        }else if reachability!.connection == .cellular {
            print("连接类型：移动网络")
            objc.showText(text: "连接类型：移动网络", view: UIApplication.shared.keyWindow!, after: 2.0)
        }else {
            print("连接类型：没有网络连接")
            objc.showText(text: "连接类型：没有网络连接", view: UIApplication.shared.keyWindow!, after: 2.0)
        }
    }
    
    
    /** 上传多张图片
     * urlString : 上传Url
     * params    : 参数
     * data      : 上传的图片数组 -> NSData *eachImgData = UIImageJPEGRepresentation(selectImage, 0.5);
     * name      : fileName
     */
    func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]
                
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            let json = JSON(value)
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                }
        }
        )
    }
    
    
    /**
     *  上传单张图片
     *  urlString : 上传Url
     *  params    : 参数
     *  data      : 上传的图片 ->  NSData *eachImgData = UIImageJPEGRepresentation(selectImage, 0.5);
     *  name      : fileName
     */
    func upLoadImageSingerRequest(urlString : String, params:[String:String], data: Data, name: String,success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]
                
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                //  ********** 此处需要注意的是需要传输的数据名称是要和后台的名称一样  Name   fileName
                multipartFormData.append(data, withName: "appPhoto", fileName: name, mimeType: "image/png")

        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            let json = JSON(value)
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                }
        }
        )
    }

    
}


//    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
//
//        // 1.获取类型
//        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
//
//        // 2.发送网络请求
//        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
//
//            // 3.获取结果
//            guard let result = response.result.value else {
//                print(response.result.error!)
//                return
//            }
//
//            // 4.将结果回调出去
//            finishedCallback(result)
//        }
//    }


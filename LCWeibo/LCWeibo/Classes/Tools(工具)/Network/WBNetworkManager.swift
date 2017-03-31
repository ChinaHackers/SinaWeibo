//
//  WBNetworkManager.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/31.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import AFNetworking

// 定义枚举类型
enum HTTPMethod {
    case GET
    case POST
}

/// 网络管理工具类
/// 
/// 封装AFN的网络请求方法
class WBNetworkManager: AFHTTPSessionManager {

    
    /// 单例
    ///
    /// 静态/常量/闭包/
    ///
    /// 在第一次访问时, 访问闭包, 并将结果保存在 shared 常量中
    static let shared = WBNetworkManager()
    
    
    /// 定义一个函数, 来封装AFNetworking 的 GET \ POST 请求
    ///
    /// - Parameters:
    ///   - method: GET / POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调
    ///   - json      : json文件(可能是字典 \ 数组)
    ///   - isSuccess : 是否成功
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String: Any], completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
       
        // 1.定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask?, json : Any?) -> () in
            
            completion(json, true)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : URLSessionDataTask?, error : Error) -> () in
            
            completion(nil, false)
            
            print("网络请求失败\(error)")
        }

        // 3.发送网络请求
        if method == .GET {
            
            get(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            
        } else {
            
            post(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }

    }

}

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

    
    // FIXME: 完善
    
    
    
    
    
    
    /// 用户登录标记[计算型属性]
    var userLogon: Bool {
        //return userAccount.access_token != nil
        
        return true
    }
    
    
    
    /// 单例
    ///
    /// 静态/常量/闭包/
    ///
    /// 在第一次访问时, 访问闭包, 并将结果保存在 shared 常量中
    static let shared = WBNetworkManager()
    
    
    
    /// 访问令牌, 所有的网络请求, 都需要此令牌(登录除外)
    // 为了用户的安全, token 时限: 默认用户 三天
    var accessToken: String? = "2.00EJsY7GYwvbnBd88e302956Vt8b7E"
    
    /// 负责拼接 Token 的网络请求方法
    ///
    /// - Parameters:
    ///   - method: GET / POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调
    ///   - json      : json文件(可能是字典 \ 数组)
    ///   - isSuccess : 是否成功
    func ToKenRequest(method: HTTPMethod = .GET, URLString: String, parameters: [String: Any]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        // 处理 ToKen 字典
        // 0>.判断 ToKen 是否为nil, 如果为nil, 直接返回
        guard let token = accessToken else {
        
            // FIXME: 发送通知，提示用户再次登录
            print("没有 token 需要登录")
            completion(nil, false)
            
            
            return
        
        
        }
        
        // 1>.判断参数字典是否存在, 如果结果为nil, 新建一个字典
        var parameters = parameters
        
        if parameters == nil {
            
            // 实例化字典
            parameters = [String: Any]()
        }
        
        // 2>. 设置参数字典, 此处字典一定有值
        parameters!["access_token"] = token
        
        
        // 调用 request 发起真正的网络请求
        request(URLString: URLString, parameters: parameters, completion: completion)
        
    }
    
    
    /// 定义一个函数, 来封装AFNetworking 的 GET \ POST 请求
    ///
    /// - Parameters:
    ///   - method: GET / POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调
    ///   - json      : json文件(可能是字典 \ 数组)
    ///   - isSuccess : 是否成功
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String: Any]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
       
        // 1.定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask?, json : Any?) -> () in
            
            completion(json, true)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : URLSessionDataTask?, error : Error) -> () in
            
            
            // 针对 403 处理用户 token 过期
            // 对于测试用户(应用程序还没有提交给新浪微博审核)每天的刷新量是有限的！
            // 超出上限，token 会被锁定一段时间
            // 解决办法，新建一个应用程序！
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
               
                print("Token 过期了")
                
                // FIXME: BUG
                
                // 发送通知，提示用户再次登录(本方法不知道被谁调用，谁接收到通知，谁处理！)
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification),object: "bad token")
            }
            
            print("网络请求失败\(error)")
            
            completion(nil, false)
            
        }

        // 3.发送网络请求
        if method == .GET {
            
            get(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            
        } else {
            
            post(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }

    }

}

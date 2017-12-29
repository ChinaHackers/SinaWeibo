//
//  WBNetworkManager+Extension.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/31.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation

// MARK:- 封装新浪微博的网络请求方法
extension WBNetworkManager {
    
    /// 加载微博数据(字典\数组)
    ///
    /// - Parameters:
    ///   - since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    ///   - max_id: 返回ID小于或等于max_id的微博，默认为0
    ///   - completion: 完成回调
    ///   - List      : 微博数据(字典\数组)
    ///   - isSuccess : 是否请求成功
    func loadDataList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ List: [[String : Any]]?, _ isSuccess: Bool)->()) {
        
        /// URL
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        /// 参数
//        let params = ["access_token": "2.00EJsY7GYwvbnBd88e302956Vt8b7E"]
       
        // Swift 中 Int 可以转换成 AnyObject/ 但是 Int64 不行
        let params = ["since_id": "\(since_id)", "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]
        
        ToKenRequest(URLString: urlString, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
            
//            print(json ?? "")
            
            // 从 json 中获取 statuses 字典数组
            // 如果 as? 失败，result = nil
            // 提示：服务器返回的字典数组，就是按照时间的倒序排序的
            
            // 首先转换json 为字典
            let convertJson = json as? [String : Any]
            
            // 然后根据 statuses 的key 取出数据
            let result = convertJson?["statuses"] as? [[String : Any]]
            
            // 回调
            completion(result , isSuccess)
        }
    }
    
    
    /// 返回微博未读数量
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        
        guard let uid = uid else { return }
        
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        
        let parm = ["uid": uid]
        
        
        ToKenRequest(URLString: urlString, parameters: parm) { (json, isSuccess) in
            
            let dict = json as! [String: AnyObject]
            
            let count = dict["status"] as? Int
            
            // print(json ?? "")
            
            completion(count ?? 0)
        }
        
    }
    
    
}

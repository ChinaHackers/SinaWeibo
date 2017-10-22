//
//  WBStatusListViewModel.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/4/2.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation


/// 微博数据列表视图模型
/*
 父类的选择
 
 - 如果类需要使用 `KVC` 或者字典转模型框架设置对象值，类就需要继承自 NSObject
 - 如果类只是包装一些代码逻辑(写了一些函数)，可以不用任何父类，好处：更加轻量级
 - 提示：如果用 OC 写，一律都继承自 NSObject 即可
 
 使命：负责微博的数据处理
 1. 字典转模型
 2. 下拉／上拉刷新数据处理
 */

/// 负责微博的数据处理
class WBStatusListViewModel {
    
    
    /// 懒加载 微博模型数组
    lazy var statusList = [WBStatusModel]()
    
    
    /// 加载微博数据列表
    ///
    /// - parameter pullup:     是否上拉刷新标记
    /// - parameter completion: 完成回调[网络请求是否成功, 是否刷新表格]
    func loadStatus(completion: @escaping (_ isSuccess : Bool) -> ()) {
        
        // since_id: 取出数组中第一条微博的ID
        let since_id = statusList.first?.id ?? 0
        
        
        WBNetworkManager.shared.loadDataList(since_id: since_id, max_id: 0) { (list, isSuccess) in
         
            // 1.字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatusModel.self, json: list ?? [])  as? [WBStatusModel] else {
                
                completion(isSuccess)
                
                return
            }
            
            // 2.拼接数据
            // 下拉刷新, 应该将结果数组拼接在数组的前面
            self.statusList = array + self.statusList
            
            // 3.完成回调
            completion(isSuccess)
        }
        
    }
    
}

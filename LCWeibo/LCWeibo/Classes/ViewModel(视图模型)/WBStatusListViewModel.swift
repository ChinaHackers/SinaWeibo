//
//  WBStatusListViewModel.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/4/2.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation


/// 微博数据列表视图模型

/// 负责微博的数据处理
class WBStatusListViewModel {
    
    
    /// 懒加载 微博模型数组
    lazy var statusList = [WBStatusModel]()
    
    
    /// 加载微博数据列表
    func loadStatus(completion: @escaping (_ isSuccess : Bool) -> ()) {
        
        WBNetworkManager.shared.loadDataList { (list, isSuccess) in
         
            // 1.字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatusModel.self, json: list ?? [])  as? [WBStatusModel] else {
                
                completion(isSuccess)
                
                return
            }
            
            // 2.拼接数据
            self.statusList += array
            
            // 3.完成回调
            completion(isSuccess)
        }
        
    }
    
}

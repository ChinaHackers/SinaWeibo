//
//  WBStatusModel.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/4/2.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import YYModel

/// 微博数据模型
class WBStatusModel: NSObject {
    
    // 如果不指明Int64, 非64位设备, 数据会溢出
    var id          : Int64 = 0     // 微博ID
    var text        : String = ""	// 微博信息内容
    var bmiddle_pic : String = ""	// 中等尺寸图片地址，没有时不返回此字段
    
    
    
    /// 重写 Description 的计算型属性
    override var description: String {
        
        return yy_modelDescription()
    }
}

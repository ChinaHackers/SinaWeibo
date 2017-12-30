//
//  Bundle+Extensions.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2016/12/30.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation

extension Bundle {
    
    // 计算型属性类似于函数，没有参数，有返回值
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}

//
//  UIBarButtonItem+Extension.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/5.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

// MARK: - 扩展 UIBarButtonItem
extension UIBarButtonItem {
    
/*   方式1:
     // convenience : 便利构造函数
     // Swift中如果在类扩展中扩充构造函数,必须写便利构造函数
     // 便利构造函数:1.必须在构造函数前convenience 2.必须调用self.init()
     
     
     /// 设置导航条按钮的普通,高亮图片,监听按钮的点击
     convenience init(imageName:String, target: AnyObject?, action: Selector) {
         let btn = UIButton()
         btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
         btn.setImage(UIImage(named: imageName), for: .normal)
         btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
         btn.addTarget(target, action: action, for: .touchUpInside)
         self.init(customView: btn)
     }
     
*/
    
    // 方式2: 自定义 UIBarButtonItem 类方法
    
    /// 设置导航条按钮的普通,高亮图片,监听按钮的点击
    class func foundBarButtonItem(imageName:String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    

    
}

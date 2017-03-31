//
//  ComposeTypeButton.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/29.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 撰写按钮
class ComposeTypeButton: UIControl {

    
    /// 控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
    /// 使用图像名称/标题创建按钮, 使用 XIB 布局\加载 按钮.
    ///
    /// - Parameters:
    ///   - imageName: 图像名称
    ///   - title: 标题文字
    /// - Returns: composeTypeButton
    class func composeTypeButton(imageName: String, title: String) -> ComposeTypeButton {
        
        let nib = UINib(nibName: "ComposeTypeButton", bundle: nil)
        
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! ComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLabel.text = title
        
        return btn
    }
    
    
}

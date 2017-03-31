//
//  TitleButton.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/6.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

// MARK: -自定义标题按钮
class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor.black, for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 修改按钮内部属性, 实现文字在前,图标在后
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width
    }

}

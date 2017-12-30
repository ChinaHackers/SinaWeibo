//
//  WBComposeTextView.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/12/31.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// UITextView的子类
class WBComposeTextView: UITextView {

    /// 占位符
    fileprivate lazy var placeholderLabel = UILabel()
    
    /// 加载nib文件时, 调用
    override func awakeFromNib() {
        
        configUI()
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 监听方法
    @objc fileprivate func textChanged() {
       
        // 如果有文本，不显示占位标签，否则显示 . hasText: 是否有文本
        placeholderLabel.isHidden = self.hasText
    }


}

private extension WBComposeTextView {
    
    /// 配置UI
    func configUI() {
        
        
        // 0.注册通知
        // - 通知是一对多，如果其他控件监听当前文本视图的通知，不会影响
        // - 但是如果使用代理，其他控件就无法使用代理监听通知！
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: NSNotification.Name.UITextViewTextDidChange, object: self)

        
        // 1.设置占位符
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLabel.sizeToFit()
        
        addSubview(placeholderLabel)

        
    }
}

//
//  WBComposeViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/12/30.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/*
    加载视图控制器的时候，如果 XIB 和控制器同名，默认的构造函数，会优先加载 XIB文件
 */

/// 撰写微博控制器
class WBComposeViewController: UIViewController {

    // MARK: - 控件属性
    /// 文本编辑视图
    @IBOutlet weak var textView: UITextView!
  
    /// 底部工具栏
    @IBOutlet weak var toolbar: UIToolbar!
    
    /// 发布按钮
    @IBOutlet var sendButton: UIButton!
    
    /// 标题标签 - 换行的热键 option + 回车
    /// 逐行选中文本并且设置属性
    /// 如果要想调整行间距，可以增加一个空行，设置空行的字体，lineHeight
    @IBOutlet var titleLabel: UILabel!
    
    /// 工具栏底部约束
    @IBOutlet weak var toolbarBottomCons: NSLayoutConstraint!
    
    // MARK: - 视图的生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        // 监听键盘通知 - UIWindow.h
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChanged), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

   
    }
    
    /// 在视图要被显示出来 之前 被调用。
    /// 这总是会发生在ViewDidload被调用之后并且每次view显示之前都会调用该方法
    ///
    /// - Parameter animated: 是否动画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 激活键盘
        textView.becomeFirstResponder()
    }
    
    /// 视图即将 可见 时,加载
    ///
    /// - Parameter animated: 是否动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 设置文本视图的代理
        textView.delegate = self
    }
    
    /// 视图即将 消失 时,加载
    ///
    /// - Parameter animated: 是否动画
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 关闭键盘
        textView.resignFirstResponder()
    }
    

    // MARK: - 监听方法
    
    /// 键盘监听
    @objc private func keyboardChanged(n: Notification) {
         print(n.userInfo ?? "")
        
        
        // 1. 拿到目标 rect
        guard let rect = (n.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // 动画时长
        guard let duration = (n.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        
        // 2. 设置底部约束的高度
        let offset = view.bounds.height - rect.origin.y
        
        // 3. 更新底部约束
        toolbarBottomCons.constant = offset
        
        // 4. 动画更新约束
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }

        
    }
    
    
    /// 取消按钮的监听
    @objc fileprivate func cancel() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - 配置UI界面
extension WBComposeViewController {
    
    /// 配置UI
    fileprivate func configUI() {
        
        view.backgroundColor = .white
        
        configNavigationBar()
        configToolbar()
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 修改导航栏按钮颜色
        navigationController?.navigationBar.tintColor = .black
     
        /// 取消按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        
        // 设置发送按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        // 设置标题视图
        navigationItem.titleView = titleLabel
        
        /// 发布按钮是否选中
        sendButton.isEnabled = false
    }
    
    /// 配置工具栏
    private func configToolbar() {
        
        /// 图片数组
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_toolbar_more"]]
        
        /// 自定义的Item数组
        var customItems = [UIBarButtonItem]()
        
        // 遍历数组
        for s in itemSettings {
            
            guard let imageName = s["imageName"] else { continue }
            
            let image = UIImage(named: imageName)
            let imageHL = UIImage(named: imageName + "_highlighted")
            
            let btn = UIButton()
            btn.sizeToFit()
            btn.setImage(image, for: [])
            btn.setImage(imageHL, for: .highlighted)
            

            // 追加按钮
            customItems.append(UIBarButtonItem(customView: btn))
            
            // 追加弹簧
            customItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        
        }
        
        // 删除末尾弹簧
        customItems.removeLast()
        
        toolbar.items = customItems
    }
    
}


// MARK: - UITextViewDelegate
/**
 通知：一对多，只要有注册的监听者，在注销监听之前，都可以接收到通知！
 代理：一对一，最后设置的代理对象有效！
 
 苹果日常开发中，代理的监听方式是最多的！
 
 - 代理是发生事件时，直接让代理执行协议方法！
 代理的效率更高
 直接的反向传值
 - 通知是发生事件时，将通知发送给通知中心，通知中心再`广播`通知！
 通知想对要低一些
 如果层次嵌套的非常深，可以使用通知传值
 */
extension WBComposeViewController: UITextViewDelegate {
    
    /// 文本视图文字变化
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.hasText
    }
}


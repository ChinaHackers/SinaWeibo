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
    
    
    // MARK: - 视图的生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
   
    }
    
    
    @objc fileprivate func close() {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(close))
        
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


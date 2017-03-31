//
//  QRCodeViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit


// MARK: - 二维码
class QRCodeViewController: UIViewController {

    
    /// 自定义TabBar
    @IBOutlet weak var CustomTabBar: UITabBar!
    
    // MARK: - 关闭按钮点击事件
    @IBAction func closeBtn(_ sender: UIBarButtonItem) {
        
        // 消失视图
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()

    }
    
    
    /// 配置UI界面
    private func configUI() {
    
        // 默认选择第0个
        CustomTabBar.selectedItem = CustomTabBar.items?[0]
        
    }
}

//
//  BaseTableViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/5.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    
    // MARK: - 懒加载属性
    // 加载xib
//    private lazy var visitor_View = VisitorView.load_VisitorView()
    
    // MARK: - 定义属性
    
    /// 是否登录
    let userLogin = true

    /// 记录游客视图
    var visitorView: VisitorView?
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        
        // 如果登录,就创建tableView, 否配置游客界面
        userLogin ? super.loadView() : configVisitor()
        
    }
}




// MARK: - 配置UI界面
extension BaseTableViewController {
    
    /// 配置游客视图界面
    fileprivate func configVisitor() {
        
        // 初始化游客界面
        let customView = VisitorView()
        
        customView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.00)
        
        // 监听关注按钮
        customView.attention_Btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        // 当前的view为游客界面
        view = customView
        
        // 赋值customView给visitorView
        visitorView = customView
        
        configVisitorNavigationItems()
        
    }
    
    /// 配置游客界面的导航栏左右的Item
    private func configVisitorNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    }

}

// MARK: - 事件监听
extension BaseTableViewController {
    
    /// 导航栏按钮点击事件
    @objc fileprivate func login() {
        print(#function)
    }
    
    @objc fileprivate func register() {
        print(#function)
    }
}




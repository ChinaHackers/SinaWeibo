//
//  MessageTableViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/5.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果没有登录, 就设置游客界面的信息
        if !userLogin {
            
            visitorView?.setupVisitorView(isHome: false, imageName: "visitordiscover_image_message", message: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
            return
        }
        
        
        //配置导航栏
        configNavigation()
        
    }
    
    // MARK: - 配置导航栏
    private func configNavigation() {
        
        // 设置导航条左右俩边的按钮
        
        /// 左边按钮
        let leftBtn = UIButton()
        leftBtn.setTitle("发现群", for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        leftBtn.setTitleColor(UIColor.black, for: .normal)
        leftBtn.setTitleColor(UIColor.orange, for: .highlighted)
        leftBtn.addTarget(self, action: #selector(LeftItemClick), for: .touchUpInside)
        leftBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem.foundBarButtonItem(imageName: "navigationbar_icon_newchat", target: self, action: #selector(RightItemClick))
    }

}

// MARK: - 事件监听
extension MessageTableViewController {
    
    // MARK: 左右2边按钮点击事件
    @objc fileprivate func LeftItemClick() {
        print("LeftItemClick")
    }
    
    @objc fileprivate func RightItemClick() {
        print("RightItemClick")
    }

    
    
}




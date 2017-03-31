//
//  MineTableViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/5.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class MineTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果没有登录, 就设置游客界面的信息
        if !userLogin {
            
            visitorView?.setupVisitorView(isHome: false, imageName: "visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }
    
        
        //配置导航栏
        configNavigation()
        
    }
    
    // MARK: - 配置导航栏
    private func configNavigation() {
        
        // 设置导航条左右俩边的按钮
        // 左边按钮
        let leftBtn = UIButton()
        leftBtn.setTitle("添加好友", for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        leftBtn.setTitleColor(UIColor.black, for: .normal)
        leftBtn.setTitleColor(UIColor.orange, for: .highlighted)
        leftBtn.addTarget(self, action: #selector(LeftItemClick), for: .touchUpInside)
        leftBtn.sizeToFit()
        
        // 右边按钮
        let rightBtn = UIButton()
        rightBtn.setTitle("设置", for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        rightBtn.setTitleColor(UIColor.orange, for: .highlighted)
        rightBtn.addTarget(self, action: #selector(RightItemClick), for: .touchUpInside)
        rightBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
     
        
    }

}


// MARK: - 事件监听
extension MineTableViewController {
    
    // MARK: 左右2边按钮点击事件
    @objc fileprivate func LeftItemClick() {
        print("LeftItemClick")
    }
    
    @objc fileprivate func RightItemClick() {
        print("RightItemClick")
    }
    
}



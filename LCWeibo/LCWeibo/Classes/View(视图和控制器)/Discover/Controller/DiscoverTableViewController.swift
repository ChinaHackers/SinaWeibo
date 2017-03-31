//
//  DiscoverTableViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/5.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果没有登录, 就设置游客界面的信息
        if !userLogin {
            
            visitorView?.setupVisitorView(isHome: false, imageName: "visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            
        }
    
    }

}

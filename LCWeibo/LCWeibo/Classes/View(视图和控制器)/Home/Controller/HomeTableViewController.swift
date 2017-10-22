//
//  HomeTableViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/5.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {
   
    // MARK: - 懒加载属性
    fileprivate lazy var titleBtn: TitleButton = TitleButton()
    
    
    /// 微博数据列表视图模型对象
    fileprivate lazy var listViewModel = WBStatusListViewModel()
    
    // 注意:在闭包中如果使用当前对象的属性或者调用方法,也需要加self
    // 两个地方需要使用self : 1> 如果在一个函数中出现歧义 2> 在闭包中使用当前对象的属性和方法也需要加self
    
    fileprivate lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[weak self] (presented) -> () in
        
        self?.titleBtn.isSelected = presented
    }
    

    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // 如果没有登录, 就设置游客界面的信息
        if !userLogin {
            visitorView?.setupVisitorView(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }

        // 配置导航栏
        configNavigationBar()
        

        loadData()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    /// 加载数据
    private func loadData() {
     
/*
        //MARK: 用网络工具微博加载数据
        WBNetworkManager.shared.loadDataList { (List, isSuccess) in
            
            print("网络加载完成....\(List)")
            
            //MARK: 字点转模型, 配置表格数据
        }
        
*/
        self.listViewModel.loadStatus { (isSuccess) in
            
            // 刷新表格
            self.tableView.reloadData()
            
        }
        
        
        
        
        
//        print("开始加载数据\(WBNetworkManager.shared)")
        
    }
    
}

// MARK: - 配置UI界面
extension HomeTableViewController {
    
    /// 配置导航栏
    fileprivate func configNavigationBar() {
        
        /*
         // 1.配置左边Item
         let leftBtn = UIButton()
         leftBtn.setImage(UIImage(named: "navigationbar_friendattention"), forState: UIControlState.Normal)
         leftBtn.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), forState: UIControlState.Highlighted)
         leftBtn.sizeToFit()
         navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
         
         // 2.配置右边Item
         
         let rightBtn = UIButton()
         rightBtn.setImage(UIImage(named: "navigationbar_pop"), forState: UIControlState.Normal)
         rightBtn.setImage(UIImage(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
         rightBtn.sizeToFit()
         navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
         
         navigationItem.leftBarButtonItem = creatBarButtonItem("navigationbar_friendattention", target: self, action: "leftItemClick")
         navigationItem.rightBarButtonItem = creatBarButtonItem("navigationbar_pop", target: self, action: "rightItemClick")
         */
        
        
        // command + control + e 快速修改变量名
        
        // 通过扩展 UIBarButtonItem的方法, 设置导航条左右俩边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.foundBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(LeftItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.foundBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(RightItemClick))
        
        // 3.设置TitleView
       // let titleBtn = TitleButton()
        
        titleBtn.setTitle("LiuChuan ", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
        
    }
    
}

// MARK: - 事件监听
extension HomeTableViewController {
    
    // MARK: 左右2边Item点击事件
    @objc fileprivate func LeftItemClick() {
        print("LeftItemClick")
    }
    
    @objc fileprivate func RightItemClick() {
        print("RightItemClick")
        
        // 获取storyboard 二维码控制器
        let storyBoard = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        
        let vc = storyBoard.instantiateInitialViewController()
        
        // motal展现
        present(vc!, animated: true, completion: nil)
        
    }
    

    // MARK: 标题View的点击事件
    @objc fileprivate func titleBtnClick(_ btn: TitleButton) {
 
        // 1.创建弹出控制器, 利用storyBoard中加载控制器
        let storyBoard = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let popoverVC = storyBoard.instantiateInitialViewController()
        
        // 2.设置转场动画的代理
        // 默认情况下modal会移除以前控制器的view, 替换为当前弹出的view
        // 如果自定义转场, 那么就不会移除以前控制器的view
        
        popoverVC!.transitioningDelegate = popoverAnimator
        
        popoverAnimator.presented_Frame = CGRect(x: 100, y: 56, width: screenW / 2.0, height: screenH / 2.0)
        
        
        // 3.设置转场动画的样式
        popoverVC!.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // 4.弹出控制器
        present(popoverVC!, animated: true, completion: nil)
        
        
    }
    
}


// MARK: - 遵守 UITableViewDataSource 协议
extension HomeTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listViewModel.statusList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
//        cell.imageView?.image = UIImage(named: listViewModel.statusList[indexPath.row].bmiddle_pic)
    
        return cell
    }
    
    
    
}
















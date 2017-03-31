//
//  PopoverPresentationController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/7.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
 

    // MARK:- 对外提供属性
    var presentedFrame : CGRect = CGRect.zero
    
    
    // MARK: - 懒加载蒙版
    fileprivate lazy var coverView: UIView = UIView()
        
    /**
     初始化方法, 用于创建负责转场动画的对象
     
     :param: presentedViewController  被展现的控制器
     :param: presentingViewController 发起的控制器, Xocde6是nil, Xcode7是野指针
     
     :returns: 负责转场动画的对象
     */
//    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
//        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
//        
//       // print(presentedViewController)
//        //print(presentingViewController)
//    }
//    
    
    // containerView :  容器视图
    // presentedView :  被展现的视图
    
    // MARK: - 即将布局转场子视图时调用
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
       
        // 1.设置弹出视图的尺寸
        presentedView?.frame = presentedFrame

        // 2.添加蒙版
        configCoverView()
     }
    
}

// MARK: - 配置UI界面
extension PopoverPresentationController {
    
    /// 配置蒙版
    fileprivate func configCoverView() {
    
        // 添加蒙版
        // 因为展现视图和蒙版都在都一个视图上, 而后添加的会盖住先添加的
        containerView?.insertSubview(coverView, at: 0)

        // 设置蒙版相关属性
        coverView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        coverView.frame = UIScreen.main.bounds
        //coverView.frame = containerView!.bounds
        
        
        // 创建手势, 并添加给蒙版
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        coverView.addGestureRecognizer(tap)

    }
}

// MARK: - 事件监听
extension PopoverPresentationController {
    
    // 点击事件 -> 关闭弹出控制器
    @objc fileprivate func close(){
        // presentedViewController: 当前弹出的控制器
        presentedViewController.dismiss(animated: true, completion: nil)
    }

}







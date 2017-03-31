//
//  TabBarController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/4.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    // MARK: - 懒加载属性
    /// 撰写按钮( +号按钮 )
    private lazy var composeBtn: UIButton = {
        
        // 创建按钮, 并设置相关属性
        let button = UIButton()
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()

    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 配置UI界面
        configUI()
        
        // 启动界面动画
        launchAnimation()
        
    }
    
    // MARK: 视图即将可见时调用。默认情况下不执行任何操作
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
        
        // 设置撰写按钮位置
        setupComposeBtn()
    }
    
    /*
        portrait   : 竖屏, 肖像
        landscape  : 横屏, 风景画
    
        - 使用代码控制设备的方向. 优点: 可以在需要的时候, 单独处理
        - 设置设备支持方向后,当前控制器 以及 字控制器 都会遵守设置的方向
        - 如果播放视频, 通常是通过 modal 展现的!
     */
    
    // MARK: - 设备的支持方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .portrait
    }
    
    
    // MARK: - 启动界面动画
    private func launchAnimation() {
        
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "launch")
        let launchview = vc.view!
        
        //let delegate = UIApplication.shared.delegate
        //delegate?.window!!.addSubview(launchview)
        
        self.view.addSubview(launchview) //如果没有导航栏，直接添加到当前的view即可
        
        //播放动画效果，完毕后将其移除
        UIView.animate(withDuration: 2, delay: 1.5, options: .beginFromCurrentState, animations: {
            
            launchview.alpha = 0.0
            
            launchview.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
            
        }) { (finished) in
            
            // 移除动画
            launchview.removeFromSuperview()
        }
        
    
    }
    
    
    // MARK: - 配置UI界面
    private func configUI() {

        
    }
    
    
    // MARK: - 撰写按钮的点击事件
    @objc private func composeBtnClick() {
        
        // FIXME: 0.判断是否登录
        
        // 1.实例化视图
        let composeView = ComposeTypeView.load_composeTypeView()
        
        // 2.显示视图
        composeView.show()
    }
    

    // MARK: - 设置撰写按钮位置
    private func setupComposeBtn(){
        
        /// 添加撰写按钮到tabBar上
        tabBar.addSubview(composeBtn)

        // 计算按钮宽度: TabBar栏的宽度 / 控制器的个数
        // 减小宽度, 使按钮按钮宽度变大, 从而解决误触碰
        let width = tabBar.bounds.width / CGFloat(viewControllers!.count) - 1
        
        // 创建按钮frame
        let rect = CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height)
        // 设置按钮frame和偏移位
        // 参数一: x方向偏移的值   参数二: y方向偏移的值
        composeBtn.frame = rect.offsetBy(dx: width * 2, dy: 0)

    }
    
}

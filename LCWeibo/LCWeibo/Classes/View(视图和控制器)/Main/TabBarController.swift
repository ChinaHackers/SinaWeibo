//
//  TabBarController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/4.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    /// 定时器
    fileprivate var timer: Timer?
    
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

        configUI()
        
        launchAnimation()
        
        setupTimer()
        
        // 设置新特性视图
        //setupNewfeatureViews()
        
        
        delegate = self
        
    }
    
    // MARK: - 销毁时钟
    deinit {
        // 销毁时钟
        timer?.invalidate()
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
        - 设置设备支持方向后,当前控制器 以及 子控制器 都会遵守设置的方向
        - 如果播放视频, 通常是通过 modal 展现的!
     */
    
    // MARK: - 设备的支持方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    /// 启动界面动画
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
    
    
    /// 配置UI界面
    private func configUI() {

        
    }
    
    
    // MARK: - 撰写按钮的点击事件
    @objc private func composeBtnClick() {
        
        // FIXME: 0.判断是否登录
        
        // 1.实例化视图
        let composeView = ComposeTypeView.load_composeTypeView()
        
        // 2.显示视图
        composeView.show { (clsName) in
            
//            print(clsName)
            
            // 展现撰写微博控制器
            guard let clsName = clsName,
                let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else {
            
                composeView.removeFromSuperview()   // 移除视图
                return
            }
            
            let vc = cls.init()
            let nav = UINavigationController(rootViewController: vc)
            
            // 让导航控制器强行更新约束 - 会直接更新所有子视图的约束！
            /* 提示：开发中如果发现不希望的布局约束和动画混在一起，应该向前寻找，强制更新约束！*/
            nav.view.layoutIfNeeded()
            
            self.present(nav, animated: true) { // motal展现控制器
                composeView.removeFromSuperview()
            }
        }
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

// MARK: - 定时器相关方法
extension TabBarController {
    
    /// 配置时钟
    fileprivate func setupTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateTimer) , userInfo: nil, repeats: true)
    }
    
    
    /// 时钟触发方法
    @objc fileprivate func updateTimer() {
        
        // 发起网络请求, 测试微博的未读数量
        WBNetworkManager.shared.unreadCount { (count) in
            
            print("监测到 \(count) 条新微博")
            
            
            // 设置首页 tabBarItem 的 badgeNumber
            self.tabBar.items?[0].badgeValue =  count > 0 ? "\(count)" : nil
            
            // 设置 App 的 badgeNumber, 从iOS8.0之后,需要用户授权后,才能显示
            UIApplication.shared.applicationIconBadgeNumber = count
            
        }
    }
}

// MARK: - 新特性视图处理
extension TabBarController {
    
    /// 设置新特性视图
    fileprivate func setupNewfeatureViews() {
        
        // 0. 判断是否登录
        if !WBNetworkManager.shared.userLogon {
            return
        }
        
        // 1. 如果更新，显示新特性，否则显示欢迎
//        let v = isNewVersion ? WBNewFeatureView.newFeatureView() : WBWelcomeView.welcomeView()
        
        // 2. 添加视图
//        view.addSubview(v!)
    }

    
    /// extesions 中可以有计算型属性，不会占用存储空间
    /// 构造函数：给属性分配空间
    /**
     版本号
     - 在 AppStore 每次升级应用程序，版本号都需要增加，不能递减
     
     - 组成 主版本号.次版本号.修订版本号
     - 主版本号：意味着大的修改，使用者也需要做大的适应
     - 次版本号：意味着小的修改，某些函数和方法的使用或者参数有变化
     - 修订版本号：框架／程序内部 bug 的修订，不会对使用者造成任何的影响
     */
    private var isNewVersion: Bool {
        
        // 1. 取当前的版本号 1.0.2
        // print(Bundle.main().infoDictionary)
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        print("当前版本" + currentVersion)
        
        // 2. 取保存在 `Document(iTunes备份)[最理想保存在用户偏好]` 目录中的之前的版本号 "1.0.2"
        let path: String = ("version" as NSString).lc_appendDocumentDir() as String
        let sandboxVersion = (try? String(contentsOfFile: path)) ?? ""
        print("沙盒版本" + sandboxVersion)
        
        // 3. 将当前版本号保存在沙盒 1.0.2
        _ = try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        
        // 4. 返回两个版本号`是否一致` not new
        return currentVersion != sandboxVersion
    }
    
}


// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    
    /// 将要选择 TabBarItem 时,调用
    /// 可以和当前选中的tab进行比较
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 1> 获取控制器在数组中的索引
        let index = (childViewControllers as NSArray).index(of: viewController)
        
        // 2> 判断当前索引是首页否, 并且 index 也处于首页, 重复点击首页按钮
        if selectedIndex == 0 && index == selectedIndex {
            print("重复点击首页......")
            
            // 3> 让表格滚动到顶部
            // 3.1> 获取控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! HomeTableViewController
            
            // 3.2> 滚动到顶部
            vc.tableView.setContentOffset(CGPoint(x: 0, y: -(navigationH + statusH)), animated: true)
            
            // 4> 刷新数据
            
        }
        // 判断 目标控制器 是否 是 UIViewController
        return !viewController.isMember(of: UIViewController.self)
        
        
    }
    
    // 选择完成, 切换完成
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        <#code#>
//    }
//    
    
    
}

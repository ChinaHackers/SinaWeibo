//
//  ComposeTypeView.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/29.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import pop

/*
 pop四大类
     POPSpringAnimation  有弹性效果的动画类（个人比较喜欢这个）
     POPBasicAnimation 基本动画类
     POPDecayAnimation 衰减动画类
     POPCustomAnimation 可以自定义动画的类
 */

/// 撰写类型视图
class ComposeTypeView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var closeBtn: UIButton!
    
    /*
     /// 按钮数据数组
     private let buttonsInfo = [["imageName": "tabbar_compose_idea_neo", "title": "文字", "clsName": "WBComposeViewController"],
     ["imageName": "tabbar_compose_camera", "title": "拍摄"],
     ["imageName": "tabbar_compose_weibo", "title": "相册"],
     ["imageName": "tabbar_compose_lbs", "title": "直播"],
     ["imageName": "tabbar_compose_review", "title": "光影秀"],
     ["imageName": "tabbar_compose_more", "title": "头条文章", "actionName": "clickMore"],
     ["imageName": "tabbar_compose_friend", "title": "好友圈"],
     ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
     ["imageName": "tabbar_compose_music", "title": "音乐"],
     ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
     ]
     
     */
    
    /// 按钮数据数组
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea_neo", "title": "文字"],
                               ["imageName": "tabbar_compose_camera", "title": "拍摄"],
                               ["imageName": "tabbar_compose_picture_neo", "title": "相册"],
                               ["imageName": "tabbar_compose_live_neo", "title": "直播"],
                               ["imageName": "tabbar_compose_slideshow_neo", "title": "光影秀"],
                               ["imageName": "tabbar_compose_article_neo", "title": "头条文章"],
                               ["imageName": "tabbar_compose_location_neo", "title": "签到"],
                               ["imageName": "tabbar_compose_comment_neo", "title": "点评"],
                               ["imageName": "tabbar_compose_topic_neo", "title": "话题"],
                               ["imageName": "tabbar_compose_envelope", "title": "红包"],
                               ["imageName": "tabbar_compose_friends_neo", "title": "好友圈"],
                               ["imageName": "tabbar_compose_music_neo", "title": "音乐"],
                               ["imageName": "tabbar_compose_shopping_neo", "title": "商品"],
                               ["imageName": "tabbar_compose_miaopai_neo", "title": "秒拍"]
        ]

    
    
    
    /// 通过XIB加载视图
    class func load_composeTypeView() -> ComposeTypeView {
        
        // 从XIB加载完成后, 就会调用 awakeFromNib
        let nib = UINib(nibName: "ComposeTypeView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! ComposeTypeView
        view.configUI()
        return view
    }

    /// 显示当前视图
    func show(){

        // 0>. 旋转关闭按钮
        rotateCloseBtn(close: closeBtn)
        
        // 1>. 将当前视图 添加到 根视图控制器 的View中
        // 获取根视图控制器
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        // 2>. 添加视图
        vc.view.addSubview(self)
        
        // 3>. 开始动画
        showCurrentView()
        
    }

    
    /// 按钮点击事件
    func btnclicked() {
        
        print("点击了......")
    }
    
    /// 关闭按钮
    @IBAction func close() {
       // removeFromSuperview() // 关闭视图
        
        // 旋转关闭按钮
        rotateCloseBtn(close: closeBtn)

        /// 隐藏按钮动画
        hideButtons()
    }
 
}


// MARK: - 动画方法扩展
extension ComposeTypeView {
    
    // MARK: - 消除动画
    /// 隐藏按钮动画
    fileprivate func hideButtons() {

        // 1.根据滚动视图的contentOffset,判断当前是显示的子视图
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let vi = scrollView.subviews[pageIndex]
        
        // 2. 倒序 遍历view中的全部按钮
        for (i, button) in vi.subviews.enumerated().reversed() {
            
            // 1>.创建动画  kPOPLayerPositionY: 上\下动画
            let animation: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            // 2>.设置动画相关的属性
            // fromValue: 动画当前值
            // toValue: 动画目标值
            
            animation.fromValue = button.center.y
            animation.toValue = button.center.y + 400
            
            // 设置动画时长
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(vi.subviews.count - i) * 0.025
            
            // 3>.添加动画
            button.layer.pop_add(animation, forKey: nil)
            
            // 4>.监听最后一个执行的按钮, 也就是第0个按钮
            if i == 0 {
                animation.completionBlock = { _, _ in
                     self.hideCurrentView()      // 隐藏当前视图
                }
                
            }
            
        }
    
    
    }
    
    /// 隐藏当前视图
    private func hideCurrentView() {
        
        // 1> 创建基本动画, 通过kPOPViewAlpha创建UIview动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        // 改变视图的透明度: 1 ~ 0
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25     // 动画时长
        
        // 2> 添加到视图
        pop_add(anim, forKey: nil)
        
        // 3> 添加完成监听方法
        anim.completionBlock = { _, _ in
            self.removeFromSuperview()      // 关闭视图
        }

    }
    
    // MARK: - 显示部分动画
    /// 动画显示当前视图
    fileprivate func showCurrentView() {
      
        // 1.创建动画, 通过kPOPViewAlpha创建UIview动画
        let anima: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        /// 设置动画相关属性
        // fromValue: 动画当前值
        // toValue: 动画目标值
        anima.fromValue = 0          // 改变视图的透明度: 0 ~ 1
        anima.toValue = 1
        anima.duration = 0.25        // 动画时长
        
        // 2.添加到视图
        pop_add(anima, forKey: nil)
        
        // 3.添加按钮的动画
        showButtons()
        
    }
    
    // MARK: - 旋转关闭按钮
    /// 旋转关闭按钮
    @objc fileprivate func rotateCloseBtn(close: UIButton) {
        
        if close.isSelected {           // 默认: FALSE
            
            // MARK: 逆时针 旋转45度 -- 还原
            UIView.animate(withDuration: 0.25, animations: {
                close.transform = CGAffineTransform.identity
                print("-------逆时针\(close.isSelected)")
            })
            
        } else {
            // MARK: 顺时针 旋转45度
            UIView.animate(withDuration: 0.25) {
                close.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
                print("-------顺时针\(close.isSelected)")
            }
        }
       
        // 记录按钮的最新状态
        close.isSelected = !close.isSelected
    
    }
    
    /// 带弹动效果, 显示所有按钮
    fileprivate func showButtons() {
        
        // 1>.获取scrollView的子视图的第0个根视图
        let vi = scrollView.subviews[0]
        
        // 2>.遍历 vi视图中所有的按钮
        
        for (i, btn) in vi.subviews.enumerated() {
            
            // MARK: - POP动画 - 具体实现
            
            // 1>.创建动画  kPOPLayerPositionY: 上\下动画
            let animation: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            // 2>.设置动画属性
            animation.fromValue = btn.center.y + 400    // 按钮往下
            animation.toValue = btn.center.y            // 按钮往上
            
            // 设置弹力系数
            // 默认值: 4 取值范围 0 ~ 20, 数值越大,弹性越大.
            animation.springBounciness = 8
            
            // 设置弹力速度, 默认值: 12, 取值范围: 0~20, 数值越大,速度越快
            animation.springSpeed = 8
            
            // 设置按钮动画的启动时间
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            // 3>.添加动画
            btn.pop_add(animation, forKey: nil)
        }
        
    }
    
    
}


// private: 表示 extension中所有的方法都是私有的
private extension ComposeTypeView {
    
    // MARK: 设置UI界面
    func configUI() {
        
        // 0. 强行更新布局, 拿到视图frame
        //layoutIfNeeded()
        
        // 1. 向 scrollView 添加视图
        let rect = scrollView.bounds
        let width = scrollView.bounds.width
        
        for i in 0..<2 { // 创建2个视图,用来存放按钮并添加到scrollView上
            
            // frame的X: 偏移 2 个视图的宽度
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            
            // 2. 添加按钮到视图上
            addButtons(view: v, index: i * 8)
            
            // 3. 将视图添加到 scrollView中
            scrollView.addSubview(v)
        }
        
        // 4. 设置 scrollView 相关属性
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        //scrollView.isScrollEnabled = false          // 禁用滚动
        
        // 创建手势
        let top = UITapGestureRecognizer(target: self, action: #selector(BtnSuperViewGesture))
        
        // 给scrollView的 父视图添加手势
        scrollView.superview?.addGestureRecognizer(top)
        
    }
    
    // MARK: - 关闭按钮父视图 手势点击时间
    @objc private func BtnSuperViewGesture() {
        
        // 旋转关闭按钮
        rotateCloseBtn(close: closeBtn)
        
        /// 隐藏按钮动画
        hideButtons()
    }
    
    /// 给视图添加按钮, 按钮的数组的索引从 index 开始
    func addButtons(view: UIView , index: Int) {
        
        // 1. 从index开始, 添加8个按钮
        let count = 8
        
        for i in index ..< (index + count) {
        
            // 如果i大于按钮数组的个数, 就跳出循环体
            if i >= buttonsInfo.count { break }
            
            // 0>. 从数组字典中获取图片名称\标题
            let dict = buttonsInfo[i]
            
            // 如何没有找到对应字典, 继续执行循环体
            guard let imageName = dict["imageName"], let title = dict["title"] else { continue }
            
            // 1>. 创建撰写按钮
            let btn = ComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            btn.addTarget(self, action: #selector(btnclicked), for: .touchUpInside)
            
            // 2>. 添加按钮到视图中
            view.addSubview(btn)
            
        }
        // 2. 遍历视图的子视图，布局按钮
        // 准备常量
        let btnSize = CGSize(width: 90, height: 90)
        
        // margin:按钮之间的间距 =  视图的宽度 - 4个按钮的宽度 / 5
        let margin = (view.bounds.width - 4 * btnSize.width) / 5
        
        for (i, btn) in view.subviews.enumerated() {
            
            // 如果按钮下标大于 3 , 就换行
            let y: CGFloat = (i > 3) ? (view.bounds.height - btnSize.height) : 0
            
            let column = i % 4       // 列: 每行4个按钮
            
            let x = CGFloat(column + 1) * margin + CGFloat(column) * btnSize.width
            
            // 设置按钮的frame
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }

        
    }
    
}


// MARK: - 遵守 UIScrollViewDelegate 协议
extension ComposeTypeView: UIScrollViewDelegate {
    
    // MARK: 随着用户的滚动，改变pageControl的显示
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 获取滚动的偏移量
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 计算 pageControl 的 currentIndex
        pageControl.currentPage = Int(offset / scrollView.bounds.width) % 2
    }
}




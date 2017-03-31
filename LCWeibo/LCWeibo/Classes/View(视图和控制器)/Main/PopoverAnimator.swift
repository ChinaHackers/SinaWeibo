//
//  PopoverAnimator.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/9.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    
    // MARK:- 对外提供的属性
    // CGRect.zero: 是一个高度和宽度为零、位于(0，0)的矩形常量
    var presented_Frame : CGRect = CGRect.zero
    
    /// 是否弹出
    var isPresented : Bool = false
    
    
    var callBack : ((_ presented : Bool) -> ())?
    
    // MARK:- 自定义构造函数
    // 注意:如果自定义了一个构造函数,但是没有对默认构造函数init()进行重写,那么自定义的构造函数会覆盖默认的init()构造函数
    init(callBack : @escaping (_ presented : Bool) -> ()) {
        self.callBack = callBack
    }

    
}

// MARK: - 遵守 UIViewControllerTransitioningDelegate 自定义转场动画的代理协议
extension PopoverAnimator: UIViewControllerTransitioningDelegate {
    
    // MARK: 设置代理方法. 告知谁来负责转场动画
    // UIPresentationController: iOS8推出的, 专门用于负责转场动画
    // 目的: 改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentation = PopoverPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presented_Frame
        return presentation
        
    }
    
    
    
    /// 这是一个结构体。
    ///
    /// 它什么都没干……
    /// - important: 这很重要！
    /// - warning: 警告！
    /// - attention: 注意！
    /// - note: 另外……没什么好说的了……
    /// - version: 1.0
    /// - author: Zenny Chen”
    
    
    
    
    
    
    /// - attention: 只要实现了一下方法, 那么系统自带的默认动画就没有了, "所有"东西都需要程序员自己来实现
    // MARK: 告诉系统谁来负责Modal的展现动画
    /*
     - presented : 被展现的视图
     - presenting: 发起的视图
     - source    : 谁来负责
     */
    
    // 目的: 自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true
        
        callBack!(isPresented)
        
        return self
    }
    
  
    
    
    // MARK: 告诉系统谁来负责Modal的消失动画
    
    /*
     - dismissed : 被关闭的视图
     - returns   : 谁来负责
     */
    
    // 目的:自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = false
        
        callBack!(isPresented)
        
        return self
    }
    
    
    
}


// MARK:- 弹出和消失动画代理的方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning {
    
    //UIViewControllerAnimatedTransitioning:  必须实现2个方法 transitionDuration \ animateTransition
    
    ///指定转场动画持续的时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 转场动画的具体内容
    // 告诉系统如何动画, 无论是展现还是消失都会调用这个方法
    // transitionContext: 获取`转场的上下文`:可以通过转场上下文获取弹出的View和消失的View
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissedView(transitionContext)
        
    }
    
    
    // UITransitionContextFromViewKey : 获取消失的View
    // UITransitionContextToViewKey   : 获取弹出的View
    /// 自定义弹出动画
    fileprivate func animationForPresentedView(_ transitionContext: UIViewControllerContextTransitioning) {
        
        print(" 自定义弹出动画")
        
        
        // 1.获取弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // 2.将弹出的View添加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        
        // 3.执行动画
        presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        
        // 锚点在中间
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            // 清空动画
            presentedView.transform = CGAffineTransform.identity
            
        }) { (_) in
            
            // 必须告诉转场上下文, 已经完成动画
            transitionContext.completeTransition(true)
            
        }
    }
    
    
    /// 自定义消失动画
    fileprivate func animationForDismissedView(_ transitionContext: UIViewControllerContextTransitioning) {
        
        print(" 自定义消失动画")
        
        // 1.获取消失的View
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        // 2.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
            
        }) { (_) -> Void in
            
            dismissView?.removeFromSuperview()
            
            // 必须告诉转场上下文, 已经完成动画
            transitionContext.completeTransition(true)
       
        }
    
    }
}


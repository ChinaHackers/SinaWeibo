//
//  WelcomeView.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/9.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import Kingfisher

class WelcomeView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    
    
    /// 提供一个类函数, 加载WelcomeView
    class func welcomeView() -> WelcomeView {
        
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WelcomeView
        
        // 从 XIB 加载的视图，默认是 600 * 600 的
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    
    
    /// 从 XIB 加载完成调用
    override func awakeFromNib() {
        
        //设置头像
//        let profileURLString = UserAccountViewModel.shareIntance.account?.avatar_large
        // 1. url
//        guard let urlString = WBNetworkManager.shared.userAccount.avatar_large,
//            let url = URL(string: urlString) else {
//                return
//        }
        
        
    }
    
    
    
}



 /*
 
 
        // ?? : 如果??前面的可选类型有值,那么将前面的可选类型进行解包并且赋值
        // 如果??前面的可选类型为nil,那么直接使用??后面的值
        
//        let url = NSURL(string: profileURLString ?? "")
        
//        iconView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default_big"))
        
//        iconView.kf_setImage(with: url, placeholder: UIImage(named: "avatar_default_big"))
        
        // 1.改变约束的值
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 200
        
        // 2.执行动画
        // Damping : 阻力系数,阻力系数越大,弹动的效果越不明显 0~1
        // initialSpringVelocity : 初始化速度
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { () -> Void in
           
            self.view.layoutIfNeeded()
        
        }) { (_) -> Void in
            
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
*/

//
//  VisitorView.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/5.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import SnapKit


// MARK: - 游客视图
class VisitorView: UIView {

    
    
    var attention_Btn: UIButton!
    
    
    // MARK: - 懒加载控件
    /// 旋转视图
    fileprivate lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
    }()
    
    /// 遮罩蒙版视图
    fileprivate lazy var maskIconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return iv
    }()
    
    /// 小房子
    fileprivate lazy var houseIconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return iv
    }()
    
    
    /// 消息文字
    fileprivate lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "关注一些人，回这里看看有什么惊喜"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        return label
    }()
    
    /// 注册按钮
    fileprivate lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", for: .normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        btn.setTitleColor(UIColor.orange, for: .normal)
        return btn
    }()
    
    /// 登录按钮
    fileprivate lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        btn.setTitleColor(UIColor.orange, for: .normal)
        return btn
    }()
    
    
    /// 关注按钮
    fileprivate lazy var attentionBtn: UIButton =  {
        let btn = UIButton()
        btn.setTitle("去关注", for: .normal)
        btn.setBackgroundImage(UIImage(named: "common_button_alpha"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "common_button_alpha_highlighted"), for: .highlighted)
        btn.setTitleColor(UIColor.orange, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    
    // MARK: - 自定义方法(公开)
    
    /**
     判断是否是首页界面，然后设置相应的图片
     
     - parameter isHome:    是否是首页
     - parameter imageName: 相应图片
     - parameter message:   相应文字
     */
    func setupVisitorView(isHome: Bool, imageName: String, message: String) {
        
        // 如果不是首页, 就隐藏转盘
        iconView.isHidden = !isHome
        
        // 修改中间的图标\文字
        houseIconView.image = UIImage(named: imageName)
        messageLabel.text = message
        
        // 判断是否需要执行动画
        if isHome {
            startAnimation()
        }
    }
    
    
    // MARK: - 自定义构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        
    }
    
    // 必须重写这个方法, Swift推荐我们要么支持纯代码, 要么支持XIB
    // 这样可以简化代码的复杂度
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



// MARK: - 配置UI界面
extension VisitorView {
    
    /// 配置UI界面
    fileprivate func configUI(){
        
        
        attention_Btn = attentionBtn
        
        //  添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(messageLabel)
        addSubview(attentionBtn)
        //addSubview(registerButton)
        //addSubview(loginButton)
        
        // 自动布局
        Automatic_Layout()
    }
    
    // MARK: 自动布局
    private func Automatic_Layout() {
        
        /*
         * SnapKit的使用方法:
         * 通过 snp.makeConstraints 方法给view添加约束
         * 修正: 位移修正（inset、offset）和 倍率修正（multipliedBy）
         *
         * 语法:
         * .equalTo：等于
         * .lessThanOrEqualTo：小于等于
         * .greaterThanOrEqualTo：大于等于
         
         */
        
        
        //MARK: 使用SnipKit自动布局
        
        // 旋转视图
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            
            // 旋转视图的中心Y轴, 等于父视图的中心Y轴, 往上偏移100
            make.centerY.equalToSuperview().offset(-100.0)
        }
        
        // 遮罩蒙版视图
        maskIconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.bottom.equalTo(iconView)
        }
        
        // 小房子图片
        houseIconView.snp.makeConstraints { (make) in
            make.center.equalTo(iconView)
        }
        
        // 消息文字
        messageLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom)
            make.width.equalTo(200)
            
        }
        
        
        // 关注按钮
        attentionBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(messageLabel.snp.bottom).offset(32.0)
            make.width.equalTo(120.0)
            make.height.equalTo(32.0)
        }
        
        /*
         // 注册按钮
         registerButton.snp.makeConstraints { (make) in
         
         make.width.equalTo(73)
         make.height.equalTo(32)
         // 左对齐
         make.left.equalTo(messageLabel.snp.left)
         
         // 顶部到底部的间距
         make.top.equalTo(iconView.snp.bottom).offset(132.0)
         
         // 顶部对齐
         make.top.equalTo(loginButton.snp.top)
         
         }
         
         
         // 登录按钮
         loginButton.snp.makeConstraints { (make) in
         
         make.width.equalTo(73)
         make.height.equalTo(32)
         // 右对对齐
         make.right.equalTo(messageLabel.snp.right)
         
         // 顶部对齐
         make.top.equalTo(registerButton.snp.top)
         
         }
         
         */
        
    }
    
    // MARK: 开始动画
    fileprivate func startAnimation() {
        
        // 创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        // 设置动画属性
        animation.toValue = 2 * M_PI        // 结束位置. 360度旋转
        animation.duration = 20             // 旋转360度的时长
        animation.repeatCount = MAXFLOAT    // 动画无限循环
        
        // 该属性默认为true, 代表动画只要执行完毕就移除
        animation.isRemovedOnCompletion = false
        
        // 将动画添加到图层上
        iconView.layer.add(animation, forKey: nil)
    }
    
    
}

// MARK: - 提供一个通过 Xib 快速创建的类方法
extension VisitorView {
    
    class func load_VisitorView() -> VisitorView {
         return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }

}


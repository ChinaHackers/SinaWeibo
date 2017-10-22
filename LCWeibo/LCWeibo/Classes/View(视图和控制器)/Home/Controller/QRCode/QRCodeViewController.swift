//
//  QRCodeViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/3/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import AVFoundation


// MARK: - 二维码
class QRCodeViewController: UIViewController {

    // MARK: - 控件属性
    
    /// 冲击波视图顶部约束
    @IBOutlet weak var scanLineTopConstranit: NSLayoutConstraint!
    
    /// 容器视图高度约束
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    
    /// 自定义TabBar
    @IBOutlet weak var CustomTabBar: UITabBar!
    
    /// 记录seesion
    var seesion: AVCaptureSession?


    
    
    // MARK: - 关闭按钮点击事件
    @IBAction func closeBtn(_ sender: UIBarButtonItem) {
        
        // 消失视图
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()

    }
    /// 视图即将 可见 时,加载
    ///
    /// - Parameter animated: 是否动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scanAnimation()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// 视图即将 消失 时,加载
    ///
    /// - Parameter animated: 是否动画
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        timer.invalidate()  // 移除定时器
    }

    
    
    /// 冲击波动画 (即: 改变冲击波的顶部约束 - 增大)
    fileprivate func scanAnimation() {
        
        // 设置动画初始约束 (让约束从顶部开始)
        self.scanLineTopConstranit.constant = -self.containerHeightConstraint.constant
        
        // 强制更新视图布局
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 3.0) {
            // 1.修改约束
            self.scanLineTopConstranit.constant = self.containerHeightConstraint.constant
            
            // 1.1设置动画重复次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            // 2.强制更新视图布局
            self.view.layoutIfNeeded()
        }
        
        startScan()
    }
    
    /// 开始扫描
    private func startScan() {
        
        // 1. 开始输入
        // 1.1 获取摄像头设备
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else { return }
        
        // 1.2 把摄像头设备当作输入设备
        var input: AVCaptureDeviceInput?
        
        do {
            //创建输入流
            input = try AVCaptureDeviceInput(device: device)
        } catch  {
            print(error)
            return
        }
        
        
        // 2.设置输出
        let outPut = AVCaptureMetadataOutput()
        
        // 2.1 设置结果处理代理
        outPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 3.创建会话, 链接输入和输出
        seesion = AVCaptureSession()
        // 如果能添加输入\输出, 然后才添加
        if seesion!.canAddInput(input) && seesion!.canAddOutput(outPut) {
            seesion!.addInput(input)
            seesion!.addOutput(outPut)
        }else {
            return
        }
        
        // 3.1 设置二维码可以识别的码制
        /* 注意: 设置识别的类型, 必须要在输出添加到会话之后, 才可以设置, 否则,程序崩溃!  */
        // 相等
        // outPut.availableMetadataObjectTypes
        // AVMetadataObjectTypeQRCode
        outPut.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        
        // 3.2 添加视频预览图层 (让用户可以看见界面) * 不是必须添加的 *
        let previewLayer = AVCaptureVideoPreviewLayer(session: seesion)
        
        //设置预览图层的填充方式
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //设置预览图层的frame
        previewLayer?.frame = view.layer.bounds
        
        //将预览图层添加到预览视图上
        view.layer.insertSublayer(previewLayer!, at: 0)
        
        
        // 4.启动会话 (让输入开始采集数据, 输出对象, 开始处理数据)
        seesion!.startRunning()
    }

    
}

// MARK: - 配置UI
extension QRCodeViewController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        // 默认选择第0个
        CustomTabBar.selectedItem = CustomTabBar.items![0]
        CustomTabBar.delegate = self
    }
    
    
    
}

// MARK: - UITabBarDelegate
extension QRCodeViewController: UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // 1.修改容器的高度
        if item.tag == 1 {
            print("二维码")
            self.containerHeightConstraint.constant = 300
        }else {
            print("条形码")
            self.containerHeightConstraint.constant = 150
        }
        // 2.停止动画
        self.scanLineView.layer.removeAllAnimations()
        
        // 3.重新开始动画
        scanAnimation()
    }
}


// MARK: - AVCaptureMetadataOutputObjectsDelegate 协议
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    // 扫描到结果之后,调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        print("扫描到结果.......")
    }
    
    
    
}


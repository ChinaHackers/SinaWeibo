//
//  WBComposeViewController.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/12/30.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 撰写微博控制器
class WBComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(close))
        
        
    }
    
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

}

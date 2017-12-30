//
//  WBCommon.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/12/30.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation

// 微博公开信息
// MARK: - 应用程序信息

/// 应用程序 ID
let AppKey: String = "1649214170"

/// 应用程序加密信息(开发者可以申请修改)
let AppSecret: String = "e1a8c149d140eda21ccec829de19521b"

/// 回调地址 - 登录完成调转的 URL，参数以 get 形式拼接
let WBRedirectURI = "http://baidu.com"


// MARK: - 全局通知定义
/// 用户需要登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
/// 用户登录成功通知
let WBUserLoginSuccessedNotification = "WBUserLoginSuccessedNotification"

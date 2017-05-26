## Swift项目-仿新浪微博

![](https://camo.githubusercontent.com/f3bc68f8badf9ec1143275e35cba2114910b0522/687474703a2f2f696d672e736869656c64732e696f2f62616467652f6c616e67756167652d73776966742d627269676874677265656e2e7376673f7374796c653d666c6174)[![Swift compatible](https://img.shields.io/badge/swift-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift/)[![Swift &3.0.2](https://img.shields.io/badge/Swift-3.0.2-orange.svg?style=flat)](https://developer.apple.com/swift/)![](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)![](https://img.shields.io/badge/platform-ios-lightgrey.svg)![](https://img.shields.io/github/watchers/badges/shields.svg?style=social&label=Watch)[![Twitter Follow](https://img.shields.io/twitter/follow/LiuChuan_.svg?style=social)](https://twitter.com/LiuChuan_)


### 效果:

![](https://ww4.sinaimg.cn/large/006tNbRwgy1fe6gst2624g30b00jeu11.gif)


## 说明
数据接口来源: 通过 Charles 抓包获得.

## 环境设置
- 项目环境
	- Xcode 8.2.1（低于这个版本会报错）。
	- Swift 3.0.2
	- iOS 10.0 +
- 使用 cocoaPods 管理第三方库
- 项目中使用的第三方库
	- SnapKit: 布局
	- Kingfisher: 缓存图片
	- SVProgressHUD:提示框 (待集成)
	- AFNetworking:网络请求 
	- SwiftyJSON: 解析 json数据
	- Pop : 核心动画	


# 实现的功能


0. 启动界面的简单实现动画谈出
1. 完成首页的布局和数据的显示
2. 实现首页顶部标题栏(TitleView)伸展动画
3. 用 URL 拼接 token 字符串访问用户微博数
4. 使用一个函数封装 AFN 的 GET&POST 请求
5. 创建网络工具单例
6. 撰写微博类型选择视图, POP动画
7. 自定义刷新框架

###待完善```

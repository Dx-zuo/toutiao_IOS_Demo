//
//  Con.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
//

import Foundation
import UIKit
/// 测试数据
struct Test {
    
    /// 标题测试数据
    static let titleData : [HomePageTitleModel] = [
        HomePageTitleModel(category: "news_hot", name: "热点", web_url: "", concern_id: ""),
        HomePageTitleModel(category: "news_hot", name: "实时", web_url: "", concern_id: ""),
        HomePageTitleModel(category: "news_hot", name: "画画", web_url: "", concern_id: "")
    ]
    
}
struct Con {

    static let screenWidth = UIScreen.main.bounds.size.width   // 屏幕的宽
    static let screenHeight = UIScreen.main.bounds.size.height // 屏幕的高
    static let statusHeight: CGFloat = 20                   // 状态栏的高度
    static let navigationHeight: CGFloat = 44               // 导航栏的高度
    static let tabBarHeight: CGFloat = 49                   // 标签栏的高度
    static let scrollLineHeight: CGFloat = 2                // 底部滚动滑块的高度
    static let titleViewHeight: CGFloat = 44                // 标题滚动视图的高度
    static let darkGreen = UIColor.red       //全局颜色:红
}

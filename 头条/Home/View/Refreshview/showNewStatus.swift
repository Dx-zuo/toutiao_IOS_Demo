//
//  showNewStatusCount.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/23.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation

// MARK: - 控件的类型
enum RefreshViewType{
    case
    RefreshHeaderView,    // 头部控件
    RefreshFooterView      // 尾部控件
}

// MARK: - 刷新视图的状态. 枚举
// MARK: - ** Header 刷新状态 **
enum Refresh_HeaderStatus {
    case
    /// 默认状态
    normal,
    /// 等待刷新
    waitRefresh,
    /// 正在刷新
    refreshing,
    endRefresh
}
// MARK: - ** Footer 刷新状态 **
enum Refresh_FooterStatus {
    case
    normal,
    waitLoad,
    loading,
    loadover            // 加载完毕
}

// MARK: - ** 当前刷新对象 **
enum Refresh_Object {
    case none,          // 无
    header,
    footer
}

//
//  Date.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation

extension Date {
    /// 判断某个时间是否为今年
    func isThisYear() -> Bool {
        let calender = Calendar.current
        // 获得某个时间的年
        let yearComps = calender.component(Calendar.Component.year, from: self)
        let nowComps = calender.component(Calendar.Component.year, from: Date())
        return yearComps == nowComps
    }
    
    /// 判断是否为昨天
    func isYesterday() -> Bool {
        var now = Date()
        //格式: 2017-06-15 21:46:00
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        //取得时间字符串
        let dateStr = fmt.string(from: self)
        //取得现在时间
        let nowStr = fmt.string(from: now)
        //取得的时间
        let date = fmt.date(from: dateStr)
        //现在时间
        now = fmt.date(from: nowStr)!
        let calender = Calendar.current
        let comps = calender.dateComponents([.year, .month, .day], from: date!, to: now)
        return comps.year == 0 && comps.month == 0 && comps.day == 1;
    }
    
    /// 判断是否为今天
    func isToday() -> Bool {
        let now = Date()
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let dateStr = fmt.string(from: self)
        let nowStr = fmt.string(from: now)
        return dateStr == nowStr
    }
}

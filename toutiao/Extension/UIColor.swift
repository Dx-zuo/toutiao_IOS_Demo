//
//  UIColor.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIColor
extension UIColor {
    /// 便利初始化方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// RGBA颜色
    func myColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
}

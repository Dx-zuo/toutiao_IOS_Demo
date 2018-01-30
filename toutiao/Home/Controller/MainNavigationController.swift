//
//  MainNavigationController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/29.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

/// 全局导航视图控制器
class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - 设置UI界面
extension MainNavigationController {
    func setupUI() {
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.white
        navBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17)]
    }
}

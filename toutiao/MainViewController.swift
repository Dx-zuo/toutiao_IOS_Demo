//
//  ViewController.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController,UITabBarControllerDelegate {
    let homeVC = HomeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
// MARK: - 设置UI界面
extension MainViewController{
    //设置ui
    func setupUI() {
        //添加view
        addChildViewController(homeVC, title: "首页", imageName: #imageLiteral(resourceName: "home_tabbar_32x32_"), selectedImage: #imageLiteral(resourceName: "home_tabbar_press_32x32_"))
    }
    
    /// 添加tabbar子视图
    ///
    /// - Parameters:
    ///   - childController: 子视图对象
    ///   - title: 视图标题
    ///   - imageName: 视图图片
    ///   - selectedImage: 选中视图图片
    private func addChildViewController(_ childController: UIViewController,title: String,
        imageName: UIImage, selectedImage: UIImage) {
        childController.tabBarItem.image = imageName
        childController.tabBarItem.selectedImage = selectedImage
        childController.title = title
        let navC = MainNavigationController(rootViewController: childController)
        navC.navigationItem.title = title
        addChildViewController(navC)

    }
}

//
//  ViewController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController,UITabBarControllerDelegate {
    private let NewsVC = HomeNewsTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddHomeUI()
    }
    func AddHomeUI() {
        addChildViewController(HomeNewsTableViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImage: "home_tabbar_press_32x32_")
    }
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImage: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named:selectedImage)
        childController.title = title
        let navC = MainNavigationController(rootViewController: childController)
        navC.navigationItem.title = title
        addChildViewController(navC)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


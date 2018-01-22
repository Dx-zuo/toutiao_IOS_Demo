//
//  ViewController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController,UITabBarControllerDelegate {
    private let NewsVC = HomeNewsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddHomeUI()
    }
    func AddHomeUI() {
        addChildViewController(HomeNewsViewController(), title: "首页", imageName: #imageLiteral(resourceName: "home_tabbar_night_32x32_"), selectedImage: #imageLiteral(resourceName: "home_tabbar_night_32x32_"))
    }
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: UIImage, selectedImage: UIImage) {
        childController.tabBarItem.image = imageName
        childController.tabBarItem.selectedImage = selectedImage
        childController.title = title
        let navC = MainNavigationController(rootViewController: childController)
        navC.navigationItem.title = title
        addChildViewController(navC)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


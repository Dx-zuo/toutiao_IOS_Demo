//
//  MainNavigationController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.white
        navBar.tintColor = UIColor(r: 0.0, g: 0.0, b: 0.0)

        navBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

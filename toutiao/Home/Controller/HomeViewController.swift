//
//  HomeViewController.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
//

import UIKit

/// 首页视图控制器
class HomeViewController: UIViewController {
    //搜索栏
    fileprivate lazy var searchFiled: SearchBar = {
        let searchfiled = SearchBar()
        searchfiled.searchFiled.delegate = self
        return searchfiled
    }()
    
    //导航栏*/
    fileprivate lazy var titleView: TitleView = {
        //frame: CGRect(x: 0.0, y: 64, width: Con.screenWidth, height: Con.screenWidth-64)
        let titleview = TitleView(frame: CGRect(x: 0.0, y: 64.0, width: Con.screenWidth, height: 44.0))
        //let titleview = TitleView()
        titleview.backgroundColor = UIColor.white
        titleview.delegate = self
        return titleview
    }()
    
    //新闻列表
    fileprivate lazy var contentView: ContentView = {
        let contentH = Con.screenHeight - 44.0 - 64.0
        let contentFrame = CGRect(x: 0, y: 44.0 + 64.0, width: Con.screenWidth, height: contentH)
        var childVcs = [UIViewController]()
        for _ in 0 ..< 3 {
            let vc = UIViewController()
            // 设置随机色
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), alpha: 1.0)
            childVcs.append(vc)
        }
        let contentView = ContentView(frame: contentFrame, childVCs: childVcs, parentViewController: self)
        contentView.delegate = self
        contentView.Nodedelegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.red
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - 设置UI界面
extension HomeViewController {
    func setupUI() {
        //搜索
        navigationController?.navigationBar.barStyle = .default
        navigationItem.titleView = searchFiled
        navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "user"), style: UIBarButtonItemStyle.done, target: nil, action: nil), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "user"), style: UIBarButtonItemStyle.plain, target: nil, action: nil), animated: true)
        //导航
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        view.addSubview(titleView)
        view.addSubview(contentView)
    }
    
}

// MARK: - TitleViewDelegate
extension HomeViewController : TitleViewDelegate {
    func titleView(_ titleView: TitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
    
}

// MARK: - ContentViewDelegate
extension HomeViewController : ContentViewDelegate{
    func contentView(_ contentView: ContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

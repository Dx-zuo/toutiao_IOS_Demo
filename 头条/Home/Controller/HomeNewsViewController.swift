//
//  HomeNewsTableViewController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

enum NewsCellType {
    case Txt
    case Image
    case Video
    case User
}

class HomeNewsViewController:  UIViewController{


    let Refresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    func setupUI() {
        //搜索
        navigationController?.navigationBar.barStyle = .default
        navigationItem.titleView = searchFiled
        navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "user"), style: UIBarButtonItemStyle.done, target: nil, action: nil), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "user"), style: UIBarButtonItemStyle.plain, target: nil, action: nil), animated: true)
        //导航
        view.addSubview(titleview)
        view.addSubview(contentView)
//        titleview.snp.makeConstraints { (make) in
//            make.right.left.bottom.equalToSuperview()
//            make.height.equalTo(44)
//        }
        //self.view.addSubview(titleview)
        //cell注册

    }
    //搜索栏
    fileprivate lazy var searchFiled: HomeSearchBar = {
        let searchfiled = HomeSearchBar()
        searchfiled.searchFiled.delegate = self
        return searchfiled
    }()

    //导航栏*/
    fileprivate lazy var titleview: TitleView = {
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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.red

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}
extension HomeNewsViewController : TitleViewDelegate {
    func titleView(_ titleView: TitleView, selectedIndex index: Int) {
        //print(index)
        contentView.setCurrentIndex(index)
    }
    
}
extension HomeNewsViewController : ContentViewDelegate{
    func contentView(_ contentView: ContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //print(progress,sourceIndex,targetIndex)
        titleview.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
extension HomeNewsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //navigationController?.pushViewController(HomeSearchViewController(), animated: false)
        return true
    }
}

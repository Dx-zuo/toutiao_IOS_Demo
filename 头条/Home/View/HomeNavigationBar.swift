//
//  HomeNavigationBar.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class HomeNavigationBar: UIView {
    // 今日头条图片
    lazy var leftImageView: UIImageView = {
        let toutiaoImageView = UIImageView(image: #imageLiteral(resourceName: "user"))
        toutiaoImageView.contentMode = .scaleAspectFill
        return toutiaoImageView
    }()
    //
    lazy var rightImageView: UIImageView = {
        let toutiaoImageView = UIImageView(image: #imageLiteral(resourceName: "相机"))
        toutiaoImageView.contentMode = .scaleAspectFill
        return toutiaoImageView
    }()
    /// 搜索框
    lazy var searchBar: HomeSearchBar = {
        let searchBar = HomeSearchBar.searchBar()
        searchBar.searchFiled.placeholder = "胡歌 刘诗诗| 雾特大"
        searchBar.searchFiled.background = #imageLiteral(resourceName: "searchbox_search_20x28_")
        return searchBar
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加今日头条图片
        addSubview(leftImageView)
        // 添加搜索框
        addSubview(searchBar)
        addSubview(rightImageView)
        //searchBar.frame = CGRect(x: Con.screenWidth/2-self.bounds.width/2, y: self.bounds.height/2, width: 100, height: 33)
        /*
         ＊创建约束 NSLayoutConstraint  参数 说明：
         
         * item 自己
         
         * attribute
         
         * relatedBy 大于等于 小于等于 等于
         
         * toItem 另外一个控件
         
         * attribute 另一个控件的熟悉
         
         * multiplier 乘以多少
         
         * constant : 加上多少
         
         * NSLayoutConstraint : 某个控件的属性值 等于 另外一个控件的属性值
         
         */
//        let width : NSLayoutConstraint = NSLayoutConstraint(item: searchBar, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0.0, constant: 200)
//        searchBar.addConstraint(width)
                leftImageView.snp.makeConstraints { (make) in
                    make.left.equalTo(self).offset(10.0)
                    make.centerY.equalTo(self)
                    make.size.equalTo(CGSize(width: 20, height: 20))
                }
        
                searchBar.snp.makeConstraints { (make) in
                    make.left.equalTo(leftImageView.snp.right).offset(15.0)
                    make.right.equalTo(rightImageView.snp.left).offset(-15.0)
                    make.centerY.equalTo(self)
                    make.height.equalTo(30)
                }
                rightImageView.snp.makeConstraints { (make) in
                    make.right.equalTo(self).offset(-10.0)
                    make.centerY.equalTo(self)
                    make.size.equalTo(CGSize(width: 20, height: 20))
                }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 重写frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: Con.screenWidth, height: 44)
            super.frame = newFrame
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }

}

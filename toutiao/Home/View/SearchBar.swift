//
//  HomeSearchBar.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/29.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class SearchBar: UIView {
    
    /// 搜索文本框
    var searchFiled: UITextField = {
        let textField = UITextField()
        let searchIcon = UIImageView()
        searchIcon.image = #imageLiteral(resourceName: "searchicon_search_20x20_")
        searchIcon.height = 35
        searchIcon.width = 35
        searchIcon.contentMode = .center
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor.white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 6
        return textField
    }()
    
    //重写界面初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchFiled)
        searchFiled.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 重写frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: Con.screenWidth/2, height: 30)
            super.frame = newFrame
        }
    }
    
    /// 重写Layout
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
}

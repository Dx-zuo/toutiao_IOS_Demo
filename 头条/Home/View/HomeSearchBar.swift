//
//  HomeSearchBar.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class HomeSearchBar: UIView {

    var searchFiled: UITextField = {
        let textField = UITextField()
        let searchIcon = UIImageView()
        searchIcon.image = #imageLiteral(resourceName: "searchicon_search_20x20_")
        searchIcon.width = 35
        searchIcon.height = 35
        searchIcon.contentMode = .center
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor.white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 6
        ToRequset.GetsearchTitle(comletionHandler: { (title) in
            textField.placeholder = title
        })
        return textField
    }()
    
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
    
    class func searchBar() -> HomeSearchBar {
        return HomeSearchBar()
    }
    /// 重写frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: Con.screenWidth/2, height: 30)
            super.frame = newFrame
        }
    }
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
}

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
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchFiled)
        searchFiled.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func searchBar() -> HomeSearchBar {
        return HomeSearchBar()
    }
}

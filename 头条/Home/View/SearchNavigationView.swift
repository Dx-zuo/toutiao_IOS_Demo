//
//  SearchNavigationView.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

protocol SearchNavigationViewDelegate: class {
    func cancelButtonClicked()
}

class SearchNavigationView: UIView {
    weak var delegate: SearchNavigationViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    lazy var searchBar: HomeSearchBar = {
        let searchBar = HomeSearchBar.searchBar()
        searchBar.searchFiled.placeholder = "请输入关键字"
        searchBar.searchFiled.tintColor = UIColor.black
        searchBar.searchFiled.background = #imageLiteral(resourceName: "searchbox_search_20x28_")
        return searchBar
    }()
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", for: .normal)
        //cancelButton.setTitleColor(UIColor(r: 40, g: 141, b: 206), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        return cancelButton
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension SearchNavigationView{
    
    fileprivate func setupUI(){
        
        
    }
    @objc fileprivate func cancelButtonClick() {
        delegate?.cancelButtonClicked()
    }
}

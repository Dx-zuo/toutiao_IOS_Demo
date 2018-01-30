//
//  PageTitleModel.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
//

import Foundation

class HomePageTitleModel : NSObject {
    /// 新闻ID
    var category: String?
    
    /// 新闻频道标题
    var name: String?
    
    var webURL: String?
    
    var concernID: String?
    
    var type: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    init(category:String,name:String?,web_url:String?,concern_id:String?) {
        self.category = category
        self.name = name
        self.webURL = web_url
        self.concernID = concern_id
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
}

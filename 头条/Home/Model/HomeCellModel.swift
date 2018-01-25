//
//  HomeCellModel.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/19.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation


class PageTitleModel : NSObject {
    /*
     "category": "news_world",
     "web_url": "",
     "flags": 0,
     "name": "\u56fd\u9645",
     "tip_new": 0,
     "default_add": 1,
     "concern_id": "6215497896255556098",
     "type": 4,
     "icon_url": ""
     */
    /// 新闻ID
    var category: String?
    
    /// 新闻频道标题
    var name: String?
    
    var web_url: String?
    
    var concern_id: String?
    
    var type: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    init(category:String,name:String?,web_url:String?,concern_id:String?) {
        self.category = category
        self.name = name
        self.web_url = web_url
        self.concern_id = concern_id
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

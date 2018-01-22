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
    
    /// 通过json文件加载标题按钮
//    static func channels() -> [PageTitleModel] {
//        var arrM = [PageTitleModel]()
//        let encoder = JSONDecoder()
//        Network.request(Con.Url.titleurl).responseJSON { (response) in
//            if response.result.isSuccess ,let data = response.data{
//                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
//                let channels = json?["data"] as! [[String: AnyObject]]
//                print(channels)
//                for i in channels{
//                    let channelModel = PageTitleModel(dict: i)
//
//                }
//
//            }
//        }
//
//        /// 定义变量, 存储模型数组
//        var arrM = [PageTitleModel]()
//
//        // MARK: - try?: 弱try   如果解析成功, 就有值, 否则为nil
//
//        // 加载 json 文件
//        //let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "topic_news", ofType: "json")!))
//
//        // 加载URL
//        //let data = try? Data(contentsOf: URL(string: "https://c.m.163.com/nc/topicset/ios/subscribe/manage/listspecial.html")!)
//        Network.request("https://c.m.163.com/nc/topicset/ios/subscribe/manage/listspecial.html").responseJSON { (response) in
//            // MARK: 反序列化 解析URL
//            //let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String: AnyObject]
//            //let json = try? JSONDecoder().decode([String: AnyObject].self, from: data)
//            // 根据 tList 的 key 取出内容
//            let json = try? JSONDecoder().decode([String: AnyObject].self, from: response.result.value as! Data)
//            let channels = json?["tList"] as! [[String: AnyObject]]
//
//            print(channels)
//            // 遍历字典, 将字典转换成模型对象
//            for i in 0 ..< channels.count {
//                // 字典转模型
//                let channelModel = PageTitleModel(dict: channels[i])
//
//                // 添加到数组中
//                arrM.append(channelModel)
//            }
//
//            //对模型中的tid进行排序
//            arrM.sort(by: { (s1, s2) -> Bool in
//
//                //return s1.tid! < s2.tid!
//                //return s1.topicid! < s2.topicid!
//                return s1.cid! < s2.cid!
//            })
//        }
//        return arrM
//    }
    
    
}

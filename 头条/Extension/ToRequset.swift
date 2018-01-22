//
//  RequsetModel.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/21.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation
///请求回调
struct ToRequset {
    // MARK: 获取标题数据
    static func GetTitleList(completionHandler: ([PageTitleModel])-> [PageTitleModel]){
        Network.request(Con.Url.URL).responseJSON { (response) in
            if response.result.isSuccess, let _ = response.result.value
            {
//                let json = try? JSONDecoder().decode(PageTitleModel.self, from: value as! Data)

            }
        }
        
    }
    // MARK: 获取搜索框标题
    static func GetsearchTitle(comletionHandler: @escaping (String)->Void){
        Network.request(Con.Url.URL + "").responseJSON { (response) in
            if response.result.isSuccess , let _ = response.data{
                
                //        IXON    let json = JSON(object: data)
//                if let value = json.rawDictionary["data"]{
//                    if let title = value as? [String:String]{
//                        comletionHandler(title["homepage_search_suggest"]!)
//                    }
//                }
            }
        }
    }
    
    ///   获取首页新闻推荐列表数据

    ///
    /// - Parameters:
    ///   - category: 新闻类别
    ///   - maxBehotTime: 那个界面
    ///   - listCount: 数据数量
    ///   - completionHandler: 返回新闻列表数据
    static func GetLoadNews(category: String, listCount: Int, _ completionHandler:@escaping ([HomeNewsModel])-> Void){
        let params = ["device_id": "\(Con.Url.device_id)",
                      "count": "\(20)",
                      "list_count": "\(listCount)",
                      "category": "\(category)",
                      "strict": "\(1)",
                      "detail": "\(1)",
                      "refresh_reason": "\(1)",
                      "tt_from": "enter_auto",
                      "iid": "\(Con.Url.iid)"] as! [String: String]
        Network.request("https://lf.snssdk.com/api/news/feed/v75/", method: .get, parameters: params, headers: nil).responseJSON { (response) in
            if response.result.isSuccess , let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                var newsdatalist : [HomeNewsModel] = []
                datas.flatMap({
                    newsdatalist.append(HomeNewsModel(data: ($0["content"].string?.data(using: String.Encoding.utf8))!))
                })
                completionHandler(newsdatalist)
                //                completionHandler(datas.flatMap({
//                    NewsModel.deserialize(from: $0["content"].string)
//                }))
            }
        }
    }
}

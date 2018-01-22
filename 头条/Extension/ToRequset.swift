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
//        let params = ["device_id": "\(Con.Url.device_id)",
//                      "count": "\(20)",
//                      "list_count": "\(listCount)",
//                      "category": "\(category)",
//                      "strict": "\(1)",
//                      "detail": "\(1)",
//                      "refresh_reason": "\(1)",
//                      "tt_from": "enter_auto",
//                      "iid": "\(Con.Url.iid)"]
        let params = [
            "fp": "FrTqLrUSP2D_FlwbJlU1FlxIc2Ge",
            "version_code": "6.5.5",
            "app_name": "news_article",
            "vid": "D1413B52-DC5C-4767-8369-B6FB8A06DFB0",
            "device_id": "46983176102",
            "channel": "App Store",
            "resolution": "750*1334",
            "aid": "13",
            "ab_feature": "201615,z1",
            "ab_group": "z1,201615",
            "openudid": "1a4dbe7e7dcb9fa16db8d8838f333901869624d5",
            "idfv": "D1413B52-DC5C-4767-8369-B6FB8A06DFB0",
            "ac": "WIFI",
            "os_version": "11.2.2",
            "ssmix": "a",
            "device_platform": "iphone",
            "iid": "23709116742",
            "ab_client": "a1,f2,f7,e1",
            "device_type": "iPhone 6S",
            "idfa": "AD062258-C930-437C-891E-A5D71BC1745F",
            "refresh_reason": "1",
            "detail": "1",
            "last_refresh_sub_entrance_interval": "1516628639",
            "tt_from": "pull",
            "count": "20",
            "list_count": "32",
            "support_rn": "4",
            "LBS_status": "deny",
            "cp": "51A66f5dEbAA0q1",
            "loc_mode": "0",
            "min_behot_time": "1516628601",
            "session_refresh_idx": "3",
            "image": "1",
            "strict": "0",
            "refer": "1",
            "city": "null",
            "concern_id": "6286225228934679042",
            "language": "zh-Hans-CN",
            "st_time": "28024",
            "as": "a2059e067f396ada251155",
            "ts": "1516628639"]
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

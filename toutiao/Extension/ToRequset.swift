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
    ///   获取首页新闻推荐列表数据
    static func getLoadNews(_ completionHandler:@escaping ([NewsModel])-> Void){
        let params = [
            "app_name": "news_article",
            "vid": "D1413B52-DC5C-4767-8369-B6FB8A06DFB0",
            "device_id": "46983176102",
            "openudid": "1a4dbe7e7dcb9fa16db8d8838f333901869624d5",
            "idfv": "D1413B52-DC5C-4767-8369-B6FB8A06DFB0",
            "idfa": "AD062258-C930-437C-891E-A5D71BC1745F",
            "min_behot_time": "1516628601",
            "concern_id": "6286225228934679042",
            "ts": "1516628639"]
        Network.request("https://lf.snssdk.com/api/news/feed/v75/", method: .get, parameters: params, headers: nil).responseJSON { (response) in
            if response.result.isSuccess , let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                var newsdatalist : [NewsModel] = []
                datas.forEach({ (j) in
                    newsdatalist.append(NewsModel(json: j["content"]))
                })
                completionHandler(newsdatalist)
            }
        }
    }
}

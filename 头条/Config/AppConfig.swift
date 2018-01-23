//
//  AppConfig.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//
import UIKit
struct Test {
    static let titledata : [PageTitleModel] = [
        PageTitleModel(category: "news_hot", name: "热点", web_url: "", concern_id: ""),
        PageTitleModel(category: "news_hot", name: "实时", web_url: "", concern_id: ""),
        PageTitleModel(category: "news_hot", name: "画画", web_url: "", concern_id: "")
    ]

}

struct Con {
    struct Url {
        ///标题URL
        static let URL = "https://is.snssdk.com/"
        static let device_id: Int = 6096495334
        static let iid: Int = 5034850950
        static let defImage = "https://ww4.sinaimg.cn/large/0060lm7Tly1fnqb7n7ie2j30f007674q.jpg"
    }
    /// 屏幕的宽
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height // 屏幕的高
    static let statusHeight: CGFloat = 20                   // 状态栏的高度
    static let navigationHeight: CGFloat = 44               // 导航栏的高度
    static let tabBarHeight: CGFloat = 49                   // 标签栏的高度
    static let scrollLineHeight: CGFloat = 2                // 底部滚动滑块的高度
    static let titleViewHeight: CGFloat = 44                // 标题滚动视图的高度
    static let darkGreen = UIColor.red       //全局颜色:红
    
    static let UrlParams : [String:String] = [
        "fp": "FrTqLrUSP2D_FlwbJlU1FlxIc2Ge",
        "version_code": "6.5.5",
        "app_name": "news_article",
        "vid": "D1413B52-DC5C-4767-8369-B6FB8A06DFB0",
        "device_id": "46983176102",
        "channel": "App Store",
        "resolution": "750*1334",
        "aid": "13",
        "ab_version": "257807,259934,260541,249685,249686,258978,249669,206076,249674,259798,260607,255372,229304,232362,259501,239095,170988,257569,253541,250950,250561,243584,248081,258355,260852,257280,258440,259491,260219,240868,259060,251151,215310,202919,251798,258311,251712,229899,254101,257784,214069,31210,254676,259243,258356,247847,228168,254167,260171,249045,258716,244746,258485,249959,260345,259794,260651,259670,241181,245085,257855,260474,252766,259759,249828,246859,218093,246437",
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
        "server_city": "庆阳",
        "categories": "[\"news_hot\",\"news_local\",\"video\",\"nineteenth\",\"hotsoon_video\",\"组图\",\"question_and_answer\",\"news_tech\",\"news_finance\",\"image_ppmm\",\"news_world\",\"image_funny\",\"news_health\",\"jinritemai\",\"news_house\",\"weitoutiao\",\"news_game\"]",
        "city": "null",
        "user_modify": "0",
        "version": "46983176102|14|1516303775",
        "as": "a225ad56012aca08534416",
        "ts": "1516492961",
    ]
}

//
//  HomeNewsModel.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/21.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation


enum NewsType {
    ///普通新闻
    case News_Text
    ///三张图
    case News_three_image
    ///有视频
    case News_video
    ///右侧有图
    case News_right_image
    ///微头条
    case News_weitou
    ///置顶模式
    case Top
    ///广告
    case add
}
class HomeNewsModel: NSObject {
    //新闻类型
    var tag : String?
    //type
    var type : NewsType?
    //新闻标题
    var title : String?
    //来源
    var source : String?
    //网页地址
    var share_url : String?
    //评论数
    var comment_count : Int?
    var commentCount: String? {
        let count = comment_count
        if count == 0  {
            return "0"
        }else if count! <= 10000  {
            return "\(count!)"
        }
        return String(format: "%.1f万", Float(count!) / 10000.0)
    }
    //文章id
    var item_id : String?
    
    // image_list
    var image_list : [String] = []
    // image
    var image : String?
    //时间
    var behot_time : String?
    var Time: String? {
        //创建时间
        var createDate: Date?
        createDate = Date(timeIntervalSince1970: TimeInterval(exactly: JSON(behot_time!).intValue)!)
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //当前时间
        let now = Date()
        //日历
        let calender = Calendar.current
        let comps: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: createDate!, to: now)
        
        guard (createDate?.isThisYear())! else { // 今年
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return fmt.string(from: createDate!)
        }
        if (createDate?.isYesterday())! { // 昨天
            fmt.dateFormat = "昨天 HH:mm";
            return fmt.string(from: createDate!)
        } else if (createDate?.isToday())! {
            if comps.hour! >= 1 {
                return String(format: "%.d小时前", comps.hour!)
            } else if comps.minute! >= 1 {
                return String(format: "%d分钟前", comps.minute!)
            } else {
                return "刚刚";
            }
        } else {
            fmt.dateFormat = "MM-dd HH:mm";
            return fmt.string(from: createDate!)
        }
        
        
        return ""
    }
    //置顶
    var stick_label : String?
    //微头条 user_name
    var user_name : String?
    //微头条 转发
    var forward_count : String?
    //微头条 点赞数
    var digg_count : String?
    //微头条 user_inf
    var user_auth_info : String?
    //avatar_url
    var avatar_url : URL?
    
    //是否是图片
    var has_image: Bool?
    //是否是视频
    var has_video: Bool?
    var has_m3u8_video: Bool?
    var has_mp4_video: Bool?
    //是否是普通
    var is_stick: Bool?
    //
    var is_subject: Bool?
    
    var jsondata : JSON?
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    init(data:Data) {
        let json = JSON(data)
        jsondata = json
        self.tag = json["tag"].stringValue
        //print(json)
        // 判断新闻类型
        //print("json[is_stick]",json["is_stick"])
        if json["user"] != JSON.null && json["cell_type"] != JSON.null  {      //微头条
            if let type = json["cell_type"].int {
                if type == 32 {
                    self.type = NewsType.News_weitou
                }

            }
        }else if json["is_stick"] != JSON.null {            //置顶
            self.type = NewsType.News_Text
        }else if json["source"].string  == "悟空问答" {  //问答
            self.type = NewsType.News_right_image
        }else if json["has_image"]  != JSON.null {    //是否有图片
            if json["image_list"].count == 3 {  //三张图片
                self.type = NewsType.News_three_image
//                print("image_list", json["title"])
            }else if json["middle_image"].count == 5 {                         // 一张图片
                self.type = NewsType.News_right_image
//                print("middle_image", json["title"])
//                print(json)
//                print("json[\"image_list\"]   :" , json["image_list"].count)
//                print("json[\"middle_image\"]  :" , json["middle_image"].count)
            }else if json["image_list"].count == 5 {            ///
                self.type = NewsType.News_three_image
            }else {
                Log(message: json["image_list"].count)
                Log(message: json)

            }
        }else  if json["has_m3u8_video"] != JSON.null || json["has_mp4_video"]  != JSON.null || json["has_video"] != JSON.null {
            if json["video_detail_info"] != JSON.null && json["tag"].string == "video_military"  {
                self.type = NewsType.News_video
            }else if json["video_detail_info"] != JSON.null {                       //侧栏视频
                self.type = NewsType.News_right_image
            }else if json["show_more"]["title"].string == "更多小视频"  || json["show_more"]["title"].string == "精彩小视频"{                 //视频
                Log(message: json)
                 self.type = NewsType.News_video
            }else if json["image_list"] == JSON.null && json["middle_image"] == JSON.null  && json["cell_type"].string == "48"{ //普通cell 点击跳转网页
                self.type = NewsType.News_Text
            }else if json["middle_image"] != JSON.null {
                self.type = NewsType.News_right_image
                
            }else if json["label"].string == "广告" {
                self.type = NewsType.add
            }else{
            Log(message: json)
            }
        }else {
            Log(message: json)

        }
        
//        let is_stick = json["is_stick"]
//        let has_image = json["has_image"].boolValue
//        let is_image_list = json["image_list"].string?.isEmpty
//        let is_middle_image = json["middle_image"].string?.isEmpty
//        let is_video = json["has_m3u8_video"] == true || json["has_mp4_video"] == true || json["has_video"] == true
//        let is_user = json["user"].string?.isEmpty
//
//        if json["is_stick"].bool == true {
//            self.type = NewsType.News_Text
//        }else if json["has_image"].bool == true {  // 判断是否是图片Cell
//            print("json j: ",json["middle_image"]["url"])
//            if json["image_list"].string != nil {       //有一张图 右侧显示
//                self.type = NewsType.News_three_image
//            }else if json["middle_image"].count == 1 {
//                self.type = NewsType.News_right_image
//            } else if json["middle_image"]["url_list"].count == 3 {
//                self.type = NewsType.News_three_image
//            }else{
//                print("json[\"middle_image\"]",json)
//            }
//            //print("json[\"image_list\"].count",json["image_list"].count)
//
//        }else if json["has_m3u8_video"] == true || json["has_mp4_video"] == true || json["has_video"] == true {
//            self.type = NewsType.News_video
//        }else if json["user"].bool == true {
//            self.type = NewsType.News_Text
//        }else {
//            self.type = NewsType.News_Text
//            //print("出现了没有发现的新闻类型 ",json)
//        }
//        if self.type == nil {
//        }
//        if tag == "news_politics" {
//            self.type = NewsType.news_politics
//        }else if tag == "news_fashion"{
//            self.type = NewsType.news_fashion
//        }else if tag  == "video_movie"{
//            self.type = NewsType.video_movie
//        }else if tag == "emotion"{
//            self.type = NewsType.emotion
//        }else if tag == "nineteenth"{
//            self.type = NewsType.nineteenth
//        }else if tag == "news_story" {
//            self.type = NewsType.news_fashion
//        }else if tag == "news_baby" {
//            self.type = NewsType.news_fashion
//
//        }else if tag == "news_tech" {
//            self.type = NewsType.emotion
//
//        }else if tag == "news_photography" {
//            self.type = NewsType.news_fashion
//
//        }else if tag == "new" {
//            self.type = NewsType.news_fashion
//
//        }
//        else if tag == "" {
//            if json["user"].isEmpty {
//                self.type = NewsType.weitou
//            }
//        }
//        else {
//            print("出现了没有发现的新闻类型",tag)
//            print("tag json",json)
//        }
        //标题 由于微头条的title值为空 所以加了一个保护条件
        if json["title"] != JSON.null  {
             self.title = json["title"].stringValue
        }else{
            
            print(json)
        }
        if json["source"] != JSON.null  {
            self.source = json["source"].stringValue
        }
        if json["share_url"] != JSON.null  {
            self.share_url = json["share_url"].string
        }
        if json["comment_count"] != JSON.null {
            self.comment_count = json["comment_count"].intValue
            Log(message: json["comment_count"].intValue)
        }
        if json["item_id"] != JSON.null  {
            self.item_id = json["item_id"].stringValue
        }
        
        if json["image_list"] != JSON.null {
            let imageList = json["image_list"]
            for i in 0...imageList.count {
                if let urlstring = imageList[i]["url"].string {
                    print("urlstring : ",urlstring)
                    if urlstring.hasSuffix(".webp"){
                        let index = urlstring.index(urlstring.endIndex, offsetBy: -5)
                        image_list.append(urlstring.prefix(upTo: index).replacingOccurrences(of: "http", with: "https"))
                    }else{
                        image_list.append(urlstring as String)
                    }
                }
            }
//            for item in imageList {
//                print("list",item as! [String: AnyObject])
//            }
        }

        if json["middle_image"]["url"].string != nil  {
            self.image = json["middle_image"]["url"].stringValue.Urlformat()
        }
        if json["behot_time"].int != nil  {
            self.behot_time = json["behot_time"].stringValue
        }
        if json["stick_label"].string != nil  {
            self.stick_label = json["stick_label"].string
        }

        if json["user"].string != nil  {
            self.user_name = json["user"]["name"].string
            self.avatar_url = json["user"]["avatar_url"].url
            self.forward_count = json["forward_info"]["forward_count"].string
            self.digg_count = json["digg_count"].string
        }
    }
}
extension String {
    //格式化图片url 取消后缀 改http ~> https
    func Urlformat() -> String {
        if self.hasSuffix(".webp"){
            let index = self.index(self.endIndex, offsetBy: -5)
            return self.prefix(upTo: index).replacingOccurrences(of: "http", with: "https")
        }else{
            return self as String
        }
    }
    
}

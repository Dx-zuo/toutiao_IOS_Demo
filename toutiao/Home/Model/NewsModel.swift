//
//  NewsModel.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
//

import Foundation

enum NewsType {
    ///普通新闻
    case newsText
    ///三张图
    case newsThreeImage
    ///有视频
    case newsVideo
    ///右侧有图
    case newsRightImage
    ///微头条
    case newsWeitou
    ///置顶模式
    case newsTop
    ///广告
    case newsAdd
}

class NewsModel: NSObject {
    //新闻类型
    var tag : String?
    //type
    var newsType : NewsType?
    //新闻标题
    var title : String?
    //来源
    var source : String?
    //网页地址
    var shareURL : String?
    //评论数
    var commentCount: String?
    //文章id
    var itemID : String?
    // image_list
    var imageURLList : [String] = []
    // image
    var imageURL : String?
    //时间
    var behotTime : String?
    //微头条 user_name
    var userName : String?
    //微头条 转发
    var forwardCount : String?
    //微头条 点赞数
    var diggCount : String?
    //微头条 user_inf
    var userAuthInfo : String?
    //avatar_url
    var avatarURL : URL?
    //保存原始数据
    var jsonData : JSON?
    
    init(json : JSON) {
        super.init()
        //save  数据存储在内部 ~ 按需格式化调用~
        self.jsonData = json
        guard let data = jsonData else {return}
        //处理
        self.title  = data["title"].string
        self.tag    = data["tag"].string
        self.source = data["source"].string
        self.shareURL = data["share_url"].string
        self.commentCount = getCommentCount(json: data["comment_count"])
        self.itemID = data["item_id"].string
        self.imageURL = data["middle_image"]["url"].string
        self.behotTime = getFormatDateTime(json: data["behot_time"])
        self.userName = data["user"]["name"].string
        self.avatarURL = data["user"]["avatar_url"].url
        self.forwardCount = data["forward_info"]["forward_count"].string
        self.diggCount = data["digg_count"].string
        
        //
        self.newsType = getNewsType(json: data)
    }
}

// MARK: - 辅助方法
extension NewsModel {
    /// 计算新闻数据类型
    func getNewsType(json: JSON) -> NewsType {
        if json["user"] != JSON.null && json["cell_type"] != JSON.null {
            return NewsType.newsWeitou
        }else if json["source"].string  == "悟空问答" || json["has_image"]  != JSON.null{
            return NewsType.newsRightImage
        }else if json["label"].string == "广告" {
            return NewsType.newsAdd
        }else if json["video_detail_info"] != JSON.null{
            return NewsType.newsVideo
        }else{
            return NewsType.newsText
        }
    }
    
    /// 格式化时间  将时间戳转换为实际时间
    func getFormatDateTime(json: JSON) -> String? {
        //创建时间
        var createDate: Date?
        guard let behottime = json["behot_time"].int else{return ""}
        createDate = Date(timeIntervalSince1970: TimeInterval(exactly: behottime) ?? 0)
        guard let newDate = createDate else {return ""}

        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //当前时间
        let now = Date()
        
        //日历
        let calender = Calendar.current
        let comps: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: newDate, to: now)
        if (createDate?.isThisYear()) != nil { // 今年
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return fmt.string(from: newDate)
        }
        if (createDate?.isYesterday()) != nil { // 昨天
            fmt.dateFormat = "昨天 HH:mm";
            return fmt.string(from: newDate)
        } else if (createDate?.isToday()) != nil {
            if comps.hour ?? 0 >= 1 {
                return String(format: "%.d小时前", comps.hour ?? 0)
            } else if comps.minute ?? 0 >= 1 {
                return String(format: "%d分钟前", comps.minute ?? 0)
            } else {
                return "刚刚";
            }
        } else {
            fmt.dateFormat = "MM-dd HH:mm";
            return fmt.string(from: newDate)
        }
    }
    
    /// 格式化评论文本
    func getCommentCount(json: JSON) -> String? {
        let count = json.int
        guard let newcount = count else {return "0"}
        if newcount == 0  {
            return "0"
        }else if count! <= 10000  {
            return "\(newcount)"
        }
        return String(format: "%.1f万", Float(newcount) / 10000.0)
    }
}


infix operator =>

func =>(key : String, json : JSON?) -> String?{
    if let newx = json?.string {
        return newx
    }else{
        return nil
    }
}



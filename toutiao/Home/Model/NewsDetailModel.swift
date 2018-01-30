//
// Created by Dx7d9 on 2018/1/24.
// Copyright (c) 2018 Dx7d9. All rights reserved.
//

import Foundation

struct NewsDetailModel{
    var detail_source : String?
    var media_user : Media_User?
    var publish_time : String?
    var title : String?
    var url : URL?
    var is_original : Bool?
    var is_pgc_article : Bool?
    var content :String?
    var source: String?
    var comment_count : String?
    var creator_uid : String?
    init(data : Data){
        let json = JSON(data)["data"]
        //
        if let t = json["title"].string {
            self.title = t
        }
        //
        if let s = json["source"].string{
            self.source = s
        }
        //
        if let u = json["url"].url{
            self.url = u
        }
        //
        if let content = json["content"].string {
            self.content = content
        }
        //
        if let comment = json["comment_count"].string{
            self.comment_count = comment
        }
        if json["media_user"] != JSON.null {
            self.media_user = Media_User(data: json["media_user"].arrayObject)
        }

    }

}
struct  Media_User {
    var avatar_url : String?
    var no_display_pgc_icon : Bool?
    var id : Int?
    var screen_name : String?
    init (data : [Any]?){
        let json = JSON(data)
        self.avatar_url = json["avatar_url"].string
        self.no_display_pgc_icon = json["no_display_pgc_icon"].bool
        self.id = json["id"].int
        self.screen_name = json["screen_name"].string
    }
}

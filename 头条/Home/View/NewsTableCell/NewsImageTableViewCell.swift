//
//  NewsImageTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit
import Kingfisher
class NewsImageTableViewCell: UITableViewCell {
    var newsmodel : HomeNewsModel?{
        didSet {
            title.text = newsmodel?.title
            Time.text = newsmodel?.Time
            comment_count.text = (newsmodel?.commentCount)! + "评论"
            source.text = newsmodel?.source
//            print(newsmodel?.image_list.count)
//            guard  newsmodel?.image_list.count != nil else {
//                return
//            }
            Log(message: newsmodel?.jsondata!["image_list"].count)
            if newsmodel?.image_list.count == 0 {return}
//            Image1.kf.setImage(with:URL(string: JSON(newsmodel?.image_list[0]).stringValue))
//            Image2.kf.setImage(with:URL(string: JSON(newsmodel?.image_list[1]).stringValue))
//            Image3.kf.setImage(with:URL(string: JSON(newsmodel?.image_list[2]).stringValue))
        }
    }

    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var comment_count: UILabel!
    @IBOutlet weak var source: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

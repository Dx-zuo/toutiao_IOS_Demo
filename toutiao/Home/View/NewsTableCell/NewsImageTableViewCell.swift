//
//  NewsImageTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class NewsImageTableViewCell: UITableViewCell {
    var newsmodel : NewsModel?{
        didSet {
            /*
            title.text = newsmodel?.title
            Time.text = newsmodel?.Time
            comment_count.text = (newsmodel?.commentCount)! + "评论"
            source.text = newsmodel?.source

            if newsmodel?.image_list.count == 0 || newsmodel?.image_list.count != 3 {return}
            Image1.loadImageUsingCache(withUrl: JSON(newsmodel?.image_list[0] ?? Con.Url.defImage).stringValue, placeholder: #imageLiteral(resourceName: "wallpaper_profile"), animation: UIImageView.AnimationTypes.none)
            Image2.loadImageUsingCache(withUrl: JSON(newsmodel?.image_list[1] ?? Con.Url.defImage).stringValue, placeholder: #imageLiteral(resourceName: "toutiaohao_34x14_"), animation: UIImageView.AnimationTypes.none)
            Image3.loadImageUsingCache(withUrl: JSON(newsmodel?.image_list[2] ?? Con.Url.defImage).stringValue, placeholder: #imageLiteral(resourceName: "addpgc_subscribe_16x16_"), animation: UIImageView.AnimationTypes.none)
             */
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

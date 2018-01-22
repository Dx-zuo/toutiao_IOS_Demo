//
//  NewsTxtTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class NewsTxtTableViewCell: UITableViewCell {
    var newsmodel : HomeNewsModel?{
        didSet{
            title.text = newsmodel?.title
            source.text = newsmodel?.source
            if newsmodel?.stick_label == nil {
                stick_label.isHidden = true
            }else {
                stick_label.text = newsmodel?.stick_label
            }
            comment_count.text = "\(JSON(newsmodel?.commentCount!).intValue as Int) 评论"
            Time.text = newsmodel?.Time
            if title.text == nil ||  title.text == ""{
                Log(message: newsmodel?.jsondata)
            }
        }
    }

    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var comment_count: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var stick_label: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

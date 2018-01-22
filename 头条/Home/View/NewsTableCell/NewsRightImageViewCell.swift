//
//  NewsRightImageViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit
import Kingfisher
class NewsRightImageViewCell: UITableViewCell {
    var newsmodel : HomeNewsModel?{
        didSet{
            title.text = newsmodel?.title
            source.text = newsmodel?.source
            comment_count.text = (newsmodel?.commentCount)! + "评论"
            Time.text = newsmodel?.Time
            //self.image1.kf.setImage(with: URL(string: (newsmodel?.image)!))
        }
    }

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var comment_count: UILabel!
    @IBOutlet weak var Time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

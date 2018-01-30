//
//  NewsRightImageViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit
class NewsRightImageViewCell: UITableViewCell {
    var newsmodel : NewsModel?{
        didSet{
            titleLabel.text = newsmodel?.title ?? "这是一个右侧有图片的cell"
            /*
            title.text = newsmodel?.title
            source.text = newsmodel?.source
            comment_count.text = (newsmodel?.commentCount)! + "评论"
            Time.text = newsmodel?.Time
            if let url = newsmodel?.image {
                guard url != "" else {return}
                image1.loadImageUsingCache(withUrl: url, placeholder: #imageLiteral(resourceName: "loading_12x12_"), animation: UIImageView.AnimationTypes.dissolve)
            }
            //self.image1.kf.setImage(with: URL(string: (newsmodel?.image)!))
            */
        }
    }

    @IBOutlet weak var newsImage1view: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var behotTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

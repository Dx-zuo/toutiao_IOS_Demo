//
//  NewsAddTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class NewsAddTableViewCell: UITableViewCell {
    var newsmodel : NewsModel?{
        
        didSet{
            titleLabel.text = newsmodel?.title ?? "这是一个广告"
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage1view: UIImageView!
    @IBOutlet weak var newsImage2view: UIImageView!
    @IBOutlet weak var newsImage3view: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

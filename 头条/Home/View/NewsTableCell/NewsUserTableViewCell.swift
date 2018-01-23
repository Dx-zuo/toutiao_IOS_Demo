//
//  NewsUserTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class NewsUserTableViewCell: UITableViewCell {
    var newsmodel : HomeNewsModel?{
        didSet{
            //Log(message: newsmodel?.jsondata)
            avatarImageView.loadImageUsingCache(withUrl: JSON(newsmodel?.jsondata!["user"]["avatar_url"]).stringValue, placeholder: #imageLiteral(resourceName: "user"), animation: UIImageView.AnimationTypes.dissolve)
            contentLabel.text = JSON(newsmodel?.jsondata!["content"]).stringValue
            nameLabel.text = JSON(newsmodel?.jsondata!["user"]["name"]).stringValue
            verifiedContentLabel.text = JSON(newsmodel?.jsondata!["verified_content"]).stringValue
            digButton.titleLabel?.text = JSON(newsmodel?.jsondata!["digg_count"]).stringValue + "推荐"
        }
    }

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var verifiedContentLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var concernButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var digButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var feedshareButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

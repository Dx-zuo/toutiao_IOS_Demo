//
//  NewsVideoTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class NewsVideoTableViewCell: UITableViewCell {
    var newsmodel : NewsModel?{
        didSet{
            titleLabel.text = newsmodel?.title
            let image = UIImageView()
            guard let newimageUrl = newsmodel?.imageURL else {
                return
            }
            image.loadImageUsingCache(withUrl: newimageUrl, placeholder: #imageLiteral(resourceName: "user"), animation: .dissolve)
            image.frame = newsVideoview.frame
            newsVideoview.addSubview(image)
        }
    }

    @IBOutlet weak var newsVideoview: UIView!
    @IBOutlet weak var behotTimeLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

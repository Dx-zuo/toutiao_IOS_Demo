//
//  NewsAddTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class NewsAddTableViewCell: UITableViewCell {
    var newsmodel : HomeNewsModel?{
        
        didSet{
            Log(message: newsmodel?.jsondata)

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

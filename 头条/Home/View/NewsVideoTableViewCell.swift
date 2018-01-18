//
//  NewsVideoTableViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class NewsVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var Video: UIView!
    @IBOutlet weak var Time: NSLayoutConstraint!
    @IBOutlet weak var comment_count: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

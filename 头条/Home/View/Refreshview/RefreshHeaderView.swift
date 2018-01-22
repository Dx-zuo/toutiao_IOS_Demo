//
//  RefreshHeaderView.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/21.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class RefreshHeaderView: UIView {
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Title: UILabel!
    public func loadview() -> RefreshHeaderView {
        return Bundle.main.loadNibNamed("RefreshHeaderView", owner: nil, options: nil)?.first as! RefreshHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func SetStatus(_ Offset: CGPoint)  {
        if Offset.y < -10.0 && Offset.y > -60.0 {
            //print(Int(Offset.y/3.3) * -1)
            Image.image = UIImage(named: "dropdown_loading_0\(Int((Offset.y+10)/3.3) * -1)")
            if Offset.y > -50 {
                Title.text = "松开刷新"
                
            }
        }else if Offset.y == 0.0 {
            Title.text = "下拉刷新"
        }
    }

}

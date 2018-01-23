//
//  RefreshFooterView.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/21.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class RefreshFooterView: UIView {
    
    public func loadview() -> RefreshFooterView {
        return Bundle.main.loadNibNamed("RefreshFooterView", owner: nil, options: nil)?.first as! RefreshFooterView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setStatus(_ status : Refresh_FooterStatus , Offset:Float){
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

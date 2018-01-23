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
    lazy var imageList : [UIImage] = [UIImage(named: "dropdown_loading_00")!,UIImage(named: "dropdown_loading_01")!,UIImage(named: "dropdown_loading_02")!,UIImage(named: "dropdown_loading_03")!,UIImage(named: "dropdown_loading_04")!,UIImage(named: "dropdown_loading_05")!,UIImage(named: "dropdown_loading_06")!,UIImage(named: "dropdown_loading_07")!,UIImage(named: "dropdown_loading_08")!,UIImage(named: "dropdown_loading_09")!,UIImage(named: "dropdown_loading_010")!,UIImage(named: "dropdown_loading_011")!,UIImage(named: "dropdown_loading_012")!,UIImage(named: "dropdown_loading_013")!,UIImage(named: "dropdown_loading_014")!,UIImage(named: "dropdown_loading_015")!]
    public func loadview() -> RefreshHeaderView {
        return Bundle.main.loadNibNamed("RefreshHeaderView", owner: nil, options: nil)?.first as! RefreshHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /// 定义可以滚动的视图, 用于监听父控件的滚动
    var superScrollView: UIScrollView!
    
    /// 记录当前刷新状态
    var Header_refreshStatus: Refresh_HeaderStatus!
    
    fileprivate var isslide : Bool = true
    /// 刷新状态
    fileprivate var isRefsh : Bool = true

    /// 传入当前的offset 计算当前状态
    ///
    /// - Parameter Offset: <#Offset description#>
    func setStatus(_ status : Refresh_HeaderStatus , Offset:Float){
        switch status {
        case .normal:
            setNomalStatus()
            break
        case .waitRefresh:
            if isRefsh {
                setWaitRefreshStatus(offSet: Offset)
            }
            break
        case .refreshing:
            setRefreshingStatus()
            break
        case .endRefresh:
            endRefreshing()
        }
    }
    
    
    
    
//    func SetStatus(_ Offset: CGPoint)  {
//        if Offset.y < -10.0 && Offset.y > -60.0 {
//            //print(Int(Offset.y/3.3) * -1)
//            Image.image = UIImage(named: "dropdown_loading_0\(Int((Offset.y+10)/3.3) * -1)")
//            if Offset.y > -50 {
//                Title.text = "松开刷新"
//
//            }
//        }else if Offset.y == 0.0 {
//            Title.text = "下拉刷新"
//        }
//    }

}
extension RefreshHeaderView {
    // MARK: - 提供一个快速创建类方法

    // MARK: - ** 各种状态切换 **
    // MARK: 正常状态
    fileprivate func setNomalStatus(){
        Title.text = "下拉推荐"
    }
    // MARK: 等待刷新状态
    fileprivate func setWaitRefreshStatus(offSet:Float){
        Header_refreshStatus = Refresh_HeaderStatus.waitRefresh
        Title.text = "下拉推荐"
        if offSet < -10.0 && offSet > -60.0 {
            Image.image = UIImage(named: "dropdown_loading_0\(Int((offSet+10)/3.3) * -1)")
        }
    }
    // MARK: 正在刷新状态
    func setRefreshingStatus() {
        if self.superScrollView.isDragging {
            Title.text = "松开推荐"
            return
        }
        Header_refreshStatus = Refresh_HeaderStatus.refreshing
        Title.text = "推荐中"
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = imageList
        Image.animationImages = imageList
        Image.animationDuration = 1
        Image.animationRepeatCount = 0
        Image.startAnimating()
        
        // MARK: 状态栏是显示风火轮
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if isslide {
            UIView.animate(withDuration: 0.25) {
                self.superScrollView.contentInset = UIEdgeInsets(top: self.superScrollView.contentInset.top + 44, left: self.superScrollView.contentInset.left, bottom: self.superScrollView.contentInset.bottom, right: self.superScrollView.contentInset.right)
            }
            // 禁止滑动
            isslide = false
        }

    }
    // MARK: 结束刷新
    fileprivate func endRefreshing() {
        Header_refreshStatus = Refresh_HeaderStatus.endRefresh
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            UIView.animate(withDuration: 0.25, animations: {
                
                self.superScrollView.contentInset = UIEdgeInsets(top: self.superScrollView.contentInset.top - 44, left: self.superScrollView.contentInset.left, bottom: self.superScrollView.contentInset.bottom, right: self.superScrollView.contentInset.right)
                // 开启滑动
                self.isslide = true;
            })
        }
        
    }
    // 控件将要添加到父控件时, 调用此函数
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        superScrollView = newSuperview as! UIScrollView

    }
}

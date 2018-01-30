//
//  ContentViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/21.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit
import SafariServices
class ContentViewCell: UICollectionViewCell {
    
    ///可复用Cell
    let NewsTxtTCell : String       = "NewsTxtTCell"
    let NewsImageCell : String      = "NewsImageCell"
    let NewsVideoTCell : String     = "NewsVideoTCell"
    let NewsUserCell : String       = "NewsUserCell"
    let NewsRightimageCell : String = "NewsRightimageCell"
    let NewsAddCell : String = "NewsAddCell"
    
    //触摸状态
    var IsTouch : Bool                      = false
    weak var delegate : HomeViewController? = nil
    var IsRef : Bool                        = true
    var NewModel :[NewsModel]               = []
    @IBOutlet weak var tableview: UITableView!
    
    /// 刷新头部
    fileprivate lazy var refreshHeaderView: RefreshHeaderView = {
        var refresh_HeaderView   = RefreshHeaderView().loadview()
        refresh_HeaderView.frame = CGRect(x: 0, y: -60, width: Con.screenWidth, height: 60.0)
        return refresh_HeaderView
    }()
    
    //刷新底部
    fileprivate lazy var refreshFooterView: RefreshFooterView = {
        var refresh_FooterView = RefreshFooterView().loadview()
        return refresh_FooterView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
}

// MARK: - 设置UI界面
extension ContentViewCell{
    
    fileprivate func setupUI(){
        //添加控件
        tableview.insertSubview(refreshHeaderView, at: 0)
        //不知道为什么 tableFooterView 直接赋值为refresh_FooterView 高度会显示错误 无奈 只好新建一个view上边添加
        let vc = UIView(frame: CGRect(x: 0.0, y: 0.0, width: Con.screenWidth, height: 60))
        tableview.tableFooterView = vc
        vc.addSubview(refreshFooterView)
        refreshFooterView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(vc)
        }
        
        
        tableview.delegate = self
        tableview.dataSource = self
        
        //注册cell
        tableview.register(UINib(nibName: "NewsTxtTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTxtTCell)
        tableview.register(UINib(nibName: "NewsImageTableViewCell", bundle: nil), forCellReuseIdentifier: NewsImageCell)
        tableview.register(UINib(nibName: "NewsVideoTableViewCell", bundle: nil), forCellReuseIdentifier: NewsVideoTCell)
        tableview.register(UINib(nibName: "NewsUserTableViewCell", bundle: nil), forCellReuseIdentifier: NewsUserCell)
        tableview.register(UINib(nibName: "NewsRightImageViewCell", bundle: nil), forCellReuseIdentifier:NewsRightimageCell)
        tableview.register(UINib(nibName: "NewsAddTableViewCell", bundle: nil), forCellReuseIdentifier:NewsAddCell)
        //发起请求
        
        ToRequset.GetLoadNews({ (data) in
            self.NewModel = data
            
            self.tableview.reloadData()
        })
    }
}
extension ContentViewCell :UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewModel.count
    }
    
    // MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _ : UITableViewCell?
        guard NewModel[indexPath.row].newsType != nil else {
            return UITableViewCell()
        }
        let cell = UITableViewCell()
        return cell
        
        switch NewModel[indexPath.row].newsType! {
        case .newsRightImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsRightimageCell, for: indexPath) as! NewsRightImageViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .newsThreeImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageCell, for: indexPath) as! NewsImageTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .newsText:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTxtTCell, for: indexPath) as! NewsTxtTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .newsVideo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsVideoTCell, for: indexPath) as! NewsVideoTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .newsWeitou:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsUserCell, for: indexPath) as! NewsUserTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .newsTop:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTxtTCell, for: indexPath) as! NewsTxtTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .newsAdd:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAddCell, for: indexPath) as! NewsAddTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        }
    }
    
    //  配置高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard NewModel[indexPath.row].newsType != nil else {
            return 30
        }
        
        switch NewModel[indexPath.row].newsType! {
        case .newsRightImage:
            return 125
        case .newsThreeImage:
            return 153
        case .newsText:
            return 84
        case .newsTop:
            return 84
        case .newsVideo:
            return 225
        case .newsWeitou:
            return 237
        case .newsAdd:
            return 159
        }
        
    }
    
    // MARK : - Cell点击跳转
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ///
        if NewModel[indexPath.row].newsType == NewsType.newsText || NewModel[indexPath.row].newsType == NewsType.newsRightImage || NewModel[indexPath.row].newsType == NewsType.newsThreeImage  {
            
            //
            let vc = UIStoryboard(name: "WebView", bundle: nil)
            let webVc = vc.instantiateViewController(withIdentifier: "WebView_ID") as! WebViewController
            webVc.newsmodel = NewModel[indexPath.row]
            //隐藏tabbar
            self.delegate?.hidesBottomBarWhenPushed = true
            self.delegate?.navigationController?.pushViewController(webVc, animated: true)
            //显示tabbar
            self.delegate?.hidesBottomBarWhenPushed = false
        }else{
            // 头条各种视图 ~ 太多辣  先只做个普通版本的
            guard let newUrl = URL(string: NewModel[indexPath.row].shareURL ?? "https://baidu.com") else{return}
            let vc = SFSafariViewController(url: newUrl)
            tableView.deselectRow(at: indexPath, animated: true)
            self.delegate?.present(vc, animated: true, completion: nil)
        }
    }
}
extension ContentViewCell : RefreshDelegate {
    func startLoading() {
        
    }
    
    func endLoading() {
        
    }
    
}

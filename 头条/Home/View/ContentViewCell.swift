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
    let NewsTxtTCell : String = "NewsTxtTCell"
    let NewsImageCell : String = "NewsImageCell"
    let NewsVideoTCell : String = "NewsVideoTCell"
    let NewsUserCell : String = "NewsUserCell"
    let NewsRightimageCell : String = "NewsRightimageCell"
    let NewsAddCell : String = "NewsAddCell"
    //触摸状态
    var IsTouch : Bool = false
    weak var delegate : HomeNewsViewController? = nil
    var IsRef : Bool = true
    var NewModel :[HomeNewsModel] = []
    @IBOutlet weak var tableview: UITableView!
    /// 刷新头部
    fileprivate lazy var refresh_HeaderView: RefreshHeaderView = {
        var refresh_HeaderView = RefreshHeaderView().loadview()
        refresh_HeaderView.frame = CGRect(x: 0, y: -60, width: Con.screenWidth, height: 60.0)
        return refresh_HeaderView
    }()
    //刷新底部
    fileprivate lazy var refresh_FooterView: RefreshFooterView = {
        var refresh_FooterView = RefreshFooterView().loadview()
        return refresh_FooterView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }

}
extension ContentViewCell{

    fileprivate func setupUI(){
        //添加控件
        tableview.insertSubview(refresh_HeaderView, at: 0)
        //不知道为什么 tableFooterView 直接赋值为refresh_FooterView 高度会显示错误 无奈 只好新建一个view上边添加
        let vc = UIView(frame: CGRect(x: 0.0, y: 0.0, width: Con.screenWidth, height: 60))
        tableview.tableFooterView = vc
        vc.addSubview(refresh_FooterView)
        refresh_FooterView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(vc)
        }
        //refresh_FooterView.frame.size.height = refresh_FooterView.frame.size.height/2
        ///
        
        tableview.delegate = self
        tableview.dataSource = self
        //自动高度自适应
        //tableview.rowHeight  = UITableViewAutomaticDimension
        //tableview.estimatedRowHeight = 100
        //注册cell
        tableview.register(UINib(nibName: "NewsTxtTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTxtTCell)
        tableview.register(UINib(nibName: "NewsImageTableViewCell", bundle: nil), forCellReuseIdentifier: NewsImageCell)
        tableview.register(UINib(nibName: "NewsVideoTableViewCell", bundle: nil), forCellReuseIdentifier: NewsVideoTCell)
        tableview.register(UINib(nibName: "NewsUserTableViewCell", bundle: nil), forCellReuseIdentifier: NewsUserCell)
        tableview.register(UINib(nibName: "NewsRightImageViewCell", bundle: nil), forCellReuseIdentifier:NewsRightimageCell)
        tableview.register(UINib(nibName: "NewsAddTableViewCell", bundle: nil), forCellReuseIdentifier:NewsAddCell)
        // 设置 tableView 底部\顶部内边距, 使Footer\ Header显示, 不反弹回去
        //tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -60.0, right: 0)
        // 设置指示器的顶部间距
        //tableview.scrollIndicatorInsets = UIEdgeInsets(top: 44.0, left: 0, bottom: 0, right: 0)
        
        
        
        ToRequset.GetLoadNews(category: "__all__", listCount: 20) { (data) in
            self.NewModel = data
            
            self.tableview.reloadData()
        }
        

    }
    
    
}
extension ContentViewCell :UITableViewDataSource,UITableViewDelegate{

// MARK:  - 判断刷新视图状态
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 开始滑动
        if scrollView.contentOffset.y <= -10 && IsRef {     //顶部滑动
            
            if scrollView.contentOffset.y <= -10 && scrollView.contentOffset.y >= -60  {    //开始动画同步
                
                refresh_HeaderView.setStatus(.waitRefresh, Offset: Float(scrollView.contentOffset.y))
                
            }else {      //完全滑动到顶  开始切换到刷新视图
                refresh_HeaderView.setStatus(.refreshing, Offset: Float(scrollView.contentOffset.y))
                if !refresh_HeaderView.superScrollView.isDragging {
                    IsRef = false
                    ToRequset.GetLoadNews(category: "__all__", listCount: 20) { (data) in
                        self.NewModel += data
                        self.tableview.reloadData()
                        self.IsRef = true
                        self.refresh_HeaderView.setStatus(.endRefresh, Offset: Float(scrollView.contentOffset.y))
                    }
                }
            }
        }else if scrollView.contentSize.height - Con.screenWidth-84 <= scrollView.contentOffset.y && IsRef {     //下滑
                Log(message: "开始上拉滑动")
                IsRef = false
                ToRequset.GetLoadNews(category: "__all__", listCount: 20) { (data) in
                    self.NewModel += data
                    self.tableview.reloadData()
                    self.IsRef = true
                }
        }
//        refresh_HeaderView.setStatus(Float(scrollView.contentOffset.y))
//        if scrollView.contentOffset.y <= -60.0 &&  IsRef {
//            IsRef = false
////            ToRequset.GetLoadNews(category: "__all__", listCount: 20) { (data) in
////                self.NewModel += data
////
////                self.tableview.reloadData()
////                self.IsRef = true
////            }
//        }
//        print(scrollView.contentOffset)
//        print(scrollView.contentSize)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewModel.count
    }
// MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _ : UITableViewCell?
        guard NewModel[indexPath.row].type != nil else {
            return UITableViewCell()
        }
        switch NewModel[indexPath.row].type! {
        case .News_right_image:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsRightimageCell, for: indexPath) as! NewsRightImageViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .News_three_image:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageCell, for: indexPath) as! NewsImageTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .News_Text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTxtTCell, for: indexPath) as! NewsTxtTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .News_video:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsVideoTCell, for: indexPath) as! NewsVideoTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .News_weitou:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsUserCell, for: indexPath) as! NewsUserTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .Top:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTxtTCell, for: indexPath) as! NewsTxtTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        case .add:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAddCell, for: indexPath) as! NewsAddTableViewCell
            cell.newsmodel = NewModel[indexPath.row]
            return cell
        }
        return UITableViewCell()

    }

//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        fatalError("tableView(tableView:indexPath:) has not been implemented")
//        return  100.0
//    }

    //  配置高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard NewModel[indexPath.row].type != nil else {
            return 30
        }
        switch NewModel[indexPath.row].type! {
        case .News_right_image:
            return 125
        case .News_three_image:
            return 153
        case .News_Text:
            return 84
        case .Top:
            return 84
        case .News_video:
            return 225
        case .News_weitou:
            return 237
        case .add:
            return 159
        }
    }
// MARK : - Cell点击跳转
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///
        if NewModel[indexPath.row].type == NewsType.News_Text || NewModel[indexPath.row].type == NewsType.News_three_image || NewModel[indexPath.row].type == NewsType.News_right_image  {
            
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
            let vc = SFSafariViewController(url: URL(string: NewModel[indexPath.row].share_url ?? "https://baidu.com")!)
            tableView.deselectRow(at: indexPath, animated: true)
            self.delegate?.present(vc, animated: true, completion: nil)
        }
        
        //SafariServices
        //print(indexPath.row)
    }
}


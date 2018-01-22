//
//  ContentViewCell.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/21.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class ContentViewCell: UICollectionViewCell {
    ///可复用Cell
    let NewsTxtTCell : String = "NewsTxtTCell"
    let NewsImageCell : String = "NewsImageCell"
    let NewsVideoTCell : String = "NewsVideoTCell"
    let NewsUserCell : String = "NewsUserCell"
    let NewsRightimageCell : String = "NewsRightimageCell"
    let NewsAddCell : String = "NewsAddCell"
    
    
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
    //界面滑动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refresh_HeaderView.SetStatus(scrollView.contentOffset)
        if scrollView.contentOffset.y <= -60.0 &&  IsRef {
            IsRef = false
            ToRequset.GetLoadNews(category: "__all__", listCount: 20) { (data) in
                self.NewModel += data
                
                self.tableview.reloadData()
                self.IsRef = true
            }
        }
//        print(scrollView.contentOffset)
//        print(scrollView.contentSize)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewModel.count
    }
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
            return 225
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //print(indexPath.row)
    }
}
extension UITableViewCell {
}

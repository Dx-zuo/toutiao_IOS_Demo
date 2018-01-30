//
//  WebViewController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/23.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController{
    var newsmodel : NewsModel?
    var newinfomodel : NewsDetailModel?
    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK : - 处理下数据 并且保存到数组中
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension WebViewController {
    //MARK : - 视图初始化
    private func setup() {
        //注册
        webview.navigationDelegate = self
        
        //注册监听事件
        NotificationCenter.default.addObserver(self,selector: #selector(WebViewController.keyboardWillChange(_:)),name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WebViewController.keyboardWillHiden(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    
    func loadHtml(item_seo_url: String){
        Network.request("https://m.toutiao.com/i\(item_seo_url)/info/").responseJSON { (response) in
            if response.result.isSuccess , let data = response.data {
                self.newinfomodel = NewsDetailModel(data: data)
                if let indodata =  self.newinfomodel, let contentTxt = indodata.content{
                    let htmlpath = Bundle.main.path(forResource: "demo", ofType: "html")
                    let htmldoc = try? String(contentsOfFile: htmlpath!)
                    let content = htmldoc?.replacingOccurrences(of: "{{ content }}", with: contentTxt)
                    self.webview.loadHTMLString(content!, baseURL: Bundle.main.bundleURL)
                }else if let url = self.newinfomodel?.url {
                    self.webview.load(URLRequest(url: url))
                }
            }
        }
    }
    
    //键盘开始
    @objc func keyboardWillChange(_ notification:Notification){
        Log(message: "弹出键盘")
    }
    //键盘消失
    @objc func keyboardWillHiden(_ notification:Notification){
        Log(message: "键盘消失")
    }
    //触摸事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}
extension WebViewController :WKNavigationDelegate{
    //MARK : - 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Log(message: "加载完成")
        if newinfomodel != nil {
            var javascript = ""
            
            if let title = newinfomodel!.title {
                javascript += "document.getElementById(\"news_title\").innerHTML = \"\(title) \";"
            }
            if let author = newinfomodel!.source {
                javascript += "document.getElementById(\"author-name\").innerHTML = \"\(author)\";"
            }
            if let time = newinfomodel!.publish_time {
                javascript += "document.getElementById(\"publish-time\").innerHTML = \"\(time)\";"
            }
            if let comment_count = newinfomodel!.comment_count {
                javascript += "document.getElementById(\"comment_count\").innerHTML = \"\(comment_count)\";"
            }
            
            webview.evaluateJavaScript(javascript) { any, error in
                Log(message: any)
                if error != nil{
                    Log(message: error)
                }
            }
        }
    }
}


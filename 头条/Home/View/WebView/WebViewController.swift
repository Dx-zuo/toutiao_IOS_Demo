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
    var newsmodel : HomeNewsModel?
    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建
        // 创建WKWebView
        // 设置访问的URL
        // 根据URL创建请求
        //loadHtml(item_seo_url: "6513449984514327053")
        setup()
    }
    private func setup() {
        if (newsmodel?.item_id) != nil {
            loadHtml(item_seo_url: (newsmodel?.item_id)!)
        }else if let path = Bundle.main.path(forResource: "demo", ofType: "html") {
            load(filePath: path)
        }
    }
    private func load(filePath: String) {
        
        let fileUrl = URL(fileURLWithPath: filePath)
        webview.loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
    }
    
    func loadHtml(item_seo_url: String){
        Network.request("https://m.toutiao.com/i\(item_seo_url)/info/").responseJSON { (response) in
            if response.result.isSuccess , JSON(response.data!)["data"] != JSON.null {
                let json = JSON(response.data!)["data"]
                self.navigationItem.title = json["title"].stringValue
                let htmlpath = Bundle.main.path(forResource: "demo", ofType: "html")
                var htmldoc = try? String(contentsOfFile: htmlpath!)
                let content = htmldoc?.replacingOccurrences(of: "{{ content }}", with: json["content"].string!)
                self.webview.loadHTMLString(content!, baseURL: response.request?.url)

            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

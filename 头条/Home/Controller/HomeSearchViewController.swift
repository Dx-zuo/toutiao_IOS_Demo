//
//  HomeSearchViewController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

class HomeSearchViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    fileprivate lazy var searchNavigationView: SearchNavigationView = {
        let searchNavigationView = SearchNavigationView()
        searchNavigationView.delegate = self
        return searchNavigationView
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
extension HomeSearchViewController{
    fileprivate func setupUI(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        //
        //
        
    }
    
}
extension HomeSearchViewController: SearchNavigationViewDelegate, UITextFieldDelegate {
    func cancelButtonClicked() {
        navigationController?.popViewController(animated: false)
    }
}

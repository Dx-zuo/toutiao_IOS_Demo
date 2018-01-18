//
//  HomeNewsTableViewController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit

enum NewsCellType {
    case Txt
    case Image
    case Video
    case User
}

class HomeNewsTableViewController: UITableViewController {
    let data : [UITableViewCell] = [NewsTxtTableViewCell(),NewsTxtTableViewCell(),NewsImageTableViewCell(),NewsImageTableViewCell(),NewsVideoTableViewCell(),NewsTxtTableViewCell(),NewsUserTableViewCell()]
    override func viewDidLoad() {
        super.viewDidLoad()
//        for i in data {
//            tableView.register(UINib(nibName: String(describing: i.self), bundle: nil), forCellReuseIdentifier: String(describing: i.self))
//        }
        tableView.register(UINib(nibName: "NewsTxtTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTxt")
        setupUI()
    }
    func setupUI() {
        navigationController?.navigationBar.barStyle = .default
        navigationItem.titleView = homeNavigationBar
        navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width:Con.screenWidth , height: 44)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    fileprivate lazy var homeNavigationBar: HomeNavigationBar = {
        let homeNavigationBar = HomeNavigationBar()
        homeNavigationBar.searchBar.searchFiled.delegate = self
        return homeNavigationBar
    }()
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(r: 248.0, g: 106.0, b: 85.0)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTxt", for: indexPath) as! NewsTxtTableViewCell
            return cell

//        let cell = Bundle.main.loadNibNamed(String(describing: data[indexPath.row].self), owner: nil, options: nil)?.last as! UITableViewCell
//        cell.backgroundColor = UIColor.red
        // Configure the cell...
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeNewsTableViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //navigationController?.pushViewController(HomeSearchViewController(), animated: false)
        return true
    }
}

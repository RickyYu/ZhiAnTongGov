//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class RouteCpyChoiceController:UITableViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let array = ["test","beijing", "shanghai","guangzhou","shenzhen" ,"changsha","wuhan","tianjing","hangzhou"]
    var result = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPage()
    }
    
    private func initPage(){
        
        // 设置navigation
        navigationItem.title="企业信息列表"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(CpyInfoListController.back))
        // 搜索内容为空时，显示全部内容
        self.result = self.array
        self.searchBar.delegate = self
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identify: String = "RouteCpyInfoListExCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = self.result[indexPath.row]
        
        return cell
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        // 没有搜索内容时显示全部内容
        if searchText == "" {
            self.result = self.array
        } else {
            
            // 匹配用户输入的前缀，不区分大小写
            self.result = []
            
            for arr in self.array {
                
                if arr.lowercaseString.hasPrefix(searchText.lowercaseString) {
                    self.result.append(arr)
                }
            }
        }
        
        // 刷新tableView 数据显示
        self.tableView.reloadData()
    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    // 书签按钮触发事件
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        
        print("搜索历史")
    }
    
    // 取消按钮触发事件
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        self.result = self.array
        self.tableView.reloadData()
    }
    
    
    func back()
    {
       // navigationController?.dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //给新进入的界面进行传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "backRouteNav" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                (segue.destinationViewController as! RouteNavViewController).coordinator = CLLocationCoordinate2D.init()
            }
        }
    }
    
    
}

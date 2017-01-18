//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class CpyInfoListController:UITableViewController,UISearchBarDelegate{

    var cpyInfoModels  = [CpyInfoModel]()
    var result = [CpyInfoModel]()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        initPage()
       
    }
    //搜索控制器
    var countrySearchController = UISearchController()
      var searchStr : String! = ""
    // 是否加载更多
    private var toLoadMore = false
    private func initPage(){
        
        // 设置navigation
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(CpyInfoListController.back))
        self.view.backgroundColor = UIColor.whiteColor()
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self  //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        // 设置下拉刷新控件
        refreshControl = RefreshControl(frame: CGRectZero)
        refreshControl?.addTarget(self, action: #selector(self.getData), forControlEvents: .ValueChanged)
        refreshControl?.beginRefreshing()
        getData()

    }
    

    
    func getData(){
        
        if refreshControl!.refreshing{
          reSet()
        }
        var parameters = [String : AnyObject]()
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        if !AppTools.isEmpty(searchStr){
         parameters["company.companyName"] = searchStr
        }
        
        
        NetworkTool.sharedTools.loadCompanys(parameters,isYh: true) { (cpyInfoModels, error,totalCount) in
            
            // 停止加载数据
            if self.refreshControl!.refreshing{
                self.refreshControl!.endRefreshing()
            }
            
            if error == nil{
                if self.currentPage>totalCount{
                    self.totalCount = totalCount!
                    self.showHint("已经到最后了", duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                    self.toLoadMore = false
                    self.cpyInfoModels += cpyInfoModels!
               
            }else{
                // 获取数据失败后
                self.currentPage -= 10
                if self.toLoadMore{
                    self.toLoadMore = false
                }
                self.showHint("\(error)", duration: 2, yOffset: 0)
            }
            
            self.tableView.reloadData()
        }
       
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cpyInfoModels.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "CpyInfoListCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CpyInfoCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let count = cpyInfoModels.count ?? 0
        if count > 0 {
            let cpyInfoModel = cpyInfoModels[indexPath.row]
            cell.cpyInfoModel = cpyInfoModel
        }
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            // 这儿写自增, 竟然有警告, swift语言更新确实有点快, 我记得1.2的时候还是可以的
            currentPage += 10
           getData()
        }
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchStr = searchText
        print("searchTextStr = \(searchStr)")
   
    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.resignFirstResponder()
        reSet()
        getData()
        
    }
    
    // 取消按钮触发事件
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        searchStr = ""
        reSet()
        getData()
    }
    
    
    func back()
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //给新进入的界面进行传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toRecordInfo" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //                let object : NSDictionary = listVideos[indexPath.row] as! NSDictionary
                //                (segue.destinationViewController as! InfoDetailController).detailItem = object
                let model = cpyInfoModels[indexPath.row]
                (segue.destinationViewController as! RecordInfoListController).cpyId = model.id
       
            }
        }
    }
    
    // MARK: - 内部控制方法
    /**
     重置数据
     */
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        cpyInfoModels.removeAll()
        cpyInfoModels = [CpyInfoModel]()
    }
}

//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

//企业查询列表界面
private let Identifier = "ReviewInfoCell"
class GovReviewListController:BaseTabViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //搜索控制器
    var countrySearchController = UISearchController()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    var listDatas  = [UnPunishmentModel]()
    var result = [UnPunishmentModel]()
    // 是否加载更多
    private var toLoadMore = false
    var searchStr : String!
    override func viewDidLoad() {
        super.viewDidLoad()
  setNavagation("政府复查")
        initPage()
    }
    
    private func initPage(){
        self.view.backgroundColor = UIColor.whiteColor()
        // 设置navigation
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(CpyInfoListController.back))
        // 设置tableview相关
        let nib = UINib(nibName: Identifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        tableView.rowHeight = 53;
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            if searchStr != nil{
                controller.searchBar.text = searchStr
            }
            controller.searchBar.delegate = self  //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.placeholder = "请输入企业名称"
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        // 设置下拉刷新控件
        refreshControl = RefreshControl(frame: CGRectZero)
        refreshControl?.addTarget(self, action: #selector(self.getDatas), forControlEvents: .ValueChanged)
        refreshControl?.beginRefreshing()
        getDatas()
    }
    
    func getDatas(){
        
        if refreshControl!.refreshing{
            reSet()
        }
        var parameters = [String : AnyObject]()
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
         if searchStr != nil{
            parameters["companyName"] = searchStr
        }
        
        
        NetworkTool.sharedTools.loadProduceCallBacks(parameters) { (datas, error,totalCount) in
            
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
                self.listDatas += datas!
                
            }else{
                // 获取数据失败后
                self.currentPage -= 10
                if self.toLoadMore{
                    self.toLoadMore = false
                }
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.listDatas.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! ReviewInfoCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let count = listDatas.count ?? 0
        if count > 0 {
            let data = listDatas[indexPath.row]
            cell.unPunishmentModel = data
        }
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += 10
            getDatas()
        }
        return cell
    }
    
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.resignFirstResponder()
        searchStr = countrySearchController.searchBar.text
        reSet()
        getDatas()
        
    }
    
    // 取消按钮触发事件
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        searchStr = ""
        reSet()
        getDatas()
    }
    
    
    
    func back()
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = listDatas[indexPath.row]
        let controller = GovReviewDetailController()
        controller.converyDataModel = object
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        listDatas.removeAll()
        listDatas = [UnPunishmentModel]()
    }
    
}

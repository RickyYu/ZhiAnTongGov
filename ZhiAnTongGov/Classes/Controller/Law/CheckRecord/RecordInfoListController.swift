//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class RecordInfoListController:BaseTabViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    var cpyId :Int? //检查单位ID
    var recordInfoModels  = [RecordInfoModel]()
    var result = [RecordInfoModel]()
    //搜索控制器
    //搜索控制器
    var countrySearchController = UISearchController()
    var searchStr : String! = ""
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
    var isRefresh:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        initPage()
        
    }
    override func viewWillAppear(animated: Bool) {
        if isRefresh{
         reSet()
         getData()
        }
       
    }
    
    private func initPage(){
        
        // 设置navigation
        navigationItem.title = "检查记录"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新增", style: UIBarButtonItemStyle.Done, target: self, action: #selector(RecordInfoListController.addRecord))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;
        // 搜索内容为空时，显示全部内容
        // self.result = self.array
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self  //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "请输入检查场所"
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        // 设置下拉刷新控件
        refreshControl = RefreshControl(frame: CGRectZero)
        refreshControl!.addTarget(self, action: #selector(self.getData), forControlEvents: .ValueChanged)
        refreshControl!.beginRefreshing()
        getData()
        
        
    }
    
    //新增
    func addRecord(){
        let controller = AddRecordController()
        controller.hzCompanyId = self.cpyId
     self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getData(){
        if refreshControl!.refreshing{
            reSet()
        }
        var parameters = [String : AnyObject]()
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        parameters["produceLocaleNote.hzCompany.id"] = cpyId
        parameters["typeId"] = 0
        
        if !AppTools.isEmpty(searchStr){
            parameters["produceLocaleNote.content"] = ""      //为空
            parameters["produceLocaleNote.appCode"] = "all"  //unPun、pun
            parameters["produceLocaleNote.checkGround"] = searchStr  //检查场所
        }
       
        
        NetworkTool.sharedTools.loadGovRecords(parameters) { (recordInfoModels, error,totalCount) in
                                    // 停止加载数据
            if self.refreshControl!.refreshing{
                self.refreshControl!.endRefreshing()
            }
          
            
            
            if error == nil{
                self.totalCount = totalCount!

                if self.currentPage>totalCount{
                    self.showHint("数据加载完毕", duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                 self.toLoadMore = false
                self.recordInfoModels += recordInfoModels!
                
            }else{
                // 获取数据失败后
                self.currentPage -= 10
                if self.toLoadMore{
                    self.toLoadMore = false
                }
                self.showHint("\(error!)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }
            }
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recordInfoModels.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "RecordInfoCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecordInfoCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let count = recordInfoModels.count ?? 0
        if count > 0 {
            let recordInfoModel = recordInfoModels[indexPath.row]
            cell.recordInfoModel = recordInfoModel
        }
        
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += 10
            getData()
        }
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchStr = searchText
        print("searchTextStr = \(searchStr)")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let controller = RecordInfoDetailController()
        controller.converyDataModel = recordInfoModels[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
      
    }
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
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
       navigationController?.popViewControllerAnimated(true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    // MARK: - 内部控制方法
    /**
     重置数据
     */
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        recordInfoModels.removeAll()
        recordInfoModels = [RecordInfoModel]()
    }
    
    
}

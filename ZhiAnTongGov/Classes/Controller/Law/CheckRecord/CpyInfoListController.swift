//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

private let CpyInfoListReuseIdentifier = "CpyInfoCell"
class CpyInfoListController:BaseTabViewController,UISearchBarDelegate,YMSortTableViewDelegate{

    var cpyInfoModels  = [CpyInfoModel]()
    var result = [CpyInfoModel]()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+PAGE_SIZE
    //总条数
    var totalCount : Int = 0
    //排序规则
    var orderProperty : String!
    var orderType:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagation("检查记录")
        let button2 = UIButton(frame:CGRectMake(0, 0, 32, 32))
        button2.setImage(UIImage(named: "icon_sort"), forState: .Normal)
        button2.addTarget(self,action:#selector(self.sortButtonClick),forControlEvents:.TouchUpInside)
        let barButton2 = UIBarButtonItem(customView: button2)
        navigationItem.rightBarButtonItem = barButton2
        popView.cells = ["修改时间","隐患数升序", "隐患数降序"]
        popView.sorts =  ["","up", "down"]
        
        initPage()
       
    }
    
    private lazy var popView: YMSortTableView = {
        let popView = YMSortTableView()
        popView.delegate = self
        return popView
    }()
    /// 搜索条件点击
    func sortButtonClick() {
        popView.show()
    }
    
    var isPun :Bool = false // false 未处罚   true 已经处罚
    // MARK: - YMSortTableViewDelegate
    func sortView(sortView: YMSortTableView, didSelectSortAtIndexPath sort: String) {
        print(sort)
        sortView.dismiss()
        //gridDangerNum
        if sort == "up" {
        orderProperty = "gridDangerNum"
            orderType = true
            reSet()
            getData()
        }else if sort == "down"{
            orderProperty = "gridDangerNum"
            orderType = false
            reSet()
            getData()
        }else{
            orderProperty = nil
            reSet()
            getData()
        }
    }
    
    //搜索控制器
   // var countrySearchController = UISearchController()
      var searchStr : String! = ""
    // 是否加载更多
    private var toLoadMore = false
    private func initPage(){
        
        // 设置navigation
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(CpyInfoListController.back))
        self.view.backgroundColor = UIColor.whiteColor()
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;

        
        // 设置tableview相关
        let nib = UINib(nibName: CpyInfoListReuseIdentifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: CpyInfoListReuseIdentifier)
        tableView.rowHeight = 53;
        tableView.backgroundColor = UIColor.whiteColor()
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self  //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = NOTICE_CPY_NAME
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
//        // 设置下拉刷新控件
//        refreshControl = RefreshControl(frame: CGRectZero)
//        refreshControl?.addTarget(self, action: #selector(self.getData), forControlEvents: .ValueChanged)
//        refreshControl?.beginRefreshing()
        getData()

    }
    

    
    
    func getData(){
        
//        if refreshControl!.refreshing{
//          reSet()
//        }
        var parameters = [String : AnyObject]()
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        if !AppTools.isEmpty(searchStr){
         parameters["company.companyName"] = searchStr
        }
        
        if orderProperty != nil{
        parameters["company.orderProperty"] = orderProperty
        parameters["company.orderType"] = String(orderType)
        }
        
        
        NetworkTool.sharedTools.loadCompanys(parameters,isYh: true) { (cpyInfoModels, error,totalCount) in
            
//            // 停止加载数据
//            if self.refreshControl!.refreshing{
//                self.refreshControl!.endRefreshing()
//            }
//            
            if error == nil{
                if self.currentPage>totalCount{
                    self.totalCount = totalCount!
                    if self.toLoadMore {
                        self.showHint("已经到最后了", duration: 2, yOffset: 0)
                    }
                    self.currentPage -= PAGE_SIZE
                    return
                }
                    self.toLoadMore = false
                    self.cpyInfoModels += cpyInfoModels!
               
            }else{
                // 获取数据失败后
                self.currentPage -= PAGE_SIZE
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
        return self.cpyInfoModels.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier(CpyInfoListReuseIdentifier, forIndexPath: indexPath) as! CpyInfoCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let count = cpyInfoModels.count ?? 0
        if count > 0 {
            let cpyInfoModel = cpyInfoModels[indexPath.row]
            cell.cpyInfoModelByGrid = cpyInfoModel
        }
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += PAGE_SIZE
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
        searchStr = countrySearchController.searchBar.text
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

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RecordInfoListController") as! RecordInfoListController
        let model:CpyInfoModel = cpyInfoModels[indexPath.row]
        controller.cpyId = model.id
        if model.gridDangerNum > 0 {
          controller.isHavaReviewNum = true
        }else{
         controller.isHavaReviewNum = false
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - 内部控制方法
    /**
     重置数据
     */
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        totalCount = 0
        cpyInfoModels.removeAll()
        cpyInfoModels = [CpyInfoModel]()
    }
}

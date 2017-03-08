//
//  HiddenInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/2/27.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

private let CpyInfoListReuseIdentifier = "CpyInfoCell"
class HiddenInfoListController:BaseTabViewController,UISearchBarDelegate,YMSortTableViewDelegate{
    
    var companyId:String!
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    //排序规则
    var orderProperty : String!
    var orderType:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        //修改导航栏按钮颜色为白色
       setNavagation("企业隐患查看")
        let button2 = UIButton(frame:CGRectMake(0, 0, 32, 32))
        button2.setImage(UIImage(named: "icon_sort"), forState: .Normal)
        button2.addTarget(self,action:#selector(self.sortButtonClick),forControlEvents:.TouchUpInside)
        let barButton2 = UIBarButtonItem(customView: button2)
        navigationItem.rightBarButtonItem = barButton2
        popView.cells = ["全部","未整改", "已整改"]
        popView.sorts =  ["","un", "down"]
        
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
        if sort == "un" {
            isRepaired = false
            reSet()
            getDatas()
        }else if sort == "down"{
            isRepaired = true
            reSet()
            getDatas()
        }else{
            isRepaired = nil
            reSet()
            getDatas()
        }
    }
    
    //搜索控制器
    var countrySearchController = UISearchController()
    var searchStr : String! = ""
    // 是否加载更多
    private var toLoadMore = false
    private func initPage(){

        
        
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
        
        // 设置下拉刷新控件
        refreshControl = RefreshControl(frame: CGRectZero)
        refreshControl?.addTarget(self, action: #selector(self.getDatas), forControlEvents: .ValueChanged)
        refreshControl?.beginRefreshing()
        getDatas()
        
    }
    
    var unModifyModels = [UnModifyModel]()
    var isRepaired:Bool!
    var sourceType:String!
    func getDatas(){
        
        var parameters = [String : AnyObject]()
        
        parameters["vDanger.companyId"] = companyId
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        
        if isRepaired != nil{
            parameters["vDanger.repaired"] = String(isRepaired)
        }
        
        if sourceType != nil{
            parameters["vDanger.sourceType"] = sourceType
        }
        if searchStr != nil{
            parameters["vDanger.description"] = searchStr
        }
        
        NetworkTool.sharedTools.loadVDangers(parameters) { (datas, error, totalCount) in
            if error == nil{
                if self.currentPage>totalCount{
                    self.totalCount = totalCount!
                    //  self.showHint(LOAD_FINISH, duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                self.toLoadMore = false
                self.unModifyModels += datas!
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
        return self.unModifyModels.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CpyInfoListReuseIdentifier, forIndexPath: indexPath) as! CpyInfoCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let count = unModifyModels.count ?? 0
        if count > 0 {
            let unModifyModel = unModifyModels[indexPath.row]
            cell.unModifyModel = unModifyModel
        }
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += 10
            getDatas()
        }
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchStr = searchText
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
        
        let model:UnModifyModel = unModifyModels[indexPath.row]
        if model.type == 1{
            let controller = GeneralHiddenViewController()
            controller.hiddenId = String(model.id)
            self.navigationController?.pushViewController(controller, animated: true)
        
        }else{
            let controller = RecordHiddenMajorController()
            controller.hiddenId = String(model.id)
            self.navigationController?.pushViewController(controller, animated: true)
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
        unModifyModels.removeAll()
        unModifyModels = [UnModifyModel]()
    }
}


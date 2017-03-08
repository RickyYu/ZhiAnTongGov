//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

private let Identifier = "IndustrySelectCell"
//反向传值
protocol ParameterDelegate{
    func passParams(industrySelectModel: IndustrySelectModel)
}
//检查记录 选择行业检查表
class IndustryCheckListController: BaseTabViewController ,UISearchBarDelegate{
    
    var industrySelectModels  = [IndustrySelectModel]()
    var result = [IndustrySelectModel]()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    
    var delegate:ParameterDelegate!
    
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
        
        self.title = "检查记录-选择行业检查表"
        let nib = UINib(nibName: Identifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        tableView.rowHeight = 53;
       // tableView.tableFooterView = UIView()

        self.view.backgroundColor = UIColor.whiteColor()
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self  //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "请输入检查表名"
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
        if !AppTools.isEmpty(searchStr){
            parameters["hzTemplateCheckTable.title"] = searchStr
        }
        
        
        NetworkTool.sharedTools.loadIndustrySelect(parameters) { (datas, error,totalCount) in
            
            // 停止加载数据
            if self.refreshControl!.refreshing{
                self.refreshControl!.endRefreshing()
            }
            
            if error == nil{
                if self.currentPage>totalCount{
                    self.totalCount = totalCount!
                  //  self.showHint(LOAD_FINISH, duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                self.toLoadMore = false
               self.industrySelectModels += datas!
                
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
        return self.industrySelectModels.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! IndustrySelectCell
        if cell.isEqual(nil){
            cell = IndustrySelectCell(style: UITableViewCellStyle.Default, reuseIdentifier: Identifier)
        }
        let count = industrySelectModels.count ?? 0
        if count > 0 {
            let industrySelectModel = industrySelectModels[indexPath.row]
            cell.industrySelectModel = industrySelectModel
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
        print("searchTextStr = \(searchStr)")
        
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertVC = UIAlertController(title: "提示", message: "确定选择这张表", preferredStyle: UIAlertControllerStyle.Alert)
        let acSure = UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in

            if((self.delegate) != nil)
            {
                //调用里面的协议方法
            self.delegate.passParams(self.industrySelectModels[indexPath.row])
            self.navigationController?.popViewControllerAnimated(true)
            }
        }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            print("click Cancel")
        }
        alertVC.addAction(acSure)
        alertVC.addAction(acCancel)
        self.presentViewController(alertVC, animated: true, completion: nil)
        
    
        }
    
    
    func back()
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
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
        industrySelectModels.removeAll()
        industrySelectModels = [IndustrySelectModel]()
    }
}

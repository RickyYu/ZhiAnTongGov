//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

//企业查询列表界面
private let CpyInfoListReuseIdentifier = "CpyInfoCell"
class CpyInfoListExController:BaseTabViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //搜索控制器
    var countrySearchController = UISearchController()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    var cpyInfoModels  = [CpyInfoModel]()
    var result = [CpyInfoModel]()
    // 是否加载更多
    private var toLoadMore = false
    var searchStr : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //修改导航栏按钮颜色为白色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //修改导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = YMGlobalBlueColor()

        //修改导航栏按钮返回只有箭头
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;
        initPage()
    }
    
    private func initPage(){
        // 设置navigation
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(CpyInfoListController.back))

        // 设置tableview相关
        let nib = UINib(nibName: "CpyInfoCell",bundle: nil)
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
            controller.searchBar.placeholder = "请输入企业名称"
            self.tableView.tableHeaderView = controller.searchBar
            self.tableView.tableHeaderView?.backgroundColor = UIColor.whiteColor()
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
           return self.cpyInfoModels.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CpyInfoListReuseIdentifier, forIndexPath: indexPath) as! CpyInfoCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let count = cpyInfoModels.count ?? 0
        if count > 0 {
            let cpyInfoModel = cpyInfoModels[indexPath.row]
            cell.cpyInfoModel = cpyInfoModel
        }
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += 10
            getData()
        }
        return cell
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
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        
//        if segue.identifier == "toCpyInfoDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let str = cpyInfoModels[indexPath.row].companyName
//                self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: nil)
//                (segue.destinationViewController as! CpyInfoDetailController).titleStr = str
//            }
//        }
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = cpyInfoModels[indexPath.row]
        let controller = CpyInfoDetailController()
        controller.converyDataModel = object
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        cpyInfoModels.removeAll()
        cpyInfoModels = [CpyInfoModel]()
    }
    
}

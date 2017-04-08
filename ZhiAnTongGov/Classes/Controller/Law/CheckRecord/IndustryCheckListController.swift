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
    //是否为第一次访问
    var first :Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initPage()
        
    }
    //搜索控制器
   // var countrySearchController = UISearchController()
    var searchStr : String! = ""
    // 是否加载更多
    private var toLoadMore = false
    private func initPage(){
        first = true
        let rightBar = UIBarButtonItem(title: "区域选择", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.choiceArea))
        self.navigationItem.rightBarButtonItem = rightBar
        self.title = "检查记录-选择行业检查表"
        let nib = UINib(nibName: Identifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        tableView.rowHeight = 53;

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
    
        getDatas()
    }
    
    var secondAreaCode:String!
    var thirdAreaCode:String!
    var isCity:Bool = false
    func choiceArea(){
        first = false
        getChoiceArea(DEFAULT_AREA_ARRAY) { (area,areaArr) in
            self.secondAreaCode =  getSecondArea(areaArr[1])
            self.thirdAreaCode = getThirdArea(areaArr[2])
            self.alertNoticeWithCancel("市本级", message: "是否选择市本级", handlerSure: {
                self.reSet()
                self.getDatas()
                self.isCity = true
                }, handlerCancel: {
                self.isCity = false
                self.reSet()
                self.getDatas()
            })
        }
    }
    func getDatas(){
        var parameters = [String : AnyObject]()
        if !AppTools.isEmpty(searchStr){
            parameters["hzTemplateCheckTable.title"] = searchStr
        }
        
        if first {
           parameters["first"] = first
        }
        
        if secondAreaCode != nil {
            parameters["hzTemplateCheckTable.firstArea"] = FIRST_AREA_CODE
            parameters["hzTemplateCheckTable.secondArea"] = self.secondAreaCode
            parameters["hzTemplateCheckTable.thirdArea"] = self.thirdAreaCode
        
        }
        
        parameters["hzTemplateCheckTable.city"] = isCity
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount


        NetworkTool.sharedTools.loadIndustrySelect(parameters) { (datas, error,totalCount) in
            
            
            if error == nil{
                if self.currentPage>totalCount{
                    self.totalCount = totalCount!
                    self.showHint(LOAD_FINISH, duration: 2, yOffset: 0)
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
                
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }else{
                   self.showHint("\(error)", duration: 2, yOffset: 0)
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
        if count > 0 && indexPath.row == count-1 && !toLoadMore && totalCount>PAGE_SIZE{
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
        first = false
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
        totalCount = 0
         totalCount = 0
        // 重置数组
        industrySelectModels.removeAll()
        industrySelectModels = [IndustrySelectModel]()
    }
}

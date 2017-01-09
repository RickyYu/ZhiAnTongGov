//
//  mSDSInfoModelserverController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/1.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

//隐患列表和历史复查记录页面
private let Identifier = "ReviewInfoCell"
class HistoryRecordListController: UITableViewController {
    
    //信息列表
    var listLawmSDSInfoModels:NSMutableArray!

    //隐患列表数据
     var hiddenModels = [HiddenModel]()
    //历史复查记录数据
     var historyReviewModels = [HistoryReviewModel]()
    //接受传进来的值
    var converyJcjlId:Int!
    var converyDataStr : String?
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
    private var isHidden = true//true  加载隐患列表数据源  false 加载历史复查记录数据源
    override func viewDidLoad() {
        initPage()
    }
    
    private func initPage(){
   
        if converyDataStr == "隐患列表"{
            isHidden = true
        }else{
            isHidden = false
        }
        self.navigationItem.title = converyDataStr
        // 设置navigation
        self.navigationController?.navigationBar.hidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(InfoListController.back))
        // 设置tableview相关
        // tableView.registerClass(InfoDemoCell.self, forCellReuseIdentifier: InfoListReuseIdentifier)
        let nib = UINib(nibName: Identifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        
        tableView.rowHeight = 53;
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        
        
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
        parameters["produceLocaleNote.id"] = converyJcjlId
        if isHidden{
        NetworkTool.sharedTools.loadHideenTroubles(parameters) { (datas, error,totalCount) in
            // 停止加载数据
            if self.refreshControl!.refreshing{
                self.refreshControl!.endRefreshing()
            }
            
            if totalCount == 0{
                self.showHint("当前无数据", duration: 2, yOffset: 0)
                return
            }

            if error == nil{
                if self.currentPage>totalCount{
                    //self.showHint("已经到最后了", duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                self.toLoadMore = false
                self.hiddenModels += datas!
                self.tableView.reloadData()
            }else{
                
                // 获取数据失败后
                self.currentPage -= 10
                if self.toLoadMore{
                    self.toLoadMore = false
                }
                self.showHint("\(error)", duration: 2, yOffset: 0)
                
             }
            }
        }else{
            NetworkTool.sharedTools.loadHistoryProduces(parameters) { (datas, error,totalCount) in
                // 停止加载数据
                if self.refreshControl!.refreshing{
                    self.refreshControl!.endRefreshing()
                }
                
                
                if totalCount == 0{
                    self.showHint("当前无数据", duration: 2, yOffset: 0)
                    return
                }
                
                if self.currentPage>totalCount{
                  //  self.showHint("已经到最后了", duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                if error == nil{
                    self.toLoadMore = false
                    self.historyReviewModels += datas!
                    self.tableView.reloadData()
                }else{
                    
                    // 获取数据失败后
                    self.currentPage -= 10
                    if self.toLoadMore{
                        self.toLoadMore = false
                    }
                    self.showHint("\(error)", duration: 2, yOffset: 0)
                    
                }
            }
        
        
        }
    }
    
    func back()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    //返回节的个数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    //返回某个节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHidden{
            return hiddenModels.count ?? 0
        }else{
            return historyReviewModels.count ?? 0
        }
        
    }
    
    //为表视图单元格提供数据，该方法是必须实现的方法
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! ReviewInfoCell
        let count :Int
        if isHidden {
        count = hiddenModels.count ?? 0
        if count > 0 {
            let hiddenModel = hiddenModels[indexPath.row]
            cell.hiddenModel = hiddenModel
            }}else{
             count = historyReviewModels.count ?? 0
            if count > 0 {
                let historyReviewModel = historyReviewModels[indexPath.row]
                cell.historyReviewModel = historyReviewModel
            }
        }
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            // 这儿写自增, 竟然有警告, swift语言更新确实有点快, 我记得1.2的时候还是可以的
            currentPage += 10
            getDatas()
        }
        return cell
        
    }

    
    // Override to support conditional rearranging of the table view.
    //在编辑状态，可以拖动设置item位置
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    // MARK: - Navigation
    
    
    // MARK: - 内部控制方法
    /**
     重置数据
     */
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        if isHidden{
            hiddenModels.removeAll()
            hiddenModels = [HiddenModel]()
        }else{
            historyReviewModels.removeAll()
            historyReviewModels = [HistoryReviewModel]()
        }
        
    }
}



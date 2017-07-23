//
//  mSDSInfoModelserverController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/1.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

//信息查询MSDS查询列表界面
private let InfoMsdsListIdentifier = "InfoMsdsListIdentifier"
class InfoMsdsListController: BaseTabViewController {
    
    //信息列表
    var listLawmSDSInfoModels:NSMutableArray!
    var mSDSInfoModels = [MSDSInfoModel]()
    //接受传进来的值
    var detailItem: NSDictionary?
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
    var infoType :String!
    override func viewDidLoad() {
        initPage()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        self.tabBarController?.hidesBottomBarWhenPushed = true
//        self.automaticallyAdjustsScrollViewInsets = false
      
    }
    
    private func initPage(){
        if let detail : NSDictionary = self.detailItem {
            setNavagation((detail.objectForKey("name") as? String)!)
            //self.navigationItem.title = detail.objectForKey("name") as? String
            self.infoType = detail.objectForKey("value") as? String
        }
        // 设置navigation
        self.navigationController?.navigationBar.hidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(InfoListController.back))
        // 设置tableview相关
        // tableView.registerClass(InfoDemoCell.self, forCellReuseIdentifier: InfoListReuseIdentifier)
        let nib = UINib(nibName: "InfoDemoCell",bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: InfoMsdsListIdentifier)
        
        tableView.rowHeight = 53;
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        
        getLawLists()
    }
    
    func getLawLists(){

        var parameters = [String : AnyObject]()
        parameters["code"] = self.infoType
        parameters["pagination.pageSize"] = 10
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        
        NetworkTool.sharedTools.getMSDSInfo(parameters) { (mSDSInfoModels, error,totalCount) in

            if self.currentPage>totalCount{
                self.showHint("已经到最后了", duration: 2, yOffset: 0)
                self.currentPage -= 10
                return
            }
            if error == nil{
                self.toLoadMore = false
                self.mSDSInfoModels += mSDSInfoModels!
                self.tableView.reloadData()
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //        return listVideos.count
        return mSDSInfoModels.count ?? 0
    }
    
    //为表视图单元格提供数据，该方法是必须实现的方法
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(InfoMsdsListIdentifier, forIndexPath: indexPath) as! InfoDemoCell
        let count = mSDSInfoModels.count ?? 0
        if count > 0 {
            let mSDSInfoModel = mSDSInfoModels[indexPath.row]
            cell.mSDSInfoModel = mSDSInfoModel
        }
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            // 这儿写自增, 竟然有警告, swift语言更新确实有点快, 我记得1.2的时候还是可以的
            currentPage += 10
            getLawLists()
        }
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = InfoMsdsDetailController()
        let object : MSDSInfoModel = mSDSInfoModels[indexPath.row] as MSDSInfoModel
        controller.msdsInfoModel = object
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            mSDSInfoModels.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        if fromIndexPath != toIndexPath{
            let info = mSDSInfoModels[fromIndexPath.row]
            mSDSInfoModels.removeAtIndex(fromIndexPath.row)
            if toIndexPath.row > self.mSDSInfoModels.count{
                mSDSInfoModels.append(info)
            }else{
                mSDSInfoModels.insert(info, atIndex: toIndexPath.row)
            }
        }
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
         totalCount = 0
        mSDSInfoModels.removeAll()
        mSDSInfoModels = [MSDSInfoModel]()
    }
}



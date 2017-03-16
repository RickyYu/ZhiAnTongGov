//
//  mSDSInfoModelserverController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/1.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit


//隐患列表和历史复查记录页面
private let Identifier = "HiddenConfirmCell"
//反向传值
protocol HiddenParameterDelegate{
    func passParams(hiddenModels: [HiddenModel])
}
class HiddenConfirmListController: BaseTabViewController {

    //隐患列表数据
    var hiddenModels :[HiddenModel] = []
    //接受传进来的值
    var converyJcjlId:Int!
  
    var delegate:HiddenParameterDelegate!
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
    override func viewDidLoad() {
        initPage()
    }
    
    private func initPage(){

        self.navigationItem.title = "隐患列表"
        // 设置tableview相关
        // tableView.registerClass(InfoDemoCell.self, forCellReuseIdentifier: InfoListReuseIdentifier)
        let nib = UINib(nibName: Identifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        
        tableView.rowHeight = 53;
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        
        let rightBar = UIBarButtonItem(title: "检查", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.back))
        self.navigationItem.rightBarButtonItem = rightBar

        
        
        // 设置下拉刷新控件
        refreshControl = RefreshControl(frame: CGRectZero)
        refreshControl?.addTarget(self, action: #selector(self.getDatas), forControlEvents: .ValueChanged)
        refreshControl?.beginRefreshing()
        getDatas()
    }
    var isCheckHidden:Bool = false
    func getDatas(){
        if refreshControl!.refreshing{
            reSet()
            
        }
        var parameters = [String : AnyObject]()
        parameters["produceLocaleNote.id"] = converyJcjlId
        
        NetworkTool.sharedTools.loadHideenTroubles(parameters) { (datas, error,totalCount) in
            // 停止加载数据
            if self.refreshControl!.refreshing{
                self.refreshControl!.endRefreshing()
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
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
                
            }
        }
        
    }
    
    func back()
    {
        if((self.delegate) != nil)
        {
          self.delegate.passParams(self.hiddenModels)
        navigationController?.popViewControllerAnimated(true)
        }
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
            return hiddenModels.count ?? 0
    }
    

    //为表视图单元格提供数据，该方法是必须实现的方法
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! HiddenConfirmCell
        if cell.isEqual(nil){
            cell = HiddenConfirmCell(style: UITableViewCellStyle.Default, reuseIdentifier: Identifier)
        }
        let count :Int = hiddenModels.count
            if  count > 0 {
                let checkHidden = hiddenModels[indexPath.row]
                cell.hiddenModel = checkHidden
            }
      
        
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += 10
            getDatas()
        }
        return cell
        
    }
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if isCheckHidden{
//            let controller = NormalHiddenDetail()
//            controller.converyId = String(checkHiddenModels[indexPath.row].id)
//            self.navigationController?.pushViewController(controller, animated: true)
//            
//        }
//    }
    
    
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
      
            hiddenModels.removeAll()
            hiddenModels = [HiddenModel]()
        
    }
    

}



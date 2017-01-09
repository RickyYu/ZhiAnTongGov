//
//  GovReviewDetailController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/29.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
private let Identifier = "HandleTypeCell"
class GovReviewDetailController: BaseViewController,UITableViewDelegate,UITableViewDataSource  {

    var converyDataModel = PunishmentModel()
    var tableView: UITableView!
    let arrayData = ["初查记录", "隐患列表", "历史复查记录"]
    override func viewDidLoad() {
       super.viewDidLoad()
        self.navigationItem.title = "政府复查"
        initPage()
        initTableView()
        getDatas()
    }
    
    func initPage(){
        
        let customView1 = DetailCellView(frame:CGRectMake(0,66, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("是否生成复查表：")
       // customView1.setRTextField(dataModel.companyName ?? "")
        
        let customView2 = DetailCellView(frame:CGRectMake(0, 111, SCREEN_WIDTH, 45))
        customView2.setLabelName("复查时间：")
        customView2.setRRightLabel("")
        
        let customView3 = DetailCellView(frame:CGRectMake(0, 156, SCREEN_WIDTH, 45))
        customView3.setLabelName("复查人员：")
          customView3.setRRightLabel("")
      
        
        let customView4 = DetailCellView(frame:CGRectMake(0, 201, SCREEN_WIDTH, 45))
        
        customView4.setLabelName("复查编号：")
        customView4.setRTextField("")
        
        
        let customView5 = DetailCellView(frame:CGRectMake(0, 246, SCREEN_WIDTH, 45))
        customView5.setLabelName("现场图片：")
        customView5.setRCenterLabel("")
        
        self.view.addSubview(customView1)
        self.view.addSubview(customView2)
        self.view.addSubview(customView3)
        self.view.addSubview(customView4)
        self.view.addSubview(customView5)
    
    }
    
    
    func initTableView(){
        let tableView = UITableView(frame: CGRectMake(0, 475, SCREEN_WIDTH, 160), style: .Grouped)
        let headView = UIView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 1))
        headView.backgroundColor = UIColor.whiteColor()
        tableView.tableHeaderView = headView
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.headerViewForSection(0)
        tableView.rowHeight = 53
        tableView.scrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: Identifier,bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        //                      tableView.snp_makeConstraints { (make) in
        //                       make.top.equalTo(scrollView.snp_bottom)
        //                        }
        self.view.addSubview(tableView)
        
    }
    
    func getDatas(){
    
        var parameters = [String : AnyObject]()
        parameters["produceLocaleNote.id"] = self.converyDataModel.jcjlId

    }
    
    /**
     section 数量 方法
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    /**
     row 数量 方法
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    /**
     row的高度 方法
     */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! HandleTypeCell
        if cell.isEqual(nil){
            cell = HandleTypeCell(style: UITableViewCellStyle.Default, reuseIdentifier: Identifier)
        }
        let str  = arrayData[indexPath.row] as String
        cell.typeName.text = str
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let str : String = arrayData[indexPath.row] as String
        
        if indexPath.row == 0 {
            let  controller = CheckRecordDetailController()
            controller.converyJcjlId = self.converyDataModel.jcjlId
            self.navigationController?.pushViewController(controller, animated: true)
            
        }else{
            let  controller = HistoryRecordListController()
            controller.converyJcjlId = self.converyDataModel.jcjlId
            controller.converyDataStr = str
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
        
        
    }

}
//
//  SettingController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
import UsefulPickerView

private let Identifier = "HandleTypeCell"
class PunInfoController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {

    
    var customView6 : DetailCellView! = nil
    var customView8 : DetailCellView! = nil
    var tableView: UITableView!
    var scrollView: UIScrollView!
    var punData = ["罚款","警告","责令改正","没收违法所得","责令停产停业整顿","暂扣或则吊销有关","关闭","拘留","其它行政处罚"]
    //var conveyDataStr : String?
   // var conveyDataModel : PunishmentModel?
    var converyJcjlId :Int!
    var converyCompanyId:Int!
    var companyInfoModel  = CompanyInfoModel()
    let arrayData = ["初查记录", "隐患列表", "历史复查记录"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "行政处罚"
        self.view.backgroundColor = UIColor.whiteColor()
         getDatas()

        
    }

    
    func initPage(){
        
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 600))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 600)
        let customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("企业名称：")
        customView1.setRCenterLabel(companyInfoModel.companyName ?? "")
        
        let customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("企业地址：")
        customView2.setRCenterLabel(companyInfoModel.address ?? "")
        
        let customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("法定代表人：")
        customView3.setRCenterLabel(companyInfoModel.fdDelegate ?? "")
        
        
        
        let customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("处罚单位：")
        customView4.setRTextField("")
        
        let customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("处罚原因：")
           customView5.setRTextField("")
        
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("处罚类别")
        customView6.setRRightLabel("")
        customView6.addOnClickListener(self, action: #selector(self.choicePunType))
        
        
        let customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("处罚内容：")
         customView7.setRTextField("")
        
        customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("处罚时间：")
        customView8.setRCenterLabel("")
        customView8.addOnClickListener(self, action: #selector(self.choiceTimes))
        
        let customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("备注：")
        
        let  submitBtn = UIButton(frame:CGRectMake(80, 565, 200, 45))
        submitBtn.setTitle("提交", forState:.Normal)
        submitBtn.backgroundColor = YMGlobalDeapBlueColor()
        submitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtn.addTarget(self, action: #selector(self.submit), forControlEvents: UIControlEvents.TouchUpInside)
        
        
          self.scrollView.addSubview(customView1)
          self.scrollView.addSubview(customView2)
          self.scrollView.addSubview(customView3)
          self.scrollView.addSubview(customView4)
          self.scrollView.addSubview(customView5)
          self.scrollView.addSubview(customView6)
          self.scrollView.addSubview(customView7)
          self.scrollView.addSubview(customView8)
          self.scrollView.addSubview(customView9)
        self.scrollView.addSubview(submitBtn)
        self.view.addSubview(scrollView)
        
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
    /**
     tableViewCell方法
     */
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
              controller.converyJcjlId = self.converyJcjlId
             self.navigationController?.pushViewController(controller, animated: true)
        
        }else{
           let  controller = HistoryRecordListController()
             controller.converyJcjlId = converyJcjlId
             controller.converyDataStr = str
             self.navigationController?.pushViewController(controller, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)


    }
    
  

    func getDatas(){
        var parameters = [String : AnyObject]()
        parameters["company.id"] = self.converyCompanyId
        //行政处罚中获取企业信息
        NetworkTool.sharedTools.loadCompanyInfo(parameters) { (data, error) in
            
            if error == nil{
             self.companyInfoModel = data!
            }else{
             self.showHint("\(error)", duration: 2, yOffset: 0)
            }
            
            self.initPage()
            self.initTableView()
        
        }
    }
    


       func submit(sender: AnyObject) {
        var parameters = [String : AnyObject]()
        parameters["punishment.hzProduceLocaleNote.id"] = self.converyCompanyId
//        parameters["punishment.hzProduceLocaleNote.id"] = conveyDataStr
//        parameters["punishment.punishmentUnit"] = conveyDataStr
//        parameters["punishment.punishmentCause"] = conveyDataStr
//        parameters["punishment.punishmentType"] = conveyDataStr
//        parameters["punishment.punishmentTime"] = conveyDataStr
//        parameters["punishment.content"] = conveyDataStr
//        parameters["punishment.remark"] = conveyDataStr
//        parameters["punishState"] = conveyDataStr
        NetworkTool.sharedTools.submitPunishment(parameters) { (recordInfoModels, error) in
            
        }
    }
    
    func choicePunType(){
        UsefulPickerView.showSingleColPicker("请选择", data: punData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.customView6!.setRRightLabel(selectedValue)
        }
        
    }
    
    func choiceTimes(){
        UsefulPickerView.showSingleColPicker("请选择", data: punData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.customView8!.setRCenterLabel(selectedValue)
        }
        
    }
    
}


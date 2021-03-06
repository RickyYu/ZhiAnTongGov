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
class UnPunInfoController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {
    var customView1  = DetailCellView()
    var customView2  = DetailCellView()
    var customView3  = DetailCellView()
    var customView4  = DetailCellView()
    var customView5  = DetailCellView()
    var customView7  = DetailCellView()
    var customView8  = DetailCellView()
    var customView9  = DetailCellView()
    var customView6  = DetailCellView()
    var tableView: UITableView!
    var scrollView: UIScrollView!
    var punData = ["罚款","警告","责令改正","没收违法所得","责令停产停业整顿","暂扣或则吊销有关","关闭","拘留","其它行政处罚"]
    var converyJcjlId :Int!
    var converyCompanyId:String!
    var companyInfoModel  = CompanyInfoModel()
    let arrayData = ["初查记录", "隐患列表", "历史复查记录"]

    //如果是从CheckRecord页面进来则为true
    var isCheck:Bool = false
    var unit:String!
    var cause:String!
    var type:String!
    var typeCode:String!
    var time:String!
    var content:String!
    var remark:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavagation("行政处罚")
        initPage()
        getDatas()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.resignEdit(_:))))
    }

    override func resignEdit(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            customView4.textField.resignFirstResponder()
            customView5.textView.resignFirstResponder()
            customView7.textView.resignFirstResponder()
            customView9.textView.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    func initPage(){
        
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 600))
        //scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)
        customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("企业名称：")
       
        customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("企业地址：")
   
        customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("法定代表人：")
        
        customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("处罚单位：")
        customView4.setRTextField("")
        
        customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("处罚原因：")
        customView5.setMinTextViewShow()
        
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("处罚类别")
        customView6.setRRightLabel("警告")
        customView6.addOnClickListener(self, action: #selector(self.choicePunType))
        
        customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("处罚内容：")
        customView7.setMinTextViewShow()
        
        customView8 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView8.setLabelName("处罚时间：")
        getSystemTime { (time) in
            self.customView8.setRRightLabel(time)
        }
        customView8.setTimeImg()
        customView8.addOnClickListener(self, action: #selector(self.choiceHandleTimes))
        
        customView9 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView9.setLabelName("备注：")
        customView9.setMinTextViewShow()
        
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
        self.view.addSubview(scrollView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: #selector(self.submit))
        
        
    }
    
    func setDatas(){
        customView1.setRCenterLabel(companyInfoModel.companyName ?? "")
        customView2.setRCenterLabel(companyInfoModel.address ?? "")
        customView3.setRCenterLabel(companyInfoModel.fdDelegate ?? "")
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
            controller.isHidden =  true
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
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
            
            self.setDatas()
            self.initTableView()
        
        }
    }
    
       func submit(sender: AnyObject) {
        unit = customView4.textField.text!
        if AppTools.isEmpty(unit) {
            alert("处罚单位不可为空", handler: {
                self.customView4.textField.becomeFirstResponder()
            })
            return
        }
        cause = customView5.textView.text!
        if AppTools.isEmpty(cause) {
            alert("处罚原因不可为空", handler: {
                self.customView5.textView.becomeFirstResponder()
            })
            return
        }
        
        if cause.characters.count>200{
            alert("处罚原因最大输入200字!", handler: {
                self.customView4.textView.becomeFirstResponder()
            })
            return
        }
        
        
        type = customView6.rightLabel.text!
        typeCode = getPunType(type)
        if AppTools.isEmpty(type) {
            alert("处罚类别不可为空", handler: {
                
            })
            return
        }
        
        content = customView7.textView.text!
        if AppTools.isEmpty(content) {
            alert("处罚内容不可为空", handler: {
                self.customView7.textView.becomeFirstResponder()
            })
            return
        }
        
        if content.characters.count>200{
            alert("处罚内容最大输入200字!", handler: {
                self.customView4.textView.becomeFirstResponder()
            })
            return
        }
        
        time = customView8.rightLabel.text!
        if AppTools.isEmpty(time) {
            alert("处罚时间不可为空", handler: {
            })
            return
        }
        remark = customView9.textView.text!
        if AppTools.isEmpty(remark) {
            alert("备注不可为空", handler: {
                self.customView9.textView.becomeFirstResponder()
            })
            return
        }
        if remark.characters.count>200{
            alert("备注最大输入200字!", handler: {
                self.customView4.textView.becomeFirstResponder()
            })
            return
        }
        
        var parameters = [String : AnyObject]()
        parameters["punishment.hzProduceLocaleNote.id"] = self.converyJcjlId
        parameters["punishment.punishmentUnit"] = unit
        parameters["punishment.punishmentCause"] = cause
        parameters["punishment.punishmentType"] = typeCode
        parameters["punishment.punishmentTime"] = time
        parameters["punishment.content"] = content
        parameters["punishment.remark"] = remark
          parameters["punishState"] = true
        NetworkTool.sharedTools.submitPunishment(parameters) { (recordInfoModels, error) in
            if error == nil{
                self.showHint("完成处罚", duration: 2, yOffset: 0)
                // 获得视图控制器中的某一视图控制器
                
                if self.isCheck {
                    let viewController = self.navigationController?.viewControllers[1] as! RecordInfoListController
                    viewController.isRefresh = true
                    self.navigationController?.popToViewController(viewController , animated: true)
                    
                }else{
                    let viewController = self.navigationController?.viewControllers[0] as! LawPunListController
                    viewController.isRefresh = true
                    self.navigationController?.popToViewController(viewController , animated: true)
                    
                    
                }
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }
            }
        }
    }
    
    func choicePunType(){
        UsefulPickerView.showSingleColPicker("请选择", data: punData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.customView6.setRRightLabel(selectedValue)
        }
        
    }
    
    func choiceHandleTimes(){
        choiceTime { (time) in
            self.customView8.setRRightLabel(time)
            self.customView8.becomeFirstResponder()
        }
        
    }
    
}


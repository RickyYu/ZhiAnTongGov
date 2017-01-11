//
//  RecordHiddenNormalController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/4.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit

class RecordHiddenMajorController: BaseViewController {
    var converyModels = CheckListVo()
    var submitBtn = UIButton()
    var scrollView: UIScrollView!
     var recordDetailModel : RecordDetailModel!
    override func viewDidLoad() {
        initPage()
        

       

    }
     //隐患地址
     let address = ""
        //联系人
    let people = ""
    let phone  = ""
    let mobile = ""
    let hiddenDes = ""
    let plantTime = ""
    let governMoney = ""
   let chargePerson = ""
   let fillDate = ""
   let fillMan = ""
    func submit(){
         address = customView2.textField.text
        if AppTools.isEmpty(des) {
            alert("隐患地址不可为空", handler: {
                self.customView2.textField.becomeFirstResponder()
            })
            return
        }
        people = customView4.rightLabel.text
        if AppTools.isEmpty(people) {
            alert("联系人不可为空", handler: {
                self.customView4.textField.becomeFirstResponder()
            })
            return
        }
        phone = customView5.rightLabel.text
        if AppTools.isEmpty(phone) {
            alert("联系电话不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        
         mobile = customView6.rightLabel.text
        if AppTools.isEmpty(mobile) {
            alert("手机不可为空", handler: {
                self.customView6.textField.becomeFirstResponder()
            })
            return
        }
         hiddenDes = customView7.rightLabel.text
        if AppTools.isEmpty(hiddenDes) {
            alert("隐患基本情况不可为空", handler: {
                self.customView7.textField.becomeFirstResponder()
            })
            return
        }
        
        plantTime = customView16.rightLabel.text
        if AppTools.isEmpty(plantTime) {
            alert("计划完成治理时间不可为空", handler: {
                self.customView7.textField.becomeFirstResponder()
            })
            return
        }
        
        
        governMoney = customView17.textField.text
        if AppTools.isEmpty(plantTime) {
            alert("治理经费不可为空", handler: {
                self.customView17.textField.becomeFirstResponder()
            })
            return
        }
        
        chargePerson = customView18.textField.text
        if AppTools.isEmpty(plantTime) {
            alert("单位负责人不可为空", handler: {
                self.customView18.textField.becomeFirstResponder()
            })
            return
        }
        fillDate = customView19.rightLabel.text
        if AppTools.isEmpty(plantTime) {
            alert("录入时间不可为空", handler: {
                
            })
            return
        }
        
        fillMan = customView20.textField.text
        if AppTools.isEmpty(plantTime) {
            alert("填报人不可为空", handler: {
                
            })
            return
        }
       
        //先上传普通记录，再上传重大隐患
    
        
        
    }

    func submitMajorTrouble(){
        var parameters = [String : AnyObject]()
         parameters["danger.hzCompany.id"] = converyModels.companyId
         parameters["danger.noteId"] = converyModels.checkId
        //市级以上重点企业
         parameters["danger.emphasisProject"] = isMagorCpy
        //隐患地址
         parameters["danger.dangerAdd"] = address
        //隐患区域三级
         parameters["danger.firstArea"] = converyModels.companyId
         parameters["danger.secondArea"] = converyModels.companyId
         parameters["danger.thirdArea"] = converyModels.companyId
        //联系人
         parameters["danger.linkMan"] = people
         parameters["danger.linkTel"] = phone
         parameters["danger.linkMobile"] = mobile
         parameters["danger.description"] = hiddenDes
        
        parameters["danger.govCoordination"] = is2
        parameters["danger.partStopProduct"] = is3
        parameters["danger.fullStopProduct"] = is4
        parameters["danger.target"] = is5
        parameters["danger.resource"] = is6
        parameters["danger.safetyMethod"] = is7
        parameters["danger.goods"] = is8
        
        
        parameters["danger.finishDate"] = plantTime
        parameters["danger.governMoney"] = governMoney
        
        parameters["danger.chargePerson"] = chargePerson
        parameters["danger.fillDate"] = fillDate
        parameters["danger.fillMan"] = fillMan
        
       // parameters["file"] = converyModels.companyId
        NetworkTool.sharedTools.createDanger(parameters) { (data, error) in
        
        }
    
    }
    
    func initPage(){
        
        
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 950))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = false
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 950)
        
        
        submitBtn.setTitle("保存", forState:.Normal)
        submitBtn.backgroundColor = YMGlobalDeapBlueColor()
        submitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtn.addTarget(self, action: #selector(self.submit), forControlEvents: UIControlEvents.TouchUpInside)
        
        let customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("市级以上重点企业：")
        customView1.setRCheckBtn()
        customView1.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("隐患地址：")
        customView2.setRTextField( "")
        
        let customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("隐患区域：")
        customView3.setRCenterLabel("")
        
        
        
        let customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("联系人：")
        customView4.setRTextField( "")
        
        
        let customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("联系电话：")
        customView5.setRTextField( "")
        
        
        let customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("手机")
        customView6.setRTextField( "")
        
        
        let customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("隐患基本情况：")
        customView7.setRTextField( "") //ImagesInfo 字段
        
        let  customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("现场图片：")
        customView8.setRCenterLabel("")
        
        let customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("是否需要政府协调：")
        customView9.setRCheckBtn()
        customView9.rightCheckBtn.addTarget(self, action:#selector(tapped2(_:)), forControlEvents:.TouchUpInside)
        
        let customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("是否需要局部停产停业：")
        customView10.setRCheckBtn()
        customView10.rightCheckBtn.addTarget(self, action:#selector(tapped3(_:)), forControlEvents:.TouchUpInside)
        
        let customView11 = DetailCellView(frame:CGRectMake(0, 460, SCREEN_WIDTH, 45))
        customView11.setLabelName("是否需要全部停产停业：")
        customView11.setRCheckBtn()
        customView11.rightCheckBtn.addTarget(self, action:#selector(tapped4(_:)), forControlEvents:.TouchUpInside)
        
        let customView12 = DetailCellView(frame:CGRectMake(0, 505, SCREEN_WIDTH, 45))
        customView12.setLabelName("落实治理目标：")
        customView12.setRCheckBtn()
        customView12.rightCheckBtn.addTarget(self, action:#selector(tapped5(_:)), forControlEvents:.TouchUpInside)
        
        let customView13 = DetailCellView(frame:CGRectMake(0, 550, SCREEN_WIDTH, 45))
        customView13.setLabelName("落实治理机构人员：")
        customView13.setRCheckBtn()
        customView13.rightCheckBtn.addTarget(self, action:#selector(tapped6(_:)), forControlEvents:.TouchUpInside)
        
        let customView14 = DetailCellView(frame:CGRectMake(0, 595, SCREEN_WIDTH, 45))
        customView14.setLabelName("落实安全促使及应急预案：")
        customView14.setRCheckBtn()
        customView14.rightCheckBtn.addTarget(self, action:#selector(tapped7(_:)), forControlEvents:.TouchUpInside)
        
        let customView15 = DetailCellView(frame:CGRectMake(0, 640, SCREEN_WIDTH, 45))
        customView15.setLabelName("落实治理经费物资：")
        customView15.setRCheckBtn()
        customView15.rightCheckBtn.addTarget(self, action:#selector(tapped8(_:)), forControlEvents:.TouchUpInside)
        
        let customView16 = DetailCellView(frame:CGRectMake(0, 685, SCREEN_WIDTH, 45))
        customView16.setLabelName("计划完成治理时间：")
        customView16.setRRightLabel("")
        customView16.addOnClickListener(self, action: #selector(self.choicePlanTimes))
        
        let customView17 = DetailCellView(frame:CGRectMake(0, 730, SCREEN_WIDTH, 45))
        customView17.setLabelName("落实治理经费:(单位：万)")
        customView17.setRTextField( "")
        
        let customView18 = DetailCellView(frame:CGRectMake(0, 775, SCREEN_WIDTH, 45))
        customView18.setLabelName("单位负责人：")
        customView18.setRTextField( "")
        
        
        let customView19 = DetailCellView(frame:CGRectMake(0, 820, SCREEN_WIDTH, 45))
        customView20.setLabelName("录入时间：")
        getSystemTime { (time) in
            customView20.setRRightLabel(time)
        }
        
        let customView20 = DetailCellView(frame:CGRectMake(0, 865, SCREEN_WIDTH, 45))
        customView21.setLabelName("填报人：")
        customView21.setRTextField( "")
        
        
        
        
        
        
        self.scrollView.addSubview(customView1)
        self.scrollView.addSubview(customView2)
        self.scrollView.addSubview(customView3)
        self.scrollView.addSubview(customView4)
        self.scrollView.addSubview(customView5)
        self.scrollView.addSubview(customView6)
        self.scrollView.addSubview(customView7)
        self.scrollView.addSubview(customView8)
        self.scrollView.addSubview(customView9)
        self.scrollView.addSubview(customView10)
        self.scrollView.addSubview(customView11)

        self.scrollView.addSubview(customView12)
        self.scrollView.addSubview(customView13)
        self.scrollView.addSubview(customView14)
        self.scrollView.addSubview(customView15)
        self.scrollView.addSubview(customView16)
        self.scrollView.addSubview(customView17)
        self.scrollView.addSubview(customView18)
        self.scrollView.addSubview(customView19)
        self.scrollView.addSubview(customView20)
        
        self.view.addSubview(submitBtn)
        self.view.addSubview(scrollView)
        submitBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
        
        scrollView.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(120)
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(submitBtn.snp_top).offset(-5)
            make.right.equalTo(self.view.snp_right)
        }
        
        customView1.snp_makeConstraints { make in
            make.top.equalTo(self.scrollView.snp_top)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView2.snp_makeConstraints { make in
            make.top.equalTo(customView1.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView3.snp_makeConstraints { make in
            make.top.equalTo(customView2.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView4.snp_makeConstraints { make in
            make.top.equalTo(customView3.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView5.snp_makeConstraints { make in
            make.top.equalTo(customView4.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView6.snp_makeConstraints { make in
            make.top.equalTo(customView5.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView7.snp_makeConstraints { make in
            make.top.equalTo(customView6.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView8.snp_makeConstraints { make in
            make.top.equalTo(customView7.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView9.snp_makeConstraints { make in
            make.top.equalTo(customView8.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView10.snp_makeConstraints { make in
            make.top.equalTo(customView9.snp_bottom)
            make.left.equalTo(self.scrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
    
    }
    
    func choicePlanTimes(){
        choiceTime { (time) in
            self.customView16.setRRightLabel(time)
            self.customView16.becomeFirstResponder()
        }
        
    }
    
    
    func choiceTime(){
        let alertController:UIAlertController=UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        // 初始化 datePicker
        let datePicker = UIDatePicker( )
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.Date
        // 设置默认时间
        datePicker.date = NSDate()
        // 响应事件（只要滚轮变化就会触发）
        // datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default){
            (alertAction)->Void in
            //更新提醒时间文本框
            let formatter = NSDateFormatter()
            //日期样式
            formatter.dateFormat = "yyyy-MM-dd"
            //self.customView1.setRRightLabel(formatter.stringFromDate(datePicker.date))
            
            })
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel,handler:nil))
        
        alertController.view.addSubview(datePicker)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    //市级以上重点企业
    var isMagorCpy = false
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            isMagorCpy = true
            print("tapped1+\(button.selected)")
        }else{
            isMagorCpy = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    //是否需要政府协调
    var is2 = false
    func tapped2(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            is2 = true
            print("tapped1+\(button.selected)")
        }else{
            is2 = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    //是否需局部停产停业
    var is3 = false
    func tapped3(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            is3 = true
            print("tapped1+\(button.selected)")
        }else{
            is3 = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    //是否需全部停产停业
    var is4 = false
    func tapped4(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            is4 = true
            print("tapped1+\(button.selected)")
        }else{
            is4 = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    
    //落实治理目标
    var is5 = false
    func tapped5(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            is5 = true
        }else{
            is5 = false
        }
        
    }
    //落实治理机构人员
    var is6 = false
    func tapped6(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            is6 = true
        }else{
            is6 = false
        }
    }
    //落实安全促使及应急预案
    var is7 = false
    func tapped7(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            is7 = true
        }else{
            is7 = false
        }
    }
    //落实治理经费物资
    var is8 = false
    func tapped8(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            is8 = true
        }else{
            is8 = false
        }
    }
    

}

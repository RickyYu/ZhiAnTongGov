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
    
    var submitBtn = UIButton()
    var scrollView: UIScrollView!
     var recordDetailModel : RecordDetailModel!
    override func viewDidLoad() {
        initPage()
        

       

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
        submitBtn.addTarget(self, action: #selector(self.choiceModifyTimes), forControlEvents: UIControlEvents.TouchUpInside)
        
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
        customView9.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("是否需要局部停产停业：")
        customView10.setRCheckBtn()
        customView10.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView11 = DetailCellView(frame:CGRectMake(0, 460, SCREEN_WIDTH, 45))
        customView11.setLabelName("是否需要全部停产停业：")
        customView11.setRCheckBtn()
        customView11.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView12 = DetailCellView(frame:CGRectMake(0, 505, SCREEN_WIDTH, 45))
        customView12.setLabelName("落实治理目标：")
        customView12.setRCheckBtn()
        customView12.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView13 = DetailCellView(frame:CGRectMake(0, 550, SCREEN_WIDTH, 45))
        customView13.setLabelName("落实治理机构人员：")
        customView13.setRCheckBtn()
        customView13.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView14 = DetailCellView(frame:CGRectMake(0, 595, SCREEN_WIDTH, 45))
        customView14.setLabelName("落实安全促使及应急预案：")
        customView14.setRCheckBtn()
        customView14.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView15 = DetailCellView(frame:CGRectMake(0, 640, SCREEN_WIDTH, 45))
        customView15.setLabelName("落实治理经费物资：")
        customView15.setRCheckBtn()
        customView15.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        let customView16 = DetailCellView(frame:CGRectMake(0, 685, SCREEN_WIDTH, 45))
        customView16.setLabelName("计划完成治理时间：")
        customView16.setRRightLabel("")
        customView16.addOnClickListener(self, action: #selector(self.choiceModifyTimes))
        
        let customView17 = DetailCellView(frame:CGRectMake(0, 730, SCREEN_WIDTH, 45))
        customView17.setLabelName("落实治理经费:(单位：万)")
        customView17.setRTextField( "")
        
        let customView18 = DetailCellView(frame:CGRectMake(0, 775, SCREEN_WIDTH, 45))
        customView18.setLabelName("单位负责人：")
        customView18.setRTextField( "")
        
        let customView19 = DetailCellView(frame:CGRectMake(0, 820, SCREEN_WIDTH, 45))
        customView19.setLabelName("单位负责人：")
        customView19.setRTextField( "")
        
        
        let customView20 = DetailCellView(frame:CGRectMake(0, 865, SCREEN_WIDTH, 45))
        customView20.setLabelName("录入时间：")
        getSystemTime { (time) in
            customView20.setRRightLabel(time)
        }
        
        let customView21 = DetailCellView(frame:CGRectMake(0, 910, SCREEN_WIDTH, 45))
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
        self.scrollView.addSubview(customView21)
        
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
    
    func choiceModifyTimes(){
        choiceTime { (time) in
//            self.customView16.setRRightLabel(time)
//            self.customView16.becomeFirstResponder()
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
    
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            print("tapped1+\(button.selected)")
        }else{
            print("tapped1+\(button.selected)")
            
        }
        
    }
}

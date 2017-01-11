//
//  RecordHiddenNormalController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/4.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit
import UsefulPickerView

class RecordHiddenNormalController: BaseViewController {
    
    var str : String = ""
    var converyModels = CheckListVo()
    //责令整改日期
    var customView1  = DetailCellView()
    //发送整改通知书
    var customView2 = DetailCellView()
    //存在隐患
    var customView3 = DetailCellView()
    
    //责令整改日期
    var customView4  = DetailCellView()
    //发送整改通知书
    var customView5 = DetailCellView()
    //存在隐患
    var customView6 = DetailCellView()
    
    var submitBtn = UIButton()
    
     let singleData = ["人", "物", "管理"]
    
    override func viewDidLoad() {
     initPage()
    
    }
    
    func initPage(){
        
        submitBtn.setTitle("保存", forState:.Normal)
        submitBtn.backgroundColor = YMGlobalDeapBlueColor()
        submitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtn.addTarget(self, action: #selector(self.submit), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        customView1.setLabelName("隐患类别：")
        customView1.setRRightLabel("")
        customView1.addOnClickListener(self, action: #selector(self.hiddenType))
        
        customView2.setLabelName("隐患描述：")
        customView2.setRTextField( "")
        
        customView3.setLabelName("现场图片：")
        customView3.setRRightLabel("")
      
        
        customView4.setLabelName("计划整改时间：")
        customView4.setRRightLabel("")
        customView4.addOnClickListener(self, action: #selector(self.choicePlanTime))
        
        customView5.setLabelName("录入时间：")
        getSystemTime({ (time) in
          self.customView5.setRCenterLabel(time)
        })

        
        customView6 =  DetailCellView(frame:CGRectMake(0, 420, SCREEN_WIDTH, 45))
        customView6.setLabelName("是否整改：")
        customView6.setRCheckBtn()
        customView6.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        
        
        self.view.addSubview(submitBtn)
        self.view.addSubview(customView1)
        self.view.addSubview(customView2)
        self.view.addSubview(customView3)
        self.view.addSubview(customView4)
        self.view.addSubview(customView5)
        self.view.addSubview(customView6)
        
        
        customView1.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(120)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView2.snp_makeConstraints { make in
            make.top.equalTo(self.customView1.snp_bottom).offset(15)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView3.snp_makeConstraints { make in
            make.top.equalTo(self.customView2.snp_bottom).offset(15)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView4.snp_makeConstraints { make in
            make.top.equalTo(self.customView3.snp_bottom).offset(15)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView5.snp_makeConstraints { make in
            make.top.equalTo(self.customView4.snp_bottom).offset(15)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
//        customView6.snp_makeConstraints { make in
//            make.top.equalTo(self.customView5.snp_bottom).offset(15)
//            make.left.equalTo(self.view.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
        
     

        submitBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
    
    }
    
    func submit(){
        let type = customView1.rightLabel.text
        let des = customView2.textField.text
        if AppTools.isEmpty(des) {
            alert("隐患描述不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        let planTime = customView4.rightLabel.text
        if AppTools.isEmpty(planTime) {
            alert("计划整改时间不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        
        
    
        
        
    
    }
    
    func submitGeneralTrouble(){
        var parameters = [String : AnyObject]()
        
        
        parameters["nomalDanger.hzCompany.id"] = converyModels.companyId
        
        parameters["produceLocaleNote.id"] = converyModels.checkId
        
        parameters["nomalDanger.linkMan"] = converyModels.lxr
        
        parameters["nomalDanger.linkManPhone"] = converyModels.phone
        
        parameters["nomalDanger.danger"] = true
        parameters["nomalDanger.type"] = type
        parameters["nomalDanger.content"] = des
        parameters["nomalDanger.cleanUp"] = isReform
        
        
        
        parameters["nomalDanger.governDate"] = planTime
        // parameters["deletedIds"] = converyModels.phone
        parameters["file"] = converyModels.phone
        NetworkTool.sharedTools.createHiddenTrouble(parameters) { (data, error) in
            //上传完后再上传之前的记录
        }
    }
    
    var isReform :Bool  = false//是否整改
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            isReform = true
            print("tapped1+\(button.selected)")
        }else{
            isReform = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    
    func hiddenType(){
    
        UsefulPickerView.showSingleColPicker("请选择", data: singleData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.customView1.setRRightLabel(selectedValue)
        }
        
    }
    
    func choicePlanTime(){
        choiceTime { (time) in
            self.customView4.setRRightLabel(time)
            self.customView4.becomeFirstResponder()
        }
        
    }
}

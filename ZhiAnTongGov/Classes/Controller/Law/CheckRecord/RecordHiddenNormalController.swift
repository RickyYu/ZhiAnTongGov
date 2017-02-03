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
import SwiftyJSON

class RecordHiddenNormalController: PhotoViewController {
    

    var normalType : String = ""
    var normalTypeCode : String = ""
    var normalDes : String = ""
    var normalPlanTime : String = ""
    var converyModels : CheckListVo!
    //责令整改日期
    var customView1normal  = DetailCellView()
    //发送整改通知书
    var customView2normal = DetailCellView()
    //存在隐患
    var customView3normal = DetailCellView()
    
    //责令整改日期
    var customView4normal  = DetailCellView()
    //发送整改通知书
    var customView5normal = DetailCellView()
    //存在隐患
    var customView6normal = DetailCellView()
    var normalIsReform :Bool  = false//是否整改
    var submitBtnnormal = UIButton()
    let singleDatanormal = ["人", "物", "管理"]
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "一般隐患"
        initNormalPage()

    }

    func initNormalPage(){

        submitBtnnormal.setTitle("保存", forState:.Normal)
        submitBtnnormal.backgroundColor = YMGlobalDeapBlueColor()
        submitBtnnormal.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtnnormal.addTarget(self, action: #selector(self.normalSubmit), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        customView1normal.setLabelName("隐患类别：")
        customView1normal.setRRightLabel("物")
        customView1normal.addOnClickListener(self, action: #selector(self.normalHiddenType))
        
        customView2normal.setLabelName("隐患描述：")
        customView2normal.setRTextField( "")

        customView3normal.setLabelName("计划整改时间：")
        customView3normal.setRRightLabel("")
        customView3normal.setTimeImg()
        customView3normal.addOnClickListener(self, action: #selector(self.normalChoicePlanTime))
        
        customView4normal.setLabelName("录入时间：")
        getSystemTime({ (time) in
          self.customView4normal.setRCenterLabel(time)
        })
        customView4normal.setTimeImg()
        
        customView5normal =  DetailCellView(frame:CGRectMake(0, 235, SCREEN_WIDTH, 45))
        customView5normal.setLabelName("是否整改：")
        customView5normal.setRCheckBtn()
        customView5normal.rightCheckBtn.addTarget(self, action:#selector(normalTapped1(_:)), forControlEvents:.TouchUpInside)
        
        customView6normal.setLabelName("现场图片：")
        customView6normal.setRRightLabel("")
        customView6normal.addOnClickListener(self, action: #selector(self.choiceNormalImage))
        initNormalPhoto()
        
        self.view.addSubview(submitBtnnormal)
        self.view.addSubview(customView1normal)
        self.view.addSubview(customView2normal)
        self.view.addSubview(customView3normal)
        self.view.addSubview(customView4normal)
        self.view.addSubview(customView5normal)
        self.view.addSubview(customView6normal)

        
        
        customView1normal.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(64)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView2normal.snp_makeConstraints { make in
            make.top.equalTo(self.customView1normal.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView3normal.snp_makeConstraints { make in
            make.top.equalTo(self.customView2normal.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView4normal.snp_makeConstraints { make in
            make.top.equalTo(self.customView3normal.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
//        customView5normal.snp_makeConstraints { make in
//            make.top.equalTo(self.customView4normal.snp_bottom)
//            make.left.equalTo(self.view.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
        
        customView6normal.snp_makeConstraints { make in
            make.top.equalTo(self.customView5normal.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }

        submitBtnnormal.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
    
    }
   
    
    func initNormalPhoto(){
        setLoc(0, y: 325)
        checkNeedAddButton()
        renderView()
        self.view.addSubview(containerView)
        containerView.hidden = true
    }
    
    func choiceNormalImage(){
        containerView.hidden = false
    }
    
    func normalSubmit(){
    
        normalType = customView1normal.rightLabel.text!
        normalTypeCode = getTroubleType(normalType)
        normalDes = customView2normal.textField.text!
        if AppTools.isEmpty(normalDes) {
            alert("隐患描述不可为空", handler: {
                self.customView5normal.textField.becomeFirstResponder()
            })
            return
        }
        normalPlanTime = customView3normal.rightLabel.text!
        if AppTools.isEmpty(normalPlanTime) {
            alert("计划整改时间不可为空", handler: {
                self.customView3normal.textField.becomeFirstResponder()
            })
            return
        }
        
        alertNotice("提示", message: "确认提交后，本次检查信息及隐患无法再更改") {
            self.submitCheck()
        }

    }

    func normalTapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            normalIsReform = true
            print("tapped1+\(button.selected)")
        }else{
            normalIsReform = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    
    func normalHiddenType(){
    
        UsefulPickerView.showSingleColPicker("请选择", data: singleDatanormal, defaultSelectedIndex: 1) {[unowned self] (selectedIndex, selectedValue) in
            self.customView1normal.setRRightLabel(selectedValue)
        }
        
    }
    
    func normalChoicePlanTime(){
        choiceTime { (time) in
            self.customView3normal.setRRightLabel(time)
            self.customView3normal.becomeFirstResponder()
        }
        
    }
    
    func submitCheck(){
        var parameters = [String : AnyObject]()
        parameters["produceLocaleNote.hzCompany.id"] = converyModels.companyId
        
        parameters["produceLocaleNote.checkTimeBegin"] = converyModels.checktime
        
        parameters["produceLocaleNote.checkGround"] = converyModels.place
        
        parameters["produceLocaleNote.fdDelegateLink"] = converyModels.phone
        
        if !converyModels.listCb.isEmpty{
            parameters["gridIds"] = JSON(arrayLiteral: converyModels.listCb).string
        }
        
        parameters["produceLocaleNote.noter"] = converyModels.people
        
        parameters["produceLocaleNote.executeUnit"] = converyModels.law
        print(converyModels.zgtime)
        if !converyModels.zgtime.isEmpty{
            parameters["hzProduceCleanUp.cleanUpTimeLimit"] = converyModels.zgtime
        }
        
        if !converyModels.nowcontent.isEmpty{
            parameters["produceLocaleNote.content"] = converyModels.nowcontent
        }
        if(!converyModels.checkId.isEmpty){
            parameters["hzTemplateCheckTable.id"] = converyModels.checkId
        }
        if !converyModels.listHy.isEmpty{
            var array = [String]()
            for i in 0..<converyModels.listHy.count{
                do{ //转化为JSON 字符串
                    let data = try NSJSONSerialization.dataWithJSONObject(converyModels.listHy[i].getParams1(), options: .PrettyPrinted)
                    array.append(NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
                    print(NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
                }catch{
                    
                }
            }
            let temp = array.joinWithSeparator(",")
            let tempStr = "["+temp+"]"
            print(tempStr)
            parameters["hzCompanyCheckTableInfosJson"] = tempStr
            
        }
        
        parameters["produceLocaleNote.sendCleanUp"] = String(Int(converyModels.check))
        
        print("parameters = \(parameters)")
        print("converyModels.listfile = \(converyModels.listfile)")
        
        NetworkTool.sharedTools.createCheckRecordImage(parameters,imageArrays: converyModels.listfile,finished: { (data, error,notedId) in
            if error == nil{
                self.showHint("添加成功", duration: 1, yOffset: 0)
                self.notedIdStr = notedId
                self.submitGeneralTrouble()
                
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }
            }
            
        })

        
}
    var notedIdStr:String = ""
    //上传一般隐患，等新增上传完毕后上传
    func submitGeneralTrouble(){
        var parameters = [String : AnyObject]()
        parameters["nomalDanger.hzCompany.id"] = converyModels.companyId
        parameters["produceLocaleNote.id"] = notedIdStr
        parameters["nomalDanger.linkMan"] = converyModels.lxr
        parameters["nomalDanger.linkManPhone"] = converyModels.phone
        parameters["nomalDanger.danger"] = String(Int(true))
        parameters["nomalDanger.type"] = normalTypeCode
        parameters["nomalDanger.content"] = normalDes
        parameters["nomalDanger.cleanUp"] = String(Int(normalIsReform))
        parameters["nomalDanger.governDate"] = normalPlanTime
        NetworkTool.sharedTools.createHiddenTrouble(parameters,imageArrays: getListImage()) { (data, error) in
            if error == nil{
                self.showHint("添加成功", duration: 1, yOffset: 0)
                let viewController = self.navigationController?.viewControllers[1] as! RecordInfoListController
                viewController.isRefresh = true
                self.navigationController?.popToViewController(viewController , animated: true)

                
            }else{
                self.showHint("\(error!)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }
            }
        }
    }
}

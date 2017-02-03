//
//  TestController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/20.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit
import UsefulPickerView
import SwiftyJSON
class TestController: PhotoViewController {
    
    var normalType : String = ""
    var normalTypeCode : String = ""
    var normalDes : String = ""
    var normalPlanTime : String = ""
    var converyModels : CheckListVo!
    var normalScrollView: UIScrollView!
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
    var buttonNormal = UIButton()
    var buttonMajor = UIButton()
    let singleDatanormal = ["人", "物", "管理"]

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        //搜索按钮
        let button1 = UIButton(frame:CGRectMake(0, 0, 36, 36))
        button1.setImage(UIImage(named: "daily_mgr_selected"), forState: .Normal)
        button1.addTarget(self,action:#selector(TestController.tapped1),forControlEvents:.TouchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        
        //设置按钮
        let button2 = UIButton(frame:CGRectMake(0, 0, 36, 36))
        button2.setImage(UIImage(named: "daily_mgr_selected"), forState: .Normal)
        button2.addTarget(self,action:#selector(TestController.tapped2),forControlEvents:.TouchUpInside)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                  action: nil)
        gap.width = 15;
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10;
        
        //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [spacer,barButton2,gap,barButton1]
        
//  
//        alertNotice("提示", message: "你好") {
//            print("123")
//        }
//        
//        buttonNormal = UIButton(frame:CGRectMake(0, 64, SCREEN_WIDTH/2, 30))
//        buttonNormal.setTitle("一般隐患", forState:.Normal)
//        buttonNormal.backgroundColor = YMGlobalDeapBlueColor()
//        buttonNormal.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
//        buttonNormal.addTarget(self, action: #selector(self.showNormal), forControlEvents: UIControlEvents.TouchUpInside)
//        buttonNormal.setTitleColor(YMGlobalBlueColor(),forState: .Normal) //普通状态下文字的颜色
// 
//        
//        buttonMajor = UIButton(frame:CGRectMake(SCREEN_WIDTH/2, 64, SCREEN_WIDTH/2, 30))
//        buttonMajor.setTitle("重大隐患", forState:.Normal)
//        buttonMajor.backgroundColor = YMGlobalDeapBlueColor()
//        buttonMajor.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
//        buttonMajor.addTarget(self, action: #selector(self.showMajor), forControlEvents: UIControlEvents.TouchUpInside)
//        buttonMajor.setTitleColor(UIColor.grayColor(),forState: .Normal) //普通状态下文字的颜色
//
// 
//         self.view.addSubview(buttonNormal)
//         self.view.addSubview(buttonMajor)
        
        //选项除了文字还可以是图片
//        let items=["一般隐患","重大隐患"] as [AnyObject]
//        let segmented=UISegmentedControl(items:items)
//        segmented.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40)
//        segmented.selectedSegmentIndex=0 //默认选中第二项
//       // segmented.setImage(UIImage(named:"icon"),forSegmentAtIndex:2)
//        segmented.addTarget(self, action: #selector(self.segmentDidchange(_:)),
//                            forControlEvents: UIControlEvents.ValueChanged)  //添加值改变监听
//        self.view.addSubview(segmented)
    //   initNormalPage()
    }
//    func segmentDidchange(segmented:UISegmentedControl){
//        //获得选项的索引
//        print(segmented.selectedSegmentIndex)
//        //获得选择的文字
//        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
//        if segmented.selectedSegmentIndex == 0{
//
//            normalScrollView.hidden = false
//            
//        }else{
//            normalScrollView.hidden = true
//            
//        }
//    }
    
    func tapped1(){
        print("搜索按钮点击")
    }
    
    func tapped2(){
        print("设置按钮点击")
    }
    
    func initNormalPage(){
        
        normalScrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, SCREEN_HEIGHT))
        normalScrollView!.pagingEnabled = true
        normalScrollView.backgroundColor = UIColor.redColor()
        normalScrollView!.scrollEnabled = true
        normalScrollView!.showsHorizontalScrollIndicator = true
        normalScrollView!.showsVerticalScrollIndicator = false
        normalScrollView!.scrollsToTop = true
        normalScrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 901)
        
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
        customView3normal.addOnClickListener(self, action: #selector(self.normalChoicePlanTime))
        
        customView4normal.setLabelName("录入时间：")
        getSystemTime({ (time) in
            self.customView4normal.setRCenterLabel(time)
        })
        
        customView5normal =  DetailCellView(frame:CGRectMake(0, 235, SCREEN_WIDTH, 45))
        customView5normal.setLabelName("是否整改：")
        customView5normal.setRCheckBtn()
        customView5normal.rightCheckBtn.addTarget(self, action:#selector(normalTapped1(_:)), forControlEvents:.TouchUpInside)
        
        customView6normal.setLabelName("现场图片：")
        customView6normal.setRRightLabel("")
        customView6normal.addOnClickListener(self, action: #selector(self.choiceNormalImage))
        initNormalPhoto()
        
        self.normalScrollView.addSubview(submitBtnnormal)
        self.normalScrollView.addSubview(customView1normal)
        self.normalScrollView.addSubview(customView2normal)
        self.normalScrollView.addSubview(customView3normal)
        self.normalScrollView.addSubview(customView4normal)
        self.normalScrollView.addSubview(customView5normal)
        self.normalScrollView.addSubview(customView6normal)
        
        
        self.view.addSubview(normalScrollView)
        
//        
//        customView1normal.snp_makeConstraints { make in
//            make.top.equalTo(self.view.snp_top).offset(120)
//            make.left.equalTo(self.view.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
//        
//        customView2normal.snp_makeConstraints { make in
//            make.top.equalTo(self.customView1normal.snp_bottom)
//            make.left.equalTo(self.view.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
//        
//        customView3normal.snp_makeConstraints { make in
//            make.top.equalTo(self.customView2normal.snp_bottom)
//            make.left.equalTo(self.view.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
//        
//        customView4normal.snp_makeConstraints { make in
//            make.top.equalTo(self.customView3normal.snp_bottom)
//            make.left.equalTo(self.view.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
//        
//        //        customView5normal.snp_makeConstraints { make in
//        //            make.top.equalTo(self.customView4normal.snp_bottom)
//        //            make.left.equalTo(self.view.snp_left)
//        //            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        //        }
//        
//        customView6normal.snp_makeConstraints { make in
//            make.top.equalTo(self.customView5normal.snp_bottom)
//            make.left.equalTo(self.view.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
//        
//        submitBtnnormal.snp_makeConstraints { make in
//            make.bottom.equalTo(self.view.snp_bottom)
//            make.left.equalTo(self.view.snp_left).offset(50)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
//        }
        
    }
    
    
    func initNormalPhoto(){
        setLoc(0, y: 380)
        checkNeedAddButton()
        renderView()
        self.view.addSubview(containerView)
        containerView.hidden = true
    }
    
    func choiceNormalImage(){
        containerView.hidden = false
    }
    
    func showNormal(){
        
   // self.normalScrollView.hidden = false
        buttonNormal.setTitleColor(YMGlobalBlueColor(),forState: .Normal) //普通状态下文字的颜色
        buttonMajor.setTitleColor(UIColor.grayColor(),forState: .Normal) //普通状态下文字的颜色
    }
    
    func showMajor(){
       // self.normalScrollView.hidden = true
        buttonMajor.setTitleColor(YMGlobalBlueColor(),forState: .Normal) //普通状态下文字的颜色
        buttonNormal.setTitleColor(UIColor.grayColor(),forState: .Normal) //普通状态下文字的颜色

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
        
        let alertVC = UIAlertController(title: "提示", message: "确认提交后，本次检查信息及隐患无法再更改", preferredStyle: UIAlertControllerStyle.Alert)
        let acSure = UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in
            
            self.submitCheck()
        }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            print("click Cancel")
        }
        alertVC.addAction(acSure)
        alertVC.addAction(acCancel)
        self.presentViewController(alertVC, animated: true, completion: nil)
        
        
        
        
        
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
        
 
        
        
    }
    //上传一般隐患，等新增上传完毕后上传
    func submitGeneralTrouble(){
        var parameters = [String : AnyObject]()
        parameters["nomalDanger.hzCompany.id"] = converyModels.companyId
        parameters["produceLocaleNote.id"] = converyModels.checkId
        parameters["nomalDanger.linkMan"] = converyModels.lxr
        parameters["nomalDanger.linkManPhone"] = converyModels.phone
        parameters["nomalDanger.danger"] = String(Int(true))
        parameters["nomalDanger.type"] = normalTypeCode
        parameters["nomalDanger.content"] = normalDes
        parameters["nomalDanger.cleanUp"] = String(Int(normalIsReform))
        parameters["nomalDanger.governDate"] = normalPlanTime
  
    }

}

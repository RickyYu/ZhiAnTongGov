//
//  RecordHiddenNormalController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/4.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class RecordHiddenMajorController: PhotoViewController {
     var converyModels : CheckListVo!
     var majorSubmitBtn = UIButton()
     var majorScrollView: UIScrollView!
     var majorRecordDetailModel : RecordDetailModel!
    
    var hiddenId:String!
    var majorHidden:MajorCheckInfoModel!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        setNavagation("重大隐患查看")
        majorInitPage()
        if hiddenId != nil{
         getDatas()
        }
    }
     //隐患地址
     var majorAddress = ""
        //联系人
    var majorPeople = ""
    var majorPhone  = ""
    var majorMobile = ""
    var majorHiddenDes = ""
    var majorPlantTime = ""
    var majorGovernMoney = ""
    var majorChargePerson = ""
    var majorFillDate = ""
    var majorFillMan = ""
    var customView1  = DetailCellView()
    var customView2  = DetailCellView()
    var customView3  = DetailCellView()
    var customView4  = DetailCellView()
    var customView5  = DetailCellView()
    var customView6  = DetailCellView()
    var customView7  = DetailCellView()
    var customView8  = DetailCellView()
    var customView9  = DetailCellView()
    var customView10  = DetailCellView()
    var customView11  = DetailCellView()
    var customView12  = DetailCellView()
    var customView13  = DetailCellView()
    var customView14  = DetailCellView()
    var customView15  = DetailCellView()
    var customView16  = DetailCellView()
    var customView17  = DetailCellView()
    var customView18  = DetailCellView()
    var customView19  = DetailCellView()
    var customView20  = DetailCellView()
    
    func getDatas(){
        var parameters = [String : AnyObject]()
        parameters["danger.id"] = hiddenId
        
        NetworkTool.sharedTools.loadDanger(parameters) { (data, error) in
            if error == nil{
                self.majorHidden = data
                self.setData()
                
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
        }
    }
    
    func setData(){
    customView1.rightCheckBtn.selected = majorHidden.emphasisProject
    customView2.setRTextField(majorHidden.dangerAdd)
    customView2.textField.enabled = false
    
        let address:String = "湖州市"+getSecondArea(String(majorHidden.secondArea))+getThirdArea(String(majorHidden.thirdArea))
        customView3.setRTextField(address)
        customView3.textField.enabled = false
        
        customView4.setRTextField(majorHidden.linkMan)
        customView4.textField.enabled = false
        
        customView5.setRTextField(majorHidden.linkTel)
        customView5.textField.enabled = false
        
        customView6.setRTextField(majorHidden.linkMobile)
        customView6.textField.enabled = false
        
        customView7.setRTextField(majorHidden.descriptions)
        customView7.textField.enabled = false
        
       customView9.rightCheckBtn.selected = majorHidden.govCoordination
        customView10.rightCheckBtn.selected = majorHidden.partStopProduct
        customView11.rightCheckBtn.selected = majorHidden.fullStopProduct
        customView12.rightCheckBtn.selected = majorHidden.target
        customView13.rightCheckBtn.selected = majorHidden.resource
        customView14.rightCheckBtn.selected = majorHidden.goods
        customView15.rightCheckBtn.selected = majorHidden.safetyMethod

        
        customView16.setRTextField(String(majorHidden.finishDate))
        customView16.textField.enabled = false
        
        customView17.setRTextField(String(majorHidden.governMoney))
        customView17.textField.enabled = false
        
        customView18.setRTextField(majorHidden.chargePerson)
        customView18.textField.enabled = false
        
        customView19.setRTextField(majorHidden.fillDate)
        customView19.textField.enabled = false
        
        customView20.setRTextField(majorHidden.fillMan)
        customView20.textField.enabled = false
        
  
    }
    
    func submit(){
         majorAddress = customView2.textField.text!
        if AppTools.isEmpty(majorAddress) {
            alert("隐患地址不可为空", handler: {
                self.customView2.textField.becomeFirstResponder()
            })
            return
        }
        majorPeople = customView4.textField.text!
        if AppTools.isEmpty(majorPeople) {
            alert("联系人不可为空", handler: {
                self.customView4.textField.becomeFirstResponder()
            })
            return
        }
        majorPhone = customView5.textField.text!
        if AppTools.isEmpty(majorPhone) {
            alert("联系电话不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        
         majorMobile = customView6.textField.text!
        if AppTools.isEmpty(majorMobile) {
            alert("手机不可为空", handler: {
                self.customView6.textField.becomeFirstResponder()
            })
            return
        }
         majorHiddenDes = customView7.textField.text!
        if AppTools.isEmpty(majorHiddenDes) {
            alert("隐患基本情况不可为空", handler: {
                self.customView7.textField.becomeFirstResponder()
            })
            return
        }
        
        majorPlantTime = customView16.rightLabel.text!
        if AppTools.isEmpty(majorPlantTime) {
            alert("计划完成治理时间不可为空", handler: {
                self.customView7.textField.becomeFirstResponder()
            })
            return
        }
        
        
        majorGovernMoney = customView17.textField.text!
        if AppTools.isEmpty(majorGovernMoney) {
            alert("治理经费不可为空", handler: {
                self.customView17.textField.becomeFirstResponder()
            })
            return
        }
        
        majorChargePerson = customView18.textField.text!
        if AppTools.isEmpty(majorChargePerson) {
            alert("单位负责人不可为空", handler: {
                self.customView18.textField.becomeFirstResponder()
            })
            return
        }
        majorFillDate = customView19.rightLabel.text!
        if AppTools.isEmpty(majorFillDate) {
            alert("录入时间不可为空", handler: {
                
            })
            return
        }
        
        majorFillMan = customView20.textField.text!
        if AppTools.isEmpty(majorFillMan) {
            alert("填报人不可为空", handler: {
                
            })
            return
        }
       
        
        alertNotice("提示", message: "确认提交后，本次检查信息及隐患无法再更改") {
            self.submitCheck()
        }
    }

 
    
    func majorInitPage(){
        
        
        majorScrollView = UIScrollView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 950))
        majorScrollView!.pagingEnabled = true
        majorScrollView!.scrollEnabled = true
        majorScrollView!.showsHorizontalScrollIndicator = true
        majorScrollView!.showsVerticalScrollIndicator = false
        majorScrollView!.scrollsToTop = true
        majorScrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 950)
        
        
        majorSubmitBtn.setTitle("保存", forState:.Normal)
        majorSubmitBtn.backgroundColor = YMGlobalDeapBlueColor()
        majorSubmitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        majorSubmitBtn.addTarget(self, action: #selector(self.submit), forControlEvents: UIControlEvents.TouchUpInside)
        if hiddenId != nil {
         majorSubmitBtn.hidden = true
        }
        
        customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("市级以上重点企业：")
        customView1.setLabelMax()
        customView1.setRCheckBtn()
        customView1.rightCheckBtn.addTarget(self, action:#selector(majortapped1(_:)), forControlEvents:.TouchUpInside)
        
         customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("隐患地址：")
        customView2.setRTextField( "")
        
         customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("隐患区域：")
        customView3.setRRightLabel("")
        majorAreaArr = ["湖州", "长兴县", "画溪街道"]
        customView3.addOnClickListener(self, action: #selector(self.majorChoiceArea))
        
        
        
         customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("联系人：")
        customView4.setRTextField( "")
        
        
        customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("联系电话：")
        customView5.setRTextField( "")
        
        
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("手机:")
        customView6.setRTextField( "")
        
        
        customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("隐患基本情况：")
        customView7.setRTextField( "") //ImagesInfo 字段
        
        customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("")
        customView8.setRCenterLabel("")
        
        customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("是否需要政府协调：")
        customView9.setRCheckBtn()
        customView9.setLabelMax()
        customView9.rightCheckBtn.addTarget(self, action:#selector(majortapped2(_:)), forControlEvents:.TouchUpInside)
        
        customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("是否需要局部停产停业：")
        customView10.setRCheckBtn()
        customView10.setLabelMax()
        customView10.rightCheckBtn.addTarget(self, action:#selector(majortapped3(_:)), forControlEvents:.TouchUpInside)
        
        customView11 = DetailCellView(frame:CGRectMake(0, 415, SCREEN_WIDTH, 45))
        customView11.setLabelName("是否需要全部停产停业：")
        customView11.setRCheckBtn()
        customView11.setLabelMax()
        customView11.rightCheckBtn.addTarget(self, action:#selector(majortapped4(_:)), forControlEvents:.TouchUpInside)
        
        customView12 = DetailCellView(frame:CGRectMake(0, 460, SCREEN_WIDTH, 45))
        customView12.setLabelName("落实治理目标：")
        customView12.setRCheckBtn()
        customView12.setLabelMax()
        customView12.rightCheckBtn.addTarget(self, action:#selector(majortapped5(_:)), forControlEvents:.TouchUpInside)
        
        customView13 = DetailCellView(frame:CGRectMake(0, 505, SCREEN_WIDTH, 45))
        customView13.setLabelName("落实治理机构人员：")
        customView13.setRCheckBtn()
        customView13.setLabelMax()
        customView13.rightCheckBtn.addTarget(self, action:#selector(majortapped6(_:)), forControlEvents:.TouchUpInside)
        
        customView14 = DetailCellView(frame:CGRectMake(0, 550, SCREEN_WIDTH, 45))
        customView14.setLabelName("落实安全促使及应急预案：")
        customView14.setRCheckBtn()
        customView14.setLabelMax()
        customView14.rightCheckBtn.addTarget(self, action:#selector(majortapped7(_:)), forControlEvents:.TouchUpInside)
        
        customView15 = DetailCellView(frame:CGRectMake(0, 595, SCREEN_WIDTH, 45))
        customView15.setLabelName("落实治理经费物资：")
        customView15.setRCheckBtn()
        customView15.setLabelMax()
        customView15.rightCheckBtn.addTarget(self, action:#selector(majorTapped8(_:)), forControlEvents:.TouchUpInside)
        
        customView16 = DetailCellView(frame:CGRectMake(0, 640, SCREEN_WIDTH, 45))
        customView16.setLabelName("计划完成治理时间：")
        customView16.setRRightLabel("")
        customView16.setTimeImg()
        customView16.setLabelMax()
        customView16.addOnClickListener(self, action: #selector(self.majorChoicePlanTimes))
        
        customView17 = DetailCellView(frame:CGRectMake(0, 685, SCREEN_WIDTH, 45))
        customView17.setLabelName("落实治理经费:(单位：万)")
        customView17.setLabelMax()
        customView17.setRCenterTextField( "")
        
        customView18 = DetailCellView(frame:CGRectMake(0, 730, SCREEN_WIDTH, 45))
        customView18.setLabelName("单位负责人：")
        customView18.setRTextField( "")
        
        
        customView19 = DetailCellView(frame:CGRectMake(0, 775, SCREEN_WIDTH, 45))
        customView19.setLabelName("录入时间：")
        getSystemTime { (time) in
            self.customView19.setRRightLabel(time)
        }
        customView19.setTimeImg()
        
        customView20 = DetailCellView(frame:CGRectMake(0, 820, SCREEN_WIDTH, 45))
        customView20.setLabelName("填报人：")
        customView20.setRTextField( "")
        
        let  customView21 = DetailCellView(frame:CGRectMake(0, 865, SCREEN_WIDTH, 45))
        customView21.setLabelName("现场图片：")
        customView21.setRCenterLabel("")
         customView21.addOnClickListener(self, action: #selector(self.majorChoiceImage))
        
        majorInitPhoto()
        
        
        
        
        
        
        self.majorScrollView.addSubview(customView1)
        self.majorScrollView.addSubview(customView2)
        self.majorScrollView.addSubview(customView3)
        self.majorScrollView.addSubview(customView4)
        self.majorScrollView.addSubview(customView5)
        self.majorScrollView.addSubview(customView6)
        self.majorScrollView.addSubview(customView7)
        self.majorScrollView.addSubview(customView8)
        self.majorScrollView.addSubview(customView9)
        self.majorScrollView.addSubview(customView10)
        self.majorScrollView.addSubview(customView11)

        self.majorScrollView.addSubview(customView12)
        self.majorScrollView.addSubview(customView13)
        self.majorScrollView.addSubview(customView14)
        self.majorScrollView.addSubview(customView15)
        self.majorScrollView.addSubview(customView16)
        self.majorScrollView.addSubview(customView17)
        self.majorScrollView.addSubview(customView18)
        self.majorScrollView.addSubview(customView19)
        self.majorScrollView.addSubview(customView20)
        self.majorScrollView.addSubview(customView21)
        
        self.view.addSubview(majorSubmitBtn)
        self.view.addSubview(majorScrollView)
        majorSubmitBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
        
        majorScrollView.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(64)
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(majorSubmitBtn.snp_top).offset(-5)
            make.right.equalTo(self.view.snp_right)
        }
        
        customView1.snp_makeConstraints { make in
            make.top.equalTo(self.majorScrollView.snp_top)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView2.snp_makeConstraints { make in
            make.top.equalTo(customView1.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView3.snp_makeConstraints { make in
            make.top.equalTo(customView2.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView4.snp_makeConstraints { make in
            make.top.equalTo(customView3.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView5.snp_makeConstraints { make in
            make.top.equalTo(customView4.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView6.snp_makeConstraints { make in
            make.top.equalTo(customView5.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView7.snp_makeConstraints { make in
            make.top.equalTo(customView6.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
//        customView8.snp_makeConstraints { make in
//            make.top.equalTo(customView7.snp_bottom)
//            make.left.equalTo(self.scrollView.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
        
        customView9.snp_makeConstraints { make in
            make.top.equalTo(customView7.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        customView10.snp_makeConstraints { make in
            make.top.equalTo(customView8.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
    
    }
    
    func majorChoiceImage(){
        containerView.hidden = false
    }
    
    func majorInitPhoto(){
        setLoc(0, y: 910)
        var listImageFile = [UIImage]()
        listImageFile = getListImage()
        listImageFile.removeAll()
        checkNeedAddButton()
        renderView()
        self.majorScrollView.addSubview(containerView)
        containerView.hidden = true
    }
    
    func majorChoicePlanTimes(){
        choiceTime { (time) in
            self.customView16.setRRightLabel(time)
            self.customView16.becomeFirstResponder()
        }
        
    }
     var majorAreaArr = [String]()
    var majorFirstAreaCode :String = "330500"
    var majorSecondAreaCode :String = ""
    var majorThirdAreaCode :String = ""
    func majorChoiceArea(){
        getChoiceArea(majorAreaArr) { (area,areaArr) in
            self.majorSecondAreaCode =  getSecondArea(areaArr[1])
            self.majorThirdAreaCode = getThirdArea(areaArr[2])
            self.customView3.setRRightLabel(area)
        }
    }
    
    
    //市级以上重点企业
    var majorisMagorCpy = false
    func majortapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majorisMagorCpy = true
            print("tapped1+\(button.selected)")
        }else{
            majorisMagorCpy = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    //是否需要政府协调
    var majoris2 = false
    func majortapped2(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris2 = true
            print("tapped1+\(button.selected)")
        }else{
            majoris2 = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    //是否需局部停产停业
    var majoris3 = false
    func majortapped3(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris3 = true
            print("tapped1+\(button.selected)")
        }else{
            majoris3 = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    //是否需全部停产停业
    var majoris4 = false
    func majortapped4(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris4 = true
            print("tapped1+\(button.selected)")
        }else{
            majoris4 = false
            print("tapped1+\(button.selected)")
            
        }
        
    }
    
    //落实治理目标
    var majoris5 = false
    func majortapped5(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris5 = true
        }else{
            majoris5 = false
        }
        
    }
    //落实治理机构人员
    var majoris6 = false
    func majortapped6(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris6 = true
        }else{
            majoris6 = false
        }
    }
    //落实安全促使及应急预案
    var majoris7 = false
    func majortapped7(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris7 = true
        }else{
            majoris7 = false
        }
    }
    //落实治理经费物资
    var majoris8 = false
    func majorTapped8(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris8 = true
        }else{
            majoris8 = false
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
        
        NetworkTool.sharedTools.createCheckRecordImage(parameters,imageArrays: converyModels.listfile,finished: { (data, error,noteId) in
            if error == nil{
                self.showHint("添加成功", duration: 1, yOffset: 0)
                self.notedIdStr = noteId
                self.submitMajorTrouble()
                
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
            
        })
    }
    var notedIdStr:String = ""
    func submitMajorTrouble(){
        var parameters = [String : AnyObject]()
        parameters["danger.hzCompany.id"] = converyModels.companyId
        parameters["danger.noteId"] = notedIdStr
        //市级以上重点企业
        parameters["danger.emphasisProject"] = String(Int(majorisMagorCpy))
        //隐患地址
        parameters["danger.dangerAdd"] = majorAddress
        //隐患区域三级
        parameters["danger.firstArea"] = majorFirstAreaCode
        parameters["danger.secondArea"] = majorSecondAreaCode
        parameters["danger.thirdArea"] = majorThirdAreaCode
        //联系人
        parameters["danger.linkMan"] = majorPeople
        parameters["danger.linkTel"] = majorPhone
        parameters["danger.linkMobile"] = majorMobile
        parameters["danger.description"] = majorHiddenDes
        
        parameters["danger.govCoordination"] = String(majoris2)
        parameters["danger.partStopProduct"] = String(majoris3)
        parameters["danger.fullStopProduct"] = String(majoris4)
        parameters["danger.target"] = String(majoris5)
        parameters["danger.resource"] = String(majoris6)
        parameters["danger.safetyMethod"] = String(majoris7)
        parameters["danger.goods"] = String(majoris8)
        
        
        parameters["danger.finishDate"] = majorPlantTime
        parameters["danger.governMoney"] = majorGovernMoney
        
        parameters["danger.chargePerson"] = majorChargePerson
        parameters["danger.fillDate"] = majorFillDate
        parameters["danger.fillMan"] = majorFillMan
        
        // parameters["file"] = converyModels.companyId
        NetworkTool.sharedTools.createDanger(parameters,imageArrays: getListImage()) { (data, error) in
            if error == nil{
                self.showHint("重大隐患上传成功", duration: 1, yOffset: 0)
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

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
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "重大隐患"
        majorInitPage()
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
    var majorCustomView2  = DetailCellView()
    var majorCustomView3  = DetailCellView()
    var majorCustomView4  = DetailCellView()
    var majorCustomView5  = DetailCellView()
    var majorCustomView6  = DetailCellView()
    var majorCustomView7  = DetailCellView()
    var majorCustomView16  = DetailCellView()
    var majorCustomView17  = DetailCellView()
    var majorCustomView18  = DetailCellView()
    var majorCustomView19  = DetailCellView()
    var majorCustomView20  = DetailCellView()
    func submit(){
         majorAddress = majorCustomView2.textField.text!
        if AppTools.isEmpty(majorAddress) {
            alert("隐患地址不可为空", handler: {
                self.majorCustomView2.textField.becomeFirstResponder()
            })
            return
        }
        majorPeople = majorCustomView4.textField.text!
        if AppTools.isEmpty(majorPeople) {
            alert("联系人不可为空", handler: {
                self.majorCustomView4.textField.becomeFirstResponder()
            })
            return
        }
        majorPhone = majorCustomView5.textField.text!
        if AppTools.isEmpty(majorPhone) {
            alert("联系电话不可为空", handler: {
                self.majorCustomView5.textField.becomeFirstResponder()
            })
            return
        }
        
         majorMobile = majorCustomView6.textField.text!
        if AppTools.isEmpty(majorMobile) {
            alert("手机不可为空", handler: {
                self.majorCustomView6.textField.becomeFirstResponder()
            })
            return
        }
         majorHiddenDes = majorCustomView7.textField.text!
        if AppTools.isEmpty(majorHiddenDes) {
            alert("隐患基本情况不可为空", handler: {
                self.majorCustomView7.textField.becomeFirstResponder()
            })
            return
        }
        
        majorPlantTime = majorCustomView16.rightLabel.text!
        if AppTools.isEmpty(majorPlantTime) {
            alert("计划完成治理时间不可为空", handler: {
                self.majorCustomView7.textField.becomeFirstResponder()
            })
            return
        }
        
        
        majorGovernMoney = majorCustomView17.textField.text!
        if AppTools.isEmpty(majorPlantTime) {
            alert("治理经费不可为空", handler: {
                self.majorCustomView17.textField.becomeFirstResponder()
            })
            return
        }
        
        majorChargePerson = majorCustomView18.textField.text!
        if AppTools.isEmpty(majorPlantTime) {
            alert("单位负责人不可为空", handler: {
                self.majorCustomView18.textField.becomeFirstResponder()
            })
            return
        }
        majorFillDate = majorCustomView19.rightLabel.text!
        if AppTools.isEmpty(majorPlantTime) {
            alert("录入时间不可为空", handler: {
                
            })
            return
        }
        
        majorFillMan = majorCustomView20.textField.text!
        if AppTools.isEmpty(majorPlantTime) {
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
        
        let customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("市级以上重点企业：")
        customView1.setRCheckBtn()
        customView1.rightCheckBtn.addTarget(self, action:#selector(majortapped1(_:)), forControlEvents:.TouchUpInside)
        
         majorCustomView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        majorCustomView2.setLabelName("隐患地址：")
        majorCustomView2.setRTextField( "")
        
         majorCustomView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        majorCustomView3.setLabelName("隐患区域：")
        majorCustomView3.setRRightLabel("")
        majorAreaArr = ["湖州", "长兴县", "画溪街道"]
        majorCustomView3.addOnClickListener(self, action: #selector(self.majorChoiceArea))
        
        
        
         majorCustomView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        majorCustomView4.setLabelName("联系人：")
        majorCustomView4.setRTextField( "")
        
        
        majorCustomView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        majorCustomView5.setLabelName("联系电话：")
        majorCustomView5.setRTextField( "")
        
        
        majorCustomView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        majorCustomView6.setLabelName("手机:")
        majorCustomView6.setRTextField( "")
        
        
        majorCustomView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        majorCustomView7.setLabelName("隐患基本情况：")
        majorCustomView7.setRTextField( "") //ImagesInfo 字段
        
        let  customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("")
        customView8.setRCenterLabel("")
        
        let customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("是否需要政府协调：")
        customView9.setRCheckBtn()
        customView9.rightCheckBtn.addTarget(self, action:#selector(majortapped2(_:)), forControlEvents:.TouchUpInside)
        
        let customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("是否需要局部停产停业：")
        customView10.setRCheckBtn()
        customView10.rightCheckBtn.addTarget(self, action:#selector(majortapped3(_:)), forControlEvents:.TouchUpInside)
        
        let customView11 = DetailCellView(frame:CGRectMake(0, 415, SCREEN_WIDTH, 45))
        customView11.setLabelName("是否需要全部停产停业：")
        customView11.setRCheckBtn()
        customView11.rightCheckBtn.addTarget(self, action:#selector(majortapped4(_:)), forControlEvents:.TouchUpInside)
        
        let customView12 = DetailCellView(frame:CGRectMake(0, 460, SCREEN_WIDTH, 45))
        customView12.setLabelName("落实治理目标：")
        customView12.setRCheckBtn()
        customView12.rightCheckBtn.addTarget(self, action:#selector(majortapped5(_:)), forControlEvents:.TouchUpInside)
        
        let customView13 = DetailCellView(frame:CGRectMake(0, 505, SCREEN_WIDTH, 45))
        customView13.setLabelName("落实治理机构人员：")
        customView13.setRCheckBtn()
        customView13.rightCheckBtn.addTarget(self, action:#selector(majortapped6(_:)), forControlEvents:.TouchUpInside)
        
        let customView14 = DetailCellView(frame:CGRectMake(0, 550, SCREEN_WIDTH, 45))
        customView14.setLabelName("落实安全促使及应急预案：")
        customView14.setRCheckBtn()
        customView14.rightCheckBtn.addTarget(self, action:#selector(majortapped7(_:)), forControlEvents:.TouchUpInside)
        
        let customView15 = DetailCellView(frame:CGRectMake(0, 595, SCREEN_WIDTH, 45))
        customView15.setLabelName("落实治理经费物资：")
        customView15.setRCheckBtn()
        customView15.rightCheckBtn.addTarget(self, action:#selector(majorTapped8(_:)), forControlEvents:.TouchUpInside)
        
        majorCustomView16 = DetailCellView(frame:CGRectMake(0, 640, SCREEN_WIDTH, 45))
        majorCustomView16.setLabelName("计划完成治理时间：")
        majorCustomView16.setRRightLabel("")
        majorCustomView16.setTimeImg()
        majorCustomView16.addOnClickListener(self, action: #selector(self.majorChoicePlanTimes))
        
        majorCustomView17 = DetailCellView(frame:CGRectMake(0, 685, SCREEN_WIDTH, 45))
        majorCustomView17.setLabelName("落实治理经费:(单位：万)")
        majorCustomView17.setRTextField( "")
        
        majorCustomView18 = DetailCellView(frame:CGRectMake(0, 730, SCREEN_WIDTH, 45))
        majorCustomView18.setLabelName("单位负责人：")
        majorCustomView18.setRTextField( "")
        
        
        majorCustomView19 = DetailCellView(frame:CGRectMake(0, 775, SCREEN_WIDTH, 45))
        majorCustomView19.setLabelName("录入时间：")
        getSystemTime { (time) in
            self.majorCustomView19.setRRightLabel(time)
        }
        majorCustomView19.setTimeImg()
        
        majorCustomView20 = DetailCellView(frame:CGRectMake(0, 820, SCREEN_WIDTH, 45))
        majorCustomView20.setLabelName("填报人：")
        majorCustomView20.setRTextField( "")
        
        let  customView21 = DetailCellView(frame:CGRectMake(0, 865, SCREEN_WIDTH, 45))
        customView21.setLabelName("现场图片：")
        customView21.setRCenterLabel("")
         customView21.addOnClickListener(self, action: #selector(self.majorChoiceImage))
        
        majorInitPhoto()
        
        
        
        
        
        
        self.majorScrollView.addSubview(customView1)
        self.majorScrollView.addSubview(majorCustomView2)
        self.majorScrollView.addSubview(majorCustomView3)
        self.majorScrollView.addSubview(majorCustomView4)
        self.majorScrollView.addSubview(majorCustomView5)
        self.majorScrollView.addSubview(majorCustomView6)
        self.majorScrollView.addSubview(majorCustomView7)
        self.majorScrollView.addSubview(customView8)
        self.majorScrollView.addSubview(customView9)
        self.majorScrollView.addSubview(customView10)
        self.majorScrollView.addSubview(customView11)

        self.majorScrollView.addSubview(customView12)
        self.majorScrollView.addSubview(customView13)
        self.majorScrollView.addSubview(customView14)
        self.majorScrollView.addSubview(customView15)
        self.majorScrollView.addSubview(majorCustomView16)
        self.majorScrollView.addSubview(majorCustomView17)
        self.majorScrollView.addSubview(majorCustomView18)
        self.majorScrollView.addSubview(majorCustomView19)
        self.majorScrollView.addSubview(majorCustomView20)
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
        
        majorCustomView2.snp_makeConstraints { make in
            make.top.equalTo(customView1.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        majorCustomView3.snp_makeConstraints { make in
            make.top.equalTo(majorCustomView2.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        majorCustomView4.snp_makeConstraints { make in
            make.top.equalTo(majorCustomView3.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        majorCustomView5.snp_makeConstraints { make in
            make.top.equalTo(majorCustomView4.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        majorCustomView6.snp_makeConstraints { make in
            make.top.equalTo(majorCustomView5.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
        majorCustomView7.snp_makeConstraints { make in
            make.top.equalTo(majorCustomView6.snp_bottom)
            make.left.equalTo(self.majorScrollView.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        
//        customView8.snp_makeConstraints { make in
//            make.top.equalTo(customView7.snp_bottom)
//            make.left.equalTo(self.scrollView.snp_left)
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
//        }
        
        customView9.snp_makeConstraints { make in
            make.top.equalTo(majorCustomView7.snp_bottom)
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
            self.majorCustomView16.setRRightLabel(time)
            self.majorCustomView16.becomeFirstResponder()
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
            self.majorCustomView3.setRRightLabel(area)
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
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
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
        
        parameters["danger.govCoordination"] = String(Int(majoris2))
        parameters["danger.partStopProduct"] = String(Int(majoris3))
        parameters["danger.fullStopProduct"] = String(Int(majoris4))
        parameters["danger.target"] = String(Int(majoris5))
        parameters["danger.resource"] = String(Int(majoris6))
        parameters["danger.safetyMethod"] = String(Int(majoris7))
        parameters["danger.goods"] = String(Int(majoris8))
        
        
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

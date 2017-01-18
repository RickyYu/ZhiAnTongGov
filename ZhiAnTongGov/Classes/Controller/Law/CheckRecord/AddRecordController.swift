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
import Photos


class AddRecordController: PhotoViewController,ParameterDelegate{
    
    var scrollView: UIScrollView!
    var hzCompanyId :Int!
    var checkRecordInfoModel : CheckRecordInfoModel!
    var customView4  = DetailCellView()
    var customView5  = DetailCellView()
    var customView6  = DetailCellView()
    var customView7  = DetailMultCbCellView()
    var customView8  = DetailCellView()
    var customView9  = DetailCellView()
    var customView11  = DetailCellView()
    var customView14  = DetailCellView()
    var customView12 = DetailEditCellView()
    var checkView  = UIView()
    //选择行业检查表时传送回来的信息
    var industrySelectModel:IndustrySelectModel!
    
    var checkList = CheckListVo()
    
    
    //获取值
    var companyName:String!  //企业名称
    var address:String!//企业地址
    var cpyContact:String! //企业联系人
    var content:String! //选中条目内容
    var companyId:String!//g公司ID
    var checkId:String!//行业检查表ID
    var place:String!//检查场所
    var phone:String!//联系方式
    var people:String!//检查人记录人
    var law:String!//执法单位
    var checkTime:String!//检查时间
    
    
    var nowcontent:String!//现场检查记录
    var check:Bool!//发送整改通知书
    var zgTime:String!//整改时间
    
    
    var c1:Int!
    var c2:Int!
    var c3:Int!
    var c4:Int!
    
    var cbName:String!
    var cbName2:String!
    var cbName3:String!
    var cbName4:String!
    
    var list2 =  [Int]()
    
    var modelsCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationItem.title = "检查记录--基本信息"
       
        getDatas()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
        if self.triggerRefresh {
            self.triggerRefresh = false
            self.updateView()
        }
        if(industrySelectModel != nil){
            checkList.checkId = String(industrySelectModel.id)
            if(industrySelectModel.title == "无"){
            self.checkView.hidden = false
                
            }else{
            self.checkView.hidden = true
            //self.customView11.rightLabel.text = ""
            }
        }
    }
   
  
    func getDatas(){
        var parameters = [String :AnyObject]()
        parameters["produceLocaleNote.hzCompany.id"] = hzCompanyId
        NetworkTool.sharedTools.loadCompanyGrid(parameters) {  (data, error) in
            if error == nil{
                self.checkRecordInfoModel = data!
                self.initPage()
                
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
            }
        }
    }
    func initPage(){
        
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 765))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = false
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 765)
        let customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("企业名称：")
        companyName = checkRecordInfoModel.companyName
        customView1.setRCenterLabel(companyName ?? "")
        
        let customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("企业地址：")
        address = checkRecordInfoModel.address
        customView2.setRCenterLabel(address ?? "")
        
        let customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("联系人：")
        cpyContact = checkRecordInfoModel.fdDelegate
        customView3.setRCenterLabel(cpyContact ?? "")
        
        
        
        customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("检查时间：")
        getSystemTime { (time) in
            self.checkTime = time
            self.customView4.setRRightLabel(time)
        }
        customView4.addOnClickListener(self, action: #selector(self.choiceCheckTimes))
        
        
        customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("检查场所：")
        customView5.setRTextField("")

        customView5.textField.becomeFirstResponder()
        
        
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("联系方式")
        customView6.setRTextField( "")
    
       
        customView7 = DetailMultCbCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45),models:checkRecordInfoModel.checkPersonModels)
        customView7.setLabelName("参与检查人：")
        let models = checkRecordInfoModel.checkPersonModels
         modelsCount = models.count
        if modelsCount != 0 {
         if modelsCount == 1{
          c1 = models[0].gridId
          cbName = models[0].gridName
        }
            
            if modelsCount == 2{
            c1 = models[0].gridId
            cbName = models[0].gridName
            c2 = models[1].gridId
            cbName2 = models[1].gridName
        }
        if modelsCount == 3{
            c1 = models[0].gridId
            cbName = models[0].gridName
            c2 = models[1].gridId
            cbName2 = models[1].gridName
            c3 = models[2].gridId
            cbName3 = models[2].gridName
        }
        if modelsCount == 4 {
            c1 = models[0].gridId
            cbName = models[0].gridName
            c2 = models[1].gridId
            cbName2 = models[1].gridName
            c3 = models[2].gridId
            cbName3 = models[2].gridName
            c4 = models[3].gridId
            cbName4 = models[3].gridName
        }
        }
        
         customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("检查人/记录人：")
        if checkRecordInfoModel.noter.isEmpty {
        customView8.setRTextField("")
        }else{
            customView8.setRCenterLabel(checkRecordInfoModel.noter ?? "")
        }
        
        customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("执法单位：")
        if checkRecordInfoModel.executeUnit.isEmpty {
            customView9.setRTextField("")
        }else{
            customView9.setRCenterLabel(checkRecordInfoModel.executeUnit ?? "")
        }
        
        let customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("图片：")
        customView10.setRRightLabel("")
        customView10.addOnClickListener(self, action: #selector(self.choiceImage))
        initPhoto()

        customView11 = DetailCellView(frame:CGRectMake(0, 450, SCREEN_WIDTH, 45))
        customView11.setLabelName("选择行业检查表：")
        customView11.setRRightLabel("")
        customView11.addOnClickListener(self, action: #selector(self.skipCheck))
        
        checkView = UIView(frame:CGRectMake(0, 495, SCREEN_WIDTH, 280))
        checkView.hidden = true
        
        customView12 = DetailEditCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 180))
        customView12.setLabelName("现场检查记录：")
        
        let customView13 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView13.setLabelName("发送整改通知书：")
        customView13.setRCheckBtn()
        customView13.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        
        customView14 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView14.setLabelName("整改时间：")
        customView14.setRRightLabel("")
        customView14.addOnClickListener(self, action: #selector(self.choiceModifyTimes))
        
        checkView.addSubview(customView12)
        checkView.addSubview(customView13)
        checkView.addSubview(customView14)
        
        
  
        let  nextBtn = UIButton(frame:CGRectMake(0, 565, SCREEN_WIDTH, 45))
        nextBtn.setTitle("下一步（行业检查表）", forState:.Normal)
        nextBtn.backgroundColor = YMGlobalDeapBlueColor()
        nextBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        nextBtn.addTarget(self, action: #selector(self.skip), forControlEvents: UIControlEvents.TouchUpInside)
        
        
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
        self.scrollView.addSubview(containerView)
        self.scrollView.addSubview(checkView)
        self.view.addSubview(scrollView)
        self.view.addSubview(nextBtn)
        
        nextBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
        
        scrollView.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(66)
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(nextBtn.snp_top).offset(-5)
            make.right.equalTo(self.view.snp_right)
        }
        
        
        
    }
    
    func initPhoto(){
        setLoc(0, y: 450)
        checkNeedAddButton()
        renderView()
        containerView.hidden = true
    }
    
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            check = true
            print("tapped1+\(check)")
        }else{
            check = false
            print("tapped1+\(check)")
            
        }
        
    }
    
    func verify(){
        if AppTools.isEmpty(checkTime) {
            alert("检查时间不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        
        if AppTools.isEmpty(place!) {
            alert("检查场所不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        
        if AppTools.isEmpty(phone!) {
            alert("联系方式不可为空", handler: {
                self.customView6.textField.becomeFirstResponder()
            })
            return
        }
        
        if industrySelectModel == nil {
            alert("行业检查表不可为空", handler: {
                // self.customView6.textField.becomeFirstResponder()
            })
            return
            
        }
        
        people = checkRecordInfoModel.noter
        law = checkRecordInfoModel.executeUnit
        if people.isEmpty{
            people = customView8.textField.text
            if AppTools.isEmpty(people!) {
                alert("检查人/记录人不可为空", handler: {
                    self.customView6.textField.becomeFirstResponder()
                })
                return
            }
        }
        if law.isEmpty{
            law = customView9.textField.text
            if AppTools.isEmpty(law!) {
                alert("执法单位不可为空", handler: {
                    self.customView6.textField.becomeFirstResponder()
                })
                return
            }
        }
        
     
        
        if modelsCount != 0{
        if modelsCount == 1 {
            if customView7.btn1.selected{
                list2.append(c1)
            }
        }
       
        if modelsCount == 2{
            if customView7.btn1.selected{
                list2.append(c1)
            }
            if customView7.btn2.selected{
                list2.append(c2)
            }
        }
        
        if modelsCount == 3{
        
            if customView7.btn1.selected{
                list2.append(c1)
            }
            if customView7.btn2.selected{
                list2.append(c2)
            }
            
            if customView7.btn3.selected{
                list2.append(c3)
            }
        }
        
        if modelsCount == 4 {
            
            if customView7.btn1.selected{
                list2.append(c1)
            }
            if customView7.btn2.selected{
                list2.append(c2)
            }
            
            if customView7.btn3.selected{
                list2.append(c3)
            }
            if modelsCount == 4{
                if customView7.btn4.selected{
                    list2.append(c4)
                }
            }
        }
        }

        
        //页面显示时
        if self.checkView.hidden{
          nowcontent = customView12.textField.text
        }else{
          nowcontent = ""
        }
    }
    
    //下一步（行业检查表）
    func skip(sender: AnyObject) {
        companyId = String(hzCompanyId)
        checkTime = customView4.rightLabel.text!
        place = customView5.textField.text
        phone = customView6.textField.text
        content = customView11.rightLabel.text
        
       
        verify()
        
        checkList.companyname = companyName
        checkList.companyadress = address
        checkList.companylxr = cpyContact
        checkList.content = content
        checkList.checktime = checkTime
        checkList.companyId = companyId
        
        checkList.place = place
        checkList.phone = phone
        checkList.people = people
        checkList.law = law
        
        //当行业检查选择无时
        checkList.zgtime = zgTime
        checkList.check = check
        checkList.nowcontent = nowcontent
        
        
        //
        checkList.listCb = list2
        
//        checkList.listCheck 可为空
//        checkList.listAll  可为空
//        checkList.listHy     可为空
//        checkList.listfile   图片要传
        checkList.lxr = phone
//
        checkList.c1 = c1
        checkList.c2 = c2
        checkList.c3 = c3
        checkList.c4 = c4
        
        checkList.cbname = cbName
        checkList.cbname2 = cbName2
        checkList.cbname3 = cbName3
        checkList.cbname4 = cbName4
        print("listImageFile = \(listImageFile.count)")
        print("selectModel = \(selectModel.count)")
        checkList.listfile = listImageFile
        
        
       

        let  controller = IndustryHandleCheckListController()
        controller.converyModels = checkList
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

    
    func choiceImage(){
       customView11.frame = CGRectMake(0, 500, SCREEN_WIDTH, 45)
        checkView.frame = CGRectMake(0, 545, SCREEN_WIDTH, 280)
        containerView.hidden = false
    }

    func choiceCheckTimes(){
       choiceTime { (time) in
        self.customView4.setRRightLabel(time)
        self.customView4.becomeFirstResponder()
        }
        
    }
    
    func choiceModifyTimes(){
        choiceTime { (time) in
            self.zgTime = time
            self.customView14.setRRightLabel(time)
            self.customView14.becomeFirstResponder()
        }
        
    }
    
    func skipCheck(){
        let controller = IndustryCheckListController()
        controller.delegate = self
      self.navigationController?.pushViewController(controller, animated: true)
    
    }

    func passParams(industrySelectModel: IndustrySelectModel) {
        self.industrySelectModel = industrySelectModel
         customView11.setRRightLabel(industrySelectModel.title)
    }
    
}




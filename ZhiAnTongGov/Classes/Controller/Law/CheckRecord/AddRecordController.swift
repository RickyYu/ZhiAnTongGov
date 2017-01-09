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


class AddRecordController: BaseViewController,ParameterDelegate{
    
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
     var checkView  = UIView()
    //选择行业检查表时传送回来的信息
    var industrySelectModel:IndustrySelectModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationItem.title = "检查记录--基本信息"
        getDatas()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
        if(industrySelectModel != nil){
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
        customView1.setRCenterLabel(checkRecordInfoModel.companyName ?? "")
        
        let customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("企业地址：")
        customView2.setRCenterLabel(checkRecordInfoModel.address ?? "")
        
        let customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("联系人：")
        customView3.setRCenterLabel(checkRecordInfoModel.fdDelegate ?? "")
        
        
        
        customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("检查时间：")
        getSystemTime { (time) in
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
        
        customView11 = DetailCellView(frame:CGRectMake(0, 450, SCREEN_WIDTH, 45))
        customView11.setLabelName("选择行业检查表：")
        customView11.setRRightLabel("")
        customView11.addOnClickListener(self, action: #selector(self.skipCheck))
        
        checkView = UIView(frame:CGRectMake(0, 495, SCREEN_WIDTH, 280))
        checkView.hidden = true
        
        let customView12 = DetailEditCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 180))
        customView12.setLabelName("现场检查记录：")
        
        let customView13 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView13.setLabelName("发送整改通知书：")
        customView13.setRCheckBtn()
        customView13.rightCheckBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        
        
        customView14 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView14.setLabelName("检查时间：")
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
        self.scrollView.addSubview(checkView)
//        self.scrollView.addSubview(customView12)
//        self.scrollView.addSubview(customView13)
//        self.scrollView.addSubview(customView14)
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
    
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            print("tapped1+\(button.selected)")
        }else{
            print("tapped1+\(button.selected)")
            
        }
        
    }
    
    //下一步（行业检查表）
    func skip(sender: AnyObject) {
        let checkTime = customView4.rightLabel.text!
        let checkAddress = customView5.textField.text
        let checkMobile = customView6.textField.text
       
        print(checkTime)
//        if AppTools.isEmpty(checkTime) {
//            alert("检查时间不可为空", handler: {
//                self.customView5.textField.becomeFirstResponder()
//            })
//            return
//        }
//        
//        if AppTools.isEmpty(checkAddress!) {
//            alert("检查场所不可为空", handler: {
//                self.customView5.textField.becomeFirstResponder()
//            })
//            return
//        }
//        
//        if AppTools.isEmpty(checkMobile!) {
//            alert("联系方式不可为空", handler: {
//                self.customView6.textField.becomeFirstResponder()
//            })
//            return
//        }
//        
//        if industrySelectModel == nil {
//            alert("行业检查表不可为空", handler: {
//               // self.customView6.textField.becomeFirstResponder()
//            })
//            return
//
//        }
        var checkNoter:String!
        var checkEunit:String!
        if checkRecordInfoModel.noter.isEmpty{
            checkNoter = customView8.textField.text
        }
        if checkRecordInfoModel.executeUnit.isEmpty{
            checkEunit = customView9.textField.text
        }
        
        //
        //        if AppTools.isEmpty(checkMobile!) {
        //            alert("联系方式不可为空", handler: {
        //                self.customView6.textField.becomeFirstResponder()
        //            })
        //            return
        //        }
        
        
        let  controller = IndustryHandleCheckListController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func choiceImage(){

        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // change the style sheet text color
        alert.view.tintColor = UIColor.blackColor()
        
        let actionCancel = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        let actionCamera = UIAlertAction.init(title: "拍照", style: .Default) { (UIAlertAction) -> Void in
            self.selectByCamera()
        }
        
        let actionPhoto = UIAlertAction.init(title: "从手机照片中选择", style: .Default) { (UIAlertAction) -> Void in
            self.selectFromPhoto()
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionCamera)
        alert.addAction(actionPhoto)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /**
     拍照获取
     */
    private func selectByCamera(){
        // todo take photo task
    }
    
    /**
     从相册中选择图片
     */
    private func selectFromPhoto(){
        
        PHPhotoLibrary.requestAuthorization { (status) -> Void in
            switch status {
            case .Authorized:
                //self.showLocalPhotoGallery()
                break
            default:
               // self.showNoPermissionDailog()
                break
            }
        }
    }
    
    
    
    func choiceCheckTimes(){
       choiceTime { (time) in
        self.customView4.setRRightLabel(time)
        self.customView4.becomeFirstResponder()
        }
        
    }
    
    func choiceModifyTimes(){
        choiceTime { (time) in
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


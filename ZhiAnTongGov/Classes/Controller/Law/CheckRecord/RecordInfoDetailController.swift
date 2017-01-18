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


class RecordInfoDetailController: BaseViewController {
     var scrollView: UIScrollView!
     var converyDataModel : RecordInfoModel!
     var recordDetailModel : RecordDetailModel!
        var imageArray = [ImageInfoModel]()
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
      var customView11 = DetailCellView()
      var customView12  = DetailCellView()
      var  submitBtn  = UIButton()
    //是否已处罚
    var isHandle :Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "记录详情"
        isHandle = converyDataModel.punishState
        if !isHandle{
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "处罚", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.addPun))
        }
        initPage()
        getDatas()
    }
    override func viewWillAppear(animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func getDatas(){
        var parameters = [String :AnyObject]()
        parameters["produceLocaleNote.id"] = converyDataModel.id
         NetworkTool.sharedTools.loadRecordDetail(parameters) { (data, error) in
            if error == nil{
                self.recordDetailModel = data!
                self.setData()
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
            }
    }
    
    
    }
    func setData(){
        customView1.setRCenterLabel(recordDetailModel.companyName ?? "")
        customView2.setRCenterLabel(recordDetailModel.address ?? "")
        customView3.setRCenterLabel(recordDetailModel.fdDelegate ?? "")
        customView4.setRCenterLabel(recordDetailModel.checkTimeBegin ?? "")
        customView5.setRCenterLabel(recordDetailModel.checkGround ?? "")
        customView6.setRCenterLabel(recordDetailModel.fdDelegateLink ?? "")
        customView7.setRCenterLabel(recordDetailModel.fdDelegate ?? "") //ImagesInfo 字段
        customView8.setRCenterLabel(recordDetailModel.noter ?? "")
        customView9.setRCenterLabel(recordDetailModel.executeUnit ?? "")
        let isSendCleanUp = recordDetailModel.sendCleanUp as Bool
        if  isSendCleanUp {
            customView10.setRCenterLabel("是")
        }else{
            customView10.setRCenterLabel("否")
        }
        customView11.setRCenterLabel(recordDetailModel.cleanUpTimeLimit ?? "")
        self.imageArray = (recordDetailModel?.imageInfos)!
        if !imageArray.isEmpty{
            submitBtn = UIButton(frame:CGRectMake(0, 650, SCREEN_WIDTH, 45))
            
        let base_path = PlistTools.loadStringValue("BASE_URL_YH")
        for i in 0..<self.imageArray.count{
            let x = 70*i+5+5*i
            let image = UIImageView(frame: CGRectMake(CGFloat(x), 540, 70, 100))
            image.kf_setImageWithURL(NSURL(string: base_path+self.imageArray[i].path)!, placeholderImage: UIImage(named: "image_select"))
           
            self.scrollView.addSubview(image)
         }
        }else{
            submitBtn = UIButton(frame:CGRectMake(0, 565, SCREEN_WIDTH, 45))
        }
        
        submitBtn.setTitle("隐患列表", forState:.Normal)
        submitBtn.backgroundColor = YMGlobalDeapBlueColor()
        submitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtn.addTarget(self, action: #selector(self.SkipYh), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(submitBtn)
    }
    func initPage(){
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 765))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = false
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 800)
       customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.setLabelName("企业名称：")
        customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("企业地址：")
        customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("联系人：")
        customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("检查时间：")
        customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("检查场所：")
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("联系方式")
        customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("参与检查人：")
         customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("检查人/记录人：")
       customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("执法单位：")
    
        customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("发送整改通知书：")
        customView11 = DetailCellView(frame:CGRectMake(0, 450, SCREEN_WIDTH, 45))
        customView11.setLabelName("责令整改日期：")
       customView12 = DetailCellView(frame:CGRectMake(0, 495, SCREEN_WIDTH, 45))
        customView12.setLabelName("图片：")


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
        self.view.addSubview(scrollView)
        
    }

    
    func addPun(){
        let controller = PunInfoController()
        controller.converyJcjlId = recordDetailModel.produceLocaleNoteId
        controller.converyCompanyId = String(recordDetailModel.companyId)
        controller.isCheck = true
        self.navigationController?.pushViewController(controller, animated: true)
        
   
    }
    
    
    
    func SkipYh(sender: AnyObject) {
        let  controller = HistoryRecordListController()
        controller.converyJcjlId = self.recordDetailModel.produceLocaleNoteId
        controller.converyDataStr = "隐患列表"
        controller.isCheckHidden = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}


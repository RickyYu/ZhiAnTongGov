//
//  PunInfoController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/24.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class PunInfoController: BaseViewController {
   var scrollView: UIScrollView!
    var customView1  = DetailCellView()
    var customView2  = DetailCellView()
    var customView3  = DetailCellView()
    var customView4  = DetailCellView()
    var customView5  = DetailCellView()
    var customView7  = DetailCellView()
    var customView8  = DetailCellView()
    var customView9  = DetailCellView()
    var customView6  = DetailCellView()
    var punishmentId : String = ""
    var punishmentInfoModel  = PunishmentInfoModel()
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "处罚详情"
        initPage()
        getDatas()
    }
    func initPage(){
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 600))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 600)
        customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("企业名称：")
        
        customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("企业地址：")
        
         customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("法定代表人：")
        
        customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("处罚单位：")
        customView4.setRTextField("")
        self.customView4.textField.becomeFirstResponder()
        
        customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("处罚原因：")
        customView5.setRTextField("")
        
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("处罚类别")
      

        
        customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("处罚内容：")
        customView7.setRTextField("")
        
        customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("处罚时间：")
     
        customView8.setTimeImg()
    
        
        customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("备注：")
        self.scrollView.addSubview(customView1)
        self.scrollView.addSubview(customView2)
        self.scrollView.addSubview(customView3)
        self.scrollView.addSubview(customView4)
        self.scrollView.addSubview(customView5)
        self.scrollView.addSubview(customView6)
        self.scrollView.addSubview(customView7)
        self.scrollView.addSubview(customView8)
        self.scrollView.addSubview(customView9)
     
        self.view.addSubview(scrollView)

        
    
    }
    
    func setData(){
        customView1.setRCenterLabel(punishmentInfoModel.companyName)
        customView2.setRCenterLabel(punishmentInfoModel.address)
        customView3.setRCenterLabel(punishmentInfoModel.fdDelegate)
        customView4.setRCenterLabel(punishmentInfoModel.punishmentUnit)
        customView5.setRCenterLabel(punishmentInfoModel.punishmentCause)
        customView6.setRCenterLabel(getPunType(punishmentInfoModel.punishmentType))
        customView7.setRCenterLabel(punishmentInfoModel.Content)
        customView8.setRCenterLabel(punishmentInfoModel.punishmentTime)
        customView9.setRCenterLabel(punishmentInfoModel.Remark)
    }

    func getDatas(){
        var parameters = [String : AnyObject]()
        print("self.punishmentId = \(self.punishmentId)")
        parameters["punishment.id"] = self.punishmentId
        NetworkTool.sharedTools.loadPunishment(parameters) { (datas, error, totalCount) in
        if error == nil{
            self.punishmentInfoModel = datas
            self.setData()
         }else{
            self.showHint("\(error)", duration: 2, yOffset: 0)
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
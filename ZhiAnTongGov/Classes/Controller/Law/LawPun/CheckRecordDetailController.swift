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

//初查记录详情
class CheckRecordDetailController: BaseViewController {
     var imageArray = [ImageInfoModel]()
      var scrollView: UIScrollView!
   //var converyDataModel : PunishmentModel?
     var converyJcjlId:Int!
    var recordDetailModel : RecordDetailModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "初查记录"
        getDatas()
        
    }
    
    func getDatas(){
        var parameters = [String : AnyObject]()
        //行政处罚中获取初查记录
        parameters["produceLocaleNote.id"] = converyJcjlId
        NetworkTool.sharedTools.loadRecordDetail(parameters) { (data, error) in
            if error == nil{
                self.recordDetailModel = data!
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }
            }
            
            self.initPage()
        }
    }
    
    func initPage(){
        
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 600))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 600)
        let customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("企业名称：")
        customView1.setRCenterLabel(recordDetailModel.companyName ?? "")
        
        let customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("企业地址：")
        customView2.setRCenterLabel(recordDetailModel.address ?? "")
        
        let customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("联系人：")
        customView3.setRCenterLabel(recordDetailModel.fdDelegate ?? "")
        
        
        
        let customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("检查时间：")
        customView4.setRCenterLabel(recordDetailModel.checkTimeBegin ?? "")

        
        let customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("检查场所：")
        customView5.setRCenterLabel(recordDetailModel.checkGround ?? "")

        
        let customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("联系方式")
        customView6.setRCenterLabel(recordDetailModel.fdDelegateLink ?? "")


        let customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("参与检查人：")
        customView7.setRCenterLabel(recordDetailModel.fdDelegate ?? "") //ImagesInfo 字段
        
       let  customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("检查人/记录人：")
        customView8.setRCenterLabel(recordDetailModel.noter ?? "")
        
        let customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("执法单位：")
        customView9.setRCenterLabel(recordDetailModel.executeUnit ?? "")

        let customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("现场检查记录：")
        customView10.setRCenterLabel(recordDetailModel.content ?? "")

        let customView11 = DetailCellView(frame:CGRectMake(0, 460, SCREEN_WIDTH, 45))
        customView11.setLabelName("图片：")

        self.imageArray = (recordDetailModel?.imageInfos)!
        if !imageArray.isEmpty{
            let base_path = PlistTools.loadStringValue("BASE_URL_YH")
            for i in 0..<self.imageArray.count{
                let x = 70*i+5+5*i
                let image = UIImageView(frame: CGRectMake(CGFloat(x), 500, 70, 100))
                image.kf_setImageWithURL(NSURL(string: base_path+self.imageArray[i].path)!, placeholderImage: UIImage(named: "default"))
                
                self.scrollView.addSubview(image)
            }
        }
        
        
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
        self.view.addSubview(scrollView)
    
    }
    
}


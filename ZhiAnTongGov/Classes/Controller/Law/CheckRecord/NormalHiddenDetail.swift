//
//  NormalHiddenDetail.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/12.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import Kingfisher

class NormalHiddenDetail: BaseViewController {
    var customView1 = DetailCellView()
    var customView2 = DetailCellView()
    var customView3 = DetailCellView()
    var customView4 = DetailCellView()
    var customView5 = DetailCellView()
    var customView6 = DetailCellView()
    var imageArray = [ImageInfoModel]()
    var converyId:String = ""
    override func viewDidLoad() {
        self.navigationItem.title = "一般隐患查看"
        self.view.backgroundColor = UIColor.whiteColor()
        getDatas()
        initPage()
    }
    
    func getDatas(){
        var parameters = [String : AnyObject]()
        print(converyId)
        parameters["nomalDanger.id"] = converyId
        NetworkTool.sharedTools.loadNormalDanger(parameters) { (data, error) in
            if error == nil{
                
                self.customView1.setRCenterLabel( data?.type ?? "")
                self.customView2.setRCenterLabel( data?.content ?? "")
                self.customView4.setRCenterLabel( data?.governDate ?? "")
                self.customView5.setRCenterLabel( data?.findTime ?? "")
                let isReform = (data?.cleanUp)! as Bool
                if isReform{
                    self.customView6.setRCenterLabel("是")
                }else{
                    self.customView6.setRCenterLabel("否")
                }
                self.imageArray = (data?.imageInfos)!
                let base_path = PlistTools.loadStringValue("BASE_URL_YH")
                for i in 0..<self.imageArray.count{
                 let x = 70*i+5+5*i
                let image = UIImageView(frame: CGRectMake(CGFloat(x), 335, 70, 100))
                    image.kf_setImageWithURL(NSURL(string: base_path+self.imageArray[i].path)!, placeholderImage: UIImage(named: "image_select"))
                    self.view.addSubview(image)
                }
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
        }
    
    }
    
    func initPage(){
        customView1 = DetailCellView(frame:CGRectMake(0, 65, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("隐患类别：")
        customView1.setRCenterLabel( "")
        
         customView2 = DetailCellView(frame:CGRectMake(0, 120, SCREEN_WIDTH, 45))
        customView2.setLabelName("隐患描述：")
        customView2.setRCenterLabel( "")
        customView3 = DetailCellView(frame:CGRectMake(0, 290, SCREEN_WIDTH, 45))
        customView3.setLabelName("现场图片：")
        customView3.setRCenterLabel( "")
        
        
        customView4 = DetailCellView(frame:CGRectMake(0, 210, SCREEN_WIDTH, 45))
        customView4.setLabelName("计划整改时间：")
        customView4.setTimeImg()
        customView4.setRCenterLabel( "")
        
        
        customView5 = DetailCellView(frame:CGRectMake(0, 245, SCREEN_WIDTH, 45))
        customView5.setLabelName("录入时间：")
        customView5.setTimeImg()
        customView5.setRCenterLabel( "")
        
        customView6 = DetailCellView(frame:CGRectMake(0, 165, SCREEN_WIDTH, 45))
        customView6.setLabelName("是否整改:")
        customView6.setRCenterLabel( "")
        
        
        self.view.addSubview(customView1)
        self.view.addSubview(customView2)
        self.view.addSubview(customView3)
        self.view.addSubview(customView4)
        self.view.addSubview(customView5)
        self.view.addSubview(customView6)
    }
}

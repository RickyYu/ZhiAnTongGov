//
//  CpyInfoDetailController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/6.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import UsefulPickerView


class CpyInfoDetailController: BaseViewController {
    

    var scrollView: UIScrollView?
    var customView12 : DetailCellView?
    var customView11 : DetailCellView?
    var customView3 : DetailCellView?
    var converyDataModel  = CpyInfoModel()
    
    var dataModel:CompanyInfoModel!
    
    let singleData = ["规上企业", "规下企业", "小微企业"]
    let economyData = ["01国有经济", "02集体经济", "03私营经济","04有限责任公司","05联营经济","06股份合作","07外商投资","08港澳台投资","09其它经济","10股份有限公司"]
    
    override func viewDidLoad() {
        
        self.navigationItem.title = "企业信息详情"
        self.view.backgroundColor = UIColor.whiteColor()
        let locationBtn = UIBarButtonItem(image: UIImage(named: "dw2"), style: .Done, target: self, action: #selector(CpyInfoDetailController.toLocation))
        self.navigationItem.rightBarButtonItem = locationBtn
        getDatas()
        
        
    }
    
    func getDatas(){
        var parameters = [String : AnyObject]()
        parameters["company.id"] = converyDataModel.id

       NetworkTool.sharedTools.loadCompanyInfo(parameters) { (data, error) in
        if error == nil{
            self.dataModel = data!
        }else{
            self.showHint("\(error)", duration: 2, yOffset: 0)
        }
        
        self.initPage()
        }
    
    }
    func initPage(){
        scrollView = UIScrollView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*2))
        print("SCREEN_WIDTH = \(SCREEN_WIDTH)+SCREEN_HEIGHT = \(SCREEN_HEIGHT)")
        //scrollView!.frame = self.view.frame
//        scrollView!.contentSize=CGSizeMake(CGFloat(320), CGFloat(800))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*2)
        
        let customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("单位名称：")
        customView1.setRTextField(dataModel.companyName ?? "")
        let customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("单位地址：")
        customView2.setRTextField(dataModel.address ?? "")
        
        customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3!.setLabelName("所属区域：")
        self.customView3!.setRRightLabel("")
        customView3!.addOnClickListener(self, action: #selector(CpyInfoDetailController.choiceArea))
        let customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("工商注册号：")
         customView4.setRTextField(dataModel.businessRegNumber ?? "")
        
        
        let customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("行业分类：")
        customView5.setRCenterLabel(dataModel.tradeTypes)
        
        let customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("行业大类：")
        customView6.setRCenterLabel("综合企业")
        
        let customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("行业中类：")
        customView7.setRCenterLabel("综合企业")
        
        let customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("行业小类：")
        customView8.setRCenterLabel("综合企业")
        
        let customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("法定代表：")
        customView9.setRTextField(dataModel.fdDelegate ?? "")
        
        let customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("联系电话：")
        customView10.setRTextField(dataModel.phone ?? "")
        
        customView11 = DetailCellView(frame:CGRectMake(0, 450, SCREEN_WIDTH, 45))
        customView11!.setLabelName("经济类型：")
        self.customView11!.setRRightLabel("")
        customView11!.addOnClickListener(self, action: #selector(CpyInfoDetailController.choiceEconomyType))
        
        customView12 = DetailCellView(frame:CGRectMake(0, 495, SCREEN_WIDTH, 45))
        customView12!.setLabelName("规模情况：")
        self.customView12!.setRRightLabel("")
        customView12!.addOnClickListener(self, action: #selector(CpyInfoDetailController.choiceCpyType))
        
        
        let customView13 = DetailCellView(frame:CGRectMake(0, 540, SCREEN_WIDTH, 45))
        customView13.setLabelName("是否生产：")
        let isProduction = dataModel.isProduction as Bool
        if isProduction {
        customView13.setRTextField("生产中")
        }else{
            customView13.setRTextField("未生产")
        }
        
        
        
        let  submitBtn = UIButton(frame:CGRectMake(80, 600, 200, 45))
        submitBtn.setTitle("提交", forState:.Normal)
        submitBtn.backgroundColor = YMGlobalDeapBlueColor()
        submitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtn.addTarget(self, action: #selector(CpyInfoDetailController.submit), forControlEvents: UIControlEvents.TouchUpInside)
        
        
 
        
        
      

        self.scrollView!.addSubview(customView1)
        self.scrollView!.addSubview(customView2)
        self.scrollView!.addSubview(customView3!)
        self.scrollView!.addSubview(customView4)
        self.scrollView!.addSubview(customView5)
        self.scrollView!.addSubview(customView6)
        self.scrollView!.addSubview(customView7)
        self.scrollView!.addSubview(customView8)
        self.scrollView!.addSubview(customView9)
        self.scrollView!.addSubview(customView10)
        self.scrollView!.addSubview(customView11!)
        self.scrollView!.addSubview(customView12!)
        self.scrollView!.addSubview(customView13)
        self.scrollView!.addSubview(submitBtn)
        self.view.addSubview(scrollView!)
    }
    
    
    
    func toLocation(){
      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LocationSaveController")
      self.navigationController!.pushViewController(vc, animated: true)

    }
    
    func choiceArea(){
        UsefulPickerView.showCitiesPicker("省市区选择", defaultSelectedValues: ["浙江", "湖州", "长兴县"]) {[unowned self] (selectedIndexs, selectedValues) in
            // 处理数据
            let combinedString = selectedValues.reduce("", combine: { (result, value) -> String in
                result + " " + value
            })
            
            self.customView3!.setRRightLabel(combinedString)

            
        }
    }
    
    func choiceEconomyType(){
        UsefulPickerView.showSingleColPicker("请选择", data: economyData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.customView11!.setRRightLabel(selectedValue)
        }

    }
 
    func choiceCpyType(){
        
        UsefulPickerView.showSingleColPicker("请选择", data: singleData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
             self.customView12!.setRRightLabel(selectedValue)
        }
        
    }
    
    func submit(){
        showHint("提交成功", duration: 2, yOffset: 2)
        navigationController?.popViewControllerAnimated(true)
   
    }
}

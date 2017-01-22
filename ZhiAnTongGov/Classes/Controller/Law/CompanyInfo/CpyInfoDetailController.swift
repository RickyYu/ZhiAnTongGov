//
//  CpyInfoDetailController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/6.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import UsefulPickerView


class CpyInfoDetailController: BaseViewController,LocationParameterDelegate,NSXMLParserDelegate {
    

    var scrollView: UIScrollView?
    var customView12 : DetailCellView!
    var customView11 : DetailCellView!
    var customView13 : DetailCellView!
    var converyDataModel  = CpyInfoModel()
    
    var dataModel:CompanyInfoModel!
    var areaArr = [String]()
    
    var lng:String = "" //经度
    var lat:String = "" //纬度
    let singleData = ["规上企业", "规下企业", "小微企业"]
    let economyData = ["01国有经济", "02集体经济", "03私营经济","04有限责任公司","05联营经济","06股份合作","07外商投资","08港澳台投资","09其它经济","10股份有限公司"]
    
    override func viewDidLoad() {
        self.navigationItem.title = "企业信息详情"
        self.view.backgroundColor = UIColor.whiteColor()
        let locationBtn = UIBarButtonItem(image: UIImage(named: "dw2"), style: .Done, target: self, action: #selector(self.toLocation))
        self.navigationItem.rightBarButtonItem = locationBtn
        self.initPage()
        getDatas()
        
        
    }
    
    func getDatas(){
        var parameters = [String : AnyObject]()
        parameters["company.id"] = converyDataModel.id

       NetworkTool.sharedTools.loadCompanyInfo(parameters) { (data, error) in
        if error == nil{
            self.dataModel = data!
            self.setData()
        }else{
            self.showHint("\(error)", duration: 2, yOffset: 0)
        }
        
        
        }
    
    }
    //单位名称
    var str1:String = ""
    //单位地址
    var str2:String = ""
    //工商注册号
    var str3:String = ""
    //联系人
    var str4:String = ""
    //联系电话
    var str5:String = ""
    
    var strCode11:String = ""
    var strCode12:String = ""
    var str13:String = ""
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
    func initPage(){
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 800))
        print("SCREEN_WIDTH = \(SCREEN_WIDTH)+SCREEN_HEIGHT = \(SCREEN_HEIGHT)")

        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = false
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH,801)
        
        customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("单位名称：")
      

        
        customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("单位地址：")
        
     
        
        customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("所属区域：")

        customView3.addOnClickListener(self, action: #selector(self.choiceArea))
        customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("工商注册号：")

        customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("行业分类：")

        
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("行业大类：")
    
        customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("行业中类：")
        
        customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("行业小类：")
        
        customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("法定代表：")

       customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("联系电话：")
        
        customView11 = DetailCellView(frame:CGRectMake(0, 450, SCREEN_WIDTH, 45))
        customView11!.setLabelName("经济类型：")
        
        
        customView12 = DetailCellView(frame:CGRectMake(0, 495, SCREEN_WIDTH, 45))
        customView12!.setLabelName("规模情况：")
  
        
        
        customView13 = DetailCellView(frame:CGRectMake(0, 540, SCREEN_WIDTH, 45))
        customView13.setLabelName("是否生产：")

        
        let view = UIView(frame:CGRectMake(0, 600, SCREEN_WIDTH, 45))
        
        
        let  submitBtn = UIButton(frame:CGRectMake(0, 565, SCREEN_WIDTH, 45))
        submitBtn.setTitle("提交", forState:.Normal)
        submitBtn.backgroundColor = YMGlobalDeapBlueColor()
        submitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtn.addTarget(self, action: #selector(self.submit), forControlEvents: UIControlEvents.TouchUpInside)

        self.scrollView!.addSubview(customView1)
        self.scrollView!.addSubview(customView2)
        self.scrollView!.addSubview(customView3)
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
        self.scrollView?.addSubview(view)
        self.scrollView!.addSubview(submitBtn)
        self.view.addSubview(scrollView!)
        
        submitBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
    }
    var secondAreaCode :String = ""
    var thirdAreaCode :String = ""
    func setData(){
        
        customView1.setRTextField(dataModel.companyName ?? "")
        customView2.setRTextField(dataModel.address ?? "")
        
       let secondStr =  getSecondArea(String(dataModel.secondArea))
       let thirdStr =  getThirdArea(String(dataModel.thirdArea))
        
        if secondStr != "" && thirdStr != ""{
        areaArr = ["湖州",secondStr,thirdStr]
        }else{
        areaArr = ["湖州", "长兴县", "画溪街道"]
        }
        self.customView3.setRRightLabel("湖州 \(secondStr)\(thirdStr)")
        customView4.setRTextField(dataModel.businessRegNumber ?? "")
        print(dataModel.tradeTypes)
        customView5.setRCenterLabel(dataModel.tradeTypes)
        let parse:NSXMLParser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("huzhou_enum", ofType: "xml")!))!
        parse.delegate = self
        // 开始解析
        parse.parse()

        customView9.setRTextField(dataModel.fdDelegate ?? "")
        customView10.setRTextField(dataModel.phone ?? "")
        let str11 : String = dataModel.economyKind
        self.customView11!.setRRightLabel(getEconomyType(str11))
        customView11!.addOnClickListener(self, action: #selector(self.choiceEconomyType))
        let str12 : String = dataModel.isEnterprise
        self.customView12!.setRRightLabel(getCpyType(str12))
        customView12!.addOnClickListener(self, action: #selector(CpyInfoDetailController.choiceCpyType))
        let isProduction = dataModel.isProduction as Bool
        if isProduction {
            customView13.setRTextField("生产中")
        }else{
            customView13.setRTextField("未生产")
        }
    
    }
    
    
    func toLocation(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LocationSaveController") as! LocationSaveController
        controller.companyId = String(self.converyDataModel.id)
        controller.delegate = self
      self.navigationController!.pushViewController(controller, animated: true)

    }
    
    func choiceArea(){
        getChoiceArea(areaArr) { (area,areaArr) in
            self.secondAreaCode =  getSecondArea(areaArr[1])
            self.thirdAreaCode = getThirdArea(areaArr[2])
            self.customView3.setRRightLabel(area)
        }
    }
    
    func choiceEconomyType(){
        UsefulPickerView.showSingleColPicker("请选择", data: economyData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.customView11!.setRRightLabel(selectedValue)
        }

    }
 
    func choiceCpyType(){
        
        UsefulPickerView.showSingleColPicker("请选择", data: singleData, defaultSelectedIndex: 1) {[unowned self] (selectedIndex, selectedValue) in
             self.customView12!.setRRightLabel(selectedValue)
        }
        
    }
    var isStr13 :Bool = false
    func submit(){
        str1 = customView1.textField.text!
        str2 = customView2.textField.text!
        str3 = customView4.textField.text!
        str4 = customView9.textField.text!
        str5 = customView10.textField.text!
        strCode11 = getEconomyType(customView11.textField.text!)
        strCode12 = getCpyType(customView12.textField.text!)
        str13 = customView13.textField.text!
        if str13 == "生产中"{
        isStr13 = true
        }else{
        isStr13 = false
        }
        
        if AppTools.isEmpty(str1) {
            alert("单位名称不可为空", handler: {
                self.customView1.textField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(str2) {
            alert("单位地址不可为空", handler: {
                self.customView2.textField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(str3) {
            alert("工商注册号不可为空", handler: {
                self.customView4.textField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(str4) {
            alert("联系人不可为空", handler: {
                self.customView9.textField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(str5) {
            alert("联系人不可为空", handler: {
                self.customView10.textField.becomeFirstResponder()
            })
            return
        }
        
        var parameters = [String : AnyObject]()
           parameters["company.id"] = converyDataModel.id
            parameters["company.companyName"] = str1
            parameters["company.address"] = str2
            parameters["company.businessRegNumber"] = str3
          //TODO 三个code
            parameters["company.firstArea"] = dataModel.firstArea
            parameters["company.secondArea"] = secondAreaCode
            parameters["company.thirdArea"] = thirdAreaCode
            parameters["company.fdDelegate"] = str4
            parameters["company.phone"] = str5
           //TODO  三个code
            parameters["company.economyKind"] = strCode11
            parameters["company.isEnterprise"] = strCode12
            parameters["company.isProduction"] = String(Int(isStr13))
        
        //经纬度
        if !lat.isEmpty && !lng.isEmpty{
            parameters["point.x"] = lng
            parameters["point.y"] = lat
        }
 
        

        NetworkTool.sharedTools.updateCompany(parameters) { (cpyInfoModels, error, totalCount) in
        
            if error == nil{
                self.showHint("保存成功", duration: 2, yOffset: 0)
                
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                self.showHint("\(error)", duration: 1, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }
            }
        }
        
    
   
    }
    
    func passParams(lng: String, lat: String) {
        self.lng = lng
        self.lat = lat
    }

    // 监听解析节点的属性
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        // 保存当前的解析到的节点名称
      //  self.currentNodeName = elementName
        if(elementName == dataModel.tradeBig){
             customView6.setRCenterLabel(attributeDict["name"]!)
        }
        if(elementName == dataModel.tradeMid){
            customView7.setRCenterLabel(attributeDict["name"]!)
        }
        if(elementName == dataModel.tradeType){
           customView8.setRCenterLabel(attributeDict["name"]!)
        }
        
    }
}

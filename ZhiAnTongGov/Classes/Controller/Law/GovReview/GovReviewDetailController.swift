//
//  GovReviewDetailController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/29.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
private let Identifier = "HandleTypeCell"
class GovReviewDetailController: PhotoViewController,UITableViewDelegate,UITableViewDataSource,HiddenParameterDelegate  {

    var converyDataModel = UnPunishmentModel()
    var tableView: UITableView!
    let arrayData = ["初查记录", "隐患列表确认", "历史复查记录"]
    override func viewDidLoad() {
       super.viewDidLoad()
        self.navigationItem.title = "政府复查"
        initTableView()
        initPage()
        getDatas()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.resignEdit(_:))))
    }
    
    func resignEdit(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            customView3.textField.resignFirstResponder()
            customView4.textField.resignFirstResponder()
            customView5.textView.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    //是否生成复查表
    var customView1  = DetailCellView()
    var customView2  = DetailCellView()
    var customView3  = DetailCellView()
    var customView4  = DetailCellView()
    var customView5  = DetailCellView()
    var customView6  = DetailCellView()
    var var2:String!//复查时间
    var var3:String!//复查人员
    var var4:String!//复查编号
    var var5:String!//隐患整改情况
        var majorHiddenId = [String]()
    func initPage(){
        customView1 =  DetailCellView(frame:CGRectMake(0, 66, SCREEN_WIDTH, 45))
        customView1.setLabelName("是否生成复查表：")
        customView1.setLabelMax()
        customView1.setRCheckBtn()
        customView1.rightCheckBtn.addTarget(self, action:#selector(tapped3(_:)), forControlEvents:.TouchUpInside)
        
        customView2 = DetailCellView(frame:CGRectMake(0, 111, SCREEN_WIDTH, 45))
        customView2.setLabelName("复查时间：")
        getSystemTime { (time) in
             self.customView2.setRRightLabel(time)
            
        }
        customView2.setTimeImg()
        
        
        customView3 = DetailCellView(frame:CGRectMake(0, 156, SCREEN_WIDTH, 45))
        customView3.setLabelName("复查人员：")
        customView3.setRTextField("")
        
        
        customView4 = DetailCellView(frame:CGRectMake(0, 201, SCREEN_WIDTH, 45))
        customView4.setLabelName("复查编号：")
        customView4.setRTextField("")
        
        
        customView5 = DetailCellView(frame:CGRectMake(0, 246, SCREEN_WIDTH, 145))
        customView5.setLabelName("隐患整改情况：")
        customView5.setTextViewShow()
        
        
        customView6 = DetailCellView(frame:CGRectMake(0, 381, SCREEN_WIDTH, 45))
        customView6.setLabelName("图片:")
         customView6.setRRightLabel("")
        customView6.setLineViewHidden()
        customView6.addOnClickListener(self, action: #selector(self.choiceImage))
        initPhoto()
        
        
        let  nextBtn = UIButton(frame:CGRectMake(0, 565, SCREEN_WIDTH, 45))
        nextBtn.setTitle("提交", forState:.Normal)
        nextBtn.backgroundColor = YMGlobalDeapBlueColor()
        nextBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        nextBtn.addTarget(self, action: #selector(self.submit), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(customView1)
        self.view.addSubview(customView2)
        self.view.addSubview(customView3)
        self.view.addSubview(customView4)
        self.view.addSubview(customView5)
        self.view.addSubview(customView6)
        self.view.addSubview(nextBtn)
        
        nextBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
    
    }
    
    func submit(){
        self.var2 = customView2.rightLabel.text
        self.var3 = customView3.textField.text
        self.var4 = customView4.textField.text
        self.var5 = customView5.textField.text
        if AppTools.isEmpty(var3) {
            alert("复查人员不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(var4) {
            alert("复查编号不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(var4) {
            alert("隐患整改情况不可为空", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        }
        
        var parameters = [String : AnyObject]()
        if !hiddenModels.isEmpty{
            
            var tempStr:String = ""
            var temp:String = ""
            if(!majorHiddenIds.isEmpty){
                var array = [String]()
                for i in 0..<majorHiddenIds.count{
                    do{ //转化为JSON 字符串
                        let data = try NSJSONSerialization.dataWithJSONObject(majorHiddenIds[i], options: .PrettyPrinted)
                        array.append(NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
                        print(NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
                    }catch{
                        
                    }
                }
                temp = array.joinWithSeparator(",")
            }
            tempStr = "["+temp+"]"
            
            parameters["dangerGorvers"]  = tempStr
            NetworkTool.sharedTools.createDangerGorver(parameters) { (datas, error) in
                if error == nil{
                  self.submit2()
                }else{
                 self.showHint("\(error)", duration: 2, yOffset: 0)
                    if error == NOTICE_SECURITY_NAME {
                        self.toLoginView()
                    }
                }
            }
            
        }else{
            alert("隐患列表需检查", handler: {
                self.customView5.textField.becomeFirstResponder()
            })
            return
        
        }
    
    }
    //获取拍照的图片
    var listfile = [UIImage]()
    func submit2(){
      var parameters = [String : AnyObject]()
        parameters["produceCallback.hzProduceLocaleNote.id"] = String(self.converyDataModel.jcjlId)
        parameters["produceCallback.isCallBack"] = String(Int(isReform))
        parameters["produceCallback.callbackTime"] = var2
        parameters["produceCallback.callBackNum"] = var4
        parameters["produceCallback.executer"] = var3
        parameters["produceCallback.hiddenState"] = var5

        var arrays = [String]()
        for i in 0..<hiddenModels.count{
            do{ //转化为JSON 字符串
                let data = try NSJSONSerialization.dataWithJSONObject(hiddenModels[i].getParams1(), options: .PrettyPrinted)
                arrays.append(NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
                print(NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
            }catch{
                
            }
        }
        let temp = arrays.joinWithSeparator(",")
        let tempStr = "["+temp+"]"
        print(tempStr)
        parameters["result.list"]  = tempStr
        NetworkTool.sharedTools.createProduceCallBack(parameters, imageArrays: listfile) { (data, error) in
            
            if error == nil{
            self.showHint("新增成功", duration: 2, yOffset: 0)
            }else{
            self.showHint("\(error)", duration: 2, yOffset: 0)
            }
        
        }
        
        
    
    }
    
    func initPhoto(){
        setLoc(0, y: 406)
        checkNeedAddButton()
        renderView()
        containerView.hidden = true
    }
    
    func choiceImage(){
        containerView.hidden = false
    }
    
    func initTableView(){
        let tableView = UITableView(frame: CGRectMake(0, 450, SCREEN_WIDTH, 160), style: .Grouped)
        let headView = UIView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 1))
        headView.backgroundColor = UIColor.whiteColor()
        tableView.tableHeaderView = headView
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.headerViewForSection(0)
        tableView.rowHeight = 53
        tableView.scrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: Identifier,bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        self.view.addSubview(tableView)
        
    }
    var isReform:Bool = false
    //是否生成复查表
    func tapped3(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            isReform = true
            print("isReform+\(isReform)")
        }else{
            isReform = false
            print("isReform+\(isReform)")
            
        }
        
        
    }
    
    func getDatas(){
    
        var parameters = [String : AnyObject]()
        parameters["produceLocaleNote.id"] = self.converyDataModel.jcjlId

    }
    
    /**
     section 数量 方法
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    /**
     row 数量 方法
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    /**
     row的高度 方法
     */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! HandleTypeCell
        if cell.isEqual(nil){
            cell = HandleTypeCell(style: UITableViewCellStyle.Default, reuseIdentifier: Identifier)
        }
        let str  = arrayData[indexPath.row] as String
        cell.typeName.text = str
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let str : String = arrayData[indexPath.row] as String
        
        if indexPath.row == 0 {
            let  controller = CheckRecordDetailController()
            controller.converyJcjlId = self.converyDataModel.jcjlId
            self.navigationController?.pushViewController(controller, animated: true)
            
        }else if indexPath.row == 1{
            
            let  controller = HiddenConfirmListController()
            controller.converyJcjlId = self.converyDataModel.jcjlId
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            let  controller = HistoryRecordListController()
            controller.converyJcjlId = self.converyDataModel.jcjlId
            controller.converyDataStr = str
            controller.isHistoryHidden = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
        
        
    }
    //反传回的数据
    var hiddenModels = [HiddenModel]()
    var majorHiddenIds = [String]()
    func passParams(hiddenModels: [HiddenModel]) {
        self.hiddenModels = hiddenModels
        for checkHidden in hiddenModels{
        if checkHidden.isBig == "1"{
            majorHiddenId.append(String(checkHidden.hiddenId))
         }
        }
    }

}
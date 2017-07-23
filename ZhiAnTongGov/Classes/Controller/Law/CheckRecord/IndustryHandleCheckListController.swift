//
//  CpyInfoListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

private let Identifier = "IndustrySelectSwitchCell"
//检查记录 选择行业检查表
class IndustryHandleCheckListController: BaseViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    
    //传过来的model
    var converyModels = CheckListVo()
    // 获取到的检查选项
    var industrySecondSelectModels  = [IndustrySecondSelectModel]()
    var result = [IndustrySelectModel]()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    
    var tableView = UITableView()
    
    //上一步（基本信息）
    var backBtn = UIButton()
    //下一步（隐患录入）
    var nextBtn = UIButton()
    
    //责令整改日期
    var customView1  = DetailCellView()
    //发送整改通知书
    var customView2 = DetailCellView()

    
    //搜索控制器
    var countrySearchController = UISearchController()
    var searchStr : String! = ""
    // 是否加载更多
    private var toLoadMore = false
    
    //是否存在隐患
    var isHiddenView = UIView()
    //是
    var yesBtn = UIButton()
    //否
    var falseBtn = UIButton()
    //检查选项
    var listHy = [IndustrySecondSelectModel]()
    var listHyId = [Int]()
    //检查选项是否通过
    var listCheck = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPage()
        getDatas()
        
    }
 
    private func initPage(){
        setNavagation("检查记录-行业检查表")
        backBtn.setTitle("上一步（基本信息）", forState:.Normal)
        backBtn.titleLabel?.font  = UIFont.boldSystemFontOfSize(13)
        backBtn.backgroundColor = YMGlobalDeapBlueColor()
        backBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        backBtn.addTarget(self, action: #selector(self.backBaseInfo), forControlEvents: UIControlEvents.TouchUpInside)
        
        nextBtn.setTitle("下一步（隐患录入）", forState:.Normal)
        nextBtn.titleLabel?.font  =  UIFont.boldSystemFontOfSize(13)
        nextBtn.backgroundColor = YMGlobalDeapBlueColor()
        nextBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        nextBtn.addTarget(self, action: #selector(self.nextRecordHidden), forControlEvents: UIControlEvents.TouchUpInside)
        

        customView1.setLabelName("责令整改日期：")
        customView1.setRRightLabel("")
        customView1.addOnClickListener(self, action: #selector(self.choiceZgTimes))
        customView1.setTimeImg()
        
        
        customView2 =  DetailCellView(frame:CGRectMake(0, 500, SCREEN_WIDTH, 45))
        customView2.setLabelName("发送整改通知书：")
        customView2.setRCheckBtn()
        customView2.setLabelMax()
        customView2.rightCheckBtn.addTarget(self, action:#selector(tapped3(_:)), forControlEvents:.TouchUpInside)

        
     
        
        self.view.addSubview(backBtn)
        self.view.addSubview(nextBtn)
        self.view.addSubview(customView1)
        self.view.addSubview(isHiddenView)
        self.view.addSubview(customView2)
   
        
        backBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(15)
            make.size.equalTo(CGSizeMake(150, 35))
        }
        
        
        nextBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.right.equalTo(self.view.snp_right).offset(-15)
            make.size.equalTo(CGSizeMake(150, 35))
        }
        
        
        customView1.snp_makeConstraints { make in
            make.bottom.equalTo(self.backBtn.snp_top).offset(-15)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }

        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(13)
        label.frame = CGRectMake(6, 5, 100, 35)
        label.textColor = YMGlobalDeapBlueColor()
        label.text = "存在隐患:"
        
        yesBtn = UIButton(frame:CGRectMake(10, 200, 30, 30))
        falseBtn = UIButton(frame:CGRectMake(40, 200, 30, 30))
        setButton(yesBtn, str: "是")
        setButton(falseBtn, str: "否")
        
        yesBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        yesBtn.selected = true
        falseBtn.addTarget(self, action:#selector(tapped2(_:)), forControlEvents:.TouchUpInside)
        
        self.isHiddenView.addSubview(label)
        self.isHiddenView.addSubview(yesBtn)
        self.isHiddenView.addSubview(falseBtn)
        
        label.snp_makeConstraints { make in
            make.top.equalTo(self.isHiddenView.snp_top).offset(5)
            make.left.equalTo(self.isHiddenView.snp_left).offset(5)
            make.size.equalTo(CGSizeMake(100, 35))
        }

  
        
        isHiddenView.snp_makeConstraints { make in
            make.bottom.equalTo(self.customView2.snp_top).offset(-15)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-30, 45))
        }
        yesBtn.snp_makeConstraints { make in
            make.centerY.equalTo(label.snp_centerY)
            make.left.equalTo(label.snp_right)
            make.size.equalTo(CGSizeMake(30, 30))
        }
        
        falseBtn.snp_makeConstraints { make in
            make.centerY.equalTo(label.snp_centerY)
            make.left.equalTo(yesBtn.snp_right).offset(15)
            make.size.equalTo(CGSizeMake(30, 30))
        }
        
        self.title = "检查记录-行业检查表"
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: Identifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: Identifier)
        tableView.rowHeight = 53;
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(66)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 300))
        }
        self.view.backgroundColor = UIColor.whiteColor()
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self  //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "请输入检查选项"
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
    }
    
    
    func backBaseInfo(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    
    func nextRecordHidden(){
        
        let modifyTime = customView1.rightLabel.text!
        converyModels.zgtime = modifyTime
        converyModels.listHy = listHy
        converyModels.check = isReform
        for i in 0..<converyModels.listHy.count{
            if converyModels.listHy[i].description == "1"{
                listCheck.append(converyModels.listHy[i].id)
            }
        }
        converyModels.listCheck = listCheck

        if !yesBtn.selected {
            
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

            print("converyModels.listfile = \(converyModels.listfile)")
            
            NetworkTool.sharedTools.createCheckRecordImage(parameters,imageArrays: converyModels.listfile,finished: { (data, error,notedId) in
                if error == nil{
                    self.showHint("添加成功", duration: 2, yOffset: 0)
                    // 获得视图控制器中的某一视图控制器
                    let viewController = self.navigationController?.viewControllers[1] as! RecordInfoListController
                    viewController.isRefresh = true
                    self.navigationController?.popToViewController(viewController , animated: true)
                    
                }else{
                    self.showHint("\(error)", duration: 2, yOffset: 0)
                    if error == NOTICE_SECURITY_NAME {
                        self.toLoginView()
                    }
                }
                
            })
        
        }else{
            if AppTools.isEmpty(modifyTime) {
                alert("责令整改日期不可为空", handler: {
                    // self.customView5.textField.becomeFirstResponder()
                })
                return
            }
            //增加一个页面
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RecordFunctionController") as! RecordFunctionController
            controller.converyModels = converyModels
            self.navigationController?.pushViewController(controller, animated: true)

        }

    }
    

    
    func getDatas(){

        var parameters = [String : AnyObject]()
        parameters["hzTemplateCheckTable.id"] = converyModels.checkId
        if !AppTools.isEmpty(searchStr){
            parameters["hzTemplateCheckTableInfo.content"] = searchStr
        }
        
        NetworkTool.sharedTools.loadIndustrySecondSelect(parameters) { (datas, error,totalCount) in
            
            if error == nil{
                if self.currentPage>totalCount{
                    self.totalCount = totalCount!
                    //  self.showHint(LOAD_FINISH, duration: 2, yOffset: 0)
                    self.currentPage -= PAGE_SIZE
                    return
                }
                self.toLoadMore = false
                self.industrySecondSelectModels += datas!
                
            }else{
                // 获取数据失败后
                self.currentPage -= PAGE_SIZE
                if self.toLoadMore{
                    self.toLoadMore = false
                }
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
            
            self.tableView.reloadData()
        }
        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.industrySecondSelectModels.count ?? 0
    }
    
      var listHyTemp = [IndustrySecondSelectModel]()
//    //listHy 将最终检查结果放入
    var isFirst = true
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! IndustrySelectSwitchCell
        if cell.isEqual(nil){
            cell = IndustrySelectSwitchCell(style: UITableViewCellStyle.Default, reuseIdentifier: Identifier)
        }
        let count = industrySecondSelectModels.count ?? 0
        
        if count > 0 {
            let industrySecondSelectModel = industrySecondSelectModels[indexPath.row]
            cell.customSwitch.addTarget(self, action:  #selector(self.switchDidChange), forControlEvents: .ValueChanged)
            if cell.customSwitch.selected{
            industrySecondSelectModel.descriptions = "1"
            }else{
            industrySecondSelectModel.descriptions = "0"
            }
            
            
            if isFirst {
            isFirst = false
            listHy.append(industrySecondSelectModel)
            listHyId.append(industrySecondSelectModel.id)
            }else{
                for list in listHy {
                    if listHyId.contains(industrySecondSelectModel.id)  {
                     industrySecondSelectModel.descriptions = list.descriptions
                    }else {
                    listHy.append(industrySecondSelectModel)
                    listHyId.append(industrySecondSelectModel.id)
                    }
                }
            }
            
           //每次加载数据listHy内都是需要重新放入的数据
            cell.industrySecondSelectModel = industrySecondSelectModel
        }
      
        if count > 0 && indexPath.row == count-1 && !toLoadMore && totalCount>PAGE_SIZE{
            toLoadMore = true
            currentPage += PAGE_SIZE
            getDatas()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func switchDidChange(){
        
        for list in listHy {
           print(list.descriptions)
        }
        
        print("change")
        
    }
    
 
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchStr = searchText
    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchStr = countrySearchController.searchBar.text
        reSet()
        getDatas()
        
    }
    
    // 取消按钮触发事件
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        searchStr = ""
        reSet()
        getDatas()
    }
    
    
    func back()
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    // MARK: - 内部控制方法
    /**
     重置数据
     */
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        totalCount = 0
        
        industrySecondSelectModels.removeAll()
        industrySecondSelectModels = [IndustrySecondSelectModel]()
    }
    
    func choiceZgTimes(){
        choiceTime { (time) in
            self.customView1.setRRightLabel(time)
            self.customView1.becomeFirstResponder()
            self.converyModels.zgtime = time
        }
        
    }
    
    
    func setButton(button:UIButton,str:String){
        button.setImage(UIImage(named: "cb_unselect"), forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont.boldSystemFontOfSize(11)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "cb_select"), forState: UIControlState.Selected)
        button.setTitle(str, forState: UIControlState.Normal)
        self.view.addSubview(button)
    }
    
    //true
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            customView1.hidden = false
            customView2.hidden = false
             falseBtn.selected = false
             nextBtn.setTitle("下一步（隐患录入）", forState:.Normal)
        }else{
            customView1.hidden = true
            customView2.hidden = true
            falseBtn.selected = true
            nextBtn.setTitle("提交", forState: .Normal)
        }
        
    }
    
    //false
    func tapped2(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            customView1.hidden = true
            customView2.hidden = true
            yesBtn.selected = false
            nextBtn.setTitle("提交", forState: .Normal)
        }else{
            customView1.hidden = false
            customView2.hidden = false
            yesBtn.selected = true
            nextBtn.setTitle("下一步（隐患录入）", forState: .Normal)
            
        }
        
    }
    var isReform:Bool = false
    //是否发送整改通知书
    func tapped3(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            isReform = true
        }else{
            isReform = false
        }
    }
}

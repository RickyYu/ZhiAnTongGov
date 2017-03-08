//
//  UnModifyHiddenListController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/2/24.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON

private let Identifier = "UnModifyHiddenCell"
class UnModifyHiddenListController: BaseViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,YMSortTableViewDelegate {
    var converyModels : CheckListVo!
    var tableView = UITableView()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    //搜索控制器
    var countrySearchController = UISearchController()
    var searchStr : String!
    // 是否加载更多
    private var toLoadMore = false
    var takeOverBtn = UIButton()
    var sourceType:String!
     var isRepaired : Bool!
    var unModifyModels = [UnModifyModel]()
    var uploadModels = [UnModifyModel]()
    override func viewDidLoad() {
        setNavagation("未整改隐患列表")
        initPage()
        getDatas()
    }
    
    override func viewWillAppear(animated: Bool) {
        if (tableView.indexPathForSelectedRow != nil) {
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    func initPage(){
        sourceType = "0"
        takeOverBtn.setTitle("接管", forState:.Normal)
        takeOverBtn.backgroundColor = YMGlobalDeapBlueColor()
        takeOverBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        takeOverBtn.addTarget(self, action: #selector(self.takeOver), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(takeOverBtn)
        takeOverBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
        let button2 = UIButton(frame:CGRectMake(0, 0, 32, 32))
        button2.setImage(UIImage(named: "icon_sort"), forState: .Normal)
        button2.addTarget(self,action:#selector(self.sortButtonClick),forControlEvents:.TouchUpInside)
        let barButton2 = UIBarButtonItem(customView: button2)
        navigationItem.rightBarButtonItem = barButton2
        popView.cells = ["全部","未整改", "已整改"]
        popView.sorts =  ["all","unModify", "Modify"]
       
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
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 500))
        }
    
    }
    
    private lazy var popView: YMSortTableView = {
        let popView = YMSortTableView()
        popView.delegate = self
        return popView
    }()
    /// 搜索条件点击
    func sortButtonClick() {
        popView.show()
    }
    
    var isPun :Bool = false // false 未处罚   true 已经处罚
    // MARK: - YMSortTableViewDelegate
    func sortView(sortView: YMSortTableView, didSelectSortAtIndexPath sort: String) {
        sortView.dismiss()
       if sort == "unModify" {
            isRepaired = false
        getDatas()
        }else if sort == "Modify"{
            isRepaired = true
        getDatas()
       }else {
        getDatas()
        }

    }
    
   
    
    func getDatas(){
        
        var parameters = [String : AnyObject]()
        
        parameters["vDanger.companyId"] = converyModels.companyId
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        
        if isRepaired != nil{
          parameters["vDanger.repaired"] = String(isRepaired)
        }
        
        if sourceType != nil{
         parameters["vDanger.sourceType"] = sourceType
        }
        if searchStr != nil{
            parameters["vDanger.description"] = searchStr
        }
        
        NetworkTool.sharedTools.loadVDangers(parameters) { (datas, error, totalCount) in
            if error == nil{
                if self.currentPage>totalCount{
                    self.totalCount = totalCount!
                    //  self.showHint(LOAD_FINISH, duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                self.toLoadMore = false
                self.unModifyModels += datas!
            }else{
                // 获取数据失败后
                self.currentPage -= 10
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
    var noteId:String!
    func takeOver(){
        
        if noteId != nil{
            self.alertNotice("提示", message: "确认接管后，隐患无法再修改！") {
                self.takeDangers()
            }
        }else{
            self.alertNotice("提示", message: "确认提交后，本次检查信息及接管隐患无法再更改！") {
                self.createCheckRecord()
            }
        }
    }
    
    
    func createCheckRecord(){
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
                print(notedId)
              self.noteId = String(notedId)
                self.takeDangers()
                
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
            
        })
    
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.unModifyModels.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! UnModifyHiddenCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        let count = unModifyModels.count ?? 0
        if count > 0 {
            let model = unModifyModels[indexPath.row]
            cell.unModifyModel = model
            if cell.select.selected {
                uploadModels.append(model)
                model.take = true
            }else  if  (uploadModels.indexOf(model) != nil) {
               uploadModels.removeAtIndex(uploadModels.indexOf(model)!)
            }
        }
        
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += 10
       
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell =   tableView.cellForRowAtIndexPath(indexPath) as! UnModifyHiddenCell
        let model = unModifyModels[indexPath.row]
        cell.select.selected = !cell.select.selected
        if cell.select.selected{
            model.take = true
            uploadModels.append(model)
        }else{
            if  (uploadModels.indexOf(model) != nil) {
                uploadModels.removeAtIndex(uploadModels.indexOf(model)!)
            }
            
        }
        
    }

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchStr = searchText
    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        unModifyModels.removeAll()
        unModifyModels = [UnModifyModel]()
    }
   
    func takeDangers(){
        var parameters = [String :AnyObject]()
        parameters["produceLocaleNote.id"] = String(self.noteId)
       
        if !uploadModels.isEmpty{
            var array = [String]()
            for i in 0..<uploadModels.count{
                do{ //转化为JSON 字符串
                    let data = try NSJSONSerialization.dataWithJSONObject(uploadModels[i].getParams1(), options: .PrettyPrinted)
                    array.append(NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
                }catch{
                    
                }
            }
            let temp = array.joinWithSeparator(",")
            let tempStr = "["+temp+"]"
            print(tempStr)
             parameters["result.list"] = tempStr
        }
       // parameters["result.list"] = ""
        NetworkTool.sharedTools.takeDangers(parameters) {  (data, error) in
            if error == nil{
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RecordFunctionController") as! RecordFunctionController
                controller.converyModels = self.converyModels
                controller.noteId = self.noteId
                self.navigationController?.pushViewController(controller, animated: true)
                
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
        }
    }
}

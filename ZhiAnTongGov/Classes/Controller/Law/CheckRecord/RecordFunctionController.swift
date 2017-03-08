//
//  RecordFunction.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/2/24.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
private let Identifier = "UnModifyHiddenCell"
class RecordFunctionController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    var converyModels : CheckListVo!
    @IBOutlet weak var addHidden: UIButton!
    @IBOutlet weak var lookHidden: UIButton!
    var table = UITableView()
    var noteId:String!
    //检查记录隐患数据源
    var checkHiddenModels = [CheckHiddenModel]()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+10
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
    var submitBtn = UIButton()
    override func viewDidLoad() {
        setNavagation("检查记录-隐患列表")
        submitBtn.setTitle("提交", forState:.Normal)
        submitBtn.backgroundColor = YMGlobalDeapBlueColor()
        submitBtn.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        submitBtn.addTarget(self, action: #selector(self.submit), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(submitBtn)
        submitBtn.snp_makeConstraints { make in
            make.bottom.equalTo(self.view.snp_bottom).offset(-15)
            make.left.equalTo(self.view.snp_left).offset(50)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-100, 35))
        }
        
        table.delegate = self
        table.dataSource = self
        let nib = UINib(nibName: Identifier,bundle: nil)
        self.table.registerNib(nib, forCellReuseIdentifier: Identifier)
        table.rowHeight = 53
        table.tableFooterView = UIView()
        self.view.addSubview(table)
        table.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(135)
            make.left.equalTo(self.view.snp_left)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 400))
        }
        
        if noteId != nil{
         table.hidden = false
         getProDangers()
        
        }else{
          table.hidden = true
        }
    }
    
    func getProDangers(){
        var parameters = [String : AnyObject]()
        parameters["produceLocaleNote.id"] = noteId
        NetworkTool.sharedTools.loadProDangers(parameters) { (datas, error,totalCount) in
       
            
            if totalCount == 0{
                self.showHint("当前无数据", duration: 2, yOffset: 0)
                return
            }
            
            if error == nil{
                if self.currentPage>totalCount{
                    //self.showHint("已经到最后了", duration: 2, yOffset: 0)
                    self.currentPage -= 10
                    return
                }
                self.toLoadMore = false
                self.checkHiddenModels += datas!
                self.table.reloadData()
            }else{
                
                // 获取数据失败后
                self.currentPage -= 10
                if self.toLoadMore{
                    self.toLoadMore = false
                }
                self.showHint("\(error)", duration: 2, yOffset: 0)
                self.toLoginView()
                
            }
        }
    
    }
    
    @IBAction func addClick(sender: AnyObject) {
        
        let controller = RecordHideenPassController()
        controller.converyModels = converyModels
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func lookClicke(sender: AnyObject) {
        let controller = UnModifyHiddenListController()
        controller.converyModels = converyModels
        controller.noteId = self.noteId
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func submit(){
        
        if noteId != nil{
            self.alert("提交成功", handler: {
                let viewController = self.navigationController?.viewControllers[1] as! RecordInfoListController
                self.navigationController?.popToViewController(viewController, animated: true)
            })
        }else{
        self.showHint("请先添加隐患", duration: 2, yOffset: 2)
       
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkHiddenModels.count ?? 0
    }
    
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! UnModifyHiddenCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None;

        let count = checkHiddenModels.count ?? 0
        if count > 0 {
            let model = checkHiddenModels[indexPath.row]
            cell.checkHiddenModel = model

        }
        
        if count > 0 && indexPath.row == count-1 && !toLoadMore{
            toLoadMore = true
            currentPage += 10
     
        }
        return cell
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func reSet(){
        // 重置当前页
        currentPage = 0
        // 重置数组
        checkHiddenModels.removeAll()
        checkHiddenModels = [CheckHiddenModel]()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model:CheckHiddenModel = checkHiddenModels[indexPath.row]
        if model.isBig == "0"{
            let controller = GeneralHiddenViewController()
            controller.hiddenId = String(model.id)
            self.navigationController?.pushViewController(controller, animated: true)
            
        }else{
            let controller = RecordHiddenMajorController()
            controller.hiddenId = String(model.id)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
}

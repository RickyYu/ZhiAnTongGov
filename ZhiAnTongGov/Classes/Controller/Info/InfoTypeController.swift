//
//  InfoTypeController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/2.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

//信息查询模块界面
class InfoTypeController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var table: UITableView!

    /// 定义tabelView和数组
    
    var arrayData = [["name":"法律法规","img":"icon_infomation_flfg","value":"FLFG"],["name":"技术标准","img":"icon_infomation_jsbz","value":"JSBZ"],["name":"MSDS查询","img":"icon_infomation_msds","value":"MSDS"],["name":"安检要闻","img":"icon_infomation_ajyw","value":"AJYW"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.scrollEnabled = false
        table.delegate = self
        table.dataSource = self
        self.navigationController?.navigationBar.hidden = true

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
         if (table.indexPathForSelectedRow != nil) {
             table.deselectRowAtIndexPath(table.indexPathForSelectedRow!, animated: true)
         }
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
        return 60
    }
    
    /**
     tableViewCell方法
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /// 定义一个cell
        let cellIdentifier:String = "infoTypeCell"
        var cell:InfoTypeCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InfoTypeCell
        if cell.isEqual(nil){
            cell = InfoTypeCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        let rowDict : NSDictionary = arrayData[indexPath.row] as NSDictionary
        cell.headImg.image = UIImage(named:(rowDict.objectForKey("img")as? String)!)
        cell.typeNameField.text = rowDict.objectForKey("name")as? String
        return cell
    }
    
    /**
     Memory
     */
    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoList = InfoListController()
         let object : NSDictionary = arrayData[indexPath.row] as NSDictionary
         infoList.detailItem = object
      
        
        if indexPath.row == 2{
            let list = InfoMsdsListController()
            let object : NSDictionary = arrayData[2] as NSDictionary
            list.detailItem = object
            self.navigationController?.pushViewController(list, animated: true)
            return
        }
        self.navigationController?.pushViewController(infoList, animated: true)
    }

}

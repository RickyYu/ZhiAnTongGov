//
//  BaseTabViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/20.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import UsefulPickerView

class BaseTabViewController:UITableViewController{
     var countrySearchController = UISearchController()
    override func viewDidLoad() {
        setNavagation("")
        tableView.tableFooterView = UIView()
    }
    func setNavagation(title:String){
        //修改导航栏按钮颜色为白色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //修改导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = YMGlobalBlueColor()
        self.view.backgroundColor = UIColor.whiteColor()
        //修改导航栏按钮返回只有箭头
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;
        self.title = title
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if (tableView.indexPathForSelectedRow != nil) {
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        if self.countrySearchController.active {
            self.countrySearchController.active = false
            self.countrySearchController.searchBar.removeFromSuperview()
        }
    }
    func alertNotice(titile:String,message:String,handler:()->Void){
        let alertController = UIAlertController(title: titile, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let acSure = UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive, handler: {
            action in
            handler()
        })
        let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            print("click Cancel")
        }
        
        
        alertController.addAction(acSure)
        alertController.addAction(acCancel)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func alertNoticeWithCancel(titile:String,message:String,handlerSure:()->Void,handlerCancel:()->Void){
        let alertController = UIAlertController(title: titile, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let acSure = UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive, handler: {
            action in
            handlerSure()
        })
        
        let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: {
            action in
            handlerCancel()
        })
        
        alertController.addAction(acSure)
        alertController.addAction(acCancel)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    func toLoginView(){
        self.alertNotice("提示", message: NOTICE_SECURITY_NAME, handler: {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    internal func getChoiceArea(areaArr:[String],finished:(area:String,areaArr:[String])->()){
        UsefulPickerView.showCitiesPicker("市区镇选择", defaultSelectedValues: areaArr) { (selectedIndexs, selectedValues) in
            // 处理数据
            let combinedString = selectedValues.reduce("", combine: { (result, value) -> String in
                result + " " + value
            })
            finished(area:combinedString,areaArr: selectedValues)
        }
        
    }
}
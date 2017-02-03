//
//  BaseViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/23.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//
import UIKit
import UsefulPickerView



class BaseViewController: UIViewController {
    
    var editText : UITextField!
    var editView : UITextView!
    override func viewDidLoad() {
        //修改导航栏按钮颜色为白色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //修改导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = YMGlobalBlueColor()

        //修改导航栏按钮返回只有箭头
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;
        
        self.view.backgroundColor = UIColor.whiteColor()
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.resignEdit(_:))))
    }
    
//    func resignEdit(sender: UITapGestureRecognizer) {
//        if sender.state == .Ended {
//            print("收回键盘")
//            handleEditText({
//            
//          })
//        }
//        sender.cancelsTouchesInView = false
//    }
    
    func handleEditText(handler: () -> Void){
       handler()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    /**
     UITableView默认初始化配置
     */
    func initTableView(tableView: UITableView) {
        //去除多余空白cell
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    /**
     通过navigationController跳转，则使用该方法返回上一页
     */
    func lastNavigationPage() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     通过navigationController跳转，则使用该方法返回到指定页面
     */
    func lastNavigationPage(toView: UIViewController) {
        self.navigationController?.popToViewController(toView, animated: true)
    }
    
    /**
     通过pushView跳转firsView->secondView->thirdView，当在thirdView执行下面语句，则调回firtView页面
     */
    func lastNavigationRootPage() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /**
     通过View的presentViewController跳转的页面才能执行，返回上一页
     */
    func lastDismissPage() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    ///presentViewController跳转，包含4种系统默认的过渡效果
    func toViewPresent(toView: UIViewController) {
        toView.modalTransitionStyle =  UIModalTransitionStyle.CrossDissolve
        presentViewController(toView, animated: true, completion: nil)
        
    }
    ///navigationController跳转
    func toViewNavigation(title: String, toView: UIViewController) {
        let item = UIBarButtonItem(title: title, style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;
        self.navigationController?.pushViewController(toView, animated: true)
    }
    
    func alert(msg: String) {
        let alertController = UIAlertController(title: "", message: msg, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func alert(msg: String, handler: () -> Void) {
        let alertController = UIAlertController(title: "", message: msg, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "确定", style: .Default, handler: {
            action in
            handler()
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   internal func choiceTime(finished:(time:String)->()){
        let alertController:UIAlertController=UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        // 初始化 datePicker
        let datePicker = UIDatePicker( )
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.Date
        // 设置默认时间
        datePicker.date = NSDate()
        // 响应事件（只要滚轮变化就会触发）
        // datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default){
            (alertAction)->Void in
            //更新提醒时间文本框
            let formatter = NSDateFormatter()
            //日期样式
            formatter.dateFormat = "yyyy-MM-dd"
           // self.customView4.setRRightLabel(formatter.stringFromDate(datePicker.date))
            finished(time: formatter.stringFromDate(datePicker.date))
            
            })
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel,handler:nil))
        
        alertController.view.addSubview(datePicker)
        
        self.presentViewController(alertController, animated: true, completion: nil)
   
    }
    internal func getSystemTime(finished:(time:String)->()){
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
         finished(time: formatter.stringFromDate(date) as String)
    }
    
    internal func getChoiceArea(areaArr:[String],finished:(area:String,areaArr:[String])->()){
//        UsefulPickerView.showCitiesPicker("市区镇选择", defaultSelectedValues: areaArr) { (selectedIndexs, selectedValues) in
//          
//        }
        UsefulPickerView.showCitiesPicker("市区镇选择", defaultSelectedValues: areaArr) {[unowned self] (selectedIndexs, selectedValues) in
            // 处理数据
            let combinedString = selectedValues.reduce("", combine: { (result, value) -> String in
                result + " " + value
            })
            finished(area:combinedString,areaArr: selectedValues)
        }
    
    }
    
}

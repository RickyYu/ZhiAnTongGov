//
//  BaseTabViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/20.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class BaseTabViewController:UITableViewController {
    override func viewDidLoad() {
        
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
}
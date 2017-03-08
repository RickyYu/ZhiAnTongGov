//
//  RecordHiddenController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/4.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

//暂时弃用，UITabBarController 无法初始化达到效果
class RecordHiddenController: UITabBarController {
    var converyModels : CheckListVo!
    override func viewDidLoad() {
        
        self.title = "隐患录入"
        self.tabBar.frame = CGRectMake(0, 66, SCREEN_WIDTH, 50)
        self.view.backgroundColor = UIColor.whiteColor()
        //创建tabbar的子控制器
        self.creatSubViewControllers()
        
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func creatSubViewControllers(){
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let converyModels = userDefaults.objectForKey("converyModels") as? CheckListVo
        
        
        let firstVC  = RecordHiddenNormalController ()
        firstVC.converyModels = converyModels
        let item1 : UITabBarItem = UITabBarItem (title: "一般隐患", image: UIImage(named: "tabbar_home"), selectedImage: UIImage(named: "dot_orange"))
        
        firstVC.tabBarItem = item1
        
        let secondVC = RecordHiddenMajorController ()
        secondVC.converyModels = converyModels
        let item2 : UITabBarItem = UITabBarItem (title: "重大隐患", image: UIImage(named: "tabbar_sort"), selectedImage: UIImage(named: "dot_orange"))
        secondVC.tabBarItem = item2

        
        let tabArray = [firstVC,secondVC]
        self.viewControllers = tabArray
    }
}

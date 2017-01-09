//
//  RecordHiddenController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/4.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class RecordHiddenController: UITabBarController {
    
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
        let firstVC  = RecordHiddenNormalController ()
        firstVC.str = "11111"
        let item1 : UITabBarItem = UITabBarItem (title: "一般隐患", image: UIImage(named: "tabbar_home"), selectedImage: UIImage(named: "dot_orange"))
        firstVC.tabBarItem = item1
        
        let secondVC = RecordHiddenMajorController ()
        
        let item2 : UITabBarItem = UITabBarItem (title: "重大隐患", image: UIImage(named: "tabbar_sort"), selectedImage: UIImage(named: "dot_orange"))
        secondVC.tabBarItem = item2

        
        let tabArray = [firstVC,secondVC]
        self.viewControllers = tabArray
    }
}

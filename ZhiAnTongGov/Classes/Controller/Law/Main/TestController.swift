//
//  TestController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/20.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit
import UsefulPickerView
import SwiftyJSON
import Photos
class TestController: SinglePhotoViewController {

    var customView6normal = DetailCellView()


    override func viewDidLoad() {
        customView6normal =  DetailCellView(frame:CGRectMake(0, 100, SCREEN_WIDTH, 45))
        customView6normal.setLabelName("现场图片：")
        customView6normal.setRRightLabel("")
        customView6normal.addOnClickListener(self, action: #selector(self.takeImage))
                self.view.addSubview(customView6normal)
        setNavagation("测试")
        //initNormalPage()
        
        
        setImageViewLoc(0, y: 145)
        self.view.addSubview(scrollView)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        self.tabBarController?.hidesBottomBarWhenPushed = true
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
}





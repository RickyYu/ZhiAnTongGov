//
//  RecordHiddenController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/4.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class RecordHideenPassController:BaseViewController {
    var converyModels : CheckListVo!
    
    override func viewDidLoad() {
        setNavagation("隐患录入")
        let buttonNormal = UIButton(frame:CGRectMake((SCREEN_WIDTH-200)/2, 200, 200, 100))
        buttonNormal.setTitle("一般隐患", forState:.Normal)
        buttonNormal.backgroundColor = YMGlobalDeapBlueColor()
        buttonNormal.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        buttonNormal.addTarget(self, action: #selector(self.showNormal), forControlEvents: UIControlEvents.TouchUpInside)
        
        
       let buttonMajor = UIButton(frame:CGRectMake((SCREEN_WIDTH-200)/2, 350, 200, 100))
        buttonMajor.setTitle("重大隐患", forState:.Normal)
        buttonMajor.backgroundColor = YMGlobalDeapBlueColor()
        buttonMajor.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        buttonMajor.addTarget(self, action: #selector(self.showMajor), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(buttonNormal)
        self.view.addSubview(buttonMajor)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func showNormal(){
        let controller = RecordHiddenNormalController()
        
        controller.converyModels = converyModels
      self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showMajor(){
        let controller = RecordHiddenMajorController()
        controller.converyModels = converyModels
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

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

        let imageView = UIImageView(frame: CGRectMake(0, 64, SCREEN_WIDTH, 225))
        imageView.image = UIImage(named: "banner_hidden")
        self.view.addSubview(imageView)
        
        let buttonNormal = UIButton(frame:CGRectMake(10, 300, SCREEN_WIDTH/2-20, 100))
        buttonNormal.setBackgroundImage(UIImage(named: "bg_general_hidden"), forState: .Normal)
        buttonNormal.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        buttonNormal.addTarget(self, action: #selector(self.showNormal), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let buttonMajor = UIButton(frame:CGRectMake(SCREEN_WIDTH/2+7, 300, SCREEN_WIDTH/2-20, 100))
        buttonMajor.setBackgroundImage(UIImage(named: "bg_major_hidden"), forState: .Normal)
        buttonMajor.setTitleColor(UIColor.greenColor(), forState: .Highlighted) //触摸状态下文字的颜色
        buttonMajor.addTarget(self, action: #selector(self.showMajor), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(buttonNormal)
        self.view.addSubview(buttonMajor)
        
        
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

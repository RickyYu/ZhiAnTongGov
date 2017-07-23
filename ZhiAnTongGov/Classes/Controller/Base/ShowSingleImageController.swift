//
//  ShowSingleImageController.swift
//  ZhiAnTongCpy
//
//  Created by Ricky on 2017/4/20.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class ShowSingleImageController: BaseViewController {
    
    var imageView :UIImageView! = nil
    var image :UIImage!
    
    override func viewDidLoad() {
        setNavagation("图片详情")
        imageView = getImageView()
        imageView.image = image
//        imageView.image = image
        
       
    }
    override func viewWillAppear(animated: Bool) {
        //        self.navBarHairlineImageView.hidden = true
        //设置navigationBar背景
//        self.navigationController?.navigationBar
//            .setBackgroundImage(UIImage(named: "head_transparent"), forBarMetrics: .Default)
//        //设置navigationBar  黑线背景
//        self.navigationController?.navigationBar.shadowImage = UIImage(named: "head_transparent")
    }
    
    func getImageView()->UIImageView{
        let imageView = UIImageView(frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        imageView.contentMode = .ScaleAspectFit
        self.view.addSubview(imageView)
       return imageView
    }
}

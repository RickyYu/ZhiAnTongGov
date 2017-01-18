//
//  TestController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/13.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class TestController: BaseViewController {
     var scrollView: UIScrollView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        scrollView = UIScrollView(frame: CGRectMake(0, 66, SCREEN_WIDTH, 500))
        scrollView.backgroundColor = UIColor.blueColor()
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = false
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 765)
        self.view.addSubview(scrollView)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
    }
}

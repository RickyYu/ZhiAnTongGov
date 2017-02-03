//
//  LawViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/5.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class LawViewController: UIViewController,UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var contentView: UIView!
    var pageControl: UIPageControl?
    var scrollView: UIScrollView?
    var isPageControlUsed = false
    var currentPage:Int! = 0
    var firstViewController :GovChartController!
    var secondViewController :CpyChartController!
    var thirdViewController :AllChartController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //修改导航栏按钮颜色为白色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //修改导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = YMGlobalBlueColor()

        //修改导航栏按钮返回只有箭头
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;
        self.title="行政执法"
        let rightBar = UIBarButtonItem(title: "刷新", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LawViewController.toCodeViewPad))
        self.navigationItem.rightBarButtonItem = rightBar
      
        let screenWidth = self.contentView.bounds.width
        let screenHeight = self.contentView.bounds.height

        scrollView = UIScrollView(frame: CGRectMake(0, 52, screenWidth, screenHeight - 55))
        pageControl = UIPageControl(frame: CGRectMake(0, screenHeight - 40, screenWidth, 40))
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView!.contentSize = CGSizeMake(screenWidth * 3, screenHeight - 60)
        
//        let firstViewController = GovChartController()
        firstViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("govChartController") as! GovChartController
        firstViewController.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 60)
        secondViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("cpyChartController") as! CpyChartController
        secondViewController.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight - 60)
         thirdViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("allChartController") as! AllChartController
        thirdViewController.view.frame = CGRectMake(screenWidth * 2, 0, screenWidth, screenHeight - 60)
        
        
        scrollView!.addSubview(firstViewController.view)
        scrollView!.addSubview(secondViewController.view)
        scrollView!.addSubview(thirdViewController.view)
        
        scrollView!.delegate = self
        
        pageControl!.numberOfPages = 3
        pageControl!.currentPage = 0
        pageControl!.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl!.pageIndicatorTintColor = UIColor.grayColor()
        pageControl!.addTarget(self, action: #selector(LawViewController.pageDidChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        self.contentView.addSubview(scrollView!)
        self.contentView.addSubview(pageControl!)
 
    }
    
    func pageDidChanged(obj : UIPageControl) -> Void
    {
        let currentPage = obj.currentPage
        var frame = scrollView!.frame
        frame.origin.x = (CGFloat)(currentPage) * frame.size.width
        
        scrollView!.scrollRectToVisible(frame, animated: true)
        isPageControlUsed = true
    }
    

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(!isPageControlUsed)
        {
            let pageWidth = scrollView.frame.size.width
            let page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1
            pageControl!.currentPage = (Int)(page)
            currentPage = (Int)(page)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
         isPageControlUsed = false
    }
    
    func toCodeViewPad() -> Void
    {
//        if currentPage == 0{
//            firstViewController.getDates()
//        }else if currentPage == 1 {
//            secondViewController.getDates()
//        }else{
//            thirdViewController.getDates()
//        }
        
       self.navigationController?.pushViewController(PViewController(), animated: true)
        
       // self.navigationController?.pushViewController(PhotoViewController(), animated: true)

    }
}

//
//  InfoDetailController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/1.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class InfoDetailController: BaseViewController {

    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var pubTime: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
        //接受传进来的值
    var detailObject : Info?
    var navTitle : String?


    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getData()
    }
    
    func configureView() {
        self.navigationItem.title = navTitle
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*4)
        
        scrollView?.addSubview(publisher)
        scrollView?.addSubview(pubTime)
        scrollView?.addSubview(caption)
        scrollView?.addSubview(content)
        
        self.view.addSubview(scrollView!)
        if let object = self.detailObject {
            self.caption.text = object.caption
            self.publisher.text = object.publisher
            self.pubTime.text = object.createTime
        
        }
        
        
//        if let url = self.urlStr {
//            let dataImg : NSData = NSData(contentsOfURL: NSURL(string : url)!)!
//            self.big_video_img.image = UIImage(data: dataImg)
//            self.title = titleStr
//        }
    }
    
    func getData(){
        
        var parameters = [String : AnyObject]()
        parameters["article.id"] = detailObject?.id
    NetworkTool.sharedTools.getArticle(parameters) { (info, error) in
        
        if error == nil{
   
           self.content.text = info?.detail
           self.content.textLeftToAlign()
            print("\(self.content.frame)")
        }else{
           self.showHint("\(error)", duration: 2, yOffset: 0)
        
          }
        }
    
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}

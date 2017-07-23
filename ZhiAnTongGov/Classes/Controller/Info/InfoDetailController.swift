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
        setNavagation(navTitle!)
        //scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2)
        
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

    }
    
    func getData(){
        var parameters = [String : AnyObject]()
        parameters["article.id"] = detailObject?.id
        NetworkTool.sharedTools.getArticle(parameters) { (info, error) in
            if error == nil{
                self.content.attributedText = self.trimHtml(info.detail)
                self.content.textLeftToAlign()
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}

//
//  ViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/16.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController {
    let URL = "http://192.168.2.224:8029/huzhou/appUser/nosecuritycheck/login.xhtml?"
    let BaiduURL = "http://apis.haoservice.com/lifeservice/cook/query?"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func reloadData(){
        
        
        let parameters = [
            "username": "chenxue",
            "password":  "123456x",
            "type": 2,
            ]
//        let parameters = [
//            "menu": "土豆",
//            "pn":  1,
//            "rn": "10",
//            "key": "2ba215a3f83b4b898d0f6fdca4e16c7c",
//            ]
        
        
        Alamofire.request(.POST, URL, parameters:parameters ).responseJSON {response in
            
            //            debugPrint(response)
            switch response.result {
            case .Success:
                print(response.result.value)
                //把得到的JSON数据转为字典
                if let j = response.result.value as? NSDictionary{
                    //获取字典里面的key为数组
                    let Items = j.valueForKey("result")as! NSArray
                    //便利数组得到每一个字典模型
                    for dict in Items{
                        
                        print(dict)
                    }
                    
                }
            case .Failure(let error):
                
                print(error)
            }
            
            
        }
        
        
    }

}


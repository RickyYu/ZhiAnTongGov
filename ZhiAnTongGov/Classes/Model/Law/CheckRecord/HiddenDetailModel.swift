//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//隐患列表vo类
class HiddenDetailModel:BaseModel{
    
 
    var type:String!
    var content:String!
     var imageInfos = [ImageInfoModel]()
    
    var governDate:String!
    var findTime:String!
    var cleanUp :Bool!
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.type = dict["type"] as? String
        self.content = dict["content"] as? String
        self.governDate = dict["governDate"] as? String
        self.findTime = dict["findTime"] as? String
        self.cleanUp = dict["cleanUp"] as? Bool
        
        let image = JSON(dict["imagesInfo"]!)
        if let items = image.arrayObject {
            for item in items {
                let homeItem = ImageInfoModel(dict: item as! [String: AnyObject])
                self.imageInfos.append(homeItem)
            }
            
        }
    }
}












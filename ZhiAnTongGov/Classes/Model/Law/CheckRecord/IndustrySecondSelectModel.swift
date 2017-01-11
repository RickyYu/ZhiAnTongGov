//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//检查记录基本信息vo类
class IndustrySecondSelectModel:BaseModel{
    
    var id:Int!
    var content:String!
    var descriptions:String!
    
    init(dict: [String: AnyObject]) {
        self.id = dict["id"] as? Int
        self.content = dict["content"] as? String
        self.descriptions = dict["description"] as? String
    }
    
    
}












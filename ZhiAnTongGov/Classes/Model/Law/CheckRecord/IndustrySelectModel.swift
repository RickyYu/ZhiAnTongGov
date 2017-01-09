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
class IndustrySelectModel:BaseModel{
    
    var id:Int!
    var title:String!

    init(dict: [String: AnyObject]) {
        self.id = dict["id"] as? Int
        self.title = dict["title"] as? String
    }
}












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
class CheckPersonModel:BaseModel{
    
    var gridId:Int!
    var gridName:String!

    
    override init() {
        super.init()
    }
    init(dict: [String: AnyObject]) {
        
        self.gridId = dict["gridId"] as? Int
        self.gridName = dict["gridName"] as? String
  
    }
}












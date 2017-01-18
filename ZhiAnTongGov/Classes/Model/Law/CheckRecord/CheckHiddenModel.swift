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
class CheckHiddenModel:BaseModel{
    
    var id :Int!
    var createTime:String!
    var content :String!
    var repaired:Bool!
    var isBig:String!
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        self.createTime = dict["createTime"] as? String
        self.content = dict["content"] as? String
        self.repaired = dict["repaired"] as? Bool
        self.isBig = dict["isBig"] as? String
    }
}












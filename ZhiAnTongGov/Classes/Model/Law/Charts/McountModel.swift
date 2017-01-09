//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//月信息vo类
class McountModel:BaseModel{
    
    var byGov:Int!
    var byCom:Int!
    var dateMonth:String!
    var repairedNum:Int!

    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        self.byGov = dict["byGov"] as? Int
        self.byCom = dict["byCom"] as? Int
        self.dateMonth = dict["dateMonth"] as? String
        self.repairedNum = dict["repairedNum"] as? Int

        
    }
}












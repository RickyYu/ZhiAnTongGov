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
class HiddenModel:BaseModel{
    
    var hiddenId :Int!
    var createTime:String!
    var content :String!
    var typeCN:String!
    var repaired:Bool!
    var isBig:String!
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.hiddenId = dict["hiddenId"] as? Int
        self.createTime = dict["createTime"] as? String
        self.content = dict["content"] as? String
        self.typeCN = dict["typeCN"] as? String
        self.repaired = dict["repaired"] as? Bool
        self.isBig = dict["isBig"] as? String
    }
    
    func getParams1() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        params = [
            "hiddenId":String(self.hiddenId),
            "createTime":self.createTime,
            "content:":self.content,
             "typeCN:":self.typeCN,
              "repaired:":self.repaired,
               "isBig:":self.isBig,
               
        ]
        return  params
    }
}












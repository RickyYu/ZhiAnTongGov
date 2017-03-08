//
//  UnModifyModel.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/2/24.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//


import UIKit
import SwiftyJSON
//未整改隐患列表vo类
class UnModifyModel:BaseModel{
    
    var companyId:Int!
    var createTime:String!
    var deleted:Bool!
    var descriptions:String!
    var id :Int!
    var repaired:Bool!
    var sourceType:String!
    var take: Bool!
    var troubleId:Int!
    var type:Int!

    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.companyId = dict["companyId"] as? Int
        self.createTime = dict["createTime"] as? String
        self.deleted = dict["deleted"] as? Bool
        self.descriptions = dict["description"] as? String
        self.id = dict["id"] as? Int
        
        self.repaired = dict["repaired"] as? Bool
        self.sourceType = dict["sourceType"] as? String
        self.take = dict["take"] as? Bool
        
        self.troubleId = dict["troubleId"] as? Int
        self.type = dict["type"] as? Int

    }
    
    func getParams1() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        params = [
            "companyId":String(self.id),
            "createTime":self.createTime,
            "deleted:":String(self.deleted),
            "description":self.descriptions,
            "id":self.id,
            "repaired":String(self.repaired),
            "sourceType":self.sourceType,
            "take":self.take,
            "troubleId":String(self.troubleId),
            "type":String(self.type),
        ]
        return  params
    }
}

//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//行政处罚列表vo类
class PunishmentInfoModel:BaseModel{
    
    var id :Int!
    var fdDelegate:String!
    var address :String!
    var Remark:String!
    var punishmentUnit:String!
    var Content:String!
    var punishmentCause:String!
    var companyName:String!
    var punishmentType:String!
    var punishmentTime:String!
    
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        self.fdDelegate = dict["fdDelegate"] as? String
        self.address = dict["address"] as? String
        self.Remark = dict["Remark"] as? String
        self.punishmentUnit = dict["punishmentUnit"] as? String
        self.Content = dict["Content"] as? String
        self.punishmentCause = dict["punishmentCause"] as? String
        self.companyName = dict["companyName"] as? String
        self.punishmentType = dict["punishmentType"] as? String
        self.punishmentTime = dict["punishmentTime"] as? String
        
    }
}












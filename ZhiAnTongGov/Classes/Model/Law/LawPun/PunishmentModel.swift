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
class PunishmentModel:BaseModel{
    
    var id :Int!
    var punishmentTime:String!
    var punishmentId :Int!
    var punishmentType:String!
    var companyName:String!

    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        self.punishmentTime = dict["punishmentTime"] as? String
        self.punishmentId = dict["punishmentId"] as? Int
        self.punishmentType = dict["punishmentType"] as? String
        self.companyName = dict["companyName"] as? String
    }
}












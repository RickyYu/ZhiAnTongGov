//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//行政未处罚列表vo类
class UnPunishmentModel:BaseModel{
    
    var jcjlId :Int!
    var companyId:Int!
    var fcNum :Int!
    var hiddenNum:Int!
    var companyName:String!
    var cleanUpTimeLimit:String!
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.jcjlId = dict["jcjlId"] as? Int
        self.companyId = dict["companyId"] as? Int
        self.fcNum = dict["fcNum"] as? Int
        self.hiddenNum = dict["hiddenNum"] as? Int
        self.companyName = dict["companyName"] as? String
        self.cleanUpTimeLimit = dict["cleanUpTimeLimit"] as? String

    }
}












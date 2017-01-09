//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//图表数据vo类
class ChartModel:BaseModel{

    var dangerGov:String!
    var checkNum:String!
    var dangerCom:String!
    var unDangerNum:String!
    var callbackNum:String!
    var dangerNum:String!
    var mcountModels = [McountModel]()
    var rectifyRateNum:String!
    
    init(dict: [String: AnyObject]) {

        self.dangerGov = dict["dangerGov"] as? String
        self.checkNum = dict["checkNum"] as? String
        self.dangerCom = dict["dangerCom"] as? String
        self.unDangerNum = dict["unDangerNum"] as? String
        self.callbackNum = dict["callbackNum"] as? String
        self.dangerNum = dict["dangerNum"] as? String
        self.rectifyRateNum = dict["rectifyRateNum"] as? String
        let dictData = JSON(dict)
        if  let items = dictData["monthCounts"].arrayObject {
            for item in items{
                let data = McountModel(dict:item as! [String:AnyObject])
                 self.mcountModels.append(data)
            }
        }
       
    }
}












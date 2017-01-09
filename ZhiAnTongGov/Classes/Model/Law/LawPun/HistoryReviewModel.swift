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
class HistoryReviewModel:BaseModel{

    var callbackTime:String!
    var executer :String!
    var hiddenState:String!
   
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.callbackTime = dict["callbackTime"] as? String
        self.executer = dict["executer"] as? String
        self.hiddenState = dict["hiddenState"] as? String
    }
}












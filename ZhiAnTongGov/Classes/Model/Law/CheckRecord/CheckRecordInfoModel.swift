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
class CheckRecordInfoModel:BaseModel{
    
    var address:String!
    var companyName:String!
    var sendCleanUp:Bool!
    var noter:String!
    var executeUnit:String!
    var fdDelegate:String!
    var checkPersonModels = [CheckPersonModel]()

    
    init(dict: JSON) {
        let entity = dict["entity"].dictionaryObject!
        self.address = entity["address"] as? String
        self.companyName = entity["companyName"] as? String
        self.sendCleanUp = entity["sendCleanUp"] as? Bool
        self.noter = entity["noter"] as? String
        self.executeUnit = entity["executeUnit"] as? String
        self.fdDelegate = entity["fdDelegate"] as? String
        
        if let items = dict["json"].arrayObject {
            for item in items {
                let homeItem = CheckPersonModel(dict: item as! [String: AnyObject])
                self.checkPersonModels.append(homeItem)
            }
            
        }
        
      }
   
    }













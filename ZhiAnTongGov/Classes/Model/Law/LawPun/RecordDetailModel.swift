//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//初查记录vo类
class RecordDetailModel:BaseModel{
    
    var content:String!
    var noter :String!
    var  fdDelegateLink:String!
    var cleanUpTimeLimit:String!
    var executeUnit :String!
    var produceLocaleNoteId:Int!
    var checkTimeBegin :String!
    var address:String!
    var companyName :String!
    
   // var imagesInfo :String! 类
    var fdDelegate:String!
    var checkGround :String!
    var companyId :Int!
    var sendCleanUp:Bool!

    
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.content = dict["content"] as? String
        self.noter = dict["noter"] as? String
        self.fdDelegateLink = dict["fdDelegateLink"] as? String
        self.cleanUpTimeLimit = dict["cleanUpTimeLimit"] as? String
        
        self.executeUnit = dict["executeUnit"] as? String
        self.produceLocaleNoteId = dict["produceLocaleNoteId"] as? Int
        self.checkTimeBegin = dict["checkTimeBegin"] as? String
        
        self.address = dict["address"] as? String
        self.companyName = dict["companyName"] as? String
        self.fdDelegate = dict["fdDelegate"] as? String
        
        self.checkGround = dict["checkGround"] as? String
        self.companyId = dict["companyId"] as? Int
        self.sendCleanUp = dict["sendCleanUp"] as? Bool
    }
}












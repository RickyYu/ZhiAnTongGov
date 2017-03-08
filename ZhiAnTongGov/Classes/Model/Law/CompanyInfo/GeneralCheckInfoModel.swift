//
//  GeneralCheckInfoModel.swift
//  ZhiAnTongCpy
//
//  Created by Ricky on 2017/2/8.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//一般隐患检查vo类
class GeneralCheckInfoModel:BaseModel{
    
    var id :Int!
    var repair :Int!
    var gov :Bool!
    var hzProduceCleanUpID :Int!
    var bagId :Int!
    var check :Bool!
    var nowYear :Int!
    var descriptions :String!
    var industryName :String!
    var completedDateCriteriaString :String!
    var completedDateString :String!
    var new :Bool!
    var type :Int!
    var currentTime :String!
    var hzHiddenTroubleID :Int!
    var fileIdCom :String!
    var remarks :String!
    var companyPassId :Int!
    var linkTel :String!
    var repaired :Bool!
    var completedDate :String!
    var deleted :Bool!
    
    var sourceType:String!
    var rectificationPlanTime:String!
    var createTime:String!
    
    var linkMobile:String!
    var checkOpition:String!
    var linkMan:String!
    
    var fileFileName:String!
    var fileRealPath:String!
    var modifyTime:String!
    
    var sourceTypeCN:String!
    var danger:Bool!
    var fileFactName:String!
     var userId :Int!
    
    var num : Int!
    override init() {
        super.init()
    }
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        self.repair = dict["repair"] as? Int
        self.gov = dict["gov"] as? Bool
        self.hzProduceCleanUpID = dict["hzProduceCleanUpID"] as? Int
        
        self.bagId = dict["bagId"] as? Int
        self.check = dict["check"] as? Bool
        self.nowYear = dict["nowYear"] as? Int
        self.descriptions = dict["description"] as? String
        
        self.industryName = dict["industryName"] as? String
        self.completedDateCriteriaString = dict["completedDateCriteriaString"] as? String
        self.completedDateString = dict["completedDateString"] as? String
        self.new = dict["new"] as? Bool
        
        self.type = dict["type"] as? Int
        self.currentTime = dict["currentTime"] as? String
        self.hzHiddenTroubleID = dict["hzHiddenTroubleID"] as? Int
        self.fileIdCom = dict["fileIdCom"] as? String
        
        self.remarks = dict["remarks"] as? String
        self.companyPassId = dict["companyPassId"] as? Int
        self.linkTel = dict["linkTel"] as? String
        self.repaired = dict["repaired"] as? Bool
        
        self.completedDate = dict["completedDate"] as? String
        self.deleted = dict["deleted"] as? Bool
        self.sourceType = dict["sourceType"] as? String
        self.rectificationPlanTime = dict["rectificationPlanTime"] as? String
        
        self.createTime = dict["createTime"] as? String
        self.linkMobile = dict["linkMobile"] as? String
        
        self.checkOpition = dict["checkOpition"] as? String
        self.linkMan = dict["linkMan"] as? String
        
        self.fileFileName = dict["fileFileName"] as? String
        self.fileRealPath = dict["fileRealPath"] as? String
        
        self.modifyTime = dict["modifyTime"] as? String
        self.sourceTypeCN = dict["sourceTypeCN"] as? String
        
        self.danger = dict["danger"] as? Bool
        self.fileFactName = dict["fileFactName"] as? String
        
        self.userId = dict["userId"] as? Int
    }
 
}
//
//  MajorCheckInfoModel.swift
//  ZhiAnTongCpy
//
//  Created by Ricky on 2017/2/8.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//重大隐患检查vo类
class MajorCheckInfoModel:BaseModel{
    
    var govCoordination :Bool!
    var fouthArea:Int!
    var gov:Bool!
    var id:Int!
    
    var industryParameters :String!
    var startTime:String!
    var chargePerson:String!
    var checkInfoId:Int!
    
    var fillMan :String!
    var nowYear:Int!
    var target:Bool!
    var descriptions:String!
    
    var new :Bool!
    var dangerNo:String!
    var safetyMethod:Bool!
    var resource:Bool!
    
    var noteId :Int!
    var endTime:String!
    var fileIdCom:String!
    var startUp:Bool!
    
    var isRollcall :String!
    var fullStopProduct:Bool!
    var fillDate:String!
    var thirdArea:Int!
    
    var partStopProduct :Bool!
    var linkTel:String!
    var firstArea:Int!
    var governMoney:Int!
    
    var fileContents :String!
    var deleted:Bool!
    var sourceType:String!
    var secondArea:Int!
    
    var uploadFiles :String!
    var createTime:String!
    var dangerAdd:String!
    var checkOpition:Int!
    
    var fifthArea :Int!
    var goods:Bool!
    var fileFileName:String!
    var fileRealPath:String!
    
    var isGorver :String!
    var linkMan:String!
    var fileFactName:String!
    var finishDate:String!
    
    var linkMobile :String!
    var modifyTime:String!
    var fileFileNames:String!
    var userId:Int!
    
    var num : Int!
    
    var emphasisProject : Bool!
    
    override init() {
        super.init()
    }
    init(dict: [String: AnyObject]) {
        super.init()
        self.govCoordination = dict["govCoordination"] as? Bool
        self.fouthArea = dict["fouthArea"] as? Int
        self.gov = dict["gov"] as? Bool
        self.id = dict["id"] as? Int
        
        self.industryParameters = dict["industryParameters"] as? String
        self.startTime = dict["startTime"] as? String
        self.chargePerson = dict["chargePerson"] as? String
        self.checkInfoId = dict["checkInfoId"] as? Int
        
        self.fillMan = dict["fillMan"] as? String
        self.nowYear = dict["nowYear"] as? Int
        self.target = dict["target"] as? Bool
        self.descriptions = dict["description"] as? String
        
        self.new = dict["new"] as? Bool
        self.dangerNo = dict["dangerNo"] as? String
        self.safetyMethod = dict["safetyMethod"] as? Bool
        self.resource = dict["resource"] as? Bool
        
        self.noteId = dict["noteId"] as? Int
        self.endTime = dict["endTime"] as? String
        self.fileIdCom = dict["fileIdCom"] as? String
        self.startUp = dict["startUp"] as? Bool
        
        self.isRollcall = dict["isRollcall"] as? String
        self.fullStopProduct = dict["fullStopProduct"] as? Bool
        self.fillDate = dict["fillDate"] as? String
        self.thirdArea = dict["thirdArea"] as? Int
        
        self.partStopProduct = dict["partStopProduct"] as? Bool
        self.linkTel = dict["linkTel"] as? String
        self.firstArea = dict["firstArea"] as? Int
        self.governMoney = dict["governMoney"] as? Int
        
        self.fileContents = dict["fileContents"] as? String
        self.deleted = dict["deleted"] as? Bool
        self.sourceType = dict["sourceType"] as? String
        self.secondArea = dict["secondArea"] as? Int
        
        self.uploadFiles = dict["uploadFiles"] as? String
        self.createTime = dict["createTime"] as? String
        self.dangerAdd = dict["dangerAdd"] as? String
        self.checkOpition = dict["checkOpition"] as? Int
        
        self.fifthArea = dict["fifthArea"] as? Int
        self.goods = dict["goods"] as? Bool
        self.fileFileName = dict["fileFileName"] as? String
        self.fileRealPath = dict["fileRealPath"] as? String
        
        self.isGorver = dict["isGorver"] as? String
        self.linkMan = dict["linkMan"] as? String
        self.fileFactName = dict["fileFactName"] as? String
        self.finishDate = dict["finishDate"] as? String
        
        self.linkMobile = dict["linkMobile"] as? String
        self.modifyTime = dict["modifyTime"] as? String
        self.fileFileNames = dict["fileFileNames"] as? String
        self.userId = dict["userId"] as? Int
        if (dict["emphasisProject"] != nil) {
            self.emphasisProject = dict["emphasisProject"] as? Bool
        }else{
            self.emphasisProject = false
         }
        
    }

}

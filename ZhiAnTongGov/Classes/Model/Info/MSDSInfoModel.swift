//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//信息查询vo类
class MSDSInfoModel:BaseModel{
    
    var id :Int!
    var burningProperty:String!
    var criticalPressure:String!
    var englishName:String!
    var jianguiFireRating:String!
    var largeLeakageIsolation:String!
    var largeLeakageDay:String!
    var protectiveClothing:String!
    var chineseName:String!
    var invasionPathway:String!
    var molecularWeight:String!
    var water:String!
    var polymerizationHazard:String!
    var riskCharacteristics:String!
    var contactLimit:String!
    var tabooObject:String!
    var boilingPoint:String!
    var meltingPoint:String!
    var skinHarm:String!
    var eyeHarm:String!
    var saturatedSteamPressure:String!
    var handingInformation:String!
    var molecularFormula:String!
    var inhalationHarm:String!
    var engineeringControl:String!
    var atmosphere:String!
    var packagingCategory:String!
    var appearanceAndProperties:String!
    var fireMethod:String!
    var imdg:String!
    var lessLeakageDay:String!
    var solubility:String!
    var flashPoint:String!
    var riskCategories:String!
    var eyeprotection:String!
    var cas:String!
    var upperExplosion:String!
    var healthHarm:String!
    var lowerExplosion:String!
    var attentions:String!
    var lessLeakageIsolation:String!
    var toxicity:String!
    var autoignitionTemperature:String!
    var mainUse:String!
    var new:String!
    var rtecs:String!
    var lessLeakageEvening:String!
    var precursorProduct:String!
    var un:String!
    var largeLeakageEvening:String!
    var combustionHeat:String!
    var avoidContactConditions:String!
    var leakageDisposal:String!
    var stability:String!
    var dangerousGoodsNumber:String!
    var handProtection:String!
    var criticalTemperature:String!
    var dangerousGoodsPackingMark:String!
    var respiratorySystemProtection:String!
    
       var ingestionHarm:String!

 
 
    
    
    init(dict: [String: AnyObject]) {
        super.init()
       self.id = dict["id"] as? Int
        self.burningProperty = dict["burningProperty"] as? String
        self.criticalPressure = dict["criticalPressure"] as? String
        self.englishName = dict["englishName"] as? String
        self.jianguiFireRating = dict["jianguiFireRating"] as? String
        self.largeLeakageIsolation = dict["largeLeakageIsolation"] as? String
        self.largeLeakageDay = dict["largeLeakageDay"] as? String
        self.protectiveClothing = dict["protectiveClothing"] as? String
        self.chineseName = dict["chineseName"] as? String
        
        
        self.invasionPathway = dict["invasionPathway"] as? String
        self.molecularWeight = dict["molecularWeight"] as? String
        self.water = dict["water"] as? String
        self.polymerizationHazard = dict["polymerizationHazard"] as? String
        self.riskCharacteristics = dict["riskCharacteristics"] as? String
        self.contactLimit = dict["contactLimit"] as? String
        self.tabooObject = dict["tabooObject"] as? String
        self.boilingPoint = dict["boilingPoint"] as? String
        
        self.meltingPoint = dict["meltingPoint"] as? String
        self.skinHarm = dict["skinHarm"] as? String
        self.eyeHarm = dict["eyeHarm"] as? String
        self.saturatedSteamPressure = dict["saturatedSteamPressure"] as? String
        self.handingInformation = dict["handingInformation"] as? String
        
        self.molecularFormula = dict["molecularFormula"] as? String
        self.inhalationHarm = dict["inhalationHarm"] as? String
        self.engineeringControl = dict["engineeringControl"] as? String
        self.atmosphere = dict["atmosphere"] as? String
        self.packagingCategory = dict["packagingCategory"] as? String
        
        self.fireMethod = dict["fireMethod"] as? String
        self.inhalationHarm = dict["inhalationHarm"] as? String
        self.imdg = dict["imdg"] as? String
        self.lessLeakageDay = dict["lessLeakageDay"] as? String
        self.solubility = dict["solubility"] as? String
        
        self.fireMethod = dict["fireMethod"] as? String
        self.inhalationHarm = dict["inhalationHarm"] as? String
        self.imdg = dict["imdg"] as? String
        self.lessLeakageDay = dict["lessLeakageDay"] as? String
        self.solubility = dict["solubility"] as? String
        
        self.flashPoint = dict["flashPoint"] as? String
        self.riskCategories = dict["riskCategories"] as? String
        self.eyeprotection = dict["eyeprotection"] as? String
        self.cas = dict["cas"] as? String
        self.upperExplosion = dict["upperExplosion"] as? String
        
        self.healthHarm = dict["healthHarm"] as? String
        self.lowerExplosion = dict["lowerExplosion"] as? String
        self.attentions = dict["attentions"] as? String
        self.lessLeakageIsolation = dict["lessLeakageIsolation"] as? String
        self.toxicity = dict["toxicity"] as? String
        
        
        self.autoignitionTemperature = dict["autoignitionTemperature"] as? String
        self.mainUse = dict["mainUse"] as? String
        self.new = dict["new"] as? String
        self.rtecs = dict["rtecs"] as? String
        self.lessLeakageEvening = dict["lessLeakageEvening"] as? String
        
        self.precursorProduct = dict["precursorProduct"] as? String
        self.un = dict["un"] as? String
        self.largeLeakageEvening = dict["largeLeakageEvening"] as? String
        self.combustionHeat = dict["combustionHeat"] as? String
        self.avoidContactConditions = dict["avoidContactConditions"] as? String
        
        self.leakageDisposal = dict["leakageDisposal"] as? String
        self.stability = dict["stability"] as? String
        self.dangerousGoodsNumber = dict["dangerousGoodsNumber"] as? String
        self.handProtection = dict["handProtection"] as? String
        self.criticalTemperature = dict["criticalTemperature"] as? String
        
        self.criticalTemperature = dict["criticalTemperature"] as? String
        self.dangerousGoodsPackingMark = dict["dangerousGoodsPackingMark"] as? String
        self.respiratorySystemProtection = dict["respiratorySystemProtection"] as? String
        
        self.ingestionHarm = dict["ingestionHarm"] as? String
           self.appearanceAndProperties = dict["appearanceAndProperties"] as? String
        
        
        
    }
}












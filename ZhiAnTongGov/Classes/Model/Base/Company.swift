//
//  Company.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/23.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import Foundation
import SwiftyJSON
class Company: BaseModel {
    var id: UInt!
    /// 企业名称
    var companyName: String
    /// 统一信用代码
    var regNum: String
    /// 组织机构代码
    var setupNumber: String
    /// 所属行业
    var tradeTypeText: String
    //-----------------------------以上是只读-------------------
    /// 所在地址
    var address: String
    /// 经营范围
    var businessScope: String
    /// 经济类型1
    var economicType1: String
    /// 经济类型2
    var economicType2: String
    /// 法人代表
    var fddelegate: String
    /// 主管部门
    var govAdminOrg: String
    /// 国民经济分类1
    var naEcoType1: String
    /// 国民经济分类2
    var naEcoType2: String
    /// 企业规模
    var productionScale: String
    /// 注册地址
    var regAddress: String
    /// 安管负责人
    var safetyMngPerson: String
    var firstArea: String
    var fouthArea: String
    var secondArea: String
    var thirdArea: String
    
    /// 企业基本信息
    var company: JSON
    /// 国民经济分类大类
    var nationalEconomicEnums: JSON
    /// 二级国民经济分类
    var childNationalEconomicEnums: JSON
    /// 经济类型大类
    var economyKindEnums: JSON
    /// 子类经济类型
    var childEconomyKindEnums: JSON
    /// 企业规模
    var companyScaleEnums: JSON
    
    init(json: JSON) {
        self.company = json["data"]["company"]
        self.nationalEconomicEnums = json["data"]["nationalEconomicEnums"]
        self.childNationalEconomicEnums = json["data"]["childNationalEconomicEnums"]
        self.economyKindEnums = json["data"]["economyKindEnums"]
        self.childEconomyKindEnums = json["data"]["childEconomyKindEnums"]
        self.companyScaleEnums = json["data"]["companyScaleEnums"]
        self.id = company["id"].uInt
        self.address = AppTools.JSON2String(company["address"])
        self.businessScope = AppTools.JSON2String(company["businessScope"])
        self.companyName = AppTools.JSON2String(company["companyName"])
        self.economicType1 = AppTools.JSON2String(company["economicType1"])
        self.economicType2 = AppTools.JSON2String(company["economicType2"])
        self.fddelegate = AppTools.JSON2String(company["fddelegate"])
        self.firstArea = AppTools.JSON2String(company["firstArea"])
        self.fouthArea = AppTools.JSON2String(company["fouthArea"])
        self.secondArea = AppTools.JSON2String(company["secondArea"])
        self.thirdArea = AppTools.JSON2String(company["thirdArea"])
        self.govAdminOrg = AppTools.JSON2String(company["govAdminOrg"])
        self.naEcoType1 = AppTools.JSON2String(company["naEcoType1"])
        self.naEcoType2 = AppTools.JSON2String(company["naEcoType2"])
        self.productionScale = AppTools.JSON2String(company["productionScale"])
        self.regAddress = AppTools.JSON2String(company["regAddress"])
        self.regNum = AppTools.JSON2String(company["regNum"])
        self.safetyMngPerson = AppTools.JSON2String(company["safetyMngPerson"])
        self.setupNumber = AppTools.JSON2String(company["setupNumber"])
        self.tradeTypeText = AppTools.JSON2String(company["tradeTypeText"])
    }
    
    func getCells() -> Dictionary<Int, [Cell]>{
        return [
            0:[
                Cell(fieldName: "companyName", image: "company_dwmc", title: "单位名称", value: self.companyName, state: .READ),
                Cell(fieldName: "regAddress", image: "company_zcdz", title: "注册地址", value: self.regAddress, state: .READ),
                Cell(fieldName: "address", image: "company_szdz", title: "所在地址", value: self.address, state: .READ),
                Cell(fieldName: "setupNumber", image: "company_zzjgdm", title: "组织机构代码", value: self.setupNumber, state: .READ),
                Cell(fieldName: "tradeTypeText", image: "company_sshy", title: "所属行业", value: self.tradeTypeText, state: .READ)
            ],
            1:[
                Cell(fieldName: "area", image: "company_szqy", title: "所在区域", value: self.getAreaCN(), state: .AREA),
                Cell(fieldName: "govAdminOrg", image: "company_zgbm", title: "主管部门", value: self.govAdminOrg, state: .TEXT, maxLength: 20),
                Cell(fieldName: "economicType", image: "company_jjlx", title: "经济类型", value: self.getEconomicTypeCN(), state: .ENUM),
                Cell(fieldName: "naEcoType", image: "company_gmjjfl", title: "国民经济分类", value: self.getNaEcoTypeCN(), state: .ENUM)
            ],
            2:[
                Cell(fieldName: "fddelegate", image: "company_frdb", title: "法人代表", value: self.fddelegate, state: .TEXT, maxLength: 40),
                Cell(fieldName: "safetyMngPerson", image: "company_agfzr", title: "安管负责人", value: self.safetyMngPerson, state: .TEXT, maxLength: 20),
                Cell(fieldName: "productionScale", image: "company_qygm", title: "企业规模", value: self.getProductionScaleCN(), state: .ENUM),
                Cell(fieldName: "businessScope", image: "company_jyfw", title: "经营范围", value: self.businessScope, state: .MULTI_TEXT, maxLength: 2000)
            ]
        ]
    }
    
    func getAreaCN() -> String {
        var areaNames = [String]()
        if !self.firstArea.isEmpty {
            areaNames.append(AppTools.getAreaCodeByName(self.firstArea))
        }
        if !self.secondArea.isEmpty {
            areaNames.append(AppTools.getAreaCodeByName(self.secondArea))
        }
        if !self.thirdArea.isEmpty {
            areaNames.append(AppTools.getAreaCodeByName(self.thirdArea))
        }
        if !self.fouthArea.isEmpty {
            areaNames.append(AppTools.getAreaCodeByName(self.fouthArea))
        }
        return areaNames.joinWithSeparator(" ")
    }
    
    func getEconomicTypeCN() -> String {
        if self.economicType1.isEmpty {
            return ""
        }
        let v1 = getCode2CN(self.economyKindEnums, code: self.economicType1)
        if self.economicType2.isEmpty {
            return v1
        }
        let v2 = getCode2CN(self.childEconomyKindEnums, code: self.economicType2)
        return "\(v1) \(v2)"
    }
    
    func getNaEcoTypeCN() -> String {
        if self.naEcoType1.isEmpty {
            return ""
        }
        let v1 = getCode2CN(self.nationalEconomicEnums, code: self.naEcoType1)
        if self.naEcoType2.isEmpty {
            return v1
        }
        let v2 = getCode2CN(self.childNationalEconomicEnums, code: self.naEcoType2)
        return "\(v1) \(v2)"
    }
    
    func getProductionScaleCN() -> String {
        return getCode2CN(self.companyScaleEnums, code: self.productionScale)
    }
    
    func getCode2CN(jsons: JSON, code: String) -> String {
        for json in jsons.array! {
            if AppTools.JSON2String(json["code"]) == code {
                return AppTools.JSON2String(json["name"])
            }
        }
        return ""
    }
    
    func getCode2EnumObj(jsons: JSON, code: String) -> (id: UInt, fatherId: UInt, code: String, name: String) {
        for json in jsons.array! {
            if AppTools.JSON2String(json["code"]) == code {
                return (json["id"].uInt!, json["fatherId"].uInt!, AppTools.JSON2String(json["code"]), AppTools.JSON2String(json["name"]))
            }
        }
        return (0, 0, "", "")
    }
    
    override func getClassAllPropertys() -> [String] {
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.alloc(0)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        
        for i in 0..<countInt {
            let temp = buff[i]
            let tempPro = property_getName(temp)
            let proper = String.init(UTF8String: tempPro)
            result.append(proper!)
        }
        return result
    }
    
    func getParams() -> Dictionary<String, String> {
        var params = Dictionary<String, String>()
        for temp in getClassAllPropertys() {
            let value  =  AppTools.anyObject2String(self.valueForKey(temp)!)
            params.updateValue(value, forKey: "companyVo.\(temp)")
        }
        return  params
    }
}
//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//企业信息vo类
class CompanyInfoModel:BaseModel{
    
    var id :Int!
    var tradeBig:String!
    var businessRegNumber:String!
    var phone:String!
    var tradeSma:String!
    var secondArea:Int!
    var isProduction:Bool!
    var tradeMid:String!
    var tradeType:String!
    var address:String!
    var tradeTypes:String!
    var companyName:String!
    var firstArea:Int!
    var economyKind:String!
    var fdDelegate:String!
    var isEnterprise:String!
    var thirdArea:Int!
    //var organCode:String!  类
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        self.firstArea = dict["firstArea"] as? Int
        self.secondArea = dict["secondArea"] as? Int
        self.thirdArea = dict["thirdArea"] as? Int
        self.companyName = dict["companyName"] as? String
        self.tradeBig = dict["tradeBig"] as? String
        self.businessRegNumber = dict["businessRegNumber"] as? String
        self.phone = dict["phone"] as? String
        self.tradeSma = dict["tradeSma"] as? String ?? ""
        self.isProduction = dict["isProduction"] as? Bool
        self.tradeMid = dict["tradeMid"] as? String ?? ""
        self.tradeType = dict["tradeType"] as? String
        self.address = dict["address"] as? String
        self.tradeTypes = dict["tradeTypes"] as? String
        self.companyName = dict["companyName"] as? String
        self.economyKind = dict["economyKind"] as? String
        self.fdDelegate = dict["fdDelegate"] as? String
        self.isEnterprise = dict["isEnterprise"] as? String
        
    }
}












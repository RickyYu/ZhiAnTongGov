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
class CpyInfoModel:BaseModel,NSCoding{
    //企业ID
    var id:Int!
    //企业名称
    var companyName:String!
    var fdDelegate:String!
    //企业区域划分
    var firstArea:Int!
    var secondArea:Int!
    var thirdArea:Int!
    var x:Double! //lng 经度
    var y:Double! //lat 纬度
    
    override init() {
        super.init()
    }
    


    
    // MARK: - 序列化和反序列化
    private let id_Key = "id"
    private let companyName_Key = "companyName"
    private let fdDelegate_Key = "fdDelegate"
    private let firstArea_Key = "firstArea"
    private let secondArea_Key = "secondArea"
    private let thirdArea_Key = "thirdArea"
    
    //序列化
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: id_Key)
        aCoder.encodeObject(companyName, forKey: companyName_Key)
        aCoder.encodeObject(fdDelegate, forKey: fdDelegate_Key)
        aCoder.encodeObject(firstArea, forKey: firstArea_Key)
        aCoder.encodeObject(secondArea, forKey: secondArea_Key)
        aCoder.encodeObject(thirdArea, forKey: thirdArea_Key)
    }
    
    //反序列化
    required init?(coder aDecoder: NSCoder) {
        id =  aDecoder.decodeObjectForKey(id_Key) as? Int
        companyName = aDecoder.decodeObjectForKey(companyName_Key) as? String
        fdDelegate =  aDecoder.decodeObjectForKey(fdDelegate_Key) as? String
        firstArea = aDecoder.decodeObjectForKey(firstArea_Key) as? Int
        secondArea = aDecoder.decodeObjectForKey(secondArea_Key) as? Int
        thirdArea = aDecoder.decodeObjectForKey(thirdArea_Key) as? Int
    }
    
    
    init(json:JSON){
        self.id = json["id"].int!
        self.companyName = json["companyName"].string!
        self.fdDelegate = json["fdDelegate"].string!
        self.firstArea = json["firstArea"].int!
        self.secondArea = json["secondArea"].int!
        self.thirdArea = json["thirdArea"].int!
    }
    
    
    //    init(dict: [String : AnyObject]) {
    //        super.init()
    //        setValuesForKeysWithDictionary(dict)
    //    }
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        self.companyName = dict["companyName"] as? String
        self.fdDelegate = dict["fdDelegate"] as? String
        self.firstArea = dict["firstArea"] as? Int
        self.secondArea = dict["secondArea"] as? Int
        self.thirdArea = dict["thirdArea"] as? Int
        self.x = dict["x"] as? Double
        self.y = dict["y"] as? Double
    
    }
    
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    // MARK: - 保存和获取所有分类
    static let CpyInfoModelsKey = "CpyInfoModelsKey"
    /**
     保存所有的分类
     
     - parameter categories: 分类数组
     */
    class func savaCpyInfoModels(cpyInfoModels: [CpyInfoModel])
    {
        let data = NSKeyedArchiver.archivedDataWithRootObject(cpyInfoModels)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: CpyInfoModel.CpyInfoModelsKey)
    }
    
    /**
     取出本地保存的分类
     
     - returns: 分类数组或者nil
     */
    class func loadLocalCpyInfoModels() -> [CpyInfoModel]?
    {
        if let array = NSUserDefaults.standardUserDefaults().objectForKey(CpyInfoModel.CpyInfoModelsKey)
        {
            return NSKeyedUnarchiver.unarchiveObjectWithData(array as! NSData) as? [CpyInfoModel]
        }
        return nil
    }
    
    
}

//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON

//检查记录信息vo类
class RecordInfoModel:BaseModel,NSCoding{
    //企业ID
    var id:Int!
    var checkGround:String!
    var checkTimeBegin:String!
    var content:String!
    var executeUnit:String!
    var hzCompanyId:Int!
    var isReview:Bool!
    var punishState:Bool!
    var wzgNum:String!

    
    // MARK: - 序列化和反序列化
    private let id_Key = "id"
    private let checkGround_Key = "checkGround"
    private let checkTimeBegin_Key = "checkTimeBegin"
    private let content_Key = "content"
    private let executeUnit_Key = "executeUnit"
    private let hzCompanyId_Key = "hzCompanyId"
      private let isReview_Key = "isReview"
      private let punishState_Key = "punishState"
      private let wzgNum_Key = "wzgNum"
    
    //序列化
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: id_Key)
        aCoder.encodeObject(checkGround, forKey: checkGround_Key)
        aCoder.encodeObject(checkTimeBegin, forKey: checkTimeBegin_Key)
        aCoder.encodeObject(content, forKey: content_Key)
        aCoder.encodeObject(executeUnit, forKey: executeUnit_Key)
        aCoder.encodeObject(hzCompanyId, forKey: hzCompanyId_Key)
        aCoder.encodeObject(isReview, forKey: isReview_Key)
        aCoder.encodeObject(punishState, forKey: punishState_Key)
        aCoder.encodeObject(wzgNum, forKey: wzgNum_Key)
        
        
    }
    
    //反序列化
    required init?(coder aDecoder: NSCoder) {
        id =  aDecoder.decodeObjectForKey(id_Key) as? Int
        checkGround = aDecoder.decodeObjectForKey(checkGround_Key) as? String
        checkTimeBegin =  aDecoder.decodeObjectForKey(checkTimeBegin_Key) as? String
        content = aDecoder.decodeObjectForKey(content_Key) as? String
        executeUnit = aDecoder.decodeObjectForKey(executeUnit_Key) as? String
        hzCompanyId = aDecoder.decodeObjectForKey(hzCompanyId_Key) as? Int
        isReview = aDecoder.decodeObjectForKey(isReview_Key) as? Bool
        punishState = aDecoder.decodeObjectForKey(punishState_Key) as? Bool
        wzgNum = aDecoder.decodeObjectForKey(wzgNum_Key) as? String
    }
    
    
    init(json:JSON){
        self.id = json["id"].int!
        self.checkGround = json["companyName"].string! ?? ""
        self.checkTimeBegin = json["fdDelegate"].string!
        self.content = json["firstArea"].string!
        self.executeUnit = json["secondArea"].string!
        self.hzCompanyId = json["thirdArea"].int!
        self.isReview = json["firstArea"].bool!
        self.punishState = json["secondArea"].bool!
        self.wzgNum = json["thirdArea"].string!
    }
    
    
    //    init(dict: [String : AnyObject]) {
    //        super.init()
    //        setValuesForKeysWithDictionary(dict)
    //    }
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        
        do{
        try self.checkGround = dict["checkGround"] as? String ?? ""
        }catch{
            self.checkGround = ""
        }
        self.checkTimeBegin = dict["checkTimeBegin"] as? String
        self.content = dict["content"] as? String
        self.executeUnit = dict["executeUnit"] as? String
        self.hzCompanyId = dict["hzCompanyId"] as? Int
        self.isReview = dict["isReview"] as? Bool
        self.punishState = dict["punishState"] as? Bool
        self.wzgNum = dict["wzgNum"] as? String
    }
    
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    // MARK: - 保存和获取所有分类
    static let RecordInfoModelsKey = "RecordInfoModelsKey"
    /**
     保存所有的分类
     
     - parameter categories: 分类数组
     */
    class func savaRecordInfoModels(recordInfoModels: [RecordInfoModel])
    {
        let data = NSKeyedArchiver.archivedDataWithRootObject(recordInfoModels)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: RecordInfoModel.RecordInfoModelsKey)
    }
    
    /**
     取出本地保存的分类
     
     - returns: 分类数组或者nil
     */
    class func loadLocalRecordInfoModels() -> [RecordInfoModel]?
    {
        if let array = NSUserDefaults.standardUserDefaults().objectForKey(RecordInfoModel.RecordInfoModelsKey)
        {
            return NSKeyedUnarchiver.unarchiveObjectWithData(array as! NSData) as? [RecordInfoModel]
        }
        return nil
    }
    
    
}

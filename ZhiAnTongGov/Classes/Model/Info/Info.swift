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
class Info:BaseModel,NSCoding{
    //修改时间
    var modifyTime:String!
    //创建时间
    var createTime:String!
    //新闻id
    var id :Int!
    //说明
    var caption:String!
    //发布单位
    var publisher:String!
    //文章主内容
    var detail:String!
    
    // MARK: - 序列化和反序列化
    private let modifyTime_Key = "modifyTime"
    private let createTime_Key = "createTime"
    private let id_Key = "id"
    private let caption_Key = "caption"
    private let publisher_Key = "publisher"
    
    //序列化
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(modifyTime, forKey: modifyTime_Key)
        aCoder.encodeObject(createTime, forKey: createTime_Key)
        aCoder.encodeObject(id, forKey: id_Key)
        aCoder.encodeObject(caption, forKey: caption_Key)
        aCoder.encodeObject(publisher, forKey: publisher_Key)
    }
    
    //反序列化
    required init?(coder aDecoder: NSCoder) {
        modifyTime = aDecoder.decodeObjectForKey(modifyTime_Key) as? String
        createTime =  aDecoder.decodeObjectForKey(createTime_Key) as? String
        id =  aDecoder.decodeObjectForKey(id_Key) as? Int
        caption = aDecoder.decodeObjectForKey(caption_Key) as? String
        publisher = aDecoder.decodeObjectForKey(publisher_Key) as? String
    }

    
    init(json:JSON){
        self.modifyTime = json["modifytime"].string!
        self.createTime = json["createtime"].string!
        self.id = json["id"].int!
        self.caption = json["caption"].string!
        self.publisher = json["publisher"].string!
        self.detail = json["detail"].string!
    }
    
    
//    init(dict: [String : AnyObject]) {
//        super.init()
//        setValuesForKeysWithDictionary(dict)
//    }
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.modifyTime = dict["modifytime"] as? String
        self.createTime = dict["createtime"] as? String
        self.id = dict["id"] as? Int
        self.caption = dict["caption"] as? String
        self.publisher = dict["publisher"] as? String
        self.detail = dict["detail"] as? String
    }
    
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    // MARK: - 保存和获取所有分类
    static let InfosKey = "InfosKey"
    /**
     保存所有的分类
     
     - parameter categories: 分类数组
     */
    class func savaInfos(infos: [Info])
    {
        let data = NSKeyedArchiver.archivedDataWithRootObject(infos)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: Info.InfosKey)
    }
    
    /**
     取出本地保存的分类
     
     - returns: 分类数组或者nil
     */
    class func loadLocalInfos() -> [Info]?
    {
        if let array = NSUserDefaults.standardUserDefaults().objectForKey(Info.InfosKey)
        {
            return NSKeyedUnarchiver.unarchiveObjectWithData(array as! NSData) as? [Info]
        }
        return nil
    }
    
    
}

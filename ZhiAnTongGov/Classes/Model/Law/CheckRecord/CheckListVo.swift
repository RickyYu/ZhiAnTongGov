//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

//检查记录基本信息vo类
class CheckListVo:BaseModel{
    /**
     * 单位名称
     */
    var companyname:String!
    /**
     * 公司dizhi
     */
    var companyadress:String!
    /**
     * 联系人
     */
    var companylxr:String!
    /**
     * 选择条目内容
     */
    var content:String!
    /**
     * 公司id
     */
    var companyId:String!
    /**
     * checkid行业检查表id
     */
    var checkId:String!
    /**
     * 隐患部位
     */
    var place:String!
    /**
     * 联系方式
     */
    var phone:String!
    /**
     * 检查人记录人
     */
    var people:String!
    /**
     * 执法单位
     */
    var law:String!
    /**
     * 责令整改时间
     */
    var zgtime:String!
    /**
     * 检查时间
     */
    var checktime:String!
    /**
     * 发送整改通知书
     */
    var check:Bool!
    
    /**
     * 参与检查人
     */
    var listCb = [Int]()
    /**
     * 检查事项
     */
      var listCheck = [Int]()
    /**
     * 检查事项全部
     */
     var listAll = [Int]()
    var listHy = [IndustrySecondSelectModel]()
    
    // 照片
    var listfile = [UIImage]()
    
    var nowcontent:String!
    var lxr:String!
    
    
    /**
     * 检查人id
     */
     var c1:Int!
     var c2:Int!
     var c3:Int!
     var c4:Int!
    
    /**
     * 检查人名字
     */
     var cbname:String!
     var cbname2:String!
     var cbname3:String!
     var cbname4:String!
    
    
//    // MARK: - 序列化和反序列化
//    private let modifyTime_Key = "modifyTime"
//    private let createTime_Key = "createTime"
//    private let id_Key = "id"
//    private let caption_Key = "caption"
//    private let publisher_Key = "publisher"
//    
//    //序列化
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(modifyTime, forKey: modifyTime_Key)
//        aCoder.encodeObject(createTime, forKey: createTime_Key)
//        aCoder.encodeObject(id, forKey: id_Key)
//        aCoder.encodeObject(caption, forKey: caption_Key)
//        aCoder.encodeObject(publisher, forKey: publisher_Key)
//    }
//    
//    //反序列化
//    required init?(coder aDecoder: NSCoder) {
//        modifyTime = aDecoder.decodeObjectForKey(modifyTime_Key) as? String
//        createTime =  aDecoder.decodeObjectForKey(createTime_Key) as? String
//        id =  aDecoder.decodeObjectForKey(id_Key) as? Int
//        caption = aDecoder.decodeObjectForKey(caption_Key) as? String
//        publisher = aDecoder.decodeObjectForKey(publisher_Key) as? String
//    }
    
    
    
    override init() {
        super.init()
    }
}












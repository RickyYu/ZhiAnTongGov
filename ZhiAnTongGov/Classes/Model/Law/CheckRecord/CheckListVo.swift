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
    var listfile = [FILE]()
    
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
    
    
    
    
    override init() {
        super.init()
    }
}












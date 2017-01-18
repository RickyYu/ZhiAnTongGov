//
//  OYConst.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

/// RGBA的颜色设置
func YMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func YMGlobalColor() -> UIColor {
    return YMColor(240, g: 240, b: 240, a: 1)
}

/// 红色
func YMGlobalRedColor() -> UIColor {
    return YMColor(245, g: 80, b: 83, a: 1.0)
}

/// 红色
func YMGlobalDeapBlueColor() -> UIColor {
    return YMColor(0, g: 191, b: 255, a: 1.0)
}

let PAGE_SIZE = 12
let LOAD_FINISH = "加载完毕"
//最大上传图片数
let IMAGE_MAX_SELECTEDNUM = 9


/// iPhone 5
let isIPhone5 = SCREEN_WIDTH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREEN_WIDTH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREEN_WIDTH == 736 ? true : false

//处罚类型
func getPunType(key:String)->String{
    switch key {
    case "警告":
        return "punishmentType01"
    case "punishmentType01":
        return "警告"
        
    case "罚款":
        return "punishmentType02"
    case "punishmentType02":
        return "罚款"
        

    case "责令改正":
        return "punishmentType03"
    case "punishmentType03":
        return "责令改正"
        
    case "没收违法所得":
        return "punishmentType04"
    case "punishmentType04":
        return "没收违法所得"
        
    case "责令停产停业整顿":
        return "punishmentType05"
    case "punishmentType05":
        return "责令停产停业整顿"
        
    case "暂扣或者吊销有关许可证":
        return "punishmentType06"
    case "punishmentType06":
        return "暂扣或者吊销有关许可证"
        
        
    case "关闭":
        return "punishmentType07"
    case "punishmentType08":
        return "关闭"
        
        
    case "拘留":
        return "punishmentType08"
    case "punishmentType08":
        return "拘留"
        
        
    case "其他行政处罚":
        return "punishmentType09"
    case "punishmentType09":
        return "其他行政处罚"

    default: return ""
    }
}


    //经济类型
    func getEconomyType(key:String)->String{
        switch key {
        case "01国有经济":
            return "economyType01"
        case "economyType01":
            return "01国有经济"
            
        case "02集体经济":
            return "economyType02"
        case "economyType02":
            return "02集体经济"
            
        case "03私营经济":
            return "economyType03"
        case "economyType03":
            return "03私营经济"
            
        case "04有限责任公司":
            return "economyType04"
        case "economyType04":
            return "04有限责任公司"
            
        case "05联营经济":
            return "economyType05"
        case "economyType05":
            return "05联营经济"
            
        case "06股份合作":
            return "economyType06"
        case "economyType06":
            return "06股份合作"
            
        case "07外商投资":
            return "economyType07"
        case "economyType07":
            return "07外商投资"
            
        case "08港澳台投资":
            return "economyType08"
        case "economyType08":
            return "08港澳台投资"
            
        case "09其它经济":
            return "economyType09"
        case "economyType09":
            return "09其它经济"
            
        case "10股份有限公司":
            return "economyType10"
        case "economyType10":
            return "10股份有限公司"
            
        default: return ""
        }
    }
    
    //规模类型
    func getCpyType(key:String)->String{
        switch key {
        case "规上企业":
            return "isEnterprise1"
        case "isEnterprise1":
            return "规上企业"
            
        case "规下企业":
            return "isEnterprise2"
        case "isEnterprise2":
            return "规下企业"
            
        case "小微企业":
            return "isEnterprise3"
        case "isEnterprise3":
            return "小微企业"
        default: return ""

        }
    }
    
    //二级区域code
    func getSecondArea(key:String)->String{
        switch key {
        case "德清县":
            return "330521"
        case "330521":
            return "德清县"
            
        case "长兴县":
            return "330522"
        case "330522":
            return "长兴县"
            
        case "安吉县":
            return "330523"
        case "330523":
            return "安吉县"
            
        case "吴兴区":
            return "330502"
        case "330502":
            return "吴兴区"
            
        case "南浔区":
            return "330503"
        case "330503":
            return "南浔区"
            
        case "湖州开发区":
            return "330504"
        case "330504":
            return "湖州开发区"
            
        case "太湖度假区":
            return "330505"
        case "330505":
            return "太湖度假区"
            
        default: return ""
            
        }
    }
    
    //三级AreaCode
    func getThirdArea(key:String)->String{
        switch key {
        case "规上企业":
            return "isEnterprise1"
        case "isEnterprise1":
            return "规上企业"
            
        case "规下企业":
            return "isEnterprise2"
        case "isEnterprise2":
            return "规下企业"
            
        case "小微企业":
            return "isEnterprise3"
        case "isEnterprise3":
            return "小微企业"
        default: return ""
            
        }
    }

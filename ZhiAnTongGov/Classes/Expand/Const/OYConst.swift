//
//  OYConst.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit


let PAGE_SIZE = 15
let LOAD_FINISH = "加载完毕"
let NOTICE_CPY_NAME = "请输入企业名称"
let NOTICE_SECURITY_NAME = "你的账号在另一台设备登录，如非本人操作，请注意账号安全!"
//最大上传图片数
let IMAGE_MAX_SELECTEDNUM = 9


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

/// navagtion蓝
func YMGlobalBlueColor() -> UIColor {
    return YMColor(0, g: 102, b: 255, a: 1.0)
}


/// 间距
let kMargin: CGFloat = 10.0

/// iPhone 5
let isIPhone5 = SCREEN_WIDTH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREEN_WIDTH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREEN_WIDTH == 736 ? true : false


func getTroubleType(key:String)->String{
    switch key {
    case "物":
       return "1332"
    case "1332":
        return "物"
        
    case "管理":
        return "1344"
    case "1344":
        return "管理"
        
    case "人":
        return "1327"
    case "1327":
        return "人"
    default: return ""
        
    }
}
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
        case "武康镇":
            return "330521100000"
        case "330521100000":
            return "武康镇"
            
        case "乾元镇":
            return "330521101000"
        case "330521101000":
            return "乾元镇"
            
        case "新市镇":
            return "330521102000"
        case "330521102000":
            return "新市镇"
            
        case "洛舍镇":
            return "330521103000"
        case "330521103000":
            return "洛舍镇"
            
        case "钟管镇":
            return "330521104000"
        case "330521104000":
            return "钟管镇"
            
        case "莫干山镇":
            return "330521105000"
        case "330521105000":
            return "莫干山镇"
            
        case "雷甸镇":
            return "330521110000"
        case "330521110000":
            return "雷甸镇"
            
        case "禹越镇":
            return "330521113000"
        case "330521113000":
            return "禹越镇"
            
        case "新安镇":
            return "330521114000"
        case "330521114000":
            return "新安镇"
            
        case "筏头乡":
            return "330521201000"
        case "330521201000":
            return "筏头乡"
            
        case "三合乡":
            return "330521202000"
        case "330521202000":
            return "三合乡"
            
        case "开发区":
            return "330521203000"
        case "330521203000":
            return "开发区"
            
        case "科技新城":
            return "330521029923"
        case "330521029923":
            return "科技新城"
            
            
        case "画溪街道":
            return "330522100000"
        case "330522100000":
            return "画溪街道"
            
        case "洪桥镇":
            return "330522101000"
        case "330522101000":
            return "洪桥镇"
            
        case "李家巷镇":
            return "330522102000"
        case "330522102000":
            return "李家巷镇"
            
        case "夹浦镇":
            return "330522103000"
        case "330522103000":
            return "夹浦镇"
            
        case "林城镇":
            return "330522104000"
        case "330522104000":
            return "林城镇"
            
        case "泗安镇":
            return "330522105000"
        case "330522105000":
            return "泗安镇"
            
        case "虹星桥镇":
            return "330522106000"
        case "330522106000":
            return "虹星桥镇"
            
        case "和平镇":
            return "330522107000"
        case "330522107000":
            return "和平镇"
            
        case "小浦镇":
            return "330522108000"
        case "330522108000":
            return "小浦镇"
            
        case "煤山镇":
            return "330522109000"
        case "330522109000":
            return "煤山镇"
            
            
        case "水口乡":
            return "330522200000"
        case "330522200000":
            return "水口乡"
            
        case "吕山乡":
            return "330522202000"
        case "330522202000":
            return "吕山乡"
            
        case "白岘乡":
            return "330522204000"
        case "330522204000":
            return "白岘乡"
            
        case "槐坎乡":
            return "330522205000"
        case "330522205000":
            return "槐坎乡"
            
        case "龙山街道":
            return "330522207000"
        case "330522207000":
            return "龙山街道"
            
        case "雉城街道":
            return "330522208000"
        case "330522208000":
            return "雉城街道"
            
        case "开发区":
            return "330522206000"
        case "330522206000":
            return "开发区"
        case "图影旅游度假区":
            return "330522201200"
        case "330522201200":
            return "图影旅游度假区"
            
        case "南太湖产业集聚区":
            return "330522201100"
        case "330522201100":
            return "南太湖产业集聚区"
        case "递铺镇":
            return "330523100000"
        case "330523100000":
            return "递铺镇"
            
        case "梅溪镇":
            return "330523101000"
        case "330523101000":
            return "梅溪镇"
            
        case "鄣吴镇":
            return "330523103000"
        case "330523103000":
            return "鄣吴镇"
            
        case "杭垓镇":
            return "330523104000"
        case "330523104000":
            return "杭垓镇"
            
        case "孝丰镇":
            return "330523105000"
        case "330523105000":
            return "孝丰镇"
            
        case "报福镇":
            return "330523106000"
        case "330523106000":
            return "报福镇"
            
        case "章村镇":
            return "330523107000"
        case "330523107000":
            return "章村镇"
            
            
        case "天荒坪镇":
            return "330523108000"
        case "330523108000":
            return "天荒坪镇"
            
        case "天子湖镇":
            return "330523109000"
        case "330523109000":
            return "天子湖镇"
            
        case "溪龙乡":
            return "330523201000"
        case "330523201000":
            return "溪龙乡"
            
        case "皈山乡":
            return "330523204000"
        case "330523204000":
            return "皈山乡"
            
        case "上墅乡":
            return "330523205000"
        case "330523205000":
            return "上墅乡"
            
        case "山川乡":
            return "330523206000"
        case "330523206000":
            return "山川乡"
            
            
        case "昌硕街道":
            return "330523207000"
        case "330523207000":
            return "昌硕街道"
        case "月河街道":
            return "330502001000"
        case "330502001000":
            return "月河街道"
            
        case "朝阳街道":
            return "330502002000"
        case "330502002000":
            return "朝阳街道"
            
        case "爱山街道":
            return "330502003000"
        case "330502003000":
            return "爱山街道"
            
            
        case "飞英街道":
            return "330502004000"
        case "330502004000":
            return "飞英街道"
            
        case "龙泉街道":
            return "330502005000"
        case "330502005000":
            return "龙泉街道"
            
        case "凤凰街道":
            return "330502006000"
        case "330502006000":
            return "凤凰街道"
            
        case "康山街道":
            return "330502007000"
        case "330502007000":
            return "康山街道"
            
        case "织里镇":
            return "330502100000"
        case "330502100000":
            return "织里镇"
            
        case "八里店镇":
            return "330502101000"
        case "330502101000":
            return "八里店镇"
            
        case "妙西镇":
            return "330502102000"
        case "330502102000":
            return "妙西镇"
        case "杨家埠街道":
            return "330502103000"
        case "330502103000":
            return "杨家埠街道"
        case "埭溪镇":
            return "330502104000"
        case "330502104000":
            return "埭溪镇"
            
            
        case "东林镇":
            return "330502105000"
        case "330502105000":
            return "东林镇"
            
        case "道场乡":
            return "330502200000"
        case "330502200000":
            return "道场乡"
            
        case "环渚乡":
            return "330502201000"
        case "330502201000":
            return "环渚乡"
        case "白雀乡":
            return "330502202000"
        case "330502202000":
            return "白雀乡"
            
            
        case "高新区":
            return "330502106000"
        case "330502106000":
            return "高新区"
            
        case "南浔镇":
            return "330503100000"
        case "330503100000":
            return "南浔镇"
        case "双林镇":
            return "330503101000"
        case "330503101000":
            return "双林镇"
            
        case "练市镇":
            return "330503102000"
        case "330503102000":
            return "练市镇"
            
        case "善琏镇":
            return "330503103000"
        case "330503103000":
            return "善琏镇"
            
        case "旧馆镇":
            return "330503104000"
        case "330503104000":
            return "旧馆镇"
            
        case "菱湖镇":
            return "330503105000"
        case "330503105000":
            return "菱湖镇"
            
        case "和孚镇":
            return "330503106000"
        case "330503106000":
            return "和孚镇"
            
        case "千金镇":
            return "330503107000"
        case "330503107000":
            return "千金镇"
            
        case "石淙镇":
            return "330503108000"
        case "330503108000":
            return "石淙镇"
            
        case "杨家埠街道":
            return "330504001000"
        case "330504001000":
            return "杨家埠街道"
            
        case "凤凰街道":
            return "330504002000"
        case "330504002000":
            return "凤凰街道"
            
        case "康山街道":
            return "330504003000"
        case "330504003000":
            return "康山街道"
            
        case "滨湖街道":
            return "330505002000"
        case "330505002000":
            return "滨湖街道"
            
        case "仁皇山街道":
            return "330505003000"
        case "330505003000":
            return "仁皇山街道"
            
            
        case "雉城街道":
            return "330522201300"
        case "330522201300":
            return "雉城街道"
            
        case "灵峰度假区":
            return "330523208000"
        case "330523208000":
            return "灵峰度假区"
            
        case "旅游企业":
            return "330523209000"
        case "330523209000":
            return "旅游企业"
            
        case "龙溪街道":
            return "330504004000"
        case "330504004000":
            return "龙溪街道"
            
            
            
        default: return ""
            
        }
    }

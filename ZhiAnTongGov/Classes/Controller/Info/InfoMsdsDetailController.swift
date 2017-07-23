//
//  CpyInfoDetailController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/6.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import UsefulPickerView


class InfoMsdsDetailController: BaseViewController {
    
    var titleStr :String?
    var scrollView: UIScrollView?
    var msdsInfoModel :MSDSInfoModel!
    
    
    override func viewDidLoad() {
        setNavagation("MSDS查询")
        initPage()
        
    }
    func initPage(){
        scrollView = UIScrollView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT))
        //scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*2)
        
        let customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.backgroundColor = UIColor.whiteColor()
        customView1.setLabelName("中文名：")
        customView1.setRMSDSCenterLabel(msdsInfoModel.chineseName)
        
        let customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("英文名：")
        customView2.setRMSDSCenterLabel(msdsInfoModel.englishName)
        
        let customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("CAS号：")
        customView3.setRMSDSCenterLabel(msdsInfoModel.cas)
        
        let customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("危险货物编号：")
        customView4.setRMSDSCenterLabel(msdsInfoModel.dangerousGoodsNumber)
        
        let customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("外观与形状：")
       customView5.setRMSDSCenterLabel(msdsInfoModel.appearanceAndProperties)
        
        let customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("避免接触的条件：")
        customView6.setRMSDSCenterLabel(msdsInfoModel.avoidContactConditions)
        
        let customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 45))
        customView7.setLabelName("熔点：")
        customView7.setRMSDSCenterLabel(msdsInfoModel.meltingPoint)
        
        let customView8 = DetailCellView(frame:CGRectMake(0, 315, SCREEN_WIDTH, 45))
        customView8.setLabelName("沸点：")
        customView8.setRMSDSCenterLabel(msdsInfoModel.boilingPoint)
        
        let customView9 = DetailCellView(frame:CGRectMake(0, 360, SCREEN_WIDTH, 45))
        customView9.setLabelName("相对密度水：")
        customView9.setRMSDSCenterLabel(msdsInfoModel.water)
        
        let customView10 = DetailCellView(frame:CGRectMake(0, 405, SCREEN_WIDTH, 45))
        customView10.setLabelName("相对密度空气：")
        customView10.setRMSDSCenterLabel(msdsInfoModel.atmosphere)
        
        let customView11 = DetailCellView(frame:CGRectMake(0, 450, SCREEN_WIDTH, 45))
        customView11.setLabelName("饱和蒸气压：")
        customView11.setRMSDSCenterLabel(msdsInfoModel.saturatedSteamPressure)
        
        let customView12 = DetailCellView(frame:CGRectMake(0, 495, SCREEN_WIDTH, 45))
        customView12.setLabelName("溶解性：")
        customView12.setRMSDSCenterLabel(msdsInfoModel.solubility)
        
        let customView13 = DetailCellView(frame:CGRectMake(0, 540, SCREEN_WIDTH, 45))
        customView13.setLabelName("燃烧性：")
        customView13.setRMSDSCenterLabel(msdsInfoModel.burningProperty)
        
        let customView14 = DetailCellView(frame:CGRectMake(0, 585, SCREEN_WIDTH, 45))
        customView14.setLabelName("自燃温度：")
        customView14.setRMSDSCenterLabel(msdsInfoModel.autoignitionTemperature)
        
        let customView15 = DetailCellView(frame:CGRectMake(0, 630, SCREEN_WIDTH, 45))
        customView15.setLabelName("爆炸下限：")
        customView15.setRMSDSCenterLabel(msdsInfoModel.lowerExplosion)
        
        let customView16 = DetailCellView(frame:CGRectMake(0, 675, SCREEN_WIDTH, 45))
        customView16.setLabelName("爆炸上限：")
        customView16.setRMSDSCenterLabel(msdsInfoModel.upperExplosion)
        
        let customView17 = DetailCellView(frame:CGRectMake(0, 720, SCREEN_WIDTH, 45))
        customView17.setLabelName("燃烧分解产物：")
        customView17.setRMSDSCenterLabel(msdsInfoModel.precursorProduct)
        
        let customView18 = DetailCellView(frame:CGRectMake(0, 765, SCREEN_WIDTH, 45))
        customView18.setLabelName("稳定性：")
        customView18.setRMSDSCenterLabel(msdsInfoModel.stability)
        
        let customView19 = DetailCellView(frame:CGRectMake(0, 810, SCREEN_WIDTH, 45))
        customView19.setLabelName("聚合危害：")
        customView19.setRMSDSCenterLabel(msdsInfoModel.polymerizationHazard)
        
        
        let customView20 = DetailCellView(frame:CGRectMake(0, 855, SCREEN_WIDTH, 45))
        customView20.setLabelName("危险性类别：")
        customView20.setRMSDSCenterLabel(msdsInfoModel.riskCategories)
        
        let customView21 = DetailCellView(frame:CGRectMake(0, 900, SCREEN_WIDTH, 45))
        customView21.setLabelName("防护服：")
        customView21.setRMSDSCenterLabel(msdsInfoModel.protectiveClothing)
        
        let customView22 = DetailCellView(frame:CGRectMake(0, 945, SCREEN_WIDTH, 45))
        customView22.setLabelName("手防护：")
        customView22.setRMSDSCenterLabel(msdsInfoModel.handProtection)
        
        let customView23 = DetailCellView(frame:CGRectMake(0, 990, SCREEN_WIDTH, 45))
        customView23.setLabelName("侵入途径：")
        customView23.setRMSDSCenterLabel(msdsInfoModel.invasionPathway)
        
        let customView24 = DetailCellView(frame:CGRectMake(0, 1035, SCREEN_WIDTH, 45))
        customView24.setLabelName("毒性：")
        customView24.setRMSDSCenterLabel(msdsInfoModel.toxicity)
        
        let customView25 = DetailCellView(frame:CGRectMake(0, 1080, SCREEN_WIDTH, 45))
        customView25.setLabelName("主要用途：")
        customView25.setRMSDSCenterLabel(msdsInfoModel.mainUse)
        
        let customView26 = DetailCellView(frame:CGRectMake(0, 1125, SCREEN_WIDTH, 45))
        customView26.setLabelName("危险特性：")
        customView26.setRMSDSCenterLabel(msdsInfoModel.riskCharacteristics)
        
        let customView27 = DetailCellView(frame:CGRectMake(0, 1170, SCREEN_WIDTH, 45))
        customView27.setLabelName("灭火方法：")
        customView27.setRMSDSCenterLabel(msdsInfoModel.fireMethod)
        
        let customView28 = DetailCellView(frame:CGRectMake(0, 1215, SCREEN_WIDTH, 45))
        customView28.setLabelName("储运注意事项：")
        customView28.setRMSDSCenterLabel(msdsInfoModel.handingInformation)
        
        let customView29 = DetailCellView(frame:CGRectMake(0, 1260, SCREEN_WIDTH, 45))
        customView29.setLabelName("健康危害：")
        customView29.setRMSDSCenterLabel(msdsInfoModel.healthHarm)
        
        let customView30 = DetailCellView(frame:CGRectMake(0, 1305, SCREEN_WIDTH, 45))
        customView30.setLabelName("眼睛防护：")
        customView30.setRMSDSCenterLabel(msdsInfoModel.eyeprotection)
        
        let customView31 = DetailCellView(frame:CGRectMake(0, 1350, SCREEN_WIDTH, 45))
        customView31.setLabelName("吸入危害：")
        customView31.setRMSDSCenterLabel(msdsInfoModel.inhalationHarm)
        
        let customView32 = DetailCellView(frame:CGRectMake(0, 1395, SCREEN_WIDTH, 45))
        customView32.setLabelName("食入危害：")
        customView32.setRMSDSCenterLabel(msdsInfoModel.ingestionHarm)
        let customView33 = DetailCellView(frame:CGRectMake(0, 1440, SCREEN_WIDTH, 45))
        customView33.setLabelName("工程控制：")
        customView33.setRMSDSCenterLabel(msdsInfoModel.engineeringControl)
        let customView34 = DetailCellView(frame:CGRectMake(0, 1485, SCREEN_WIDTH, 45))
        customView34.setLabelName("呼吸系统防护：")
        customView34.setRMSDSCenterLabel(msdsInfoModel.respiratorySystemProtection)
        
        let customView35 = DetailCellView(frame:CGRectMake(0, 1530, SCREEN_WIDTH, 45))
        customView35.setLabelName("泄露处置：")
        customView35.setRMSDSCenterLabel(msdsInfoModel.leakageDisposal)
        
        let customView36 = DetailCellView(frame:CGRectMake(0, 1575, SCREEN_WIDTH, 45))
        customView36.setLabelName("其他注意事项：")
        customView36.setRMSDSCenterLabel(msdsInfoModel.attentions)
        
        self.scrollView!.addSubview(customView1)
        self.scrollView!.addSubview(customView2)
        self.scrollView!.addSubview(customView3)
        self.scrollView!.addSubview(customView4)
        self.scrollView!.addSubview(customView5)
        self.scrollView!.addSubview(customView6)
        self.scrollView!.addSubview(customView7)
        self.scrollView!.addSubview(customView8)
        self.scrollView!.addSubview(customView9)
        self.scrollView!.addSubview(customView10)
        self.scrollView!.addSubview(customView11)
        self.scrollView!.addSubview(customView12)
        self.scrollView!.addSubview(customView13)
        self.scrollView!.addSubview(customView14)
        self.scrollView!.addSubview(customView15)
        self.scrollView!.addSubview(customView16)
        self.scrollView!.addSubview(customView17)
        self.scrollView!.addSubview(customView18)
        self.scrollView!.addSubview(customView19)
        self.scrollView!.addSubview(customView20)
        self.scrollView!.addSubview(customView21)
        self.scrollView!.addSubview(customView22)
        self.scrollView!.addSubview(customView23)
        self.scrollView!.addSubview(customView24)
        self.scrollView!.addSubview(customView25)
        self.scrollView!.addSubview(customView26)
        self.scrollView!.addSubview(customView27)
        self.scrollView!.addSubview(customView28)
        self.scrollView!.addSubview(customView29)
        self.scrollView!.addSubview(customView30)
        self.scrollView!.addSubview(customView31)
        self.scrollView!.addSubview(customView32)
        self.scrollView!.addSubview(customView33)
        self.scrollView!.addSubview(customView34)
        self.scrollView!.addSubview(customView35)
        self.scrollView!.addSubview(customView36)
        self.view.addSubview(scrollView!)
    }

}

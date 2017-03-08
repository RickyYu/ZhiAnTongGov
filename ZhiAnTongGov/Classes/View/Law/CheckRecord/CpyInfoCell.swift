//
//  InfoListCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/9.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class CpyInfoCell: UITableViewCell {
    
    
    @IBOutlet weak var cpyName: UILabel!
    @IBOutlet weak var delegate: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var unDangerNum: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    var cpyInfoModel: CpyInfoModel?
        {
        didSet{
            if let art = cpyInfoModel {
                // 设置数据
                cpyName.text = art.companyName
                delegate.text = "负责人："+art.fdDelegate
                let secondStr =  getSecondArea(String(art.secondArea))
                let thirdStr =  getThirdArea(String(art.thirdArea))
                area.text = "所属区域："+String("湖州市 \(secondStr)\(thirdStr)")
                if art.allDangerNum > 0 {
                 unDangerNum.text = "未整改隐患数量：\(art.allDangerNum)个"
                 unDangerNum.textColor = UIColor.redColor()
                }else{
                  unDangerNum.text = "未整改隐患数量：0个"
                  unDangerNum.textColor = UIColor.lightGrayColor()
                }
                
            }
        }
    }
    var cpyInfoModelByGrid: CpyInfoModel?
        {
        didSet{
            if let art = cpyInfoModelByGrid {
                // 设置数据
                cpyName.text = art.companyName
                delegate.text = "负责人："+art.fdDelegate
                let secondStr =  getSecondArea(String(art.secondArea))
                let thirdStr =  getThirdArea(String(art.thirdArea))
                area.text = "所属区域："+String("湖州市 \(secondStr)\(thirdStr)")
                if art.gridDangerNum > 0 {
                    unDangerNum.text = "未整改隐患数量：\(art.gridDangerNum)个"
                    unDangerNum.textColor = UIColor.redColor()
                }else{
                    unDangerNum.text = "未整改隐患数量：0个"
                    unDangerNum.textColor = UIColor.lightGrayColor()
                }
                
            }
        }
    }
    
    var unModifyModel: UnModifyModel?
        {
        didSet{
            if let art = unModifyModel {
                // 设置数据
                cpyName.text = art.descriptions
                delegate.text = "录入日期："+art.createTime
                area.text = ""
                if art.sourceType == "3"{
                unDangerNum.text = "来源：政府"
                }else{
                unDangerNum.text = "来源：企业"
                }
            }
        }
    }
}

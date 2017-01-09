//
//  InfoListCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/9.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class ReviewInfoCell: UITableViewCell {
    
    @IBOutlet weak var cpyName: UILabel!
    @IBOutlet weak var hiddenNum: UILabel!
    @IBOutlet weak var reviewNum: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    var punishmentModel: PunishmentModel?
        {
        didSet{
            if let art = punishmentModel {
                // 设置数据
                cpyName.text = art.companyName
                hiddenNum.text = "未整改隐患数量（"+String(art.hiddenNum)+")个"
                reviewNum.text = "复查次数"+String(art.fcNum)+"次"
                reviewDate.text = "责令整改日期："+art.cleanUpTimeLimit
            }
        }
    }
    
    var hiddenModel: HiddenModel?
        {
        didSet{
            if let art = hiddenModel {
                // 设置数据
                cpyName.text = art.content
                hiddenNum.text = "录入日期："+art.createTime
                let repaired :Bool = art.repaired
                if repaired {
                    reviewNum.text = "已整改"
                    reviewNum.textColor = UIColor.redColor()
                }else {
                    reviewNum.text = "未整改"
                    reviewNum.textColor = UIColor.grayColor()
                }
                
                reviewDate.text = ""
            }
        }
    }
    
    
    var historyReviewModel: HistoryReviewModel?
        {
        didSet{
            if let art = historyReviewModel {
                // 设置数据
                cpyName.text = "复查情况：" + art.hiddenState
                hiddenNum.text = "复查日期："+art.callbackTime
                reviewNum.text = "复查人："+art.executer
                reviewDate.text = ""
            }
        }
    }
}

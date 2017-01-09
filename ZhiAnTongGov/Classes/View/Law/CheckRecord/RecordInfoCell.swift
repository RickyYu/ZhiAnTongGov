//
//  InfoListCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/9.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class RecordInfoCell: UITableViewCell {

    @IBOutlet weak var checkState: UILabel!
    @IBOutlet weak var unChangeDangerNum: UILabel!
    @IBOutlet weak var checkTime: UILabel!
    @IBOutlet weak var checkGround: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    var recordInfoModel: RecordInfoModel?
        {
        didSet{
            if let art = recordInfoModel {
                // 设置数据
                checkGround.text = "检查场所：" + art.checkGround
                let punishState : Bool = art.punishState
                if punishState {
                    checkState.text = "已处罚"
                    checkState.textColor = UIColor.redColor()
                }else{
                    checkState.text = "未处罚"
                    checkState.textColor = UIColor.blackColor()
                }
                
                unChangeDangerNum.text = "未整改隐患数量("+String(art.wzgNum)+")个"
                checkTime.text="检查日期：" + art.checkTimeBegin
            }
        }
    }
}

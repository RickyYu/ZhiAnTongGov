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
                area.text = "所属区域："+String(art.firstArea)
            }
        }
    }
}

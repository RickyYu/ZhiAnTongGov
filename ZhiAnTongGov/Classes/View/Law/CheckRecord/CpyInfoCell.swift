//
//  InfoListCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/9.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class CpyInfoCell: UITableViewCell {
    
    @IBOutlet weak var infoTitile: UILabel!
    @IBOutlet weak var infoSubTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    var  info: Info?
        {
        didSet{
            if let art = info {
                // 设置数据
                infoTitile.text = art.caption
                infoSubTitle.text = art.publisher
                time.text = art.modifyTime
            }
            
        }
    }
    
}

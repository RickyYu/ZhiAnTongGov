//
//  InfoListCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/9.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class IndustrySelectCell: UITableViewCell {
    
    @IBOutlet weak var titile: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    var industrySelectModel: IndustrySelectModel?
        {
        didSet{
            if let art = industrySelectModel {
                // 设置数据
                titile.text = art.title

            }
        }
    }
    
    var industrySecondSelectModel: IndustrySecondSelectModel?
        {
        didSet{
            if let art = industrySecondSelectModel {
                // 设置数据
                titile.text = art.content
                
            }
        }
    }
}

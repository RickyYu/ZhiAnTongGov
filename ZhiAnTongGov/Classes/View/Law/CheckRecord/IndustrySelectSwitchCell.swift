//
//  InfoListCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/9.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class IndustrySelectSwitchCell: UITableViewCell {
    
    
    @IBOutlet weak var titile: UILabel!
    @IBOutlet weak var customSwitch: UISwitch!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

    @IBAction func valueChange(sender: AnyObject) {
        let sw = sender as! UISwitch
        if sw.on{
        industrySecondSelectModel?.descriptions = "1"
        }else{
        industrySecondSelectModel?.descriptions = "0"
        }
        
    }
    
    var industrySecondSelectModel: IndustrySecondSelectModel?
        {
        didSet{
            if let art = industrySecondSelectModel {
                // 设置数据
                titile.text = art.content
                if art.descriptions == "1"{
                  customSwitch.on = true
                }else{
                  customSwitch.on = false
                }
            }
        }
    }
}

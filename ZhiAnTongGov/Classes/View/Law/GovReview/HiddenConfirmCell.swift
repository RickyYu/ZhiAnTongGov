//
//  HiddenConfirmCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/16.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class HiddenConfirmCell: UITableViewCell {

    @IBOutlet weak var titile: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var customSwitch: UISwitch!

    @IBAction func valueChange(sender: AnyObject) {
        let sw = sender as! UISwitch
        if sw.on{
            hiddenModel?.repaired = true
        }else{
            hiddenModel?.repaired = false
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
    var hiddenModel: HiddenModel?
        {
        didSet{
            if let art = hiddenModel {
                // 设置数据
                if(art.isBig == "0"){
                titile.text = "一般隐患" + art.content
                }else{
                titile.text = "重大隐患" + art.content
                }
                
                date.text = "录入日期" + art.createTime
                let isRepair :Bool = art.repaired
                if isRepair {
                    customSwitch.on = true
                }else{
                    customSwitch.on = false
                }
            }
        }
    }

    
}




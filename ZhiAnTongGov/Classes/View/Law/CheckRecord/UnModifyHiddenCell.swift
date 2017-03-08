//
//  UnModifyHiddenCell.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/2/24.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class UnModifyHiddenCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var select: UIButton!
    
    var uploadModels = [UnModifyModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var unModifyModel: UnModifyModel?
        {
        didSet{
            if let art = unModifyModel {
                select.setImage(UIImage(named: "cb_select"), forState: UIControlState.Selected)
                select.setImage(UIImage(named: "cb_unselect"), forState: UIControlState.Normal)
               // select.addTarget(self, action:#selector(tapped(_:)), forControlEvents:.TouchUpInside)
                // 设置数据
                title.text = String(art.descriptions)
                subTitle.text = "录入日期："+art.createTime
                let isTake:Bool = art.take
                if isTake {
                state.text = "该隐患已接管过"
                state.textColor = UIColor.redColor()
                }else{
                state.text =  ""
                }
            }
        }
    }
    
    var checkHiddenModel: CheckHiddenModel?
        {
        didSet{
            if let art = checkHiddenModel {
                select.hidden = true
                // 设置数据
                title.text = String(art.content) ?? ""
                subTitle.text = "录入日期："+art.createTime
                    state.text =  ""
                
            }
        }
    }
    func tapped(button:UIButton){
        button.selected = !button.selected
        if button.selected{
        }else{
            
        }
    }
    
}

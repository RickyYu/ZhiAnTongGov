//
//  DetailCellView.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/7.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit

class DetailEditCellView: UIView {
    
    var lineView = UIView()
    var label = UILabel()
    var textField = UITextField()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        label.font = UIFont.boldSystemFontOfSize(13)
        label.frame = CGRectMake(6, 5, 100, 35)
        label.textColor = YMGlobalDeapBlueColor()
        
        lineView.frame = CGRectMake(3, 42, SCREEN_WIDTH-6, 2)
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        textField = UITextField(frame: CGRect(x:10, y:60, width:200, height:30))
        //设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect
        
        
        self.addSubview(label)
        self.addSubview(lineView)
        self.addSubview(textField)
        
        label.snp_makeConstraints { make in
            make.top.equalTo(self.snp_top).offset(5)
            make.left.equalTo(self.snp_left).offset(5)
            make.size.equalTo(CGSizeMake(100, 35))
        }
        
        textField.snp_makeConstraints { (make) in
            make.top.equalTo(self.label.snp_bottom).offset(2)
            make.bottom.equalTo(self.lineView.snp_top).offset(-10)
            make.left.equalTo(self.snp_left).offset(3)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-6, 100))
        }
        
        
        lineView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-2)
            make.left.equalTo(self.snp_left).offset(3)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-6, 2))
        }
   
        
    }
    
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            print("tapped1+\(button.selected)")
        }else{
            print("tapped1+\(button.selected)")
            
        }
        
    }
    func tapped2(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            print("tapped2+\(button.selected)")
        }else{
            print("tapped2+\(button.selected)")
            
        }
        
    }
    func tapped3(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            print("tapped3+\(button.selected)")
        }else{
            print("tapped3+\(button.selected)")
            
        }
        
    }
    func tapped4(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            print("tapped4+\(button.selected)")
        }else{
            print("tapped4+\(button.selected)")
            
        }
        
    }
    
    
    func setLabelName(name:String) {
        label.text = name
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

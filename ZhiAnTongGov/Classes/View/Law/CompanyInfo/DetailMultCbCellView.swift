//
//  DetailCellView.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/7.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit




class DetailMultCbCellView: UIView {
    
    var lineView = UIView()
    var label = UILabel()
     var label1 = UILabel()
    var labelNotice = UILabel()
  
    var btn1 : UIButton!
    var btn2 : UIButton!
    var btn3 : UIButton!
    var btn4 : UIButton!

    override init(frame: CGRect) {
       super.init(frame: frame)
    }
    
    init(frame: CGRect,models: [CheckPersonModel]) {
        super.init(frame: frame)
        
        
        label.font = UIFont.boldSystemFontOfSize(13)
        label.frame = CGRectMake(6, 5, 100, 35)
        label.textColor = YMGlobalDeapBlueColor()
        
        label1.font = UIFont.boldSystemFontOfSize(13)
        label1.frame = CGRectMake(106, 5, 100, 35)
        label1.textColor = UIColor.blackColor()
        label1.hidden = true

        lineView.frame = CGRectMake(3, 42, SCREEN_WIDTH-6, 2)
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        
        
        self.addSubview(label)
        self.addSubview(label1)
        self.addSubview(labelNotice)
        self.addSubview(lineView)
        
        label.snp_makeConstraints { make in
            make.top.equalTo(self.snp_top).offset(5)
            make.left.equalTo(self.snp_left).offset(5)
            make.size.equalTo(CGSizeMake(100, 35))
        }

        
        lineView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-2)
            make.left.equalTo(self.snp_left).offset(3)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-6, 2))
        }
        
        
        if !models.isEmpty{
        for i in 0..<models.count{
            let button = UIButton()
            button.setImage(UIImage(named: "cb_unselect"), forState: UIControlState.Normal)
            button.titleLabel!.font = UIFont.boldSystemFontOfSize(11)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setImage(UIImage(named: "cb_select"), forState: UIControlState.Selected)
            button.setTitle(models[i].gridName, forState: UIControlState.Normal)
            self.addSubview(button)
            
            button.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.snp_top).offset(5)
                make.left.equalTo(self.label.snp_right).offset(60*i)
                make.size.equalTo(CGSizeMake(60, 35))
            })
            switch i {
            case 0:
                self.btn1  = button
                button.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
            case 1:
                self.btn2  = button
                button.addTarget(self, action:#selector(tapped2(_:)), forControlEvents:.TouchUpInside)
            case 2:
                self.btn3  = button
                button.addTarget(self, action:#selector(tapped3(_:)), forControlEvents:.TouchUpInside)
            case 3:
                self.btn4  = button
                button.addTarget(self, action:#selector(tapped4(_:)), forControlEvents:.TouchUpInside)
                
            default: break
                
            }
          }
        }else{
        
        
        }
        
    }
    
    func tapped1(button:UIButton){
        button.selected = !button.selected
        self.btn1  = button
        if button.selected{
            
            print("tapped1+\(button.selected)")
        }else{
            print("tapped1+\(button.selected)")
            
        }
        
    }
    func tapped2(button:UIButton){
        button.selected = !button.selected
        self.btn2  = button
        if button.selected{
            
            print("tapped2+\(button.selected)")
        }else{
            print("tapped2+\(button.selected)")
            
        }
        
    }
    func tapped3(button:UIButton){
        button.selected = !button.selected
        self.btn3  = button
        if button.selected{
            
            print("tapped3+\(button.selected)")
        }else{
            print("tapped3+\(button.selected)")
            
        }
        
    }
    func tapped4(button:UIButton){
        button.selected = !button.selected
        self.btn4  = button
        if button.selected{
            
            print("tapped4+\(button.selected)")
        }else{
            print("tapped4+\(button.selected)")
            
        }
        
    }

    
    func setLabelName(name:String) {
        label.text = name
    }
    func setLabel1Name(name:String) {
        label1.text = name
        label1.hidden = false
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

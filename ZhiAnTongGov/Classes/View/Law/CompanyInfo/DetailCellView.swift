//
//  DetailCellView.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/7.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit




class DetailCellView: UIView {
    
    var lineView = UIView()
    var label = UILabel()
    var textField = UITextField()
    var rightLabel =  UILabel()
    var rightImg  = UIImageView()
    var centerLabel = UILabel()
    var rightCheckBtn = UIButton()
    var textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        label.font = UIFont.boldSystemFontOfSize(13)
        label.frame = CGRectMake(6, 5, 100, 35)
        label.textColor = YMGlobalDeapBlueColor()
        
        
 
        textField.frame = CGRectMake(90, 5, SCREEN_WIDTH-80, 35)
        textField.borderStyle = UITextBorderStyle.None
        textField.adjustsFontSizeToFitWidth=true
        textField.font = UIFont.boldSystemFontOfSize(13)
        textField.contentVerticalAlignment = .Center //垂直居中对齐
        
        
        

        lineView.frame = CGRectMake(3, 42, SCREEN_WIDTH-6, 2)
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        
        self.addSubview(label)
        self.addSubview(textField)
        self.addSubview(lineView)
    }
    
    func setLineViewHidden(){
        self.lineView.hidden = true
    }
    
    func setLabelName(name:String) {
        label.text = name
    }
    
    func setRTextField(text:String){
        textField.text = text
    }
    
    func setRRightLabel(name:String){

        rightLabel.text = name
        rightLabel.font = UIFont.boldSystemFontOfSize(13)
        rightLabel.frame = CGRectMake(SCREEN_WIDTH-150, 5, 120, 35)
        rightLabel.textColor = UIColor.blackColor()
        
        rightImg  = UIImageView()
        rightImg.image = UIImage(named: "right_arrow")
        rightImg.frame = CGRectMake(SCREEN_WIDTH-20, 10, 20, 20)
        self.textField.removeFromSuperview()
        self.addSubview(rightLabel)
        self.addSubview(rightImg)
    }
    
    func setTimeImg(){
       self.rightImg.removeFromSuperview()
       rightImg.image = UIImage(named: "daily_mgr_unselect")
       self.addSubview(rightImg)
    }
    
    func setTextViewShow(){
      textView = UITextView(frame:CGRect(x:6, y:40, width:SCREEN_WIDTH-12, height:100))
        textView.layer.borderWidth = 1  //边框粗细
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.layer.cornerRadius = 8
        textView.editable = true
        textView.selectable = true
        self.textField.removeFromSuperview()
     self.lineView.removeFromSuperview()
     self.addSubview(textView)
    }
    
    func setRCenterLabel(name:String){
        centerLabel.text = name
        centerLabel.font = UIFont.boldSystemFontOfSize(13)
        centerLabel.frame = CGRectMake(90, 5, SCREEN_WIDTH-80, 35)
        centerLabel.textColor = UIColor.lightGrayColor()
        self.textField.removeFromSuperview()
        self.addSubview(centerLabel)
    }
    
    func setRMSDSCenterLabel(name:String){
        centerLabel.text = name
        centerLabel.font = UIFont.boldSystemFontOfSize(13)
        centerLabel.frame = CGRectMake(90, 5, SCREEN_WIDTH-80, 35)
        centerLabel.textColor = UIColor.blackColor()
        self.textField.removeFromSuperview()
        self.addSubview(centerLabel)
    }
    
    func setRCheckBtn(){
        rightCheckBtn = UIButton(frame:CGRectMake(SCREEN_WIDTH-40, 5, 35, 35))
        rightCheckBtn.setImage(UIImage(named: "cb_unselect"), forState: UIControlState.Normal)
        rightCheckBtn.titleLabel!.font = UIFont.boldSystemFontOfSize(11)
        rightCheckBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        rightCheckBtn.setImage(UIImage(named: "cb_select"), forState: UIControlState.Selected)
        self.textField.removeFromSuperview()
        self.addSubview(rightCheckBtn)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailCellView {
    
    func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        userInteractionEnabled = true
        addGestureRecognizer(gr)
    }
    
}
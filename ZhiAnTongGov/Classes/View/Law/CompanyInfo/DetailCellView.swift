//
//  DetailCellView.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/7.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit

class DetailCellView: UIView,UITextFieldDelegate,UITextViewDelegate {
    
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
        
        // 设置 UITextField 的 frame
        textField.frame = CGRectMake(90, 5, SCREEN_WIDTH-80, 35)
        // 设置 样式 (.none 无边框  .line 直线边框  .roundedRect 圆角矩形边框  .bezel 边线+阴影)
        textField.borderStyle = UITextBorderStyle.None
        // 设置 文字超出文本框时自适应大小
        textField.adjustsFontSizeToFitWidth=true
        // 设置 提示字
        //        textField.placeholder = "我是 UITextfield"
        // 设置 文字颜色   (颜色系统默认为 nil )
        //        textField.textColor = UIColor.blue
        //设置文字大小
        textField.font = UIFont.boldSystemFontOfSize(13)
        textField.textAlignment = .Left // 左边对齐
        //       NSTextAlignment.center   // 居中对齐
        //        NSTextAlignment.right  // 右对齐
        
        textField.contentVerticalAlignment = .Center //垂直居中对齐
        textField.keyboardType = .Default
        textField.clearButtonMode = .WhileEditing
        // 设置 文字超出文本框时自适应大小
        textField.adjustsFontSizeToFitWidth = true
        // 设置 最小可缩小的字号
        textField.minimumFontSize = 13
        textField.delegate = self

        lineView.frame = CGRectMake(3, 42, SCREEN_WIDTH-6, 1)
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
    
    func setRCenterTextField(text:String){
        textField.frame = CGRectMake(160, 5, SCREEN_WIDTH-80, 35)
        textField.text = text
    }
    
    func setRTextFieldGray(text:String){
        textField.text = text
        textField.textColor = UIColor.lightGrayColor()
    }
    
    func setRTextViewGray(text:String){
        textView.textColor = UIColor.grayColor()
        textView.text = text
    }
    
    func setLabelMax(){
        label.frame = CGRectMake(6, 5, 160, 35)
        
    }
    
    func setRRightLabel(name:String){
        rightLabel.text = name
        rightLabel.font = UIFont.boldSystemFontOfSize(13)
        rightLabel.frame = CGRectMake(SCREEN_WIDTH-220, 5, 180, 35)
        rightLabel.textAlignment = .Right
        rightLabel.textColor = UIColor.blackColor()
        
        rightImg  = UIImageView()
        rightImg.image = UIImage(named: "right_arrow")
        rightImg.frame = CGRectMake(SCREEN_WIDTH-30, 10, 20, 20)
        self.textField.removeFromSuperview()
        self.addSubview(rightLabel)
        self.addSubview(rightImg)
    }
    
    func setRRightLabelGray(text:String){
        rightLabel.textColor = UIColor.grayColor()
        rightLabel.text = text
    }
    
    func setTimeImg(){
        
       self.rightImg.removeFromSuperview()
       rightImg.image = UIImage(named: "daily_mgr_unselect")
       self.addSubview(rightImg)
    }
    func setPhotoImg(){
        rightImg  = UIImageView()
        rightImg.image = UIImage(named: "icon_photo_bg")
        rightImg.frame = CGRectMake(SCREEN_WIDTH-40, 2.5, 40, 40)
        self.textField.removeFromSuperview()
        self.addSubview(rightImg)
    }
    
    
    func setRTextView(text:String){
        textView.text = text
    }
    func setTextViewShow(){
      textView = UITextView(frame:CGRect(x:6, y:40, width:SCREEN_WIDTH-12, height:100))
        textView.layer.borderWidth = 1  //边框粗细
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.layer.cornerRadius = 8
        textView.editable = true
        textView.selectable = true
        textView.delegate = self
        self.textField.removeFromSuperview()
     self.lineView.removeFromSuperview()
     self.addSubview(textView)
    }
    
    func setRCenterLabel(name:String){
        centerLabel.text = name
        centerLabel.font = UIFont.boldSystemFontOfSize(13)
        centerLabel.frame = CGRectMake(91, 5, SCREEN_WIDTH-80, 35)
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
        rightCheckBtn = UIButton(frame:CGRectMake(SCREEN_WIDTH-100, 2.5, 140, 40))
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
}

extension UIView {
    
   func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        userInteractionEnabled = true
        addGestureRecognizer(gr)
    }
    
}
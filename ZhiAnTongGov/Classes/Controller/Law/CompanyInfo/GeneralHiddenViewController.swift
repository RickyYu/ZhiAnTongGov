//
//  GeneralHiddenViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/2/27.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

//
//  GelHistoryHiddenDetailController.swift
//  ZhiAnTongCpy
//
//  Created by Ricky on 2017/2/16.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import UsefulPickerView

class GeneralHiddenViewController: PhotoViewController {
    var customView1  = DetailCellView()
    var customView2  = DetailCellView()
    var customView3  = DetailCellView()
    var customView4  = DetailCellView()
    var customView5  = DetailCellView()
    var customView6  = DetailCellView()
    var customView7  = DetailCellView()
    var customView8  = DetailCellView()
    var customView9  = DetailCellView()
    var submitBtn = UIButton()
    var scrollView: UIScrollView!
    var model:GeneralCheckInfoModel!
    var hiddenId:String!
    override func viewDidLoad() {
        setNavagation("一般隐患整改历史记录")
        InitPage()
        getDatas()
        
    }
    
    func setData(){
        let isSelected : Bool = model.repaired
        if isSelected {
            customView1.rightCheckBtn.selected = true
        }else{
            customView1.rightCheckBtn.selected = false
        }
        customView2.setRTextField(model.linkMan)
        customView2.textField.enabled = false
        customView3.setRTextField(model.linkTel)
        customView3.textField.enabled = false
        customView4.setRTextField(model.descriptions)
        customView4.textField.enabled = false
        customView5.setRTextField(getTroubleType(String(model.type)))
        customView5.textField.enabled = false
        customView6.setRTextField(model.rectificationPlanTime)
        customView6.textField.enabled = false
        customView7.setRTextView(model.remarks)
        customView7.textView.editable = false
        
    }
    
    func InitPage(){
        scrollView = UIScrollView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 550))
        scrollView!.pagingEnabled = true
        scrollView!.scrollEnabled = true
        scrollView!.showsHorizontalScrollIndicator = true
        scrollView!.showsVerticalScrollIndicator = false
        scrollView!.scrollsToTop = true
        scrollView!.contentSize = CGSizeMake(SCREEN_WIDTH, 550)
        
        customView1 = DetailCellView(frame:CGRectMake(0, 0, SCREEN_WIDTH, 45))
        customView1.setLabelName("企业确认整改：")
        customView1.setLabelMax()
        customView1.setRCheckBtn()
        customView1.rightCheckBtn.addTarget(self, action:#selector(majortapped1(_:)), forControlEvents:.TouchUpInside)
        
        customView2 = DetailCellView(frame:CGRectMake(0, 45, SCREEN_WIDTH, 45))
        customView2.setLabelName("联系人：")
        
        customView3 = DetailCellView(frame:CGRectMake(0, 90, SCREEN_WIDTH, 45))
        customView3.setLabelName("联系电话：")
        
        
        customView4 = DetailCellView(frame:CGRectMake(0, 135, SCREEN_WIDTH, 45))
        customView4.setLabelName("隐患描述：")
        
        
        customView5 = DetailCellView(frame:CGRectMake(0, 180, SCREEN_WIDTH, 45))
        customView5.setLabelName("隐患类别:")
        
        
        customView6 = DetailCellView(frame:CGRectMake(0, 225, SCREEN_WIDTH, 45))
        customView6.setLabelName("计划整改时间：")
        
        
        customView7 = DetailCellView(frame:CGRectMake(0, 270, SCREEN_WIDTH, 135))
        customView7.setLabelName("备注：")
        customView7.setTextViewShow()
        
        
        
        
        self.scrollView.addSubview(customView1)
        self.scrollView.addSubview(customView2)
        self.scrollView.addSubview(customView3)
        self.scrollView.addSubview(customView4)
        self.scrollView.addSubview(customView5)
        self.scrollView.addSubview(customView6)
        self.scrollView.addSubview(customView7)

        self.view.addSubview(scrollView)
       
        
        scrollView.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(64)
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(self.view.snp_bottom).offset(-5)
            make.right.equalTo(self.view.snp_right)
        }
        
    }
    

        func getDatas(){
            var parameters = [String : AnyObject]()
            parameters["nomalDanger.id"] = hiddenId
            
            NetworkTool.sharedTools.loadNomalDangerView(parameters) { (data, error) in
                if error == nil{
                    self.model = data
                    self.setData()

                }else{
                    self.showHint("\(error)", duration: 2, yOffset: 0)
                    if error == NOTICE_SECURITY_NAME {
                        self.toLoginView()
                    }
                }
            }
            
        }

    
    //是否需要政府协调
    var majoris1 = false
    func majortapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            majoris1 = true
            print("tapped1+\(button.selected)")
        }else{
            majoris1 = false
            print("tapped1+\(button.selected)")
            
        }
        
    }

}


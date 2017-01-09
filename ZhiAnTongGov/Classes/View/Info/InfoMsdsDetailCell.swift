//
//  DetailCellView.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/7.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit




class InfoMsdsDetailCell: UIView {
    
    /// 标题
    private lazy var infoTitile : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.blackColor()
        label.text = "[家居庭院]";
        return label
    }()
    
    /// 简介
    private lazy var infoSubTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = UIColor.grayColor()
        label.text = "[家居庭院]";
        return label
    }()
    
    // MARK: - 生命周期相关

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI设置和布局
    private func setupUI()
    {
        backgroundColor = UIColor.grayColor()
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(infoTitile)
        self.addSubview(infoSubTitle)
        self.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
      
        
        infoTitile.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 151, height: 35))
            make.left.equalTo(self)
            make.top.equalTo(self).offset(15)
        }
        
        infoSubTitle.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 260, height: 15))
            make.left.equalTo(self)
            make.top.equalTo(self).offset(15)
            make.left.equalTo(infoTitile.snp_right).offset(5)
    
        }
        
 
        
    }
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
          }


    
}
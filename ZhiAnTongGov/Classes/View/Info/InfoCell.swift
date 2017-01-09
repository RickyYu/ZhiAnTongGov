//
//  HomeArticleCell.swift
//  Floral
//
//  Created by Ricky on 16/10/26.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class InfoCell: UITableViewCell {
    ///小圆点地图
    private lazy var iconImageView :UIImageView = {
     let icon = UIImageView()
        icon.image = UIImage(named:"dot_orange")
        return icon
    }()
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
    /// 时间
    private lazy var time : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = UIColor.grayColor()
        label.text = "[家居庭院]";
        return label
    }()
    
    //下划线
    private lazy var lineView :UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.grayColor()
        return icon
    }()
    
    //右边箭头
    private lazy var arrowView :UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named:"right_arrow")
        return icon
    }()
    
    
    
    var  info: Info?
        {
        didSet{
            if let art = info {
                // 设置数据
                infoTitile.text = art.caption
                infoSubTitle.text = art.publisher
                time.text = art.modifyTime
            }
            
        }
    }
    
    
    
    // MARK: - 生命周期相关
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI设置和布局
    private func setupUI()
    {
        backgroundColor = UIColor.grayColor()
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(iconImageView)
        contentView.addSubview(infoTitile)
        contentView.addSubview(infoSubTitle)
        contentView.addSubview(time)
        contentView.addSubview(lineView)
        contentView.addSubview(arrowView)
        
        contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        iconImageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalTo(contentView)
            make.top.equalTo(contentView).offset(15)
        }
        
        infoTitile.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 151, height: 15))
            make.left.equalTo(iconImageView.snp_right).offset(5)
            make.top.equalTo(contentView).offset(5)
        }
        
        infoSubTitle.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 260, height: 15))
            make.left.equalTo(infoTitile.snp_left)
            make.top.equalTo(infoTitile.snp_bottom).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        time.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 20))
             make.bottom.equalTo(contentView).offset(-5)
            make.right.equalTo(contentView).offset(-5)
    
        }
        
        lineView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 370, height: 1))
            make.bottom.equalTo(contentView).offset(-2)
        }
        
        arrowView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.right.equalTo(contentView)
            make.top.equalTo(contentView).offset(15)
        }
   
    }
}

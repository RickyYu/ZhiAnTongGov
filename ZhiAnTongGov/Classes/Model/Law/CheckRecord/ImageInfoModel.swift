//
//  Info.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//隐患列表vo类
class ImageInfoModel:BaseModel{
    
    
    var fileFileName:String!
    var path:String!

    init(dict: [String: AnyObject]) {
        super.init()
        self.fileFileName = dict["fileFileName"] as? String
        self.path = dict["path"] as? String
    }
}












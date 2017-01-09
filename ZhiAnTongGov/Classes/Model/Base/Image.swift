//
//  Image.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/23.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import Foundation

class Image: BaseModel {
    var id: UInt
    var name: String
    var path: String
    
    init(id: UInt, name: String, path: String) {
        self.id = id
        self.name = name
        self.path = path
    }
}
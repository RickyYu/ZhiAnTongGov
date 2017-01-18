//
//  LocInfoModel
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
//隐患列表vo类
class LocInfoModel:BaseModel{
    var y:Double! //纬度
    var deleted:Bool!
    var id:Int!
    var new:Bool!
    var x :Double! //经度
    
    override init() {
     
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.y = dict["y"] as? Double
        self.deleted = dict["deleted"] as? Bool
        self.id = dict["id"] as? Int
        self.new = dict["new"] as? Bool
        self.x = dict["x"] as? Double
    }
}












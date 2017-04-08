//
//  SettingController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class SettingController: BaseViewController {

    @IBOutlet weak var userNameField: UILabel!
    @IBOutlet weak var userCompanyField: UILabel!
    
    @IBOutlet weak var tel: UIButton!
    @IBOutlet weak var modify: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        modify.backgroundColor = UIColor.orangeColor()
        tel.backgroundColor = UIColor.orangeColor()
        let user = AppTools.loadNSUserDefaultsClassValue("user") as! User
        userNameField.text = user.factName as String
        userCompanyField.text = user.userCompany as String
        
    }
    
    @IBAction func modifyPwd(sender: AnyObject) {
//        self.alert("修改密码")
    }

    @IBAction func showCpyName(sender: AnyObject) {
        self.alert(userCompanyField.text!)
    }
    @IBAction func callPhone(sender: AnyObject) {
        let url = NSURL(string: "tel://0574-87364008")
        UIApplication.sharedApplication().openURL(url!)
   self.alert("拨号")
    }
}


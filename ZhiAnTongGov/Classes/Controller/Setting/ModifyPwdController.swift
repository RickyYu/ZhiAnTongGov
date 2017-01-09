//
//  ModifyPwdController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/30.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ModifyPwdController: BaseViewController {
    
    @IBOutlet weak var newPwdField: UITextField!
    @IBOutlet weak var confirmNewPwdField: UITextField!
    @IBOutlet weak var oldPwdField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPage()
    }
    
    private func initPage(){
        
        // 设置navigation
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(ModifyPwdController.back))
        
        
    }
    func back()
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func submit(sender: AnyObject) {
        let newPwd = newPwdField.text!
        let confirmNewPwd = confirmNewPwdField.text!
        let oldPwd = oldPwdField.text!
        if AppTools.isEmpty(newPwd) {
            alert("请输入您的新密码!", handler: {
                self.newPwdField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(confirmNewPwd) {
            alert("请确认您的新密码!", handler: {
                self.confirmNewPwdField.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(oldPwd) {
            alert("请输入您的旧密码!", handler: {
                self.oldPwdField.becomeFirstResponder()
            })
            return
        }
        if newPwd != confirmNewPwd{
            alert("您输入的新密码两次不同，请重新输入！",handler:{
                self.confirmNewPwdField.becomeFirstResponder()
            })
            return
        }
        self.updatePwd(confirmNewPwd, oldPwd: oldPwd)
    }
    
    func updatePwd(confirmNewPwd:String,oldPwd:String){
        var parameters = [String : AnyObject]()
        parameters["newPasswordUnEncrypted"] = confirmNewPwd
        parameters["password"] = oldPwd
        NetworkTool.sharedTools.changePwd(parameters) { (login, error) in
            if error == nil {
             self.showHint("密码修改成功！", duration: 2, yOffset: 2)
            self.navigationController?.popViewControllerAnimated(true)
            }else{
              self.showHint("密码修改失败！", duration: 2, yOffset: 2)
            }
            
        }
    }
}


//
//  EditTextTools.swift
//  ZhiAnTongCpy
//
//  Created by Ricky on 2017/4/7.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import Foundation
///自定义帮助类
public class EditTextTools {
    //限制小数点后面最多只能2位
   class func limitFloat(text:String,range:NSRange,string:String)->Bool{
        let futureString: NSMutableString = NSMutableString(string: text)
        futureString.insertString(string, atIndex: range.location)
        var flag = 0;
        let limited = 2;//小数点后需要限制的个数
        if !futureString.isEqualToString("") {
            for i in (futureString.length - 1).stride(through: 0, by: -1) {
                let char = Character(UnicodeScalar(futureString.characterAtIndex(i)))
                if char == "." {
                    if flag > limited {
                        return false
                    }
                    break
                }
                flag += 1
            }
        }
        return true
    }
}


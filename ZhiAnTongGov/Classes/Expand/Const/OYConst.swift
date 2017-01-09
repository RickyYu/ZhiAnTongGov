//
//  OYConst.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/28.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

/// RGBA的颜色设置
func YMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func YMGlobalColor() -> UIColor {
    return YMColor(240, g: 240, b: 240, a: 1)
}

/// 红色
func YMGlobalRedColor() -> UIColor {
    return YMColor(245, g: 80, b: 83, a: 1.0)
}

/// 红色
func YMGlobalDeapBlueColor() -> UIColor {
    return YMColor(0, g: 191, b: 255, a: 1.0)
}

let PAGE_SIZE = 12
let LOAD_FINISH = "加载完毕"


/// iPhone 5
let isIPhone5 = SCREEN_WIDTH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREEN_WIDTH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREEN_WIDTH == 736 ? true : false
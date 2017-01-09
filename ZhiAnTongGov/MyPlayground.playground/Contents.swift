//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var str2=String()
    
print(str2.isEmpty)

var str3:String="China"

//------可选类型------在任何已有类型的后面紧跟？即可代表可选类型，可选类型的变量可用于处理“值缺失”的情况
var str4="fkit"
//无法通过，Int类型只接受Int值，不能接受“值缺失”的情况，由于str4转换为Int有可能失败，故num有可能没有值，
//var num:Int = Int(str4)
//可通过，Int？类型变量便是可选类型，可接受Int值和“值缺失”两种情况
var num:Int? = Int(str4)
var n=Int(str4)
//Swift使用nil代表“值缺失”，因此上面程序中num、n变量的值为nil

//------强制解析-------
//Int？类型与Int类型不相同
//为了获取可选类型的变量或常量实际存储的值，需在其后添加感叹号！进行解析
//感叹号表明：已知可选变量有值，请提取其中的值。此过程便为强制解析

var str5:String?="crazy"
//str5是String？类型的，不能赋值给String类型的s变量,在str5后面添加！，即可获取
var s:String = str5!

//-------可选绑定-------用于判断可选类型常/变量是否有值
var str6:String! = "fkit.org"

if var tmp = str6 {
  print("str6的值:\(tmp)")
}else{
  print("str的值为nil，不能解析！")
}

//------隐式可选类型------ 
//除了在任意已有类型后面添加？来表示可选类型之外，Switf还允许在任意已有类型后面添加！来表示可选类型
//Int、Int？和Int！ 都不同
var str7:String!="crazy.org"
//对于String！隐式可选类型，无须使用感叹号执行强制解析
var tmp2:String=str7

















//
//  TestSnapController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/3.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
class TestSnapController: PhotoViewController {
    enum PunTypeEnum : String{
        case 警告 = "punishmentType02"
        case punishmentType02 = "警告"
    }
    var redView      = UIView()
    var yellowView   = UIView()
    var greenView    = UIView()
    var blackView    = UIView()
    var purpleView   = UIView()
    var cyanView     = UIView()
    var grayViewBtn  = UIButton()
    var leftView     = UIView()
    var rightView    = UIView()
    
    var yesBtn = UIButton()
    var falseBtn = UIButton()
    override func viewDidLoad() {
        
        self.view.addSubview(containerView)
        setLoc(0, y: 300)
        checkNeedAddButton()
        renderView()

         print("警告 = "+getPunType("警告"))
         print("punishmentType02 = "+getPunType("punishmentType02"))
      
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        let models = IndustrySelectModel()
        models.id = 1
        models.title = "爱打打"
        
        var array = [JSON]()
        let dict = ["one":"asd","two":"asd","three":"asd","four":"asd"]
        print(dict)
        print(JSON(dict))
        array.append(JSON(dict))
        array.append(JSON(dict))
        print(array)
        
      

        let customView1 = TestCellView(frame:CGRectMake(0, 110, SCREEN_WIDTH, 45))
        customView1.setLabelName("企业：")
       // customView1.setRTextField("TTTTTTTTTTTTTTTTTTT")

 
        view.addSubview(customView1)
        view.addSubview(containerView)

        
        redView.backgroundColor = UIColor.redColor()
        yellowView.backgroundColor = UIColor.yellowColor()
        greenView.backgroundColor = UIColor.greenColor()
        blackView.backgroundColor = UIColor.blackColor()
        purpleView.backgroundColor = UIColor.purpleColor()
        cyanView.backgroundColor = UIColor.cyanColor()
        grayViewBtn.backgroundColor = UIColor.grayColor()
        leftView.backgroundColor = UIColor.cyanColor()
        rightView.backgroundColor = UIColor.orangeColor()
        
        yesBtn = UIButton(frame:CGRectMake(10, 200, 30, 30))
        falseBtn = UIButton(frame:CGRectMake(40, 200, 30, 30))
        setButton(yesBtn, str: "是")
        setButton(falseBtn, str: "否")
        
        yesBtn.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
        yesBtn.selected = true
        falseBtn.addTarget(self, action:#selector(tapped2(_:)), forControlEvents:.TouchUpInside)
        
        
   
    
    }
    
    func setButton(button:UIButton,str:String){
        button.setImage(UIImage(named: "cb_unselect"), forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont.boldSystemFontOfSize(11)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "cb_select"), forState: UIControlState.Selected)
        button.setTitle(str, forState: UIControlState.Normal)
        self.view.addSubview(button)
    }
    
    //true
    func tapped1(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            falseBtn.selected = false
        }else{
            falseBtn.selected = true
        }
        
    }
    
    //false
    func tapped2(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            yesBtn.selected = false
        }else{
            yesBtn.selected = true
            
        }
        
    }
    
    
}

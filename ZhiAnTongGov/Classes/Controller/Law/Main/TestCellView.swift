//
//  DetailCellView.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/7.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit




class TestCellView: UIView {
    
    var lineView = UIView()
    var label  = UILabel()
    var  button1 = UIButton()
     var  button = UIButton()
     var  button2 = UIButton()
    var  button3 = UIButton()
    var  button4 = UIButton()
     var models = [CheckPersonModel]()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.boldSystemFontOfSize(13)
        label.textColor = YMGlobalDeapBlueColor()
        lineView.backgroundColor = UIColor.lightGrayColor()
        let model = CheckPersonModel()
        model.gridName = "李伟奇"
        let model1 = CheckPersonModel()
        model1.gridName = "adad"
        let model2 = CheckPersonModel()
        model2.gridName = "adad"
        models.append(model)
         models.append(model1)
         models.append(model2)
models.append(model2)
//      
//        
//        if !models.isEmpty{
//        let modelCount = models.count
//            if modelCount == 1{
//             addCheckBox(button1, model: models[0])
//            }else if modelCount == 2{
//             addCheckBox(button1, model: models[0])
//             addCheckBox(button2, model: models[1])
//            }else if modelCount == 3{
//                addCheckBox(button1, model: models[0])
//                addCheckBox(button2, model: models[1])
//            }else if modelCount == 4{
//                addCheckBox(button1, model: models[0])
//                addCheckBox(button2, model: models[1])
//            }
//            
//        }
        
    
       
        
    

        
        self.addSubview(label)
        self.addSubview(lineView)

        label.snp_makeConstraints { make in
            make.top.equalTo(self.snp_top).offset(5)
            make.left.equalTo(self.snp_left).offset(5)
            make.size.equalTo(CGSizeMake(100, 35))
        }

//        button.snp_makeConstraints(closure: { (make) in
//            make.top.equalTo(self.snp_top).offset(5)
//            make.left.equalTo(self.label.snp_right)
//            make.size.equalTo(CGSizeMake(60, 35))
//        })
        
//        button1.snp_makeConstraints(closure: { (make) in
//            make.top.equalTo(self.label.snp_top)
//            make.left.equalTo(self.label.snp_right).offset(30)
//            make.size.equalTo(CGSizeMake(86, 22))
//        })
//        
//        button1.snp_makeConstraints(closure: { (make) in
//            make.top.equalTo(self.snp_top).offset(5)
//            make.left.equalTo(self.button.snp_right)
//             make.size.equalTo(CGSizeMake(60, 35))
//        })


        lineView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-2)
            make.left.equalTo(self.snp_left).offset(3)
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH-6, 2))
        }
        
        
        for i in 0..<models.count{
            let button = UIButton()
            button.setImage(UIImage(named: "cb_unselect"), forState: UIControlState.Normal)
            button.titleLabel!.font = UIFont.boldSystemFontOfSize(11)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setImage(UIImage(named: "cb_select"), forState: UIControlState.Selected)
            button.setTitle(models[i].gridName, forState: UIControlState.Normal)
            self.addSubview(button)
            
            button.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self.snp_top).offset(5)
                make.left.equalTo(self.label.snp_right).offset(60*i)
                make.size.equalTo(CGSizeMake(60, 35))
            })
            switch i {
            case 0:
                button.addTarget(self, action:#selector(tapped1(_:)), forControlEvents:.TouchUpInside)
            case 1:
                button.addTarget(self, action:#selector(tapped2(_:)), forControlEvents:.TouchUpInside)
            case 2:
                button.addTarget(self, action:#selector(tapped3(_:)), forControlEvents:.TouchUpInside)
            case 3:
                button.addTarget(self, action:#selector(tapped4(_:)), forControlEvents:.TouchUpInside)
                
            default: break
                
            }
            
            
        }
    }

    
    func setLabelName(name:String) {
        label.text = name
    }

    func tapped1(button:UIButton){
      button.selected = !button.selected
        if button.selected{
        
         print("tapped1+\(button.selected)")
        }else{
         print("tapped1+\(button.selected)")
        
        }

    }
    func tapped2(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            print("tapped2+\(button.selected)")
        }else{
            print("tapped2+\(button.selected)")
            
        }
        
    }
    func tapped3(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            print("tapped3+\(button.selected)")
        }else{
            print("tapped3+\(button.selected)")
            
        }
        
    }
    func tapped4(button:UIButton){
        button.selected = !button.selected
        if button.selected{
            
            print("tapped4+\(button.selected)")
        }else{
            print("tapped4+\(button.selected)")
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

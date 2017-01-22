//
//  TestSnapController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/3.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SwiftyJSON
class TestSnapController: PhotoViewController,NSXMLParserDelegate {
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
    var currentNodeName:String!
    // 监听解析节点的属性
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        // 保存当前的解析到的节点名称
        self.currentNodeName = elementName
        if(elementName == "tradeType03"){
            print("attributeDict = \(attributeDict["name"]!)")
        }
        if(elementName == "tradeType03_5_5"){
            print("attributeDict = \(attributeDict["name"]!)")
        }
        if(elementName == "tradeType03_5"){
            print("attributeDict = \(attributeDict["name"]!)")
        }
        
    }
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
    }
    override func viewDidLoad() {
        
        //选项除了文字还可以是图片
        let items=["选项一","选项二","选项三"] as [AnyObject]
        let segmented=UISegmentedControl(items:items)
        segmented.center=self.view.center
        //segmented.selectedSegmentIndex=1 //默认选中第二项
        segmented.addTarget(self, action: #selector(self.segmentDidchange(_:)),
                            forControlEvents: UIControlEvents.ValueChanged)  //添加值改变监听
        self.view.addSubview(segmented)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        self.view.addSubview(containerView)
        let parse:NSXMLParser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("huzhou_enum", ofType: "xml")!))!
        parse.delegate = self
        // 开始解析
        parse.parse()
        
        
        
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

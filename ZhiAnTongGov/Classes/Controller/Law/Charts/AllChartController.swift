//
//  GovChartController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/5.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
import Charts
class AllChartController:UIViewController,ChartViewDelegate{
    
    @IBOutlet weak var chartView: BarChartView!
    var mCountModels = [McountModel]()
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    var dataModel:ChartModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.initChartView()
        getDates()
        
        
    }
    
    func getDates(){
        
        let parameters = [String : AnyObject]()
        
        NetworkTool.sharedTools.loadGovCount(parameters) { (data, error) in
            
            if error == nil{
                self.dataModel = data!
            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
            }
            self.label1.text = self.dataModel.checkNum
            self.label2.text = self.dataModel.callbackNum
            self.label3.text = self.dataModel.dangerNum
            self.label4.text = self.dataModel.rectifyRateNum
            self.mCountModels = self.dataModel.mcountModels
            self.setChartData()
        }
        
        
    }
    
    
    func initChartView(){
        chartView.barData
        chartView.delegate = self
        chartView.descriptionText=""
        chartView.noDataTextDescription="获取数据失败，请稍后再试"
        //图表是否可触摸
        chartView.multipleTouchEnabled = false
        //是否可拖拽
        chartView.dragEnabled = false
        //是否可缩放
        chartView.setScaleEnabled(false)
        //双指缩放
        chartView.pinchZoomEnabled = false
        //隐藏右边坐标轴
        chartView.rightAxis.enabled = false
        //显示左边坐标轴
        chartView.leftAxis.enabled = true
        //图表背景色
        // chartView.gridBackgroundColor = UIColor.grayColor()
        chartView.backgroundColor = UIColor.lightGrayColor()
        //设置X轴
        let xAxis = chartView.xAxis
        xAxis.labelPosition = ChartXAxis.LabelPosition.Bottom
        xAxis.drawGridLinesEnabled = true
        xAxis.spaceBetweenLabels = 2
        let leftAxis = chartView.leftAxis
        leftAxis.axisMaxValue = 20
        leftAxis.labelCount = 4
        
    }
    
    
    var months : [String] = []
    //1.定义数组
    var valuesCpyYh: [Double] = [] //企业自查隐患
    var valuesGovYh: [Double] = []; //政府检查隐患
     var valuesZg: [Double] = []; //隐患整改数量
    func setChartData() {
        months.removeAll()
        valuesCpyYh.removeAll()
        valuesGovYh.removeAll()
        valuesZg.removeAll()
        //转换数据
        for item in mCountModels{
            let month = item.dateMonth.substringFromIndex(item.dateMonth.startIndex.advancedBy(3))+"月"
            months.append(month)
            valuesCpyYh.append(Double(item.byCom))
            valuesGovYh.append(Double(item.byGov))
            valuesZg.append(Double(item.repairedNum))
            
        }
        
        var dataEntriesCpyYh: [BarChartDataEntry] = []
        for i in 0..<valuesCpyYh.count {
            let dataEntry = BarChartDataEntry(value: valuesCpyYh[i], xIndex: i)
            dataEntriesCpyYh.append(dataEntry)
        }
        
        var dataEntriesGovYh: [BarChartDataEntry] = []
        for i in 0..<valuesGovYh.count {
            let dataEntry = BarChartDataEntry(value: valuesGovYh[i], xIndex: i)
            dataEntriesGovYh.append(dataEntry)
        }
        
        var dataEntriesZg: [BarChartDataEntry] = []
        for i in 0..<valuesZg.count {
            let dataEntry = BarChartDataEntry(value: valuesZg[i], xIndex: i)
            dataEntriesZg.append(dataEntry)
        }
        
        let sortArray = valuesGovYh.sort(){ $1 < $0 }
        let leftAxis = chartView.leftAxis
        leftAxis.axisMaxValue = sortArray[0]
        
        let chartDataSet = BarChartDataSet(yVals: dataEntriesCpyYh, label: "企业自查隐患")
        let chartDataSet1 = BarChartDataSet(yVals: dataEntriesGovYh, label: "政府检查隐患")
        let chartDataSet2 = BarChartDataSet(yVals: dataEntriesZg, label: "隐患整改数量")
        
        chartDataSet.colors = [ UIColor.redColor()]
        chartDataSet1.colors = [UIColor.cyanColor()]
        chartDataSet2.colors = [UIColor.yellowColor()]
        // 加上动画
        chartView.animate(yAxisDuration: 1.0, easingOption: .EaseInBounce)
        //赋值  xVals x轴数据    dataSet 图标内值
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        chartData.addDataSet(chartDataSet1)
        chartData.addDataSet(chartDataSet2)
        chartView.data = chartData
        
    }
    
    func createRightBarButtonItem()
    {
        let buttonRight = UIButton.init(type: UIButtonType.Custom)
        buttonRight.frame = CGRectMake(0, 0, 40, 40)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonRight)
        buttonRight.setTitle("Save", forState: UIControlState.Normal)
        buttonRight.addTarget(self, action:#selector(GovChartController.save(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    func save(btn: UIButton)
    {
        // 保存到相册
        chartView.saveToCameraRoll()
        print("保存成功")
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int,     highlight: ChartHighlight) {
        print("\\\\(entry.value) in \\\\(months[entry.xIndex])")
    }
}
